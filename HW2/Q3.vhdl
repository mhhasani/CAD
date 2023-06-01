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



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 


entity BitGenerator is
  Port (
    input_bits : in  std_logic_vector(15 downto 0);
    output_bits : out std_logic_vector(1 downto 0)
  );
end entity BitGenerator;

architecture Behavioral of BitGenerator is
begin
  process(input_bits)
    variable evenSum : integer;
    variable oddSum : integer;
  begin
    evenSum := 0;
    oddSum := 0;
    
    for i in 0 to 15 loop
      if i mod 2 = 0 then	
        if input_bits(i) = '1' then
          evenSum := evenSum + 1;
        end if;
      else
        if input_bits(i) = '1' then
          oddSum := oddSum + 1;
        end if;
      end if;
    end loop;

    if evenSum mod 3 = 0 then
      output_bits(1) <= '1';
    else
      output_bits(1) <= '0';
    end if;

    if oddSum mod 5 = 0 then
      output_bits(0) <= '1';
    else
      output_bits(0) <= '0';
    end if;
  end process;
end architecture Behavioral;
