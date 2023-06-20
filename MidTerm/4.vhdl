library IEEE;
use IEEE.std_logic_1164.all;

entity jkff is
  port (
    j, k, c : in STD_LOGIC;  -- Input ports: J, K, and clock
    q : out STD_LOGIC        -- Output port: Q
  );
end jkff;

library IEEE;
use IEEE.std_logic_1164.all;

entity d_register is
  port (
    d : in STD_LOGIC_VECTOR(7 downto 0);  -- Input port: D (8-bit vector)
    clk : in STD_LOGIC;                   -- Input port: Clock
    q : out STD_LOGIC_VECTOR(7 downto 0)  -- Output port: Q (8-bit vector)
  );
end d_register;

architecture behavior of d_register is
  component jkff is
    port (
      j, k, c : in STD_LOGIC;  -- Input ports: J, K, and clock
      q : out STD_LOGIC        -- Output port: Q
    );
  end component;

  signal j_in, k_in : STD_LOGIC_VECTOR(7 downto 0);  -- Internal signals for J and K inputs
  signal q_out : STD_LOGIC_VECTOR(7 downto 0);       -- Internal signal for Q output

begin

  GEN_FF : for i in 0 to 7 generate  -- Generate 8 JK flip-flops
    jk_inst : jkff port map (
      j => j_in(i),          -- Connect J input to j_in(i)
      k => k_in(i),          -- Connect K input to k_in(i)
      c => clk,              -- Connect clock input to clk
      q => q_out(i)          -- Connect Q output to q_out(i)
    );
  end generate;

  d_comp : process(d)  -- Process for generating J and K inputs based on D input
  begin
    for i in 0 to 7 loop
      j_in(i) <= d(i);           -- J input is directly connected to D(i)
      k_in(i) <= not d(i);       -- K input is the complement of D(i)
    end loop;
  end process d_comp;

  q <= q_out;  -- Assign internal signal q_out to the output port q

end behavior;
