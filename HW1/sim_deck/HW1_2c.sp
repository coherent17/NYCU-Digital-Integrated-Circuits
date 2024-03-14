*   Simulator setting
.option accurate
.option post           
.op
.TEMP 25.0


*   Library setting
.protect
.lib '../bulk_32nm.l'TT
.unprotect


*   Parameter setting
.param lmin = 32n
.param cycle = 1n
.param simtime = 5n

*   Schmitt Trigger
*   MOS D G S B type w l
m1 n12 in vss vss nmos_svt w=64n l=400n
m2 out in n12 vss nmos_svt w=64n l=lmin
m3 n34 out n12 vss nmos_svt w=200n l=lmin
m4 vdd ct n34 vss nmos_svt w=150n l=lmin
m5 out in n56 vdd pmos_svt w=150n l=1300n
m6 n56 in vdd vdd pmos_svt w=64n l=1300n
m7 n78 out n56 vdd pmos_svt w=1800n l=lmin
m8 vss ct n78 vdd pmos_svt w=1000n l=lmin

*   Power Setting
vvdd vdd 0 0.9V
vvss vss 0 0V
vin in vss 0V
vct ct vss 0.72V

*   DC SWEEP
.dc vin 0 0.9V 0.01V
.dc vin 0.9V 0 -0.01V
.end