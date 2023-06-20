library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity special_ff is
    port (
        clk : in std_logic;     -- Clock input
        d   : in std_logic;     -- Data input
        t   : in std_logic;     -- Toggle input
        r   : in std_logic;     -- Reset input
        tq  : inout std_logic;  -- Output for tq
        dq  : out std_logic     -- Output for dq
    );
end entity special_ff;

architecture behavioral of special_ff is

begin

    special_ff_block: block
        -- Define a record type for tq and dq
        type td is record
            tq : std_logic;
            dq : std_logic;
        end record;

        -- Define an array type for the state
        type state is array (natural range 0 to 7) of td;

        -- Define the next state transition table
        constant next_state : state := (
            -- D=0, T=0, R=0
            (tq => '0', dq => '0'),
            -- D=0, T=0, R=1
            (tq => '1', dq => '0'),
            -- D=0, T=1, R=0
            (tq => '1', dq => '0'),
            -- D=0, T=1, R=1
            (tq => '0', dq => '1'),
            -- D=1, T=0, R=0
            (tq => '0', dq => '1'),
            -- D=1, T=0, R=1
            (tq => '0', dq => '1'),
            -- D=1, T=1, R=0
            (tq => '0', dq => '0'),
            -- D=1, T=1, R=1
            (tq => '1', dq => '0')
        );

        signal present_state : natural range 0 to 7 := 0;

    begin  -- special_ff_block

        process (clk)
        begin
            if rising_edge(clk) then
                if r = '1' then  -- Reset
                    tq <= '0';
                    dq <= '0';
                    present_state <= 0;  -- Reset to state 000
                else  -- Not reset
                    tq <= next_state(present_state).tq;
                    dq <= next_state(present_state).dq;
                    if t = '1' then  -- Toggle
                        tq <= not tq;
                    end if;
                    present_state <= to_integer(unsigned(d & t & r));  -- Update present state
                end if;
            end if;
        end process;

    end block special_ff_block;

end architecture behavioral;
