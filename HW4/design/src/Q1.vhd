-- Design a circuit that get an n-bit binary and displays the first and last consecutive zeros of the first block after the first block and displays the number of ones and the last zeros of the last block of zeros as a string in binary format.
-- Example
-- Inputs: 001111000000111110001
-- Output:
-- 111(7) - 1011 (12) → Start And End Index Of First Zero Block After First One Block
-- 10010(18) - 10100 (20) → Start And End Index Of Last Zero Block


-- s0 -> if input = 1 then s1 else s0
-- s1 -> if input = 0 then s2 else s1
-- s2 -> if input = 1 then s3 else s2
-- s3 -> if input = 0 then s4 else s3
-- s4 -> if input = 1 then s5 else s4

library ieee;
use ieee.std_logic_1164.all;

entity ZeroBlockFinder is
    port (
        clk   : in  std_logic;
        input : in  std_logic;
        start_first_zero_block  : out integer range 0 to 255;
		end_first_zero_block    : out integer range 0 to 255;
		start_last_zero_block   : out integer range 0 to 255;
		end_last_zero_block     : out integer range 0 to 255;
		current_index            : out integer range 0 to 255
	); 
end ZeroBlockFinder;

architecture Behavioral of ZeroBlockFinder is
	type state_type is (s0, s1, s2, s3, s4);
	signal state : state_type := s0;
	signal counter : integer range 0 to 255 := 1;
	signal start_first_zero_block_temp : integer range 0 to 255 := 0;
	signal end_first_zero_block_temp : integer range 0 to 255 := 0;
	signal start_last_zero_block_temp : integer range 0 to 255 := 0;
	signal end_last_zero_block_temp : integer range 0 to 255 := 0;
begin
	process(clk)
	begin	 
		if rising_edge(clk) then
			counter <= counter + 1;
			current_index <= counter;
			case state is
				when s0 =>
					if input = '0' then
						state <= s0;
					else
						state <= s1;
					end if;
				when s1 =>
					if input = '1' then
						state <= s1;
					else
						state <= s2;
						start_first_zero_block_temp <= counter;
						start_last_zero_block_temp <= counter;
					end if;
				when s2 =>
					if input = '0' then
						state <= s2;
						end_first_zero_block_temp <= counter + 1;
						end_last_zero_block_temp <= counter + 1;
					else
						state <= s3;
					end if;
				when s3 =>
					if input = '1' then
						state <= s3;
					else
						state <= s4;
						start_last_zero_block_temp <= counter + 1;
					end if;
				when s4 =>
					if input = '0' then
						state <= s4;
						end_last_zero_block_temp <= counter + 1;
					else
						state <= s3;
					end if;
				when others =>
					state <= s0;
			end case;
		end if;
	end process;

	start_first_zero_block <= start_first_zero_block_temp;
	end_first_zero_block <= end_first_zero_block_temp;
	start_last_zero_block <= start_last_zero_block_temp;
	end_last_zero_block <= end_last_zero_block_temp;
end Behavioral;

					