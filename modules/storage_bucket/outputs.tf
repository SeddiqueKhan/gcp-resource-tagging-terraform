output "bucket_name" {
  description = "The name of the storage bucket"
  value       = google_storage_bucket.default.name
}

output "bucket_self_link" {
  description = "The self-link of the storage bucket"
  value       = google_storage_bucket.default.self_link
}
