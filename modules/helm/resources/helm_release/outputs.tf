output "metadata" {
  value = helm_release.release.metadata
}

output "values" {
  value = helm_release.release.values
}
