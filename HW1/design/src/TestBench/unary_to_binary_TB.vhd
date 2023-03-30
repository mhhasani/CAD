library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity unary_to_binary_tb is
end unary_to_binary_tb;

architecture TB_ARCHITECTURE of unary_to_binary_tb is
	-- Component declaration of the tested unit
	component unary_to_binary
	port(
		unary : in STD_LOGIC_VECTOR(15 downto 0);
		binary : out STD_LOGIC_VECTOR(3 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal unary : STD_LOGIC_VECTOR(15 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal binary : STD_LOGIC_VECTOR(3 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : unary_to_binary
		port map (
			unary => unary,
			binary => binary
		);

	-- Add your stimulus here ...

	-- Stimulus process
	stimulus : process
	begin
		-- test 1
		wait for 10 ns;
		unary <= "0000000000000001";
		wait for 10 ns;
		assert (binary = "0001") report "Test 1 failed" severity error;
		
		-- test 2
		unary <= "0000000000000111";
		wait for 10 ns;
		assert (binary = "0011") report "Test 2 failed" severity error;

		-- test 3
		unary <= "0000000111111111";
		wait for 10 ns;
		assert (binary = "1001") report "Test 3 failed" severity error;

		-- test 4
		unary <= "0111111111111111";
		wait for 10 ns;
		assert (binary = "1111") report "Test 4 failed" severity error;

		wait;
	end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_unary_to_binary of unary_to_binary_tb is
	for TB_ARCHITECTURE
		for UUT : unary_to_binary
			use entity work.unary_to_binary(arch);
		end for;
	end for;
end TESTBENCH_FOR_unary_to_binary;

