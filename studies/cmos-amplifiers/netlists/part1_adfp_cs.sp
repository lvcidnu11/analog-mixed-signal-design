* HW1 Part I ADFP CS - settings transcribed from user simulations
.protect
.lib "model_link/n16adfp_spice_model_v1d0_usage.l" TTMacro_MOS_MOSCAP
.unprotect
.option post=1
.temp 27
.param VIN_DC=0.6769715 VBP_DC=0.1176151
VDD vdd 0 0.8
VIN vin 0 DC='VIN_DC' AC=1
VBP vbp 0 DC='VBP_DC'
XMN0 vout vin 0 0 nch_svt_mac L=16n nfin=2 m=2
XMP0 vout vbp vdd vdd pch_svt_mac L=16n nfin=2 m=2
CL vout 0 1.889173f
.op
.tf v(vout) VIN
.dc VIN 0 0.8 0.0001
.meas dc vout_dc FIND v(vout) AT='VIN_DC'
.meas dc id_dc FIND par('-i(VDD)') AT='VIN_DC'
.ac dec 100 1 1t
.probe ac vdb(vout) vp(vout)
.print ac vdb(vout) vp(vout)
.meas ac gain_db FIND vdb(vout) AT=100
.meas ac gain_vv FIND vm(vout) AT=100
.meas ac bw_hz WHEN vdb(vout)='gain_db-3.0103' FALL=1
.meas ac ugbw_hz WHEN vdb(vout)=0 FALL=1
.end
