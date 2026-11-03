* HW1 Part I CIC018 CS; L=0.18um, gm/Id=2/2
.protect
.lib "cic018.l" TT
.unprotect
.option post=1 nomod ingold=2 numdgt=10 measdgt=10
.option reltol=1e-6 abstol=1e-12 vntol=1e-8 dccap
* PZ FMAX is an angular-frequency limit (rad/s), not the AC stop frequency.
.option fmax=1e14
.temp 27
.param VDDX=1.8
.param VIN_DC=1.1026436959 VB_DC=0.58438643769
VDD vdd 0 DC='VDDX'
VIN vin 0 DC='VIN_DC' AC=1
VB vb 0 DC='VB_DC' AC=0
.param CIN=7.709309252e-16
* Two-transistor CS body, lengths/widths in um; ID=110uA
MN1 vout vin 0 0 N_18 W=0.4186565897u L=0.18u M=1
MP1 vout vb vdd vdd P_18 W=1.113693023u L=0.18u M=1
CL vout 0 '10*CIN'
* VCHECK is an isolated source; the amplifier is never output-clamped.
VCHECK check 0 DC=0
.op
.tf v(vout) VIN
.dc VCHECK 0 1 1
.meas dc vout_dc FIND v(vout) AT=0
.meas dc id_a FIND par('-i(VDD)') AT=0
* Charge-conserving drain-from-gate feedthrough; differs from OP cgd.
.meas dc cdg_f FIND par('-lx32(MN1)') AT=0
.ac dec 100 1 100g
.pz v(vout) VIN
.probe ac vdb(vout) vp(vout)
.print ac vdb(vout) vp(vout)
.meas ac gain_db FIND vdb(vout) AT=100
.meas ac gain_vv FIND vm(vout) AT=100
.meas ac bw_hz WHEN vdb(vout)='gain_db-3.01029995664' FALL=1
.meas ac ugbw_hz WHEN vdb(vout)=0 FALL=1
.end
