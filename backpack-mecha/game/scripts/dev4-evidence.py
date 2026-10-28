"""Assemble dev.4 evidence without promoting pending browser/device checks."""
from pathlib import Path
import datetime
import hashlib
import json
import re

root = Path(__file__).resolve().parents[1]
qa = root / 'qa'
read = lambda name: json.loads((qa / name).read_text())
digest = lambda path: hashlib.sha256(path.read_bytes()).hexdigest()
tests = (qa / 'dev4-test-output.txt').read_text()
passed = int(re.search(r'ℹ pass (\d+)', tests)[1])
assert re.search(r'ℹ fail 0\b', tests)
assert re.search(r'ℹ skipped 0\b', tests)
parity = read('dev4-rule-parity.json')
assert parity['currentCombatHash'] == digest(root / 'src/combat.ts')
natural = read('natural-probe-dev4-legacy.json')
assert all(digest(root / path) == value for path, value in natural['sourceHashes'].items())
comparison = read('dev4-natural-comparison.json')
assert comparison['status'] == parity['status'] == 'passed'
perf = read('dev4-performance-summary.json')
perf_source = read('dev4-performance-source.json')
assert all(digest(root / path) == value for path, value in perf_source['sourceHashes'].items())
scenes = read('dev4-motion-scenes.json')
assert all(digest(root / path) == value for path, value in scenes['sourceHashes'].items())
bundle = read('bundle-check.json')
baseline = read('dev4-baseline.json')
art = json.loads((root / 'assets/atlas-manifest.json').read_text())
assert all(digest(root / 'assets' / path) == art['inspection'][key]['sha256'] for key, path in art['atlases'].items())
assert bundle['bytes'] < 11 * 1024 * 1024
sources = [*sorted((root / 'src').glob('*.ts')), root / 'styles.css', root / 'index.html', root / 'assets/atlas-manifest.json']
report = {
    'checkedAt': datetime.datetime.now(datetime.timezone.utc).isoformat(),
    'buildVersion': '0.2.0-dev.4', 'rulesVersion': '0.1.0',
    'status': 'development-build-acceptance-pending',
    'scope': {'D4_00': 'completed', 'D4_01': 'core-implemented-and-engineering-checked',
              'D4_02': 'core-implemented-and-engineering-checked', 'D4_03': 'partial',
              'D4_04': 'local-build-checked-archives-recorded-in-release-manifest',
              'combatOrEconomyValuesChanged': False, 'artPixelsChanged': False, 'onlineDeployment': False},
    'checks': {
        'typecheck': 'passed', 'tests': {'passed': passed, 'failed': 0, 'skipped': 0, 'evidence': 'dev4-test-output.txt'},
        'ruleParity': {'status': 'passed', 'scenarios': len(parity['cases']), 'ticks': parity['ticks'], 'evidence': 'dev4-rule-parity.json'},
        'naturalComparison': {'status': 'passed', 'identicalRuns': comparison['identicalRuns'], 'resumeChecks': comparison['resumeChecks'], 'evidence': 'dev4-natural-comparison.json'},
        'motionScenes': {'count': scenes['generatedFixtures'], 'viewports': scenes['viewportSmokeChecks'], 'evidence': 'dev4-motion-scenes.json'},
        'performance': {'status': perf['status'], 'renderP95GrowthPct': perf['renderP95GrowthPct'], 'evidence': 'dev4-performance-summary.json'},
        'bundle': bundle, 'runtimeGrowthBytesFromDev3': bundle['bytes'] - 9654710,
        'atlasIntegrity': {'status': 'passed', 'regions': len(art['sprites']), 'atlases': len(art['atlases'])},
    },
    'browserFlowEvidence': 'dev4-browser-flow.json',
    'pending': ['Independent Chrome: real twelve-wave win, result and new run',
                'Independent Safari: first chapter, audio, save/reload and background recovery',
                'Android physical-device input, sound, background and performance',
                'iPhone Safari: user has no device available', 'Human comprehension/playtest evidence']
               + ([] if perf['status'] == 'passed' else ['Renderer performance review: ' + perf['status']]),
    'sourceHashes': {str(p.relative_to(root)): digest(p) for p in sources},
    'releaseManifest': '../releases/release-manifest-v0.2.0-dev.4.json',
}
(qa / 'dev4-check.json').write_text(json.dumps(report, ensure_ascii=False, indent=2) + '\n')
print(json.dumps({'tests': passed, 'runtimeBytes': bundle['bytes'], 'performance': perf['status'], 'pending': len(report['pending'])}))
