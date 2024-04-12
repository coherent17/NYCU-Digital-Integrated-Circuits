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
.lib '../bulk_32nm.l'TT
.unprotect


********************************
**     Parameter setting      **
********************************
.param xvdd = 0.9
.param xvss = 0
.param wp4 = 100n
.param wp5 = 100n
.param wp6 = 100n
.param wn1 = 500n
.param wn2 = 100n
.param wn3 = 2500n
.param cycle = 1n
.param simtime = 5n
.param xvCT = 0.9

********************************
**     Circuit description    **
********************************
.subckt Inv1 in out  vdd vss
m1 out  in  vss  vss nmos_svt w=wn1 l=32n
m2 out  in  vdd  vdd pmos_svt w=wn1*2 l=32n
.ends

.subckt Inv2 in out  vdd vss
m1 out  in  vss  vss nmos_lvt w=wn1 l=32n
m2 out  in  vdd  vdd pmos_lvt w=wn1*2 l=32n
.ends

.subckt Inv3 in out  vdd vss
m1 out  in  vss  vss nmos_hvt w=wn1 l=32n
m2 out  in  vdd  vdd pmos_hvt w=wn1*2 l=32n
.ends

xinv_1 input output1  vdd vss Inv1
xinv_2 input output2  vdd vss Inv2
xinv_3 input output3  vdd vss Inv3
cload1  output1 vss 5f
cload2  output2 vss 5f
cload3  output3 vss 5f

********************************
**     Power declaration      **
********************************
vvdd       vdd       0    xvdd
vvss       vss       0    xvss
vCT		   CT		 0 	  xvCT
********************************
**     Input declaration      **
********************************
vin        input     0    pulse(xvdd 0 1n 0.1n 0.1n 'cycle*0.45' cycle)


********************************
**     Analysis setting       **
********************************

.tran 1p simtime
.end   


