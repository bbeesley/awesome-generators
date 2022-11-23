import { mkdir, readdir, readFile, cp, rm } from 'node:fs/promises';
import { existsSync } from 'node:fs';
import { dirname, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';
import { execa, type Options } from 'execa';
import test from 'ava';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const testRoot = resolve(__dirname, 'test-root');
const testPath = resolve(testRoot, 'test-output');
const templatesPath = resolve(__dirname, '../_templates');
const execaOptions: Options = {
  preferLocal: true,
  env: {
    HYGEN_TMPLS: templatesPath,
  },
  cwd: testPath,
  stdio: 'pipe',
  timeout: 10e3,
};

async function setup() {
  try {
    await mkdir(testRoot);
    await mkdir(testPath);
    await cp(
      resolve(__dirname, '../config-stubs/package.json'),
      resolve(testRoot, 'package.json'),
    );
    await cp(
      resolve(__dirname, '../config-stubs/package.json'),
      resolve(templatesPath, 'package.json'),
    );
    await cp(
      resolve(__dirname, '../config-stubs/tsconfig.json'),
      resolve(testRoot, 'tsconfig.json'),
    );
    await cp(
      resolve(__dirname, '../config-stubs/tsconfig.json'),
      resolve(templatesPath, 'tsconfig.json'),
    );
  } catch {
    // Console.error('Error creating test output directory', e);
    // throw e;
  }
}

async function cleanup() {
  try {
    await rm(resolve(templatesPath, 'tsconfig.json'));
    await rm(resolve(templatesPath, 'package.json'));
    await rm(testRoot, { recursive: true });
  } catch {
    // Console.error('Error removing test output directory', e);
    // throw e;
  }
}

test.serial.beforeEach(async () => {
  await cleanup();
  await setup();
});
test.serial.afterEach(async () => {
  await cleanup();
});

const defaultArgs = [
  '--name',
  'name',
  '--description',
  'description',
  '--author',
  'author',
  '--repo-name',
  'repo-name',
  '--node-version',
  '14.19.0',
  '--support-node-version',
  '14.19.0',
];

test.serial('should create expected files', async (t) => {
  await execa('hygen', ['node-module', 'new', ...defaultArgs], execaOptions);
  const filesCreated = await readdir(testPath);
  t.snapshot(filesCreated);
});
test.serial(
  'should omit top level files when creating lerna packages',
  async (t) => {
    await execa(
      'hygen',
      ['node-module', 'new', '--is-lerna-child', 'true', ...defaultArgs],
      execaOptions,
    );
    const filesCreated = await readdir(testPath);
    t.falsy(filesCreated.includes('tsconfig-lint.json'));
    t.falsy(filesCreated.includes('.nvmrc'));
    t.falsy(filesCreated.includes('.eslintrc.cjs'));
  },
);
test.serial('should omit src files when creating lerna root', async (t) => {
  await execa(
    'hygen',
    ['node-module', 'new', '--is-lerna-root', 'true', ...defaultArgs],
    execaOptions,
  );
  t.falsy(existsSync(resolve(testPath, 'src', 'index.ts')));
});
test.serial(
  'should omit release config when creating lerna root',
  async (t) => {
    await execa(
      'hygen',
      ['node-module', 'new', '--is-lerna-root', 'true', ...defaultArgs],
      execaOptions,
    );
    const pjContent = await readFile(resolve(testPath, 'package.json'), {
      encoding: 'utf8',
    });
    const pj = JSON.parse(pjContent) as Record<string, any>;
    t.falsy(pj.release);
  },
);
