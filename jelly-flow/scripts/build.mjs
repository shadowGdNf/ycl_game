import { cp, mkdir, copyFile, rm, writeFile } from 'node:fs/promises';
import { existsSync } from 'node:fs';
import { spawnSync } from 'node:child_process';
import { fileURLToPath } from 'node:url';

process.chdir(fileURLToPath(new URL('../', import.meta.url)));
await rm('dist', { recursive: true, force: true });
const result = spawnSync(process.execPath, ['node_modules/typescript/bin/tsc'], { stdio: 'inherit' });
if (result.status !== 0) process.exit(result.status ?? 1);
await mkdir('dist', { recursive: true });
for (const file of ['index.html', 'styles.css']) await copyFile(file, `dist/${file}`);
if (existsSync('assets')) await cp('assets', 'dist/assets', { recursive: true });
await writeFile('dist/.nojekyll', '');
console.log('Jelly Flow built in dist/');
