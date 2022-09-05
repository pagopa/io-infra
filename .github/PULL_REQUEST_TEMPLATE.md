<!--- Please always add a PR description as if nobody knows anything about the context these changes come from. -->
<!--- Even if we are all from our internal team, we may not be on the same page. -->
<!--- Write this PR as you were contributing to a public OSS project, where nobody knows you and you have to earn their trust. -->
<!--- This will improve our projects in the long run! Thanks. -->

### List of changes

<!--- Describe your changes in detail -->

### Motivation and context

<!--- Why is this change required? What problem does it solve? -->

### Type of changes

- [ ] Add new resources
- [ ] Update configuration to existing resources
- [ ] Remove existing resources

### Env to apply

- [ ] DEV
- [ ] UAT
- [ ] PROD

### Does this introduce a change to production resources with possible user impact?

- [ ] Yes, users may be impacted applying this change
- [ ] No

### Does this introduce an unwanted change on infrastructure? Check terraform plan execution result

- [ ] Yes
- [ ] No

### Other information

<!-- Any other information that is important to this PR such as screenshots of how the component looks before and after the change. -->

---

### If PR is partially applied, why? (reserved to mantainers)

<!--- Describe the blocking cause -->

### How to apply

After PR is approved
1. run deploy pipeline from Azure DevOps [io-platform-iac-projects](https://dev.azure.com/pagopaspa/io-platform-iac-projects/_build?view=folders)
2. select PR branch
3. wait for approval
