---
to: "<%= locals.isLernaChild ? null : 'tsconfig-lint.json' %>"
---
{
  "extends": "./tsconfig.json",
  "include": [
    "**/*.ts",
    "**/.*.ts",
    "**/*.js",
    "**/*.mjs",
    "**/*.cjs",
    "**/.*.js",
    "**/.*.mjs",
    "**/.*.cjs",
    "*.js",
    "*.mjs",
    "*.cjs",
    ".*.js",
    ".*.mjs",
    ".*.cjs",
    "*.ts",
    ".*.ts"
  ]
}
