---
to: tsconfig.json
---
{
  "compilerOptions": {
    "allowJs": true,
    "checkJs": true,
    "incremental": false,
    "isolatedModules": false,
    "lib": ["ESNext", "DOM", "DOM.Iterable"],
    "module": "node16",
    "target": "ES2021",
    "moduleResolution": "node16",
    "sourceMap": true,
    "declaration": true,
    "declarationMap": true,
    "strict": true,
    "noImplicitAny": true,
    "strictFunctionTypes": true,
    "strictNullChecks": true,
    "allowSyntheticDefaultImports": false,
    "esModuleInterop": true,
    "importHelpers": false,
    "allowUnreachableCode": false,
    "allowUnusedLabels": false,
    "forceConsistentCasingInFileNames": true,
    "resolveJsonModule": false,
    "pretty": true,
    "stripInternal": true,
    "noImplicitReturns": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noFallthroughCasesInSwitch": true,
    "noUncheckedIndexedAccess": true,
    "noPropertyAccessFromIndexSignature": false,
    "noEmitOnError": true,
    "useDefineForClassFields": true,
    "skipLibCheck": false,
    "exactOptionalPropertyTypes": true,
    "noImplicitOverride": true,
    "importsNotUsedAsValues": "error",
    "types": [],
    "declarationDir": "dist/types",
    "outDir": "dist/esm"
  },
  "include": ["src/**/*.ts", "src/*.ts"],
  "exclude": ["src/*.test.*", "src/**/*.test.*", "src/test/*.ts"]
}
