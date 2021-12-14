terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 4.19.0"
    }
  }
}

provider "github" {
  owner = "relaycorp"
}

module "self" {
  source = "../.."

  name         = "terraform-github-oss-project"
  description  = "Terraform module for open source projects by Relaycorp"
  homepage_url = "https://registry.terraform.io/modules/relaycorp/oss-project/github/latest"
  licence      = "mit"
  ci_contexts  = ["ci"]
}
