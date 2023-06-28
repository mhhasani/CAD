SetActiveLib -work
comp -include "$dsn\src\Q4.vhd" 
comp -include "$dsn\src\TestBench\binary_to_unary_TB.vhd" 
asim +access +r TESTBENCH_FOR_binary_to_unary 
wave 
wave -noreg binary
wave -noreg unary
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\binary_to_unary_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_binary_to_unary 
