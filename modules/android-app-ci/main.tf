resource "google_service_account" "ci" {
  project      = var.gcp_project_name
  account_id   = "github-ci"
  display_name = "Continuous Integration"
}

resource "google_service_account" "publisher" {
  project      = var.global_gcp_project_name
  account_id   = "${var.gcp_project_name}-pub"
  display_name = "Publisher for ${var.gcp_project_name}"
}

resource "google_project_iam_member" "publisher_service_account_user" {
  project = var.global_gcp_project_name
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${google_service_account.publisher.email}"
}

resource "google_service_account_key" "github_actions_ci" {
  service_account_id = google_service_account.ci.name
}

resource "google_service_account_key" "github_actions_publisher" {
  service_account_id = google_service_account.publisher.name
}

resource "google_project_iam_binding" "firebase_editors" {
  project = var.gcp_project_name
  role    = "roles/editor"
  members = ["serviceAccount:${google_service_account.ci.email}"]
}

// See https://firebase.google.com/docs/projects/iam/permissions#test-lab
resource "google_project_iam_binding" "firebase_test_lab_viewer" {
  project = var.gcp_project_name
  role    = "roles/cloudtestservice.testViewer"
  members = var.firebase_test_lab_viewers
}
resource "google_project_iam_binding" "firebase_analytics_viewer" {
  project = var.gcp_project_name
  role    = "roles/firebase.analyticsViewer"
  members = var.firebase_test_lab_viewers
}

resource "github_actions_secret" "ci_service_account" {
  repository      = var.gh_repo_name
  secret_name     = "CI_GCP_SERVICE_ACCOUNT"
  plaintext_value = base64decode(google_service_account_key.github_actions_ci.private_key)
}

resource "github_dependabot_secret" "ci_service_account" {
  repository      = var.gh_repo_name
  secret_name     = "CI_GCP_SERVICE_ACCOUNT"
  plaintext_value = base64decode(google_service_account_key.github_actions_ci.private_key)
}

resource "github_actions_secret" "publisher_service_account" {
  repository      = var.gh_repo_name
  secret_name     = "PUBLISHER_GCP_SERVICE_ACCOUNT"
  plaintext_value = base64decode(google_service_account_key.github_actions_publisher.private_key)
}

resource "google_project_service" "testing" {
  project                    = var.gcp_project_name
  service                    = "testing.googleapis.com"
  disable_dependent_services = true
}

resource "google_project_service" "toolresults" {
  project                    = var.gcp_project_name
  service                    = "toolresults.googleapis.com"
  disable_dependent_services = true
}
