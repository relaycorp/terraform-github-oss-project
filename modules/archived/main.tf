resource "github_repository" "main" {
  name     = var.name
  archived = true

  lifecycle {
    ignore_changes = [
      auto_init,
      description,
      homepage_url,
      topics,
      allow_merge_commit,
      allow_rebase_merge,
      allow_auto_merge,
      delete_branch_on_merge,
      has_issues,
      has_downloads,
      vulnerability_alerts,
      pages,
    ]
  }
}
