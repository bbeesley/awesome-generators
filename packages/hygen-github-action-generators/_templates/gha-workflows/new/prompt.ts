const prompt = [
  {
    type: 'input',
    name: 'nodeVersion',
    message: 'What node version should be used in ci?',
    validate: (v: any) => /^(\d+\.\d+.\d+)$/.test(v),
    initial: () =>
      (/^v(\d+\.\d+.\d+)/.exec(process.version) ?? [undefined, undefined])[1],
  },
];

export default prompt;
