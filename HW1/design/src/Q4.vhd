-- Design a circuit that takes 2 arrays of 8 numbers and returns their dot product.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package array_of_num_pkg is
	type array_of_num is array(0 to 7) of integer range -128 to 127;
end array_of_num_pkg;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.array_of_num_pkg.all;

entity dot_p is
	port (
		a : in array_of_num;
		b : in array_of_num;
		c : out integer range -1000000000 to 1000000000
	);
end dot_p;

architecture Behavioral of dot_p is
begin
	process(a, b)
	begin
		c <= a(0)*b(0) + a(1)*b(1) + a(2)*b(2) + a(3)*b(3) + a(4)*b(4) + a(5)*b(5) + a(6)*b(6) + a(7)*b(7);
	end process;
end Behavioral;