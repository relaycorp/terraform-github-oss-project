terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = ">= 6.0.0, < 7.0.0"
    }
  }

  required_version = ">= 0.14.5"
}
