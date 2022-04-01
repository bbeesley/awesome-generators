---
to: .github/workflows/automerge.yml
---
name: Auto Merge
on:
  pull_request:
    types:
      - labeled
  pull_request_review:
    types:
      - submitted
jobs:
  automerge:
    runs-on: ubuntu-latest
    timeout-minutes: 5
    steps:
      - id: automerge
        name: automerge
        uses: "pascalgn/automerge-action@v0.15.2"
        if: github.actor != 'dependabot[bot]'
        env:
          GITHUB_TOKEN: "${{ secrets.GH_PA_TOKEN }}"
          MERGE_LABELS: "dependencies,approved"
          MERGE_METHOD: "rebase"