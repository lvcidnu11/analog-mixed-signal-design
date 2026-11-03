# Common-Source and Source-Follower Design Studies

A comparison of two basic amplifier stages using C18 and ADFP device models, with attention to bias calibration, operating regions, and load definitions.

## Common-source: optimize under explicit constraints

The ADFP study keeps VDD = 0.8 V, TT, 27 °C, L = 16 nm and nfin = 2, while targeting approximately 110 μA and Vout = 0.4 V. The external load is recalculated as 10 times the input NMOS operating-point gate capacitance after sizing changes.

| NMOS / PMOS multiplier | Gain (dB) | −3 dB bandwidth (GHz) | Unity crossing (GHz) | Evidence status |
|---|---:|---:|---:|---|
| 8 / 8 | 20.8095 | 2.5905 | 28.4105 | Archived user-run results |
| 2 / 8 | 14.8654 | 7.2132 | 39.4069 | Corrected operating point confirmed in archived screenshots |
| 2 / 2 | 15.3815 | 7.4199 | 43.1053 | Final selected case; OP, load and TF confirmed in archived screenshots |

The final 2/2 case records CL = 1.889173 fF, Id = 110 μA, Vout ≈ 0.4 V and both devices in saturation. Its reconstructed deck is included.

**Interpretation:** unity crossing improves while gain falls relative to 8/8. This is a topology/sizing/load-policy comparison, not a fixed-load speedup: the external load changes with Cin. The GHz values are nominal schematic-level small-signal results under a very small load; they do not establish a practical system bandwidth or post-layout result. The original remote AC curves are not packaged here.

## Source follower: select a defensible tradeoff

At an intended fixed 1 pF load, the ADFP study compares a follower with a single current sink against a follower using a two-device, shared-gate stacked sink.

| Follower / sink multipliers | Gain (V/V) | Bandwidth (MHz) | Selection |
|---|---:|---:|---|
| 32 / 4 | 0.9275172 | 355.5968 | Single-sink comparison |
| 64 / (8+8) | 0.9405928 | 419.8433 | Higher measured gain; follower reported as Subth |
| 32 / (8+8) | 0.9364341 | 352.1679 | Final selected design |

The selected stacked-sink circuit records 110 μA, Vout ≈ 0.3 V and Rout = 450.1036 Ω. Its simulator region labels are Saturation / Saturation / Linear for follower / upper sink / lower sink. The design is not described as having all devices saturated. The 64-device follower is retained as a comparison, not the selected final design. No PVT or mismatch robustness is inferred from this selection.

## Included decks and reproducibility

- `part1_cic018_cs.sp` and `part2_cic018_cd.sp`: copies of the previously verified C18 design decks, with the student identifier removed.
- `part1_adfp_cs.sp` and `part2_adfp_cd.sp`: reconstructions from confirmed user-run settings, not the original remote files.

Place the separately licensed C18 library at `cic018.l` and the ADFP library at the path specified by each `.lib` directive. With compatible HSPICE and models, run each deck, for example:

```sh
hspice -i netlists/part1_adfp_cs.sp -o part1_adfp_cs
```

Run from this study directory so relative model paths resolve. No model libraries or simulator binaries are supplied. These decks were not rerun during portfolio preparation; numerical agreement with a new run remains to be checked. Some archived runs used a 3 dB bandwidth drop while the reconstructed decks use 3.0103 dB, so final digits can differ. Cross-process comparisons also differ in supply, device structure, and sizing, and do not isolate a process-only benefit.
