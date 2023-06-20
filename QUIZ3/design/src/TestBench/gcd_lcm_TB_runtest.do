SetActiveLib -work
comp -include "$dsn\src\1.vhd" 
comp -include "$dsn\src\TestBench\gcd_lcm_TB.vhd" 
asim +access +r TESTBENCH_FOR_gcd_lcm 
wave 
wave -noreg num1
wave -noreg num2
wave -noreg gcd
wave -noreg lcm
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\gcd_lcm_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_gcd_lcm 
