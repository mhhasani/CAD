-- Design a circuit that takes 2 arrays of 8 numbers and returns their dot product.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dot_product is
	port (
		a : in std_logic_vector(7 downto 0);
		b : in std_logic_vector(7 downto 0);
		c : out std_logic_vector(7 downto 0)
	);
end dot_product;

architecture Behavioral of dot_product is
begin
	process(a, b)
		variable result : std_logic_vector(7 downto 0) := (others => '0');
	begin
		for i in 0 to 7 loop
			result(i) := a(i) and b(i);
		end loop;
		c <= result;
	end process;
end Behavioral;