-- 10 moore


library ieee;
use ieee.std_logic_1164.all;

entity sequencer is
  port (
    clk, reset, input : in std_logic;
    output : out std_logic
  );
end entity sequencer;

architecture moore of sequencer is
  type state is (S0, S1, S2);  -- state declaration
  signal Moore_state : state;

begin
  U_Moore: process (clk, reset)
  begin
    if reset = '1' then
      Moore_state <= S0;
    elsif clk'event and clk = '1' then
      case Moore_state is
        when S0 =>
          if input = '1' then
            Moore_state <= S1;
          else
            Moore_state <= S0;
          end if;
          
        when S1 =>
          if input = '0' then
            Moore_state <= S2;
          else
            Moore_state <= S1;
          end if;
          
        when S2 =>
          if input = '0' then
            Moore_state <= S0;
          else
            Moore_state <= S1;
          end if;
      end case;
    end if;
  end process;
  
  output <= '1' when Moore_state = S2 else '0'; 
end architecture;


-- 10 moore with design 1

library ieee;
use ieee.std_logic_1164.all;

-----------------------------------------------------
entity sequencer is
    port (
        input  : in  std_logic;
        reset  : in  std_logic;
        clock  : in  std_logic;
        output : out std_logic
    );
end sequencer;
-----------------------------------------------------
architecture moore of sequencer is
    type state is (state0, state1, state2);
    signal pr_state, nx_state : state;
begin
    ---------- Lower section: ------------------------
    process (reset, clock)
    begin
        if (reset = '1') then
            pr_state <= state0;
        elsif (clock'event and clock = '1') then
            pr_state <= nx_state;
        end if;
    end process;

    ---------- Upper section: ------------------------
    process (input, pr_state)
    begin
        case pr_state is
            when state0 =>
                if (input = '1') then
                    output <= '0';
                    nx_state <= state1;
                else
                    output <= '0';
                    nx_state <= state0;
                end if;
            when state1 =>
                if (input = '0') then
                    output <= '0';
                    nx_state <= state2;
                else
                    output <= '0';
                    nx_state <= state1;
                end if;
            when state2 =>
                if (input = '0') then
                    output <= '1';
                    nx_state <= state0;
                else
                    output <= '0';
                    nx_state <= state1;
                end if;
        end case;
    end process;
end moore;



-- 10 mealy


library ieee;
use ieee.std_logic_1164.all;

entity sequencer is
  port (
    clk, reset, input : in std_logic;
    output : out std_logic
  );
end entity sequencer;

architecture Mealy of sequencer is
  type state is (S0, S1);
  signal Mealy_state : state;

begin
  U_Mealy: process (clk, reset)
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        Mealy_state <= S0;
      else
        case Mealy_state is
          when S0 =>
            if input = '1' then
              Mealy_state <= S1;
            else
              Mealy_state <= S0;
            end if;
          
          when S1 =>
            if input = '0' then
              Mealy_state <= S0;
            else
              Mealy_state <= S1;
            end if;
        end case;
      end if;
    end if;
  end process;
  
  output <= '1' when (Mealy_state = S1 and input = '0') else '0';
end architecture;




-- design 1

library ieee;
use ieee.std_logic_1164.all;

-----------------------------------------------------
entity <entity_name> is
    port (
        input  : in  <data_type>;
        reset  : in  std_logic;
        clock  : in  std_logic;
        output : out <data_type>
    );
end <entity_name>;
-----------------------------------------------------
architecture <arch_name> of <entity_name> is
    type state is (state0, state1, state2, state3, ...);
    signal pr_state, nx_state : state;
begin
    ---------- Lower section: ------------------------
    process (reset, clock)
    begin
        if (reset = '1') then
            pr_state <= state0;
        elsif (clock'event and clock = '1') then
            pr_state <= nx_state;
        end if;
    end process;

    ---------- Upper section: ------------------------
    process (input, pr_state)
    begin
        case pr_state is
            when state0 =>
                if (input = ...) then
                    output <= <value>;
                    nx_state <= state1;
                else
                    -- ...
                end if;
            when state1 =>
                if (input = ...) then
                    output <= <value>;
                    nx_state <= state2;
                else
                    -- ...
                end if;
            when state2 =>
                if (input = ...) then
                    output <= <value>;
                    nx_state <= state3;
                else
                    -- ...
                end if;
            -- ...
        end case;
    end process;
end <arch_name>;



-- design 2


ENTITY <ent_name> IS
    PORT (
        input  : IN  <data_type>;
        reset  : IN  STD_LOGIC;
        clock  : IN  STD_LOGIC;
        output : OUT <data_type>
    );
END <ent_name>;

-------------------------------------------------------

ARCHITECTURE <arch_name> OF <ent_name> IS
    TYPE states IS (state0, state1, state2, state3, ...);
    SIGNAL pr_state, nx_state : states;
    SIGNAL temp : <data_type>;
BEGIN
    ---------- Lower section: --------------------------
    PROCESS (reset, clock)
    BEGIN
        IF (reset = '1') THEN
            pr_state <= state0;
        ELSIF (clock'EVENT AND clock = '1') THEN
            output <= temp;
            pr_state <= nx_state;
        END IF;
    END PROCESS;

    ---------- Upper section: --------------------------
    PROCESS (pr_state)
    BEGIN
        CASE pr_state IS
            WHEN state0 =>
                temp <= <value>;
                IF (condition) THEN
                    nx_state <= state1;
                    ...
                END IF;
            WHEN state1 =>
                temp <= <value>;
                IF (condition) THEN
                    nx_state <= state2;
                    ...
                END IF;
            WHEN state2 =>
                temp <= <value>;
                IF (condition) THEN
                    nx_state <= state3;
                    ...
                END IF;
            ...
        END CASE;
    END PROCESS;
END <arch_name>;



-- We want to design a circuit that takes as input a serial bit stream and outputs a ‘1’ whenever the sequence ‘‘111’’ occurs.
-- Overlaps must also be considered, that is, if . . .0111110 . . . occurs, than the output should remain active for three consecutive clock cycles.


ENTITY string_detector IS
    PORT (
        d   : IN  BIT;
        clk : IN  BIT;
        rst : IN  BIT;
        q   : OUT BIT
    );
END string_detector;

-----------------------------------------------------

ARCHITECTURE my_arch OF string_detector IS
    TYPE state IS (zero, one, two, three);
    SIGNAL pr_state, nx_state : state;
    SIGNAL temp : BIT;
BEGIN
    ---------- Lower section: --------------------------
    PROCESS (rst, clk)
    BEGIN
        IF (rst = '1') THEN
            pr_state <= zero;
        ELSIF (clk'EVENT AND clk = '1') THEN
            pr_state <= nx_state;
            q <= temp;
        END IF;
    END PROCESS;

    ---------- Upper section: --------------------------
    PROCESS (d, pr_state)
    BEGIN
        CASE pr_state IS
            WHEN zero =>
                temp <= '0';
                IF (d = '1') THEN
                    nx_state <= one;
                ELSE
                    nx_state <= zero;
                END IF;
            WHEN one =>
                temp <= '0';
                IF (d = '1') THEN
                    nx_state <= two;
                ELSE
                    nx_state <= zero;
                END IF;
            WHEN two =>
                temp <= '0';
                IF (d = '1') THEN
                    nx_state <= three;
                ELSE
                    nx_state <= zero;
                END IF;
            WHEN three =>
                temp <= '1';
                IF (d = '0') THEN
                    nx_state <= zero;
                ELSE
                    nx_state <= three;
                END IF;
        END CASE;
    END PROCESS;
END my_arch;




-- traffic light

ENTITY tlc IS
    PORT (
        clk, stby, test: IN STD_LOGIC;
        r1, r2, y1, y2, g1, g2: OUT STD_LOGIC
    );
END tlc;

ARCHITECTURE behavior OF tlc IS
    CONSTANT timeMAX : INTEGER := 2700;
    CONSTANT timeRG : INTEGER := 1800;
    CONSTANT timeRY : INTEGER := 300;
    CONSTANT timeGR : INTEGER := 2700;
    CONSTANT timeYR : INTEGER := 300;
    CONSTANT timeTEST : INTEGER := 60;
    
    TYPE state IS (RG, RY, GR, YR, YY);
    
    SIGNAL pr_state, nx_state: state;
    SIGNAL time : INTEGER RANGE 0 TO timeMAX;

BEGIN
    -- Lower section of state machine:
    PROCESS (clk, stby)
        VARIABLE count : INTEGER RANGE 0 TO timeMAX;
    BEGIN
        IF (stby = '1') THEN
            pr_state <= YY;
            count := 0;
        ELSIF (clk'EVENT AND clk = '1') THEN
            count := count + 1;
            IF (count = time) THEN
                pr_state <= nx_state;
                count := 0;
            END IF;
        END IF;
    END PROCESS;
    
    -- Upper section of state machine:
    PROCESS (pr_state, test)
    BEGIN
        CASE pr_state IS
            WHEN RG =>
                r1 <= '1'; r2 <= '0'; y1 <= '0'; y2 <= '0'; g1 <= '0'; g2 <= '1';
                nx_state <= RY;
                IF (test = '0') THEN
                    time <= timeRG;
                ELSE
                    time <= timeTEST;
                END IF;
                
            WHEN RY =>
                r1 <= '1'; r2 <= '0'; y1 <= '0'; y2 <= '1'; g1 <= '0'; g2 <= '0';
                nx_state <= GR;
                IF (test = '0') THEN
                    time <= timeRY;
                ELSE
                    time <= timeTEST;
                END IF;
                
            WHEN GR =>
                r1 <= '0'; r2 <= '1'; y1 <= '0'; y2 <= '0'; g1 <= '1'; g2 <= '0';
                nx_state <= YR;
                IF (test = '0') THEN
                    time <= timeGR;
                ELSE
                    time <= timeTEST;
                END IF;
                
            WHEN YR =>
                r1 <= '0'; r2 <= '1'; y1 <= '1'; y2 <= '0'; g1 <= '0'; g2 <= '0';
                nx_state <= RG;
                IF (test = '0') THEN
                    time <= timeYR;
                ELSE
                    time <= timeTEST;
                END IF;
                
            WHEN YY =>
                r1 <= '0'; r2 <= '0'; y1 <= '1'; y2 <= '1'; g1 <= '0'; g2 <= '0';
                nx_state <= RY;
        END CASE;
    END PROCESS;
    
END behavior;
