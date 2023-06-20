-- Define package
library ieee;
use ieee.std_logic_1164.all;

package BinaryCalculator is
    function addition(a, b : in std_logic_vector(7 downto 0)) return std_logic_vector;
    function subtraction(a, b : in std_logic_vector(7 downto 0)) return std_logic_vector;
end BinaryCalculator;

package body BinaryCalculator is
    function addition(a, b : in std_logic_vector(7 downto 0)) return std_logic_vector is
        variable sum : std_logic_vector(7 downto 0);
    begin
        sum(0) := a(0) xor b(0);
        for i in 1 to 7 loop
            sum(i) := (a(i) xor b(i)) xor (a(i-1) and b(i-1));
        end loop;
        return sum;
    end addition;

    function subtraction(a, b : in std_logic_vector(7 downto 0)) return std_logic_vector is
        variable diff : std_logic_vector(7 downto 0);
    begin
        diff(0) := a(0) xor b(0);
        for i in 1 to 7 loop
            diff(i) := (a(i) xor b(i)) xor ((not a(i-1)) and b(i-1));
        end loop;
        return diff;
    end subtraction;
end BinaryCalculator;


library ieee;
use ieee.std_logic_1164.all;
use work.BinaryCalculator.all;

-- Main entity
entity Calculator is
    port (
        a     : in  std_logic_vector(7 downto 0);
        b     : in  std_logic_vector(7 downto 0);
        op    : in  std_logic;
        result: out std_logic_vector(7 downto 0)
    );
end Calculator;

architecture Behavioral of Calculator is
    signal temp_result : std_logic_vector(7 downto 0);
begin
    process(a, b, op)
    begin
        if op = '0' then
            temp_result <= addition(a, b);
        else
            temp_result <= subtraction(a, b);
        end if;
    end process;

    result <= temp_result;
end Behavioral;
