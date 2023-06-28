library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity binary_to_unary_tb is
end binary_to_unary_tb;

architecture TB_ARCHITECTURE of binary_to_unary_tb is
	-- Component declaration of the tested unit
	component binary_to_unary
	port(
		binary : in STD_LOGIC_VECTOR(2 downto 0);
		unary : out STD_LOGIC_VECTOR(7 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal binary : STD_LOGIC_VECTOR(2 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal unary : STD_LOGIC_VECTOR(7 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : binary_to_unary
		port map (
			binary => binary,
			unary => unary
		);

	-- Add your stimulus here ...
	process
	begin
		wait for 10 ns;

		-- Test case 1
		binary <= "000";
		wait for 10 ns;
		assert unary = "00000001" report "Test case 1 failed" severity error;
		
		-- Test case 2
		binary <= "001";
		wait for 10 ns;
		assert unary = "00000010" report "Test case 2 failed" severity error;
		
		-- Test case 3
		binary <= "010";
		wait for 10 ns;
		assert unary = "00000100" report "Test case 3 failed" severity error;
		
		-- Test case 4
		binary <= "011";
		wait for 10 ns;
		assert unary = "00001000" report "Test case 4 failed" severity error;
		
		-- Test case 5
		binary <= "100";
		wait for 10 ns;
		assert unary = "00010000" report "Test case 5 failed" severity error;
		
		-- Test case 6
		binary <= "101";
		wait for 10 ns;
		assert unary = "00100000" report "Test case 6 failed" severity error;
		
		-- Test case 7
		binary <= "110";
		wait for 10 ns;
		assert unary = "01000000" report "Test case 7 failed" severity error;
		
		-- Test case 8
		binary <= "111";
		wait for 10 ns;
		assert unary = "10000000" report "Test case 8 failed" severity error;
		
		-- End the simulation
		wait;
	end process;
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_binary_to_unary of binary_to_unary_tb is
	for TB_ARCHITECTURE
		for UUT : binary_to_unary
			use entity work.binary_to_unary(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_binary_to_unary;

