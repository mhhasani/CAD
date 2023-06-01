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



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SqrtCeiling is
  Port (
    inp_number : in  std_logic_vector(9 downto 0);
    sqrt_ceiling : out std_logic_vector(5 downto 0)
  );
end SqrtCeiling;

architecture Behavioral of SqrtCeiling is
begin
  process(inp_number)
    variable inp : integer range 0 to 1023;
    variable square_root : integer := 0;
    variable tmp : integer := 0;
  begin
    inp := to_integer(unsigned(inp_number));

    while tmp * tmp < inp loop
      tmp := tmp + 1;
    end loop;

    square_root := tmp;

    sqrt_ceiling <= std_logic_vector(to_unsigned(square_root, 6));
  end process;
end Behavioral;
