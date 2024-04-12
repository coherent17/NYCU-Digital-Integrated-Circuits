********************************
**     Simulator setting      **
********************************
.option accurate
.option post           
.op
.TEMP 25.0


********************************
**     Library setting        **
********************************
.protect
.include '../7nm_TT_160803.pm'
.unprotect


********************************
**     Parameter setting      **
********************************
.param xvdd = 0.7
.param xvss = 0
.param num = 1
.param cycle = 1n
.param simtime = 5n

********************************
**     Circuit description    **
********************************
.subckt inv in out vdd vss
m1 out in vdd vdd pmos_rvt nfin = num
m2 out in vss vss nmos_rvt nfin = 1
.ends

xinv_1 input output vdd vss inv
cload  output vss 5f

********************************
**     Power declaration      **
********************************
vvdd       vdd       0    xvdd
vvss       vss       0    xvss

********************************
**     Input declaration      **
********************************
vin        input     0    0


********************************
**     Analysis setting       **
********************************

.dc vin 0 0.7 0.01 sweep num 1 10 1

.end   


