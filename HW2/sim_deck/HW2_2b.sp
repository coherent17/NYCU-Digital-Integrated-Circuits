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
M5 Y A vdd vdd pmos_lvt l=lmin w=wp as='64n*108n' ad='64n*108n' pd='2*(64n+108n)' ps='2*(64n+108n)'
M1 Y A n1 vss nmos_lvt l=lmin w=wn as='149n*108n' ad='149n*108n' pd='2*(149n+108n)' ps='2*(149n+108n)'
M2 n1 A vss vss nmos_lvt l=lmin w=wn as='149n*108n' ad='149n*108n' pd='2*(149n+108n)' ps='2*(149n+108n)'
M6 Y A vdd vdd pmos_lvt l=lmin w=wp as='64n*108n' ad='64n*108n' pd='2*(64n+108n)' ps='2*(64n+108n)'
M3 Y A n2 vss nmos_lvt l=lmin w=wn as='149n*108n' ad='149n*108n' pd='2*(149n+108n)' ps='2*(149n+108n)'
M4 n2 A vss vss nmos_lvt l=lmin w=wn as='149n*108n' ad='149n*108n' pd='2*(149n+108n)' ps='2*(149n+108n)'

*   Input voltage
VA A 0 0
.option captab
.probe tran I(vvdd)

.alter
VA A 0 0.8
.end   