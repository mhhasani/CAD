library design;
use design.array_3x3_pkg.all;

	-- Add your library and packages declaration here ...

entity convert_3x3_to_sum_tb is
end convert_3x3_to_sum_tb;

architecture TB_ARCHITECTURE of convert_3x3_to_sum_tb is
	-- Component declaration of the tested unit
	component convert_3x3_to_sum
	port(
		in_3x3 : in array_3x3;
		out_sum : out INTEGER );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal in_3x3 : array_3x3;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal out_sum : INTEGER := 0;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : convert_3x3_to_sum
		port map (
			in_3x3 => in_3x3,
			out_sum => out_sum
		);

	-- Add your stimulus here ...

	new_process : process
	begin
		-- test 1
		in_3x3(0,0) <= "0000";
		in_3x3(0,1) <= "0001";
		in_3x3(0,2) <= "0010";
		in_3x3(1,0) <= "0011";
		in_3x3(1,1) <= "0100";
		in_3x3(1,2) <= "0101";
		in_3x3(2,0) <= "0110";
		in_3x3(2,1) <= "0111";
		in_3x3(2,2) <= "1000";
		wait for 10 ns;
		assert out_sum = 36 report "Test 1 failed" severity error;	
		wait;
	end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_convert_3x3_to_sum of convert_3x3_to_sum_tb is
	for TB_ARCHITECTURE
		for UUT : convert_3x3_to_sum
			use entity work.convert_3x3_to_sum(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_convert_3x3_to_sum;

