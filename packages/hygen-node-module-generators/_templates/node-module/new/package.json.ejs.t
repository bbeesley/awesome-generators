---
to: package.json
---
{
  "name": "<%= name.toLowerCase() %>",
  "version": "0.0.0",
  "description": "<%= description %>",
  "type": "module",
  "exports": {
    ".": {
      "types": "./dist/types/index.d.ts",
      "import": "./dist/esm/index.js",
      "require": "./dist/cjs/index.cjs"
    }
  },
  "module": "./dist/esm/index.js",
  "main": "./dist/cjs/index.cjs",
  "types": "./dist/types/index.d.ts",
  "files": [
    "dist",
    "src"
  ],
  "scripts": {
    "test": "ava",
    "pretest": "npm run lint && npm run compile",
    "lint": "xo",
    "precompile": "rm -rf dist",
    "compile:esm": "tsc -p tsconfig.json",
    "compile:cjs": "babel src --out-dir dist/cjs --extensions '.ts,.cjs,.mjs' --ignore '**/*.test.ts' --source-maps --out-file-extension '.cjs'",
    "compile": "run-p compile:*",
    "release": "semantic-release"
  },
  "repository": {
    "type": "git",
    "url": "git+<%= repoName %>.git"
  },
  "author": "<%= author %>",
  "license": "MIT",
  "eslintConfig": {
		"parserOptions": {
      "project": ["./tsconfig.json", "./tsconfig-lint.json"]
    }
	},
  "xo": {
    "space": true,
    "prettier": true,
    "rules": {
      "func-names": [
        "error",
        "always"
      ],
      "no-await-in-loop": "off",
      "@typescript-eslint/no-implicit-any-catch": "off",
      "unicorn/no-array-reduce": "off",
      "import/extensions": "off",
      "n/prefer-global/process": "off"
    }
  },
  "dependencies": {},
  "devDependencies": {
<% if(!locals.isLernaChild){ -%>
    "@babel/cli": "^7.17.6",
    "@babel/core": "^7.17.5",
    "@babel/preset-env": "^7.16.11",
    "@babel/preset-typescript": "^7.16.7",
    "@beesley/tsconfig": "^1.1.0",
    "@commitlint/cli": "^16.2.1",
    "@commitlint/config-conventional": "^16.2.1",
    "@semantic-release/changelog": "^6.0.1",
    "@semantic-release/commit-analyzer": "^9.0.2",
    "@semantic-release/git": "^10.0.1",
    "@semantic-release/github": "^8.0.2",
    "@semantic-release/npm": "^9.0.1",
    "@semantic-release/release-notes-generator": "^10.0.3",
    "@types/js-yaml": "^4.0.5",
    "@types/jsdom": "^16.2.14",
    "@types/sinon": "^10.0.11",
    "@types/yargs": "^17.0.8",
    "ava": "^4.0.1",
    "babel-plugin-replace-import-extension": "^1.1.3",
    "conventional-changelog-angular": "^5.0.13",
    "cz-conventional-changelog": "^3.3.0",
    "documentation": "^13.2.5",
    "npm-run-all": "^4.1.5",
    "prettier": "^2.5.1",
    "semantic-release": "^19.0.2",
    "sinon": "^13.0.1",
    "typescript": "^4.9.3",
    "xo": "^0.53.1"
<% } -%>
  }<% if(!locals.isLernaRoot){ -%>,
  "release": {
    "branches": [
      "main",
      "next"
    ],
    "plugins": [
      [
        "@semantic-release/commit-analyzer",
        {
          "releaseRules": [
            {
              "type": "docs",
              "release": "patch"
            },
            {
              "type": "refactor",
              "release": "patch"
            },
            {
              "type": "chore",
              "scope": "deps*",
              "release": "patch"
            }
          ]
        }
      ],
      "@semantic-release/release-notes-generator",
      [
        "@semantic-release/changelog",
        {
          "changelogFile": "CHANGELOG.md"
        }
      ],
      "@semantic-release/npm",
      "@semantic-release/github",
      [
        "@semantic-release/git",
        {
          "assets": [
            "package.json",
            "CHANGELOG.md",
            "README.md"
          ],
          "message": "chore(release): ${nextRelease.version} 🚀 [skip ci]\n\n${nextRelease.notes}"
        }
      ]
    ]
  }
<% } -%>
}
