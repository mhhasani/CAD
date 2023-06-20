SetActiveLib -work
comp -include "$dsn\src\Q2.vhd" 
comp -include "$dsn\src\TestBench\recursive_functions_entity_TB.vhd" 
asim +access +r TESTBENCH_FOR_recursive_functions_entity 
wave 
wave -noreg BCD_In
wave -noreg Binary_Out
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\recursive_functions_entity_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_recursive_functions_entity 
