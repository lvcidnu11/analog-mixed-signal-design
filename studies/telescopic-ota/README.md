# Telescopic Cascode OTA

The design objective is to meet gain, unity-gain frequency, and phase-margin requirements simultaneously while maintaining valid DC operating points.

## Design sequence

1. Select input-device gm/Id near 15 V⁻¹ and PMOS-load gm/Id near 12 V⁻¹ as initial sizing guides. The archived report uses L = 1.2 μm and current-density characterization at NMOS VDS = 0.4 V and PMOS VSD = 0.2 V.
2. Use device multiplicity to implement practical widths, then recheck the actual amplifier operating point: body bias and drain voltage differ from isolated characterization conditions.
3. Adjust the PMOS cascode bias, tail reference current, and NMOS cascode bias in sequence. Repeat because each adjustment can move internal nodes.
4. Verify branch currents near 39 μA, outputs near 2.4991 V, and saturation for all eleven transistors.
5. Evaluate the differential AC response with 1 pF at each output.

These steps summarize the archived design report; the complete sizing/sweep history is not packaged here.

## What the result teaches

Cascoding increases output resistance and DC gain, but internal nodes add capacitance and phase lag. High gain alone does not establish adequate unity-frequency stability. Here the achieved UGF is only about 1.28% above the 70 MHz target: the nominal result meets the target, but does not demonstrate margin across process, voltage, or temperature.

The 852.7 Hz open-loop −3 dB bandwidth and 70.89 MHz unity-gain frequency describe different points on the same high-gain response. They must not be used interchangeably.

## Measurement convention

Both inputs have 2.5 V DC common mode. Differential AC excitation is +0.5 V and −0.5 V, giving 1 V differential normalization. Output is the complex voltage difference V(voi)−V(vop), divided by the differential input. AC analysis is a linearization around the DC operating point; the 1 V normalization is not a tested large-signal swing.

For the stated differential unity-negative-feedback convention, phase margin is 180° plus the continuously unwrapped phase at the first falling 0 dB crossing. The saved trace gives approximately −111.5642° there, hence 68.4358°. This does not characterize a common-mode feedback loop.

## Evidence and remaining work

- `ac_response.csv`: 1001 saved frequency, gain, and phase samples from the previous HSPICE export.
- `evidence.json`: archived measurement values, reported conditions, and eleven device operating-point records.
- `../../scripts/analyze_ota.py`: independently recalculates the crossing from the saved trace.

The older report references original `.sp`, `.cir`, `.lis`, and `.ac0` files that are absent from their recorded local locations. Earlier baseline decks have different biases and are deliberately not presented as the final measured circuit. Restore the matching final files before claiming full simulation reproducibility. The archived schematic is also withheld until it can be matched against that final deck. No new HSPICE run was performed for this portfolio.
