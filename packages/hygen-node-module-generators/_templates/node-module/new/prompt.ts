const prompt = [
  {
    type: 'input',
    name: 'name',
    message: "What's the package name?",
    validate: (v: any) => v !== '',
  },
  {
    type: 'input',
    name: 'description',
    message: "What's the package description?",
    validate: (v: any) => v !== '',
  },
  {
    type: 'input',
    name: 'author',
    message:
      "Who's the author of the package? (e.g. You <you@your-domain.com>)",
    validate: (v: any) => v !== '',
  },
  {
    type: 'input',
    name: 'repoName',
    message: "What's the https url for your git repo?",
    validate: (v: any) => v !== '',
  },
  {
    type: 'input',
    name: 'nodeVersion',
    message: 'What node version should be used locally?',
    validate: (v: any) => /^(\d+\.\d+.\d+)$/.test(v),
    initial: () =>
      (/^v(\d+\.\d+.\d+)/.exec(process.version) ?? [undefined, undefined])[1],
  },
  {
    type: 'input',
    name: 'supportNodeVersion',
    message: 'What minimum node version should the module support?',
    validate: (v: any) => /^(\d+\.\d+.\d+)$/.test(v),
    initial: '14.18.3',
  },
];

export default prompt;
