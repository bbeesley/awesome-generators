---
to: .github/workflows/auto-rebase.yml
---
name: Request Dependabot Rebase
on:
  push:
  release:
    types: [published]
jobs:
  auto-rebase:
    name: rebase dependabot PRs
    runs-on: ubuntu-latest
    timeout-minutes: 5
    if: github.event_name == 'release' || github.ref_name == github.event.repository.default_branch
    steps:
      - name: request rebase
        uses: "bbeesley/gha-auto-dependabot-rebase@main"
        env:
          GITHUB_TOKEN: ${{ secrets.GH_PA_TOKEN }}
