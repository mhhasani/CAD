library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity bitgenerator_tb is
end bitgenerator_tb;

architecture TB_ARCHITECTURE of bitgenerator_tb is
	-- Component declaration of the tested unit
	component bitgenerator
	port(
		input_bits : in STD_LOGIC_VECTOR(15 downto 0);
		output_bits : out STD_LOGIC_VECTOR(1 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal input_bits : STD_LOGIC_VECTOR(15 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal output_bits : STD_LOGIC_VECTOR(1 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : bitgenerator
		port map (
			input_bits => input_bits,
			output_bits => output_bits
		);

	-- Add your stimulus here ...
	  process
	  begin
	    input_bits <= "1100110000111111";
	    wait for 10 ns;
		assert output_bits = "01" report "Error for input_bits = 1100110000111111" severity error;

	    wait;
	  end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_bitgenerator of bitgenerator_tb is
	for TB_ARCHITECTURE
		for UUT : bitgenerator
			use entity work.bitgenerator(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_bitgenerator;

