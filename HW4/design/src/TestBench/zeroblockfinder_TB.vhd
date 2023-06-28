library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity zeroblockfinder_tb is
end zeroblockfinder_tb;

architecture TB_ARCHITECTURE of zeroblockfinder_tb is
	-- Component declaration of the tested unit
	component zeroblockfinder
	port(
		clk : in STD_LOGIC;
		input : in STD_LOGIC;
		start_first_zero_block : out INTEGER range 0 to 255;
		end_first_zero_block : out INTEGER range 0 to 255;
		start_last_zero_block : out INTEGER range 0 to 255;
		end_last_zero_block : out INTEGER range 0 to 255;
		current_index : out INTEGER range 0 to 255 );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk : STD_LOGIC;
	signal input : STD_LOGIC;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal start_first_zero_block : INTEGER range 0 to 255;
	signal end_first_zero_block : INTEGER range 0 to 255;
	signal start_last_zero_block : INTEGER range 0 to 255;
	signal end_last_zero_block : INTEGER range 0 to 255;
	signal current_index : INTEGER range 0 to 255;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : zeroblockfinder
		port map (
			clk => clk,
			input => input,
			start_first_zero_block => start_first_zero_block,
			end_first_zero_block => end_first_zero_block,
			start_last_zero_block => start_last_zero_block,
			end_last_zero_block => end_last_zero_block,
			current_index => current_index
		);

	-- Add your stimulus here ...
	-- Clock process definitions
	clk_process : process
	begin
		clk <= '1';
		wait for 5 ns;
		clk <= '0';
		wait for 5 ns;
	end process;

	-- Stimulus process definitions
	stimulus : process
	  -- test 001111000000111110001
	begin
		wait for 10 ns;
		input <= '0';
		wait for 10 ns;
		input <= '0';
		wait for 10 ns;
		input <= '1';
		wait for 10 ns;
		input <= '1';
		wait for 10 ns;
		input <= '1';
		wait for 10 ns;
		input <= '1';
		wait for 10 ns;
		input <= '0';
		wait for 10 ns;
		input <= '0';
		wait for 10 ns;
		input <= '0';
		wait for 10 ns;
		input <= '0';
		wait for 10 ns;
		input <= '0';
		wait for 10 ns;
		input <= '1';
		wait for 10 ns;
		input <= '1';
		wait for 10 ns;
		input <= '1';
		wait for 10 ns;
		input <= '1';
		wait for 10 ns;
		input <= '1';
		wait for 10 ns;
		input <= '0';
		wait for 10 ns;
		input <= '0';
		wait for 10 ns;
		input <= '0';
		wait for 10 ns;
		input <= '1';
		wait for 10 ns;
	
	end process; 
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_zeroblockfinder of zeroblockfinder_tb is
	for TB_ARCHITECTURE
		for UUT : zeroblockfinder
			use entity work.zeroblockfinder(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_zeroblockfinder;

