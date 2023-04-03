-- Design a circuit that takes 16-bit unary numbers as input and converts them to 4-bit binary numbers.
-- (Hint: you can use else-when)
-- Example:
-- The unary number of 0100: is 0000000000001111
-- The unary number of 1000 is 0000000011111111

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity unary_to_binary is
	port (unary: in std_logic_vector(15 downto 0);
		  binary: out std_logic_vector(3 downto 0));
end unary_to_binary;

architecture arch of unary_to_binary is
begin
	binary <= "0000" when unary = "0000000000000000" else
			  "0001" when unary = "0000000000000001" else
			  "0010" when unary = "0000000000000011" else
			  "0011" when unary = "0000000000000111" else
			  "0100" when unary = "0000000000001111" else
			  "0101" when unary = "0000000000011111" else
			  "0110" when unary = "0000000000111111" else
			  "0111" when unary = "0000000001111111" else
			  "1000" when unary = "0000000011111111" else
			  "1001" when unary = "0000000111111111" else
			  "1010" when unary = "0000001111111111" else
			  "1011" when unary = "0000011111111111" else
			  "1100" when unary = "0000111111111111" else
			  "1101" when unary = "0001111111111111" else
			  "1110" when unary = "0011111111111111" else
			  "1111" when unary = "0111111111111111" else
			  "0000";
end arch;


-- TestBench


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

