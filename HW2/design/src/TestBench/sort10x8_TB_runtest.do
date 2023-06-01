SetActiveLib -work
comp -include "$dsn\src\1.vhd" 
comp -include "$dsn\src\TestBench\sort10x8_TB.vhd" 
asim +access +r TESTBENCH_FOR_sort10x8 
wave 
wave -noreg matrixIn
wave -noreg matrixOut
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\sort10x8_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_sort10x8 
