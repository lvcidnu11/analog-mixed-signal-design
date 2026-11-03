* CD compact gain experiment: single
.protect
.lib "cic018.l" TT
.unprotect
.option post=1 nomod ingold=2 numdgt=10 measdgt=10
.option reltol=1e-6 abstol=1e-12 vntol=1e-8 dccap
* PZ FMAX is an angular-frequency limit (rad/s), not the AC stop frequency.
.option fmax=1e14
.temp 27
.param VDDX=1.8
VDD vdd 0 DC=1.8
VIN vin 0 DC=1.5369155831 AC=1
VB vb 0 DC=0.98336620769 AC=0
MF1 vdd vin vout 0 N_18 W=70u L=0.36u M=1
MS1 vout vb 0 0 N_18 W=4.100446417u L=1.8u M=1
CL vout 0 1p
VCHECK check 0 DC=0
.op
.tf v(vout) VIN
.dc VCHECK 0 1 1
.meas dc vout_dc FIND v(vout) AT=0
.meas dc id_a FIND par('-i(VDD)') AT=0
.meas dc csg_f FIND par('lx18(MF1)+lx21(MF1)+lx32(MF1)') AT=0
.ac dec 100 1 100g
.pz v(vout) VIN
.print ac vdb(vout) vp(vout)
.probe ac vdb(vout) vp(vout)
.meas ac gain_db FIND vdb(vout) AT=100
.meas ac gain_vv FIND vm(vout) AT=100
.meas ac bw_hz WHEN vdb(vout)='gain_db-3.01029995664' FALL=1
.end
