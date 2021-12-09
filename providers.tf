terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 4.18.2"
    }
  }

  required_version = ">= 0.14.5"
}
