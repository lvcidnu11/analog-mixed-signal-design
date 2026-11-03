#!/usr/bin/env python3
"""Recompute OTA AC metrics from archived samples; no circuit simulator needed."""
import csv
import json
import math
from pathlib import Path

root = Path(__file__).resolve().parents[1]
rows = list(csv.DictReader((root / 'studies/telescopic-ota/ac_response.csv').open()))
evidence = json.loads((root / 'studies/telescopic-ota/evidence.json').read_text())
samples = [(float(r['frequency_Hz']), float(r['gain_dB']), float(r['phase_deg'])) for r in rows]
assert len(samples) == 1001, 'Unexpected sample count'
assert all(all(math.isfinite(x) for x in r) for r in samples)
assert all(0 < a[0] < b[0] for a, b in zip(samples, samples[1:]))
a, b = next((a, b) for a, b in zip(samples, samples[1:]) if a[1] > 0 >= b[1])
t = a[1] / (a[1] - b[1])
frequency = math.exp(math.log(a[0]) + t * math.log(b[0] / a[0]))
phase = a[2] + t * (b[2] - a[2])
margin = 180 + phase
listing = evidence['listing_measurements']
assert abs(frequency / listing['fug'] - 1) < 0.001, 'Unity crossing differs by >=0.1%'
assert abs(margin - listing['pm_deg']) < 0.02, 'Phase margin differs by >=0.02 degrees'
assert abs(samples[0][1] - listing['av0_db']) < 0.001
assert len(evidence['op_devices']) == 11
assert all(d['region'] == 'Saturation' for d in evidence['op_devices'].values())
print(json.dumps({'source': 'archived AC samples; log-frequency linear interpolation',
                  'sample_count': len(samples), 'low_frequency_gain_dB': samples[0][1],
                  'unity_gain_frequency_MHz': frequency / 1e6, 'phase_at_unity_deg': phase,
                  'phase_margin_deg': margin, 'archived_device_regions': '11/11 Saturation',
                  'agreement_with_archived_listing': 'PASS'}, indent=2))
