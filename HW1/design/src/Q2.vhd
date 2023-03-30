-- Design an ALU to perform addition, subtraction, and, and or operations with respect to the control bits defined as
-- The given input is performed on its 2-bit inputs (A and B are each a 2-bit std_logic_vector)

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
	port (A, B : in std_logic_vector(1 downto 0);
		  C : in std_logic_vector(3 downto 0);
		  F : out std_logic_vector(1 downto 0));
end ALU;

architecture Behavioral of ALU is
begin
	F <= std_logic_vector(unsigned(A) + unsigned(B)) when C = "0000" else
		 std_logic_vector(unsigned(A) - unsigned(B)) when C = "0001" else
		 std_logic_vector(unsigned(A) and unsigned(B)) when C = "0010" else
		 std_logic_vector(unsigned(A) or unsigned(B)) when C = "0011" else
		 "00";
end Behavioral;
