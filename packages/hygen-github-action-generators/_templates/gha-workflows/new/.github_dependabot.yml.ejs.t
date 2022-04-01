---
to: .github/dependabot.yml
---
version: 2
updates:
  - package-ecosystem: npm
    directory: "/"
    schedule:
      interval: daily
      time: "04:00"
      timezone: Europe/London
    open-pull-requests-limit: 5
    commit-message:
      prefix: chore
      include: scope
  - package-ecosystem: "github-actions"
    directory: "/"
    schedule:
      interval: "daily"
    commit-message:
      prefix: chore
      include: scope
