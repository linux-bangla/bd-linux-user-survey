output "domain" {
  description = "The survey domain"
  value       = "https://tex-example.com"
}

output "routes" {
  description = "Active survey routes"
  value = {
    form   = "https://tex-example.com/form"
    data   = "https://tex-example.com/data"
    result = "https://tex-example.com/result"
  }
}
