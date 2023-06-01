library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity sqrtceiling_tb is
end sqrtceiling_tb;

architecture TB_ARCHITECTURE of sqrtceiling_tb is
	-- Component declaration of the tested unit
	component sqrtceiling
	port(
		inp_number : in STD_LOGIC_VECTOR(9 downto 0);
		sqrt_ceiling : out STD_LOGIC_VECTOR(5 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal inp_number : STD_LOGIC_VECTOR(9 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal sqrt_ceiling : STD_LOGIC_VECTOR(5 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : sqrtceiling
		port map (
			inp_number => inp_number,
			sqrt_ceiling => sqrt_ceiling
		);

	-- Add your stimulus here ...

	process
	begin
		wait for 10 ns;
		inp_number <= "0001110000";
		wait for 10 ns;
		assert sqrt_ceiling = "001011" report "Test failed for input 112" severity error;
		
	
	end process;


end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_sqrtceiling of sqrtceiling_tb is
	for TB_ARCHITECTURE
		for UUT : sqrtceiling
			use entity work.sqrtceiling(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_sqrtceiling;

