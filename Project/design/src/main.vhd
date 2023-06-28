

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counterEx is
  generic (
    M : natural := 6;
    N : natural := 4 -- N bits are required for M
  );
  port (
    clk, reset : in std_logic;
    out_moore : out std_logic_vector(N-1 downto 0)
  );
end entity;

architecture arch of counterEx is
  type stateType_moore is (start_moore, count_moore); -- Define an enumeration type for Moore state
  signal state_moore_reg, state_moore_next : stateType_moore; -- Registers to hold current and next Moore state
  signal count_moore_reg, count_moore_next : unsigned(N-1 downto 0); -- Registers to hold current and next count value
begin
  process (clk, reset)
  begin
    if reset = '1' then -- Asynchronous reset condition
      state_moore_reg <= start_moore; -- Reset the state to start_moore
      count_moore_reg <= (others => '0'); -- Reset the count to all zeros
    elsif rising_edge(clk) then -- Synchronous behavior on rising edge of the clock
      state_moore_reg <= state_moore_next; -- Update the current state with the next state
      count_moore_reg <= count_moore_next; -- Update the current count with the next count
    end if;
  end process;

  process (count_moore_reg, state_moore_reg)
  begin
    case state_moore_reg is
      when start_moore =>
        count_moore_next <= (others => '0'); -- Reset the count to all zeros
        state_moore_next <= count_moore; -- Transition to count_moore state
      when count_moore =>
        count_moore_next <= count_moore_reg + 1; -- Increment the count by 1
        if (count_moore_reg + 1) = M - 1 then -- Check if the count reached (M - 1)
          state_moore_next <= start_moore; -- Transition back to start_moore state
        else
          state_moore_next <= count_moore; -- Stay in the count_moore state
        end if;
    end case;
  end process;

  out_moore <= std_logic_vector(count_moore_reg); -- Convert the count to std_logic_vector and assign it to the output
end arch;
