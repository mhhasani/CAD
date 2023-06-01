SetActiveLib -work
comp -include "$dsn\src\4.vhd" 
comp -include "$dsn\src\TestBench\alarm_for_clock_TB.vhd" 
asim +access +r TESTBENCH_FOR_alarm_for_clock 
wave 
wave -noreg clk
wave -noreg rst
wave -noreg clk_set
wave -noreg alarm_set
wave -noreg alarm_stop
wave -noreg hour
wave -noreg minute
wave -noreg on_alarm
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\alarm_for_clock_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_alarm_for_clock 
