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

resource "github_branch_protection" "main" {
  repository_id = github_repository.main.node_id
  pattern       = "^${var.main_branch}$"

  required_linear_history         = true
  require_conversation_resolution = true

  required_status_checks {
    strict = true
    contexts = concat(
      var.require_semantic_releases ? ["pr-ci / semantic-pr-title"] : [],
      var.ci_contexts,
      ["license/cla"]
    )
  }

  required_pull_request_reviews {
    dismiss_stale_reviews           = true
    required_approving_review_count = 1
  }

  push_restrictions = [
    local.github_actions_app_node_id, # Allow @semantic-release/github to create GH releases
    local.kodiakhq_app_node_id,       # Allow Kodiak to merge PRs
  ]
}

resource "github_issue_label" "kodiak_automerge" {
  // https://kodiakhq.com/
  repository  = github_repository.main.name
  name        = "automerge"
  description = "Allow kodiak to automerge commit when all checks pass"
  color       = "00A868"
}
