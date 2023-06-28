library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity binary_to_unary is
	Port ( binary : in  STD_LOGIC_VECTOR (2 downto 0);
		   unary : out  STD_LOGIC_VECTOR (7 downto 0));
end binary_to_unary;

architecture Behavioral of binary_to_unary is
begin
	unary <= "00000000" when binary = "000" else
			 "00000001" when binary = "001" else
			 "00000011" when binary = "010" else
			 "00000111" when binary = "011" else
			 "00001111" when binary = "100" else
			 "00011111" when binary = "101" else
			 "00111111" when binary = "110" else
			 "01111111" when binary = "111" else
			 "00000000";
end Behavioral;


