-- Design a circuit that takes 2 arrays of 8 numbers and returns their dot product.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package array_of_num_pkg is
	type array_of_num is array(0 to 7) of integer range -128 to 127;
end array_of_num_pkg;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.array_of_num_pkg.all;

entity dot_p is
	port (
		a : in array_of_num;
		b : in array_of_num;
		c : out integer range -1000000000 to 1000000000
	);
end dot_p;

architecture Behavioral of dot_p is
begin
	process(a, b)
	begin
		c <= a(0)*b(0) + a(1)*b(1) + a(2)*b(2) + a(3)*b(3) + a(4)*b(4) + a(5)*b(5) + a(6)*b(6) + a(7)*b(7);
	end process;
end Behavioral;


-- TestBench


library design;
use design.array_of_num_pkg.all;

	-- Add your library and packages declaration here ...

entity dot_p_tb is
end dot_p_tb;

architecture TB_ARCHITECTURE of dot_p_tb is
	-- Component declaration of the tested unit
	component dot_p
	port(
		a : in array_of_num;
		b : in array_of_num;
		c : out INTEGER range -1024 to 1023 );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal a : array_of_num;
	signal b : array_of_num;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal c : INTEGER range -1024 to 1023;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : dot_p
		port map (
			a => a,
			b => b,
			c => c
		);

	-- Add your stimulus here ...

	-- Stimulus process
	stimulus : process
	begin
		-- Add your stimulus here ...
		wait for 10 ns;
		a <= (1, 2, 3, 4, 5, 6, 7, 8);
		b <= (8, 7, 6, 5, 4, 3, 2, 1);
		wait for 10 ns;
		assert c = 120 report "Test 1 failed" severity error;

		a <= (1, 1, 1, 1, 1, 1, 1, 1);
		b <= (10, 10, 10, 10, 10, 10, 10, 10);
		wait for 10 ns;
		assert c = 80 report "Test 2 failed" severity error;
		wait;
	end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_dot_p of dot_p_tb is
	for TB_ARCHITECTURE
		for UUT : dot_p
			use entity work.dot_p(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_dot_p;

