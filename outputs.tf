output "bucket_name" {
  description = "Nom du bucket utilisé pour héberger le site."
  value       = minio_s3_bucket.tp1_bucket.bucket
}

output "index_url" {
  description = "URL publique de la page d'accueil du site."
  value       = "http://127.0.0.1:9000/${minio_s3_bucket.tp1_bucket.bucket}/index.html"
}

output "css_url" {
  description = "URL publique de la feuille de style."
  value       = "http://127.0.0.1:9000/${minio_s3_bucket.tp1_bucket.bucket}/style.css"
}