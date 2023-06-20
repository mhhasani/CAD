library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MedianAverage is
    Port (
        num0, num1, num2, num3, num4, num5, num6: in std_logic_vector(7 downto 0);   -- Input ports for numbers
        median: out std_logic_vector(7 downto 0);                                    -- Output port for median
        average: out std_logic_vector(7 downto 0)                                   -- Output port for average
    );
end MedianAverage;

architecture Behavioral of MedianAverage is
    type array_type is array (0 to 6) of std_logic_vector(7 downto 0);               -- Type declaration for array of numbers
    signal numbers: array_type;                                                      -- Signal to hold the numbers
begin
    process (num0, num1, num2, num3, num4, num5, num6)                               -- Process triggered on number changes
        variable sorted_numbers: array_type;                                          -- Variable to hold sorted numbers
        variable sum: integer := 0;	                                                 -- Variable to hold the sum
		variable temp: std_logic_vector(7 downto 0);                                 -- Variable to hold temporary value
    begin
        numbers(0) <= num0;                                                           -- Assign num0 to numbers(0)
        numbers(1) <= num1;                                                           -- Assign num1 to numbers(1)
        numbers(2) <= num2;                                                           -- Assign num2 to numbers(2)
        numbers(3) <= num3;                                                           -- Assign num3 to numbers(3)
        numbers(4) <= num4;                                                           -- Assign num4 to numbers(4)
        numbers(5) <= num5;                                                           -- Assign num5 to numbers(5)
        numbers(6) <= num6;                                                           -- Assign num6 to numbers(6)

        -- Sort the numbers in ascending order
        sorted_numbers := numbers;                                                    -- Copy numbers to sorted_numbers
        for i in 0 to 6 loop                                                          -- Loop over the range of numbers
            for j in 0 to 5 loop                                                      -- Loop over the range to compare adjacent elements
                if (to_integer(unsigned(sorted_numbers(j))) > to_integer(unsigned(sorted_numbers(j + 1)))) then
                    temp := sorted_numbers(j);                                         -- Swap elements if they are out of order
                    sorted_numbers(j) := sorted_numbers(j + 1);
                    sorted_numbers(j + 1) := temp;
                end if;
            end loop;
        end loop;

        -- Calculate the median
        median <= sorted_numbers(3);                                                  -- Assign the middle element to median

        -- Calculate the average
        sum := 0;
        for i in 0 to 6 loop                                                          -- Loop over the numbers to calculate the sum
            sum := sum + to_integer(unsigned(numbers(i)));
        end loop;
        average <= std_logic_vector(to_unsigned(sum / 7, 8));                         -- Calculate average and assign it to average port
    end process;
end Behavioral;
