---
to: package.json
---
{
  "name": "<%= name.toLowerCase() %>",
  "version": "0.0.0",
  "description": "<%= description %>",
  "main": "dist/index.js",
  "exports": {
    ".": {
      "import": "./dist/index.js"
    }
  },
  "files": [
    "dist"
  ],
  "scripts": {
    "test": "ava",
    "pretest": "npm run lint && npm run compile",
    "lint": "eslint .",
    "precompile": "rm -rf generators/* || true",
    "compile:cjs": "rm -rf dist || true && babel src --out-dir dist --extensions '.ts,.cjs,.mjs' --copy-files --include-dotfiles --no-copy-ignored --ignore '**/*.test.ts' --out-file-extension '.cjs' --config-file ./babel.config.cjs",
    "compile": "npm run compile:cjs && tsc --emitDeclarationOnly",
    "release": "semantic-release"
  },
  "repository": {
    "type": "git",
    "url": "git+<%= repoName %>.git"
  },
  "author": "<%= author %>",
  "license": "MIT",
  "dependencies": {},
  "devDependencies": {
<% if(!locals.lernaPackage){ -%>
    "@babel/cli": "^7.17.6",
    "@babel/core": "^7.17.5",
    "@babel/eslint-parser": "^7.17.0",
    "@babel/preset-env": "^7.16.11",
    "@babel/preset-typescript": "^7.16.7",
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
    "@typescript-eslint/eslint-plugin": "^5.13.0",
    "@typescript-eslint/parser": "^5.13.0",
    "ava": "^4.0.1",
    "babel-plugin-add-import-extension": "^1.6.0",
    "conventional-changelog-angular": "^5.0.13",
    "cz-conventional-changelog": "^3.3.0",
    "documentation": "^13.2.5",
    "eslint": "^8.10.0",
    "eslint-config-airbnb-base": "^15.0.0",
    "eslint-config-prettier": "^8.4.0",
    "eslint-plugin-ava": "^13.2.0",
    "eslint-plugin-eslint-comments": "^3.2.0",
    "eslint-plugin-import": "^2.25.4",
    "eslint-plugin-node": "^11.1.0",
    "eslint-plugin-prettier": "^4.0.0",
    "eslint-plugin-promise": "^6.0.0",
    "eslint-plugin-unicorn": "^41.0.0",
    "prettier": "^2.5.1",
    "semantic-release": "^19.0.2",
    "sinon": "^13.0.1"
<% } -%>
  },
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
}
