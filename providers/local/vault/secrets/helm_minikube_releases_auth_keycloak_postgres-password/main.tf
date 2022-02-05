variable filename {
  type = string
}

data "local_file" "secret" {
  filename = var.filename
}

output secret {
  value       = trimspace(data.local_file.secret.content)
  sensitive   = true
}
