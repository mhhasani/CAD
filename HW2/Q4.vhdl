library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity alarm_for_clock_tb is
end alarm_for_clock_tb;

architecture TB_ARCHITECTURE of alarm_for_clock_tb is
	-- Component declaration of the tested unit
	component alarm_for_clock
	port(
		clk : in STD_LOGIC;
		rst : in STD_LOGIC;
		clk_set : in STD_LOGIC;
		alarm_set : in STD_LOGIC;
		alarm_stop : in STD_LOGIC;
		hour : in STD_LOGIC_VECTOR(5 downto 0);
		minute : in STD_LOGIC_VECTOR(7 downto 0);
		on_alarm : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk : STD_LOGIC;
	signal rst : STD_LOGIC;
	signal clk_set : STD_LOGIC;
	signal alarm_set : STD_LOGIC;
	signal alarm_stop : STD_LOGIC;
	signal hour : STD_LOGIC_VECTOR(5 downto 0);
	signal minute : STD_LOGIC_VECTOR(7 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal on_alarm : STD_LOGIC;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : alarm_for_clock
		port map (
			clk => clk,
			rst => rst,
			clk_set => clk_set,
			alarm_set => alarm_set,
			alarm_stop => alarm_stop,
			hour => hour,
			minute => minute,
			on_alarm => on_alarm
		);

	-- Add your stimulus here ...
	stim_process: process
	begin
	   -- Initialize signals
	   rst <= '1';
	   clk_set <= '0';
	   alarm_set <= '0';
	   alarm_stop <= '0';
	   hour <= "000000";
	   minute <= "00000000";
	   
	   -- Wait for reset to finish
	   wait for 10 ns;
	   rst <= '0';
	   
	   -- Test case 1: Set the clock
	   clk_set <= '1';
	   hour <= "000011";
	   minute <= "00111100";
	   wait for 10 ns;
	   clk_set <= '0';
	   
	   -- Test case 2: Set the alarm
	   alarm_set <= '1';
	   hour <= "001100";
	   minute <= "10101010";
	   wait for 10 ns;
	   alarm_set <= '0';
	   
	   -- Test case 3: Trigger the alarm
	   alarm_stop <= '1';
	   wait for 10 ns;

	   -- Test case 4: Stop the alarm
	   alarm_stop <= '0';
	   wait for 10 ns;
	
 
	   wait;
	end process stim_process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_alarm_for_clock of alarm_for_clock_tb is
	for TB_ARCHITECTURE
		for UUT : alarm_for_clock
			use entity work.alarm_for_clock(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_alarm_for_clock;



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
