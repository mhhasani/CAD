SetActiveLib -work
comp -include "$dsn\src\Q1.vhd" 
comp -include "$dsn\src\TestBench\zeroblockfinder_TB.vhd" 
asim +access +r TESTBENCH_FOR_zeroblockfinder 
wave 
wave -noreg clk
wave -noreg input
wave -noreg start_first_zero_block
wave -noreg end_first_zero_block
wave -noreg start_last_zero_block
wave -noreg end_last_zero_block
wave -noreg current_index
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\zeroblockfinder_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_zeroblockfinder 
