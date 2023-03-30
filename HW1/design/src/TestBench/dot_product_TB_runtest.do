SetActiveLib -work
comp -include "$dsn\src\Q4.vhd" 
comp -include "$dsn\src\TestBench\dot_product_TB.vhd" 
asim +access +r TESTBENCH_FOR_dot_product 
wave 
wave -noreg a
wave -noreg b
wave -noreg c
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\dot_product_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_dot_product 
