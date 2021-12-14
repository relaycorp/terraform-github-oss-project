# Using root module to manage current project

This module initialises the root module to manage the current project, for testing purpose -- this code doesn't actually manage the resources.

## Set up

1. Generate GitHub Personal Access Token with the following parameters:
  - Scopes: `public_repo`, `read:org`, `read:user`, `user:email`.
  - TTL: 1 day.
1. Export the `GTIHUB_TOKEN` in your terminal session; e.g.:
  ```shell
  export GITHUB_TOKEN='ghp_...'
  ```
1. Import the resources:
  ```shell
  terraform init
  terraform import module.self.github_repository.main terraform-github-oss-project
  terraform import module.self.github_issue_label.kodiak_automerge terraform-github-oss-project:automerge
  terraform import module.self.github_branch_protection_v3.main terraform-github-oss-project:main
  ```

## Test changes

Run `terraform plan` each time you want to test changes to the main module.
