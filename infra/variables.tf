variable "cloudflare_api_token" {
  description = "Scoped CF API token — Zone:Read + Zone Settings:Edit + DNS:Edit on tex-example.com"
  type        = string
  sensitive   = true
}

variable "zone_id" {
  description = "Cloudflare Zone ID for tex-example.com (found in CF dashboard sidebar)"
  type        = string
  sensitive   = true
}
