SetActiveLib -work
comp -include "$dsn\src\Q3.vhd" 
comp -include "$dsn\src\TestBench\unary_to_binary_TB.vhd" 
asim +access +r TESTBENCH_FOR_unary_to_binary 
wave 
wave -noreg unary
wave -noreg binary
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\unary_to_binary_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_unary_to_binary 
