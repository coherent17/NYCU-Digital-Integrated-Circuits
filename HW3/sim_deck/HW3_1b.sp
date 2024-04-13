*   Simulator setting
.option accurate
.option post           
.op
.TEMP 25.0

*   Library setting
.protect
.include '../7nm_FF_160803.pm'
.unprotect

*   Parameter setting
.param cycle = 1n
.param simtime = 5n
.param nfin_p = 1
.param nfin_n = 1

*   Power declaration
vvdd vdd 0 0.8
vvss vss 0 0

*   Input
vin in vss 0

*   Circuit description
.subckt INV in out vdd vss
m1 out in vdd vdd pmos_rvt nfin = nfin_p
m2 out in vss vss nmos_rvt nfin = nfin_n
.ends

xinv in out vdd vss INV

*   DC sweep
.dc vin 0 0.8 0.01

.alter
.param nfin_p = 2

.end   