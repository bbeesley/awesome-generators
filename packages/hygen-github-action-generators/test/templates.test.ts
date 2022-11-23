import { cp, mkdir, readdir, rm, readFile } from 'node:fs/promises';
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

const defaultArgs = ['--node-version', '14.19.0'];

test.serial('should create expected files', async (t) => {
  await execa('hygen', ['gha-workflows', 'new', ...defaultArgs], execaOptions);
  const outputFolderContent = await readdir(testPath);
  const githubFolderContent = await readdir(resolve(testPath, '.github'));
  const workflowsFolderContent = await readdir(
    resolve(testPath, '.github', 'workflows'),
  );
  t.snapshot([
    ...outputFolderContent,
    ...githubFolderContent,
    ...workflowsFolderContent,
  ]);
});

test.serial(
  'should include bootstrap if --is-lerna-monorepo true',
  async (t) => {
    await execa(
      'hygen',
      ['gha-workflows', 'new', ...defaultArgs, '--is-lerna-monorepo', 'true'],
      execaOptions,
    );
    const workflowsFolder = resolve(testPath, '.github', 'workflows');
    const commonWorkflowContent = await readFile(
      resolve(workflowsFolder, 'build-test-common.yml'),
      { encoding: 'utf8' },
    );
    t.regex(commonWorkflowContent, /npm run bootstrap/);
  },
);

test.serial(
  'should not include bootstrap without --is-lerna-monorepo true',
  async (t) => {
    await execa(
      'hygen',
      ['gha-workflows', 'new', ...defaultArgs],
      execaOptions,
    );
    const workflowsFolder = resolve(testPath, '.github', 'workflows');
    const commonWorkflowContent = await readFile(
      resolve(workflowsFolder, 'build-test-common.yml'),
      { encoding: 'utf8' },
    );
    t.notRegex(commonWorkflowContent, /npm run bootstrap/);
  },
);
