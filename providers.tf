terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = ">= 5.32.0, < 7.0.0"
    }
  }

  required_version = ">= 0.14.5"
}
