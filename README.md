Digital_clock_1BM23EC284
AAT 2 - Digital Clock Design and Verification
Author: Varsha R USN: 1BM23EC284 Section: E

Description
6-bit seconds and minutes synchronous digital clock implemented in SystemVerilog with functional coverage and assertions.

Tools Used
Cadence Xcelium

How to Run
cd ~/CadWorkDir/Digital
csh
source .cshrc
cd 1BM23EC284
ncvlog +access+r +sv +nccoverage+all -covoverwrite digital_clock.sv clock_interface.sv clock_test.sv clock_tb.sv
ncsim clock_tb
imc -gui

Coverage Achieved
100%
