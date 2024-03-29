---
to: babel.config.cjs
---
module.exports = function configureBabel(api) {
  api.cache(true); // this tells babel to cache it's transformations, it's pretty good at checking file hashes and invalidating it's cache, but if you have problems with changes not being reflected you can set false here.

  const presets = [
    [
      '@babel/preset-env', // this plugin tells babel to transpile your code for a specific runtime environment, we'll use node
      {
        targets: {
          node: '<%= supportNodeVersion %>',
        },
        modules: 'cjs',
      },
    ],
    [
      '@babel/preset-typescript', // this plugin allows babel to work with typescript (bear in mind it will only transpile it, it doesn't care if you have type errors)
    ],
  ];

  const plugins = [[
    'babel-plugin-replace-import-extension',
    { extMapping: { '.js': '.cjs' } },
  ]];

  return {
    presets,
    plugins,
  };
};
