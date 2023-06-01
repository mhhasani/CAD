SetActiveLib -work
comp -include "$dsn\src\2.vhd" 
comp -include "$dsn\src\TestBench\sqrtceiling_TB.vhd" 
asim +access +r TESTBENCH_FOR_sqrtceiling 
wave 
wave -noreg input_number
wave -noreg sqrt_ceiling
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\sqrtceiling_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_sqrtceiling 
