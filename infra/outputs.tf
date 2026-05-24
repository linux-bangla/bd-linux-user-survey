output "domain" {
  description = "The survey domain"
  value       = "https://tuxstats.com"
}

output "routes" {
  description = "Active survey routes"
  value = {
    form   = "https://tuxstats.com/form"
    data   = "https://tuxstats.com/data"
    result = "https://tuxstats.com/result"
  }
}
