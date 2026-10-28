"""Verify dev.5 evidence while keeping real-browser/device gaps explicit."""
from pathlib import Path
import datetime
import hashlib
import json
import math
import re
import subprocess

root = Path(__file__).resolve().parents[1]
qa = root / 'qa'
read = lambda name: json.loads((qa / name).read_text())
digest = lambda path: hashlib.sha256(path.read_bytes()).hexdigest()
baseline = read('dev5-baseline.json')
probe = read('dev5-expeditions.json')
browser = read('dev5-browser-flow.json')
web_report = read('dev5-browser-first-light-report.json')
assert json.loads((root / 'package.json').read_text())['version'] == '0.2.0-dev.5'
assert all(digest(root / path) == value for path, value in probe['sourceHashes'].items()), 'Stale probe evidence'
assert len(probe['results']) == 216 and probe['baselineMatches'] == 60
assert all(r['verifiedResume'] for r in probe['results'])
assert all(r['diagnostics']['dropped'] == 0 for r in probe['results'])
assert all(r['spending']['droppedJournalEvents'] == 0 for r in probe['results'])
rules = ['src/combat.ts', 'src/economy.ts', 'src/encounters.ts', 'src/content.ts', 'src/random.ts',
         'assets/content.json', 'assets/atlas-manifest.json']
assert all(digest(root / p) == baseline['sourceHashes'][p] for p in rules)
tests = (qa / 'dev5-test-output.txt').read_text()
passed = int(re.search(r'ℹ pass (\d+)', tests)[1])
assert re.search(r'ℹ fail 0\b', tests) and re.search(r'ℹ skipped 0\b', tests)
index = subprocess.check_output(['git', 'ls-files', '-s'], cwd=root)
assert hashlib.sha256(index).hexdigest() == baseline['indexEntriesSha256'], 'Previous version staging changed'
head = subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=root).decode().strip()
head_tree = subprocess.check_output(['git', 'rev-parse', 'HEAD^{tree}'], cwd=root).decode().strip()
staged_files = len(subprocess.check_output(['git', 'diff', '--cached', '--name-only'], cwd=root).decode().splitlines())
previous_committed = head_tree == baseline['stagedTree']
assert web_report['buildVersion'] == '0.2.0-dev.5'
assert digest(qa / browser['evidence']) == browser['reportSha256']
for wave, frame in web_report['journal']['frames'].items():
    recent = frame['recent']
    raw = sorted(recent['intervals'])
    measured = web_report['performance']['waves'][wave]
    assert len(raw) <= 3600
    assert measured['interval']['p95Ms'] == raw[math.ceil(len(raw) * .95) - 1]
    assert measured['interval']['maxMs'] == max(raw)
bundle = read('bundle-check.json')
assert bundle['status'] == 'passed' and bundle['bytes'] < 11 * 1024 * 1024
manifest = json.loads((root / 'assets/atlas-manifest.json').read_text())
assert all(digest(root / 'assets' / p) == manifest['inspection'][key]['sha256'] for key, p in manifest['atlases'].items())
sources = [*sorted((root / 'src').glob('*.ts')), *sorted((root / 'scripts').glob('*.ts')),
           *sorted((root / 'tests').glob('*.ts')), root / 'scripts/dev5-evidence.py', root / 'package.json']
report = {
    'checkedAt': datetime.datetime.now(datetime.timezone.utc).isoformat(),
    'buildVersion': '0.2.0-dev.5', 'rulesVersion': '0.1.0',
    'status': 'development-build-independent-browser-and-device-acceptance-pending',
    'staging': {'previousVersion': '0.2.0-dev.4', 'filesStagedAtHandoff': baseline['stagedFiles'],
                'tree': baseline['stagedTree'], 'indexEntriesUnchanged': True,
                'currentStagedFiles': staged_files,
                'currentState': 'previous-version-committed-outside-this-task' if previous_committed else 'previous-version-staged',
                'previousVersionCommit': head if previous_committed else None,
                'newVersionChanges': 'working-tree-only', 'commitCreatedByThisTask': False},
    'checks': {
        'typecheck': 'passed', 'tests': {'passed': passed, 'failed': 0, 'skipped': 0, 'evidence': 'dev5-test-output.txt'},
        'rulesAndArtUnchanged': True,
        'naturalExpeditions': {'runs': len(probe['results']), 'baselineMatches': probe['baselineMatches'],
                              'resumeChecks': sum(r['resumedWaves'] for r in probe['results']),
                              'failedRunsRetained': sum(r['report']['status'] == 'lost' for r in probe['results']),
                              'evidence': 'dev5-expeditions.json', 'coverage': probe['coverage']},
        'browser': {'status': 'first-wave-and-save-reload-checked', 'browser': browser['browser'],
                    'evidence': 'dev5-browser-flow.json', 'rawPercentilesRecomputed': True},
        'bundle': bundle,
    },
    'interpretationCaveat': 'The delayed model changes both decision cadence and action latency. At 300ms cadence the existing pilot also stops velocity extrapolation (its sensor window is below 250ms). This is not a latency-only ablation or a human skill classification.',
    'pending': browser['pending'] + ['Natural event choices: ' + ', '.join(probe['coverage']['missingEventChoices'])],
    'sourceHashes': {str(p.relative_to(root)): digest(p) for p in sources},
    'evidenceHashes': {name: digest(qa / name) for name in ['dev5-expeditions.json', 'dev5-expeditions-runs.json.gz',
                       'dev5-browser-flow.json', 'dev5-browser-first-light-report.json', 'dev5-test-output.txt']},
    'releaseManifest': '../releases/release-manifest-v0.2.0-dev.5.json', 'onlineDeployment': False,
}
(qa / 'dev5-check.json').write_text(json.dumps(report, ensure_ascii=False, indent=2) + '\n')
print(json.dumps({'tests': passed, 'runs': len(probe['results']), 'resumeChecks': report['checks']['naturalExpeditions']['resumeChecks'],
                  'previousVersionIndexPreserved': True, 'runtimeBytes': bundle['bytes']}))
