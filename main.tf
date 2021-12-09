resource "github_repository" "main" {
  name         = var.name
  description  = var.description
  homepage_url = var.homepage_url
  visibility   = "public"
  topics       = var.topics
  archived     = var.is_archived

  // Only allow squash merges
  allow_merge_commit = false
  allow_rebase_merge = false

  delete_branch_on_merge = true
  has_issues             = true
  has_downloads          = false
  auto_init              = true

  vulnerability_alerts = true

  dynamic "pages" {
    for_each = var.pages_source_path == null ? [] : [1]

    content {
      source {
        branch = var.pages_source_branch
        path   = var.pages_source_path
      }
    }
  }

  lifecycle {
    // Prevent imported repos from being recreated
    ignore_changes = [auto_init]
  }
}

resource "github_branch_protection_v3" "main" {
  repository = github_repository.main.name
  branch     = var.main_branch

  required_status_checks {
    strict = true
    contexts = concat(
      var.require_semantic_releases ? ["action-semantic-pull-request"] : [],
      var.ci_contexts,
      ["license/cla"]
    )
  }

  required_pull_request_reviews {
    dismiss_stale_reviews           = true
    required_approving_review_count = 1
  }

  restrictions {
    apps = [
      "github-actions", # Allow @semantic-release/github to create GH releases
      "kodiakhq",       # Allow Kodiak to merge PRs
    ]
  }
}

resource "github_issue_label" "kodiak_automerge" {
  // https://kodiakhq.com/
  repository  = github_repository.main.name
  name        = "automerge"
  description = "Allow kodiak to automerge commit when all checks pass"
  color       = "00A868"
}
