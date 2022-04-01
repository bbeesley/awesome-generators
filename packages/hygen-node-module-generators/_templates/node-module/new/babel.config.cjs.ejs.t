---
to: babel.config.cjs
---
module.exports = function configureBabel(api) {
  api.cache(true);

  const presets = [
    [
      '@babel/preset-env',
      {
        targets: {
          node: '<%= supportNodeVersion %>',
        },
        modules: false,
      },
    ],
    [
      '@babel/preset-typescript', // this plugin allows babel to work with typescript (bear in mind it will only transpile it, it doesn't care if you have type errors)
    ],
  ];

  const plugins = [
    [
      'babel-plugin-add-import-extension',
      { extension: 'mjs', replace: true },
    ],
  ];

  return {
    presets,
    plugins,
  };
};
