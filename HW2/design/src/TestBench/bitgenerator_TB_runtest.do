SetActiveLib -work
comp -include "$dsn\src\3.vhd" 
comp -include "$dsn\src\TestBench\bitgenerator_TB.vhd" 
asim +access +r TESTBENCH_FOR_bitgenerator 
wave 
wave -noreg input_bits
wave -noreg output_bits
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\bitgenerator_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_bitgenerator 
