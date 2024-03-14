*   Simulator setting
.option accurate
.option post           
.op
.TEMP 25.0
.global gnd! vdd!


*   Library setting
.protect
.lib '../bulk_32nm.l'TT
.unprotect

*   Voltage setting
Vgsn gn gnd! 0
Vdsn dn gnd! 0

Vgsp gp vdd! 0
Vdsp dp vdd! 0

Vvdd vdd! 0 0.9v
Vgnd gnd! 0 0v

*   Nmos transistor
mn dn gn gnd! gnd! nmos_svt w=64n l=32n
mp dp gp vdd! vdd! pmos_svt w=64n l=32n

*   Perform DC sweep
.dc Vdsn 0 0.9 0.05 SWEEP Vgsn 0 0.9 0.1
.dc Vdsp -0.9 0 0.05 SWEEP Vgsp -0.9 0 0.1
.PROBE DC i(mn)
.PROBE DC i(mp)
.end