library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alarm_for_clock is
    port (
        clk        : in std_logic;
        rst        : in std_logic;
        clk_set    : in std_logic;
        alarm_set  : in std_logic;
        alarm_stop : in std_logic;
        hour       : in std_logic_vector(5 downto 0);
        minute     : in std_logic_vector(7 downto 0);
        on_alarm   : out std_logic
    );
end alarm_for_clock;

architecture behavioral of alarm_for_clock is
    signal seconds      : integer range 0 to 59 := 0;
    signal minutes      : integer range 0 to 59 := 0;
    signal hours        : integer range 0 to 23 := 0;
    signal alarm_hour   : integer range 0 to 23 := 0;
    signal alarm_minute : integer range 0 to 59 := 0; 

begin
    process (clk, rst)
    begin
        if rst = '1' then
            seconds <= 0;
            minutes <= 0;
            hours <= 0;
            on_alarm <= '0';
        elsif rising_edge(clk) then
            if clk_set = '1' then
                minutes <= to_integer(unsigned(minute));
                hours <= to_integer(unsigned(hour));
            elsif alarm_set = '1' then
                alarm_minute <= to_integer(unsigned(minute));
                alarm_hour <= to_integer(unsigned(hour));
            else
                seconds <= seconds + 1;
                if seconds = 60 then
                    seconds <= 0;
                    minutes <= minutes + 1;
                    if minutes = 60 then
                        minutes <= 0;
                        hours <= hours + 1;
                        if hours = 24 then
                            hours <= 0;
                        end if;
                    end if;
                end if;

                if alarm_stop = '1' then
                    on_alarm <= '0';
                elsif (hours = alarm_hour) and (minutes = alarm_minute) then
                    on_alarm <= '1';
                end if;
            end if;
        end if;
    end process;

end behavioral;
