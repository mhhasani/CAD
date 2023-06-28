SetActiveLib -work
comp -include "$dsn\src\Q3.vhd" 
comp -include "$dsn\src\TestBench\mooremachine_TB.vhd" 
asim +access +r TESTBENCH_FOR_mooremachine 
wave 
wave -noreg clk
wave -noreg reset
wave -noreg inp
wave -noreg outp
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\mooremachine_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_mooremachine 
