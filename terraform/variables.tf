variable "credentials" {
  description = "My credentials"
  default     = "./keys/my-creds.json"

}

variable "project" {
  description = "Project"
  default     = "aesthetic-root-416403"
}

variable "region" {
  description = "Region"
  default     = "us-central1"
}

variable "location" {
  description = "Project Location"
  default     = "US"
}

variable "bq_dataset_name" {
  description = "The name of the BigQuery dataset"
  default     = "dataset_project_minhnghia113"
}

variable "gcs_bucket_name" {
  description = "My storage bucket name"
  default     = "data_lake_minhnghia113"
}


variable "gcs_storage_class" {
  description = "Bucket storage class"
  default     = "STANDARD"
}