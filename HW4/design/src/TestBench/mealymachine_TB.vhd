library ieee;
use ieee.std_logic_1164.all;

-- Add your library and packages declaration here ...

entity mealymachine_tb is
end mealymachine_tb;

architecture TB_ARCHITECTURE of mealymachine_tb is
  -- Component declaration of the tested unit
  component mealymachine
    port(
      clk : in STD_LOGIC;
      reset : in STD_LOGIC;
      inp : in STD_LOGIC;
      outp : out STD_LOGIC
    );
  end component;

  -- Stimulus signals - signals mapped to the input and inout ports of tested entity
  signal clk : STD_LOGIC := '0';       -- Initialize clk to '0'
  signal reset : STD_LOGIC := '0';     -- Initialize reset to '0'
  signal inp : STD_LOGIC := '0';       -- Initialize inp to '0'
  -- Observed signals - signals mapped to the output ports of tested entity
  signal outp : STD_LOGIC;

  -- Add your code here ...

begin

  -- Unit Under Test port map
  UUT : mealymachine
    port map (
      clk => clk,
      reset => reset,
      inp => inp,
      outp => outp
    );

  -- Add your stimulus here ...
  
  -- Clock process definitions
  clk_process : process
  begin
    clk <= '0';
    wait for 5 ns;
    clk <= '1';
    wait for 5 ns;
  end process;

  -- Stimulus process definitions
  stim_proc : process
  begin
    -- add test to check just 1110 is accepted
    wait for 10 ns;
    inp <= '1';
    wait for 10 ns;
    inp <= '1';
    wait for 10 ns;
    inp <= '1';
    wait for 10 ns;
    inp <= '0';
    wait for 10 ns;
    inp <= '1';
    wait for 10 ns;
    inp <= '0';
    wait for 10 ns;
    inp <= '1';
    wait for 10 ns;
    inp <= '0';
    wait;
  end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_mealymachine of mealymachine_tb is
  for TB_ARCHITECTURE
    for UUT : mealymachine
      use entity work.mealymachine(behavioral);
    end for;
  end for;
end TESTBENCH_FOR_mealymachine;
