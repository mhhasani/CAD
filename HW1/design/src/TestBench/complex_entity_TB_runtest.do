SetActiveLib -work
comp -include "$dsn\src\Q5.vhd" 
comp -include "$dsn\src\TestBench\complex_entity_TB.vhd" 
asim +access +r TESTBENCH_FOR_complex_entity 
wave 
wave -noreg num1
wave -noreg num2
wave -noreg operation
wave -noreg result
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\complex_entity_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_complex_entity 
