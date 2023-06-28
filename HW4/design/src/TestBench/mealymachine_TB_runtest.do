SetActiveLib -work
comp -include "$dsn\src\Q3.vhd" 
comp -include "$dsn\src\TestBench\mealymachine_TB.vhd" 
asim +access +r TESTBENCH_FOR_mealymachine 
wave 
wave -noreg clk
wave -noreg reset
wave -noreg inp
wave -noreg outp
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\mealymachine_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_mealymachine 
