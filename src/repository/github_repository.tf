resource "github_repository" "this" {
  name        = "io-infra"
  description = "IO platform infrastructure"

  #tfsec:ignore:github-repositories-private
  visibility = "public"

  allow_update_branch         = true
  allow_auto_merge            = true
  allow_rebase_merge          = false
  allow_merge_commit          = false
  allow_squash_merge          = true
  squash_merge_commit_title   = "PR_TITLE"
  squash_merge_commit_message = "PR_BODY"

  delete_branch_on_merge = true

  has_projects    = false
  has_wiki        = false
  has_discussions = false
  has_issues      = false
  has_downloads   = false

  topics = ["io", "infrastructure"]

  vulnerability_alerts = true

  archive_on_destroy = true
}

resource "github_repository_autolink_reference" "jira_boards" {
  for_each = toset(local.jira_boards_ids)

  repository          = github_repository.this.name
  key_prefix          = format("%s-", each.value)
  target_url_template = "https://pagopa.atlassian.net/browse/${each.value}-<num>"
}
