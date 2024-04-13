*   Simulator setting
.option accurate
.option post           
.op
.TEMP 25.0

*   Library setting
.protect
.include '../7nm_FF_160803.pm'
.unprotect

*   Power
vvdd vdd 0 0.8
vvss vss 0 0

*   Input
vdsp vdsp vdd 0
vdsn vdsn vss 0
vgsp vgsp vdd 0
vgsn vgsn vss 0

*   Circuit
*   D G S B type nfin
m1 vdsp vgsp vdd vdd pmos_rvt nfin = 1
m2 vdsn vgsn vss vss nmos_rvt nfin = 1

*   dc sweep and measurement
.dc vdsp 0 -0.8 -0.01  sweep vgsp -0.35 -0.8 -0.05
.probe i(m1)
.print i(m1)

.dc vdsn 0  0.8  0.01  sweep vgsn 0.35 0.8 0.05
.probe i(m2)
.print i(m2)

.end   
