---
to: "<%= (locals.isLernaRoot) ? null : 'src/index.ts' %>"
---
export function hello(): void {
  console.log('Hello world!');
}
