---
to: .github/workflows/commitlint.yml
---
name: Commitlint
on:
  pull_request:
    types: [opened, synchronize, edited]
jobs:
  lint-commits:
    runs-on: ubuntu-latest
    timeout-minutes: 5
    steps:
      - uses: actions/checkout@v3
        with:
          fetch-depth: 0
      - uses: actions/setup-node@v3
        with:
          node-version: '<%= nodeVersion %>'
      - name: install
        run: npm i --package-lock=false @commitlint/cli @commitlint/config-conventional conventional-commit-types conventional-changelog-angular
      - name: commitlint
        run: ./node_modules/.bin/commitlint --from HEAD~${{ github.event.pull_request.commits }} --to HEAD
