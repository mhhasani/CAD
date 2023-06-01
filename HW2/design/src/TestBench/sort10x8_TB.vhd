library design;
use design.array10x8.all;

	-- Add your library and packages declaration here ...

entity sort10x8_tb is
end sort10x8_tb;

architecture TB_ARCHITECTURE of sort10x8_tb is
	-- Component declaration of the tested unit
	component sort10x8
	port(
		matrixIn : in Array10x8;
		matrixOut : out Array10x8 );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal matrixIn : Array10x8;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal matrixOut : Array10x8;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : sort10x8
		port map (
			matrixIn => matrixIn,
			matrixOut => matrixOut
		);

	-- Add your stimulus here ...
	process
	begin 
		matrixIn <= (
			"10000000",
			"01000000",
			"00100000",
			"00110000",
			"01011000",
			"01111100",
			"01101110",
			"01000111",
			"00100011",
			"00000001"
		);
		wait for 10 ns;

		assert matrixOut = (
			"00000001",
			"00100000",
			"00100011",
			"00110000",
			"01000000",
			"01000111",
			"01011000",
			"01101110",
			"01111100",
			"10000000"
		) report "matrixOut is not correct" severity error;
		
		wait;
	end process;
	
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_sort10x8 of sort10x8_tb is
	for TB_ARCHITECTURE
		for UUT : sort10x8
			use entity work.sort10x8(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_sort10x8;


