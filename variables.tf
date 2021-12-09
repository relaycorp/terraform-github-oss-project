variable "name" {
  description = "GitHub project name"
}
variable "description" {
  description = "GitHub project description"
}
variable "homepage_url" {
  description = "GitHub project homepage"
}
variable "licence" {
  description = "The project licence (e.g., MIT)"
}
variable "main_branch" {
  default     = "main"
  description = "Main branch of the repository"
}
variable "topics" {
  default     = []
  type        = list(string)
  description = "Topics to label the project with"
}
variable "ci_contexts" {
  default     = []
  type        = list(string)
  description = "Required CI contexts for PRs to merged in the main branch"
}

variable "require_semantic_releases" {
  default     = true
  description = "Whether the project uses Semantic Releases"
}

variable "is_archived" {
  default     = false
  description = "Whether the project is archived"
}

variable "pages_source_path" {
  default     = null
  type        = string
  description = "The page to the source of the GitHub Pages website"
}
variable "pages_source_branch" {
  default     = "gh-pages"
  type        = string
  description = "The branch containing the GitHub Pages website"
}
