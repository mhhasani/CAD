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

