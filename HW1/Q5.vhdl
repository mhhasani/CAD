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
			when "001" => result.x <= Resize(num1.x * num2.x - num1.y * num2.y, 8);
						  result.y <= Resize(num1.x * num2.y + num1.y * num2.x, 8);
			when "010" => result.x <= num1.x + num2.x;
						  result.y <= num1.y + num2.y;
			when "100" => result.x <= num1.x - num2.x;
						  result.y <= num1.y - num2.y;
			when others => result.x <= (others => '0');
						   result.y <= (others => '0');
		end case;
	end process;
end Behavioral;

	
-- TestBench


library ieee;
use ieee.std_logic_1164.all;
library design;
use design.complex_package.all;

entity complex_entity_tb is
end complex_entity_tb;

architecture TB_ARCHITECTURE of complex_entity_tb is
	-- Component declaration of the tested unit
	component complex_entity
	port(
		num1 : in complex_type;
		num2 : in complex_type;
		operation : in STD_LOGIC_VECTOR(2 downto 0);
		result : out complex_type );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal num1 : complex_type;
	signal num2 : complex_type;
	signal operation : STD_LOGIC_VECTOR(2 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal result : complex_type;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : complex_entity
		port map (
			num1 => num1,
			num2 => num2,
			operation => operation,
			result => result
		);

	-- Add your stimulus here ...

	-- simulation process
	process
	begin
		wait for 10 ns;
		num1 <= complex_type'(x => "00000010", y => "00000011");
		num2 <= complex_type'(x => "00000010", y => "00000011");
		operation <= "010";
		wait for 10 ns;
		assert result = complex_type'(x => "00000100", y => "00000110") report "Test failed" severity error;
		
		num1 <= complex_type'(x => "00010010", y => "10000111");
		num2 <= complex_type'(x => "00001110", y => "00000011");
		operation <= "100";
		wait for 10 ns;
		assert result = complex_type'(x => "00000100", y => "10000100") report "Test failed" severity error;

		num1 <= complex_type'(x => "00000100", y => "00000101");
		num2 <= complex_type'(x => "00000010", y => "00000001");
		operation <= "001";
		wait for 10 ns;
		assert result = complex_type'(x => "00000011", y => "00001110") report "Test failed" severity error;
		wait;
	end process;
	
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_complex_entity of complex_entity_tb is
	for TB_ARCHITECTURE
		for UUT : complex_entity
			use entity work.complex_entity(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_complex_entity;

