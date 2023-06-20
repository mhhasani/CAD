library ieee;
use ieee.std_logic_1164.all;

package array2x2_pkg is
    type array2x2 is array(1 to 2, 1 to 2) of std_logic_vector(3 downto 0);  -- Package defining a 2x2 array type
end package array2x2_pkg;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.array2x2_pkg.all;

entity MatrixOperation is
    port (
        a : in  array2x2;                                  -- Input port for matrix A
        b : in  array2x2;                                  -- Input port for matrix B
        logic_bit : in  std_logic;                         -- Input port for logic bit
        output : out std_logic_vector(7 downto 0)          -- Output port for result
    );
end entity MatrixOperation;

architecture Behavioral of MatrixOperation is
begin
    process (a, b, logic_bit)
        variable sum : integer range 0 to 255;              -- Variable to hold the sum
    begin
        sum := 0;                                          -- Initialize the sum to 0

        if logic_bit = '0' then                            -- Check the value of the logic bit
            for i in 1 to 2 loop                            -- Loop over rows of matrices
                for j in 1 to 2 loop                        -- Loop over columns of matrices
                    sum := sum + to_integer(unsigned(a(i, j))) * to_integer(unsigned(b(i, j)));   -- Perform multiplication and add to sum
                end loop;
            end loop;
        else
            for i in 1 to 2 loop                            -- Loop over rows of matrices
                for j in 1 to 2 loop                        -- Loop over columns of matrices
                    sum := sum + to_integer(unsigned(a(i, j))) / to_integer(unsigned(b(i, j)));   -- Perform division and add to sum
                end loop;
            end loop;
        end if;

        output <= std_logic_vector(to_unsigned(sum, 8));    -- Convert sum to 8-bit std_logic_vector and assign to output port
    end process;
end architecture Behavioral;
