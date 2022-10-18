---
to: .github/workflows/build-test-common.yml
---
name: Build & Test Common
on:
  workflow_call:
    inputs:
      actor:
        required: true
        type: string
      ref:
        required: true
        type: string
      commit:
        required: true
        type: string
      is_main_branch:
        required: true
        type: boolean
jobs:
  test:
    runs-on: ubuntu-latest
    timeout-minutes: 20
    steps:
      - uses: actions/checkout@v3
        with:
          ref: ${{ inputs.ref }}
      - uses: actions/setup-node@v3
        with:
          node-version: '<%= nodeVersion %>'
      - uses: actions/cache@v3
        with:
          path: |
            node_modules
<% if(locals.isLernaMonorepo == 'true'){ -%>
            packages/*/node_modules
            packages/*/dist
<% } else {-%>
            dist
<% } -%>
          key: ${{ inputs.commit }}-test
      - name: install
        run: |
          npm ci
<% if(locals.isLernaMonorepo == 'true'){ -%>
          npm run bootstrap
<% } -%>
      - name: test
        run: npm test