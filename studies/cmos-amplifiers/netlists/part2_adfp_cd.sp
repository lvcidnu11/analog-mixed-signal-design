* HW1 Part II ADFP - selected32/(8+8), archived user-simulated settings
.protect
.lib "model_link/n16adfp_spice_model_v1d0_usage.l" TTMacro_MOS_MOSCAP
.unprotect
.option post=1
.temp 27

.param VIN_DC=0.6972394
.param VBN_DC=0.5661651

VDD vdd 0 0.8
VIN vin 0 DC='VIN_DC' AC=1
VBN vbn 0 DC='VBN_DC'

XF vdd vin vout 0 nch_svt_mac L=16n nfin=2 m=32
XS1 vout vbn mid 0 nch_svt_mac L=16n nfin=2 m=8
XS2 mid vbn 0 0 nch_svt_mac L=16n nfin=2 m=8
CL vout 0 1p

.op
.tf v(vout) VIN
.dc VIN 0 0.8 0.0001
.meas dc vout_dc FIND v(vout) AT='VIN_DC'
.meas dc id_dc FIND par('-i(VDD)') AT='VIN_DC'
.meas dc vmid_dc FIND v(mid) AT='VIN_DC'

.ac dec 100 1 1t
.probe ac vdb(vout) vp(vout)
.print ac vdb(vout) vp(vout)
.meas ac gain_db FIND vdb(vout) AT=100
.meas ac gain_vv FIND vm(vout) AT=100
.meas ac bw_hz WHEN vdb(vout)='gain_db-3.0103' FALL=1
.end
