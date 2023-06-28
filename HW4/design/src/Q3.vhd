------------------------- MealyMachine -------------------------

library ieee;
use ieee.std_logic_1164.all;

entity MealyMachine is
  port (
    clk   : in  std_logic;      -- Clock input
    reset : in  std_logic;      -- Reset input
    inp   : in  std_logic;      -- Input signal
    outp  : out std_logic       -- Output signal
  );
end entity MealyMachine;

architecture Behavioral of MealyMachine is
  type state_type is (s0, s1, s2, s3);  -- Define an enumerated type for states
  signal current_state, next_state : state_type;  -- Signals for current and next states

begin
  process (clk, reset)
  begin
    if reset = '1' then
      current_state <= s0;        -- Reset current state to s0
    elsif rising_edge(clk) then   -- Check for rising edge of the clock
      current_state <= next_state;  -- Update current state with next state value
    end if;
  end process;

  process (current_state, inp)
  begin
    case current_state is       -- State transition and output logic based on the current state
      when s0 =>               -- State s0
        if inp = '1' then      -- If input is '1'
          next_state <= s1;    -- Transition to s1
        else
          next_state <= s0;    -- Stay in s0
        end if;
        outp <= '0';           -- Output '0'

      when s1 =>               -- State s1
        if inp = '1' then      -- If input is '1'
          next_state <= s2;    -- Transition to s2
        else
          next_state <= s0;    -- Transition to s0
        end if;
        outp <= '0';           -- Output '0'

      when s2 =>               -- State s2
        if inp = '1' then      -- If input is '1'
          next_state <= s3;    -- Transition to s3
        else
          next_state <= s0;    -- Transition to s0
        end if;
        outp <= '0';           -- Output '0'

      when s3 =>               -- State s3
        if inp = '0' then      -- If input is '0'
          next_state <= s0;    -- Transition to s0
        else
          next_state <= s1;    -- Transition to s1
        end if;
        outp <= '1';           -- Output '1'
    end case;
  end process;
end architecture Behavioral; 


------------------------- MooreMachine -------------------------


library ieee;
use ieee.std_logic_1164.all;

entity MooreMachine is
  port (
    clk   : in  std_logic;      -- Clock input
    reset : in  std_logic;      -- Reset input
    inp   : in  std_logic;      -- Input signal
    outp  : out std_logic       -- Output signal
  );
end entity MooreMachine;

architecture Behavioral of MooreMachine is
  type state_type is (s0, s1, s2, s3);  -- Define an enumerated type for states
  signal current_state, next_state : state_type;  -- Signals for current and next states

begin
  process (clk, reset)
  begin
    if reset = '1' then
      current_state <= s0;        -- Reset current state to s0
    elsif rising_edge(clk) then   -- Check for rising edge of the clock
      current_state <= next_state;  -- Update current state with next state value
    end if;
  end process;

  process (current_state, inp)
  begin
    case current_state is       -- State transition and output logic based on the current state
      when s0 =>               -- State s0
        if inp = '1' then      -- If input is '1'
          next_state <= s1;    -- Transition to s1
        else
          next_state <= s0;    -- Stay in s0
        end if;
        
      when s1 =>               -- State s1
        if inp = '1' then      -- If input is '1'
          next_state <= s2;    -- Transition to s2
        else
          next_state <= s0;    -- Transition to s0
        end if;
        
      when s2 =>               -- State s2
        if inp = '1' then      -- If input is '1'
          next_state <= s3;    -- Transition to s3
        else
          next_state <= s0;    -- Transition to s0
        end if;
        
      when s3 =>               -- State s3
        if inp = '0' then      -- If input is '0'
          next_state <= s0;    -- Transition to s0
        else
          next_state <= s1;    -- Transition to s1
        end if;
    end case;
    
    -- Output logic
    case current_state is
      when s0 => outp <= '0';
      when s1 => outp <= '0';
      when s2 => outp <= '0';
      when s3 => outp <= '1';
    end case;
    
  end process;
end architecture Behavioral;


