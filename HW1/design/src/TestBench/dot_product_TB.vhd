library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity dot_product_tb is
end dot_product_tb;

architecture TB_ARCHITECTURE of dot_product_tb is
	-- Component declaration of the tested unit
	component dot_product
	port(
		a : in STD_LOGIC_VECTOR(7 downto 0);
		b : in STD_LOGIC_VECTOR(7 downto 0);
		c : out STD_LOGIC_VECTOR(7 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal a : STD_LOGIC_VECTOR(7 downto 0);
	signal b : STD_LOGIC_VECTOR(7 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal c : STD_LOGIC_VECTOR(7 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : dot_product
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
		a <= "00000000";
		b <= "00000000";
		wait for 10 ns;
		assert c = "00000000" report "Test failed for input combination: 00000000, 00000000" severity error;
		a <= "11001001";
		b <= "10001101";
		wait for 10 ns;
		assert c = "10001001" report "Test failed for input combination: 11001001, 10001101" severity error;
		a <= "11111111";
		b <= "11111111";
		wait for 10 ns;
		assert c = "11111111" report "Test failed for input combination: 11111111, 11111111" severity error;
		wait;
	end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_dot_product of dot_product_tb is
	for TB_ARCHITECTURE
		for UUT : dot_product
			use entity work.dot_product(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_dot_product;

