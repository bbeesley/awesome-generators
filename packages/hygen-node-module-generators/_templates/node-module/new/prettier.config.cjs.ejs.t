---
to: "<%= locals.isLernaChild ? null : 'prettier.config.cjs' %>"
---
module.exports = {
  trailingComma: 'all',
  tabWidth: 2,
  semi: true,
  singleQuote: true,
  bracketSpacing: true,
};
