library ieee;
use ieee.std_logic_1164.all;

-- Add your library and packages declaration here ...

entity gcd_lcm_tb is
end gcd_lcm_tb;

architecture TB_ARCHITECTURE of gcd_lcm_tb is
	-- Component declaration of the tested unit
	component gcd_lcm
	port(
		num1 : in INTEGER;
		num2 : in INTEGER;
		gcd : out INTEGER;
		lcm : out INTEGER );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal num1 : INTEGER;
	signal num2 : INTEGER;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal gcd_out : INTEGER;
	signal lcm_out : INTEGER;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : gcd_lcm
		port map (
			num1 => num1,
			num2 => num2,
			gcd => gcd_out,
			lcm => lcm_out
		);

	-- Add your stimulus here ...
	process
	begin
		-- Test case
		num1 <= 12;
		num2 <= 18;
		
		-- Wait for some time to allow the output values to stabilize
		wait for 10 ns;
		
		-- Check the expected output values
		assert gcd_out = 6 report "GCD Test Failed" severity error;
		assert lcm_out = 36 report "LCM Test Failed" severity error;
		
		-- Add more test cases if needed
		
		-- Stop the simulation
		wait;
	end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_gcd_lcm of gcd_lcm_tb is
	for TB_ARCHITECTURE
		for UUT : gcd_lcm
			use entity work.gcd_lcm(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_gcd_lcm;
