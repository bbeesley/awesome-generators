---
to: tsconfig.json
---
{
  "extends": "@beesley/tsconfig/npm.json",
  "compilerOptions": {
    "types": [],
    "declarationDir": "dist/types",
    "outDir": "dist/esm"
  },
  "include": ["src/**/*.ts", "src/*.ts"],
  "exclude": ["src/*.test.*", "src/**/*.test.*", "src/test/*.ts"]
}
