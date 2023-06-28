library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

-- Add your library and packages declaration here ...

entity counterex_tb is
  -- Generic declarations of the tested unit
  generic (
    M : NATURAL := 6;
    N : NATURAL := 4
  );
end counterex_tb;

architecture TB_ARCHITECTURE of counterex_tb is
  -- Component declaration of the tested unit
  component counterex
    generic (
      M : NATURAL := 6;
      N : NATURAL := 4
    );
    port (
      clk : in STD_LOGIC;
      reset : in STD_LOGIC;
      out_moore : out STD_LOGIC_VECTOR(N-1 downto 0)
    );
  end component;

  -- Stimulus signals - signals mapped to the input and inout ports of tested entity
  signal clk : STD_LOGIC;
  signal reset : STD_LOGIC;
  -- Observed signals - signals mapped to the output ports of tested entity
  signal out_moore : STD_LOGIC_VECTOR(N-1 downto 0);

  -- Add your code here ...

begin

  -- Unit Under Test port map
  UUT : counterex
    generic map (
      M => M,
      N => N
    )
    port map (
      clk => clk,
      reset => reset,
      out_moore => out_moore
    );

  -- Add your stimulus here ...
  -- Example test: Generate a clock signal and assert a reset signal

  -- Clock generation process
  process
  begin
    clk <= '0'; -- Initialize clock to 0
    while now < 300 ns loop -- Generate clock for 300 ns
      wait for 10 ns;
      clk <= not clk; -- Toggle the clock
    end loop;
    wait;
  end process;

  -- Reset assertion process
  process
  begin
    reset <= '1'; -- Assert reset
    wait for 20 ns; -- Wait for 20 ns
    reset <= '0'; -- Deassert reset
    wait;
  end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_counterex of counterex_tb is
  for TB_ARCHITECTURE
    for UUT : counterex
      use entity work.counterex(arch);
    end for;
  end for;
end TESTBENCH_FOR_counterex;
