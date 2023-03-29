-- Take a 3x3 array of 4-bit std_logic_vectors as input, sum it as output 
-- return (treat each std_logic_vector as a 4-bit number).

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package array_3x3_pkg is
    type array_3x3 is array (0 to 2, 0 to 2) of std_logic_vector(3 downto 0);
end array_3x3_pkg;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.array_3x3_pkg.all;

entity convert_3x3_to_sum is
    port (in_3x3 : in array_3x3;
          out_sum : out integer := 0);
end convert_3x3_to_sum;

architecture Behavioral of convert_3x3_to_sum is
begin
    process (in_3x3)
        variable temp_sum : integer := 0;
    begin
        for i in 0 to 2 loop
            for j in 0 to 2 loop
                temp_sum := temp_sum + to_integer(unsigned(in_3x3(i,j)));
            end loop;
        end loop;
        out_sum <= temp_sum;
    end process;
end Behavioral;




