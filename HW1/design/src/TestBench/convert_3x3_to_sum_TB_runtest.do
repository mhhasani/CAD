SetActiveLib -work
comp -include "$dsn\src\Q1.vhd" 
comp -include "$dsn\src\TestBench\convert_3x3_to_sum_TB.vhd" 
asim +access +r TESTBENCH_FOR_convert_3x3_to_sum 
wave 
wave -noreg in_3x3
wave -noreg out_sum
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\convert_3x3_to_sum_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_convert_3x3_to_sum 
