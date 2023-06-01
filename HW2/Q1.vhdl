library design;
use design.array10x8.all;

	-- Add your library and packages declaration here ...

entity sort10x8_tb is
end sort10x8_tb;

architecture TB_ARCHITECTURE of sort10x8_tb is
	-- Component declaration of the tested unit
	component sort10x8
	port(
		matrixIn : in Array10x8;
		matrixOut : out Array10x8 );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal matrixIn : Array10x8;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal matrixOut : Array10x8;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : sort10x8
		port map (
			matrixIn => matrixIn,
			matrixOut => matrixOut
		);

	-- Add your stimulus here ...
	process
	begin 
		matrixIn <= (
			"10000000",
			"01000000",
			"00100000",
			"00110000",
			"01011000",
			"01111100",
			"01101110",
			"01000111",
			"00100011",
			"00000001"
		);
		wait for 10 ns;

		assert matrixOut = (
			"00000001",
			"00100000",
			"00100011",
			"00110000",
			"01000000",
			"01000111",
			"01011000",
			"01101110",
			"01111100",
			"10000000"
		) report "matrixOut is not correct" severity error;
		
		wait;
	end process;
	
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_sort10x8 of sort10x8_tb is
	for TB_ARCHITECTURE
		for UUT : sort10x8
			use entity work.sort10x8(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_sort10x8;




library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package array10x8 is
    type Array10x8 is array (0 to 9) of std_logic_vector(7 downto 0); -- Define a type for a 10x8 matrix of std_logic_vectors
    type Array10 is array(0 to 9) of integer range 0 to 255; -- Define a type for a 10-element array of integers ranging from 0 to 255
end array10x8;

----------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.array10x8.all;

entity Sort10x8 is
    port (
        matrixIn : in array10x8; -- Input matrix of type Array10x8
        matrixOut : out array10x8 -- Output matrix of type Array10x8
    );
end Sort10x8;

architecture Behavioral of Sort10x8 is
begin
    process (matrixIn)
        variable numbers : array10; -- Variable to store the converted integers
        variable temp : integer; -- Temporary variable for swapping numbers
    begin
        -- Convert std_logic_vector to integer
        for i in 0 to 9 loop
            numbers(i) := to_integer(unsigned(matrixIn(i))); -- Convert std_logic_vector to integer using unsigned conversion
        end loop;

        -- Perform sorting
        for i in 0 to 8 loop
            for j in i + 1 to 9 loop
                if numbers(j) < numbers(i) then
                    -- Swap numbers
                    temp := numbers(i);
                    numbers(i) := numbers(j);
                    numbers(j) := temp;
                end if;
            end loop;
        end loop;

        -- Convert integer back to std_logic_vector
        for i in 0 to 9 loop
            matrixOut(i) <= std_logic_vector(to_unsigned(numbers(i), 8)); -- Convert integer back to std_logic_vector using to_unsigned function
        end loop;
    end process;
end Behavioral;
