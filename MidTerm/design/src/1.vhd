library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
    port (
        clk : in std_logic;                         -- Clock input
        clear : in std_logic;                       -- Clear input
        preset : in std_logic;                      -- Preset input
        count : in std_logic;                       -- Count input
        q : out std_logic_vector(11 downto 0)        -- Output of the counter
    );
end entity counter;

architecture behavioral of counter is
    signal counter_value : unsigned(11 downto 0) := (others => '0');  -- Internal signal to hold the counter value
    signal clear_sync : std_logic := '0';                             -- Internal synchronized clear signal
begin
    process (clear)
    begin
        if clear = '1' then
            clear_sync <= '1';                        -- Synchronize the clear signal
        end if;
    end process;
    
    process (clk)
        variable std_num_mod_100 : unsigned(11 downto 0) := to_unsigned(99521199 mod 100, 12);  -- Variable to hold the modulus 100 value
        variable std_num_mod_10 : unsigned(3 downto 0) := to_unsigned(99521199 mod 10, 4);      -- Variable to hold the modulus 10 value
    begin
        if clear_sync = '1' then
            counter_value <= (others => '0');         -- Clear the counter if clear_sync is high
            clear_sync <= '0';                        -- Reset the synchronized clear signal
        elsif preset = '0' then
            counter_value <= std_num_mod_100;         -- Load the modulus 100 value into the counter
        elsif count'event and count = '1' and clk = '0' and clk'event then
            counter_value <= counter_value + std_num_mod_10;  -- Increment the counter by the modulus 10 value
        end if;

        q <= std_logic_vector(counter_value);        -- Output the counter value
    end process;
end architecture behavioral;