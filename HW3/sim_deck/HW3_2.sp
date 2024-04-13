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
.param nfin_p = 2
.param nfin_n = 1

*   Power declaration
vvdd vdd 0 0.8
vvss vss 0 0

*   Circuit description
.subckt INV in out vdd vss
m1 out in vdd vdd pmos_rvt nfin = nfin_p
m2 out in vss vss nmos_rvt nfin = nfin_n
.ends

xinv1 input A vdd vss INV
xinv2 A B vdd vss INV
xinv3 B input vdd vss INV

*   Initial condition
.ic v(input) = 0

*   Transient
.tran 1p 100p

*   Measurement
.meas pavg AVG POWER
.meas pmax MAX POWER
.meas TRAN PERIOD TRIG V(input) VAL=0.4 RISE=1 TARG V(input) VAL=0.4 RISE=2
.print FREQ =  1/PERIOD
.end