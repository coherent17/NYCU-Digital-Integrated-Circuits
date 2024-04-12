*    Simulator setting
.option accurate
.option post
.op
.TEMP 25.0

*   Library setting
.protect
.lib '../bulk_32nm.l'TT
.unprotect

*   Parameter setting
.param xvdd = 0.8
.param xvss = 0
.param wp = 64n
.param wn = 149n
.param lmin = 32n

*   Power declaration
vvdd    vdd    0    xvdd
vvss	vss    0    xvss

*   Circuit description
.subckt ND2 in1 in2 out vdd vss
M5 out in1 vdd vdd pmos_lvt l=lmin w=wp as='64n*108n' ad='64n*108n' pd='2*(64n+108n)' ps='2*(64n+108n)'
M1 out in1 n1 vss nmos_lvt l=lmin w=wn as='149n*108n' ad='149n*108n' pd='2*(149n+108n)' ps='2*(149n+108n)'
M2 n1 in2 vss vss nmos_lvt l=lmin w=wn as='149n*108n' ad='149n*108n' pd='2*(149n+108n)' ps='2*(149n+108n)'
M6 out in2 vdd vdd pmos_lvt l=lmin w=wp as='64n*108n' ad='64n*108n' pd='2*(64n+108n)' ps='2*(64n+108n)'
M3 out in2 n2 vss nmos_lvt l=lmin w=wn as='149n*108n' ad='149n*108n' pd='2*(149n+108n)' ps='2*(149n+108n)'
M4 n2 in1 vss vss nmos_lvt l=lmin w=wn as='149n*108n' ad='149n*108n' pd='2*(149n+108n)' ps='2*(149n+108n)'
.ends

X1 in1 in2 Y vdd vss ND2
X2 Y vdd out2 vdd vss ND2
X3 Y vdd out3 vdd vss ND2

*   Input voltage
vin1 in1 0 0.8
vin2 in2 0 pulse (0 0.8 0ns 0.4ns 0.4ns 0.6ns 2ns)

*   Measure
.tran 0.001n 5n
.meas tran AvgPower AVG Power
.meas tran PeakPower MAX Power
.meas tran tdr1 trig v(in1) val='0.45*0.8' fall=1 targ v(Y) val='0.5*0.8' rise=1
.meas tran tdf1 trig v(in1) val='0.45*0.8' rise=1 targ v(Y) val='0.5*0.8' fall=1
.meas tran tdr2 trig v(in2) val='0.45*0.8' fall=1 targ v(Y) val='0.5*0.8' rise=1
.meas tran tdf2 trig v(in2) val='0.45*0.8' rise=1 targ v(Y) val='0.5*0.8' fall=1


.alter
vin1 in1 0 pulse (0 0.8 0ns 0.4ns 0.4ns 0.6ns 2ns)
vin2 in2 0 0.8

.end   