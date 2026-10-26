import { cp, mkdir, copyFile } from 'node:fs/promises';
import { existsSync } from 'node:fs';
await mkdir('dist', { recursive: true });
for (const file of ['index.html', 'styles.css']) await copyFile(file, `dist/${file}`);
if (existsSync('assets')) await cp('assets', 'dist/assets', { recursive: true });
console.log('Jelly Flow built in dist/');
