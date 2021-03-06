variable "global_gcp_project_name" {
  description = "Name of GCP project linked to Relaycorp's Google Play developer account"
  default     = "pc-api-6786721935796732762-360"
}

variable "gcp_project_name" {
  description = "Name of GCP project dedicated to the Android app"
}
variable "firebase_test_lab_viewers" {
  type    = list(string)
  default = []
}

variable "gh_repo_name" {}
