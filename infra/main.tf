terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

locals {
  # Add new years here when a new survey runs
  survey_years = ["2025"]
  routes       = ["form", "data", "result"]
}

# ── DNS ─────────────────────────────────────────────────────────────────────

resource "cloudflare_record" "root" {
  zone_id = var.zone_id
  name    = "@"
  type    = "CNAME"
  value   = "tex-lang.github.io"
  proxied = true
}

resource "cloudflare_record" "www" {
  zone_id = var.zone_id
  name    = "www"
  type    = "CNAME"
  value   = "tex-lang.github.io"
  proxied = true
}

# ── Redirect Rules ───────────────────────────────────────────────────────────

resource "cloudflare_ruleset" "survey_redirects" {
  zone_id = var.zone_id
  name    = "Survey redirects"
  kind    = "zone"
  phase   = "http_request_dynamic_redirect"

  # /form, /data, /result → latest survey pages
  dynamic "rules" {
    for_each = local.routes
    content {
      description = "Latest survey /${rules.value}"
      enabled     = true
      expression  = "(http.request.uri.path eq \"/${rules.value}\")"
      action      = "redirect"
      action_parameters {
        from_value {
          status_code = 302
          target_url {
            value = "https://tex-lang.github.io/survey/${rules.value}"
          }
          preserve_query_string = true
        }
      }
    }
  }

  # /2025/form, /2025/data, /2025/result etc.
  dynamic "rules" {
    for_each = flatten([
      for year in local.survey_years : [
        for route in local.routes : {
          year  = year
          route = route
        }
      ]
    ])
    content {
      description = "Survey ${rules.value.year} /${rules.value.route}"
      enabled     = true
      expression  = "(http.request.uri.path eq \"/${rules.value.year}/${rules.value.route}\")"
      action      = "redirect"
      action_parameters {
        from_value {
          status_code = 301
          target_url {
            value = "https://tex-lang.github.io/survey/${rules.value.year}/${rules.value.route}"
          }
          preserve_query_string = true
        }
      }
    }
  }
}
