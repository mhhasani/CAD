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
