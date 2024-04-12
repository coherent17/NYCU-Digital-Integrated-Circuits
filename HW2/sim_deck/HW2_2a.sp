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
.param wn = 64n
.param lmin = 32n

*   Power declaration
vvdd    vdd    0    xvdd
vvss	vss    0    xvss

*   Circuit description
M1 Y A vdd vdd pmos_lvt l=lmin w=wp
M2 Y A n1 vss nmos_lvt l=lmin w=wn
M3 n1 A vss vss nmos_lvt l=lmin w=wn
M4 Y A vdd vdd pmos_lvt l=lmin w=wp
M5 Y A n2 vss nmos_lvt l=lmin w=wn
M6 n2 A vss vss nmos_lvt l=lmin w=wn

*   Input voltage
VA A 0 0.8

*   DC sweep
*.dc VA 0 0.8 0.01
.dc VA 0 0.8 0.01 sweep wn 64n 200n 1n

.end   

