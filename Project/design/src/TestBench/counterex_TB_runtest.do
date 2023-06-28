SetActiveLib -work
comp -include "$dsn\src\main.vhd" 
comp -include "$dsn\src\TestBench\counterex_TB.vhd" 
asim +access +r TESTBENCH_FOR_counterex 
wave 
wave -noreg clk
wave -noreg reset
wave -noreg out_moore
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\counterex_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_counterex 
