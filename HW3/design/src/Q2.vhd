library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package Recursive_Functions is

    -- BCD to Binary conversion
    function BCD_to_Binary (BCD : in std_logic_vector) return unsigned;

    -- Binary reversal
    function Binary_Reverser (Binary : in std_logic_vector) return std_logic_vector;

end package Recursive_Functions;

package body Recursive_Functions is

    -- BCD to Binary conversion
    function BCD_to_Binary (BCD : in std_logic_vector) return unsigned is
    begin
        if BCD'length = 1 then
            return unsigned'("0" & BCD(0));
        else
            return 2 * BCD_to_Binary(BCD(0 to BCD'length - 2)) + unsigned'("0" & BCD(BCD'length - 1));
        end if;
    end function BCD_to_Binary;

    -- Binary reversal
    function Binary_Reverser (Binary : in std_logic_vector) return std_logic_vector is
    begin
        if Binary'length <= 1 then
            return Binary;
        else
            return Binary(Binary'length) & Binary_Reverser(Binary(1 to Binary'length - 1));
        end if;
    end function Binary_Reverser;

end package body Recursive_Functions;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Recursive_Functions.all;

entity Recursive_Functions_Entity is
    port (
        BCD_In: in std_logic_vector;
        Binary_Out: out std_logic_vector
    );
end entity Recursive_Functions_Entity;

architecture Behavioral of Recursive_Functions_Entity is
begin
    process (BCD_In)
    begin
        Binary_Out <= Binary_Reverser(std_logic_vector(BCD_to_Binary(BCD_In)));
    end process;
end architecture Behavioral;

