library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity alu_tb is
end alu_tb;

architecture TB_ARCHITECTURE of alu_tb is
	-- Component declaration of the tested unit
	component alu
	port(
		A : in STD_LOGIC_VECTOR(1 downto 0);
		B : in STD_LOGIC_VECTOR(1 downto 0);
		C : in STD_LOGIC_VECTOR(3 downto 0);
		F : out STD_LOGIC_VECTOR(1 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal A : STD_LOGIC_VECTOR(1 downto 0);
	signal B : STD_LOGIC_VECTOR(1 downto 0);
	signal C : STD_LOGIC_VECTOR(3 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal F : STD_LOGIC_VECTOR(1 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : alu
		port map (
			A => A,
			B => B,
			C => C,
			F => F
		);

	-- Add your stimulus here ...

	-- Stimulus process
	stimulus : process
	begin
		-- Add your stimulus here ...
		wait for 10 ns;
		A <= "00";
		B <= "11";
		C <= "0000";
		wait for 10 ns;
		assert F = "11" report "Test failed for input combination: 00, 11, 0000" severity error;
		A <= "11";
		B <= "10";
		C <= "0001";
		wait for 10 ns;
		assert F = "01" report "Test failed for input combination: 11, 10, 0001" severity error;
		A <= "10";
		B <= "01";
		C <= "0010";
		wait for 10 ns;
		assert F = "00" report "Test failed for input combination: 11, 11, 0010" severity error;
		A <= "00";
		B <= "10";
		C <= "0011";
		wait for 10 ns;
		assert F = "10" report "Test failed for input combination: 00, 10, 0011" severity error;
		wait;
	end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_alu of alu_tb is
	for TB_ARCHITECTURE
		for UUT : alu
			use entity work.alu(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_alu;

