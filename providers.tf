terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = ">= 4.26.0, < 5.0.0"
    }
  }

  required_version = ">= 0.14.5"
}
