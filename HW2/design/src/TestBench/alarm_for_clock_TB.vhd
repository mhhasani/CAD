library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity alarm_for_clock_tb is
end alarm_for_clock_tb;

architecture TB_ARCHITECTURE of alarm_for_clock_tb is
	-- Component declaration of the tested unit
	component alarm_for_clock
	port(
		clk : in STD_LOGIC;
		rst : in STD_LOGIC;
		clk_set : in STD_LOGIC;
		alarm_set : in STD_LOGIC;
		alarm_stop : in STD_LOGIC;
		hour : in STD_LOGIC_VECTOR(5 downto 0);
		minute : in STD_LOGIC_VECTOR(7 downto 0);
		on_alarm : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk : STD_LOGIC;
	signal rst : STD_LOGIC;
	signal clk_set : STD_LOGIC;
	signal alarm_set : STD_LOGIC;
	signal alarm_stop : STD_LOGIC;
	signal hour : STD_LOGIC_VECTOR(5 downto 0);
	signal minute : STD_LOGIC_VECTOR(7 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal on_alarm : STD_LOGIC;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : alarm_for_clock
		port map (
			clk => clk,
			rst => rst,
			clk_set => clk_set,
			alarm_set => alarm_set,
			alarm_stop => alarm_stop,
			hour => hour,
			minute => minute,
			on_alarm => on_alarm
		);

	-- Add your stimulus here ...
	stim_process: process
	begin
	   -- Initialize signals
	   rst <= '1';
	   clk_set <= '0';
	   alarm_set <= '0';
	   alarm_stop <= '0';
	   hour <= "000000";
	   minute <= "00000000";
	   
	   -- Wait for reset to finish
	   wait for 10 ns;
	   rst <= '0';
	   
	   -- Test case 1: Set the clock
	   clk_set <= '1';
	   hour <= "000011";
	   minute <= "00111100";
	   wait for 10 ns;
	   clk_set <= '0';
	   
	   -- Test case 2: Set the alarm
	   alarm_set <= '1';
	   hour <= "001100";
	   minute <= "10101010";
	   wait for 10 ns;
	   alarm_set <= '0';
	   
	   -- Test case 3: Trigger the alarm
	   alarm_stop <= '1';
	   wait for 10 ns;

	   -- Test case 4: Stop the alarm
	   alarm_stop <= '0';
	   wait for 10 ns;
	
 
	   wait;
	end process stim_process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_alarm_for_clock of alarm_for_clock_tb is
	for TB_ARCHITECTURE
		for UUT : alarm_for_clock
			use entity work.alarm_for_clock(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_alarm_for_clock;

