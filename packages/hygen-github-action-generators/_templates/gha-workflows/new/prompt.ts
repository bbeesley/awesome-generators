export default [
  {
    type: 'input',
    name: 'nodeVersion',
    message: 'What node version should be used in ci?',
    validate: (v: any) => /^(\d+\.\d+.\d+)$/.test(v),
    initial: () =>
      (process.version.match(/^v(\d+\.\d+.\d+)/) ?? [undefined, undefined])[1],
  },
];
