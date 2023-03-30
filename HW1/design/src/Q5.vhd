-- Define a type for complex numbers that includes y, x values. Then write a program that two complex numbers and 3
-- The signal for the multiplication, addition and subtraction operators is taken as an input and the desired operation is performed on the two given numbers.
-- It outputs the result (only one of the operator signals will be equal to 1 at any time).

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package complex_package is
	type complex_type is record
		x, y : signed(7 downto 0);
	end record;
end complex_package;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.complex_package.all;

entity complex_entity is
port(
	num1, num2 : in complex_type;
	operation : in std_logic_vector(2 downto 0);
	result : out complex_type
);
end complex_entity;

architecture Behavioral of complex_entity is
begin
	process(num1, num2, operation)
	begin
		case operation is
			when "001" => result.x <= num1.x * num2.x - num1.y * num2.y;
						  result.y <= num1.x * num2.y + num1.y * num2.x;
			when "010" => result.x <= num1.x + num2.x;
						  result.y <= num1.y + num2.y;
			when "100" => result.x <= num1.x - num2.x;
						  result.y <= num1.y - num2.y;
			when others => result.x <= (others => '0');
						   result.y <= (others => '0');
		end case;
	end process;
end Behavioral;

	