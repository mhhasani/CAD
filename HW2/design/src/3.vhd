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
