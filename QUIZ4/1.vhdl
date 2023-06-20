-- Component for N-bit full adder

library ieee;
use ieee.std_logic_1164.all;

entity Full_Adder is
  port(
    A, B, Cin : in std_logic;
    Sum, Cout : out std_logic
  );
end Full_Adder;

architecture Behavioral of Full_Adder is
begin
  Sum <= A xor B xor Cin; -- Calculate the sum output using XOR gates
  Cout <= (A and B) or (Cin and (A xor B)); -- Calculate the carry output using AND and OR gates
end Behavioral;


library ieee;
use ieee.std_logic_1164.all;

-- Component for output generator

entity Output_Generator is
  generic(
    N : integer range 2 to 7
  );
  port(
    A : in std_logic_vector(N-1 downto 0);
    B : in std_logic;
    C : out std_logic_vector(N downto 0)
  );
end Output_Generator;

architecture Behavioral of Output_Generator is
begin
  C <= B & A; -- Concatenate B and A to generate the output vector C
end Behavioral;


library ieee;
use ieee.std_logic_1164.all;

-- Component for counting the number of 1s in the input and returning 1 if even

entity Even_Count_Checker is
  generic(
    N : integer range 1 to 8
  );
  port(
    A : in std_logic_vector(N-1 downto 0);
    B : out std_logic
  );
end Even_Count_Checker;

architecture Behavioral of Even_Count_Checker is
begin
  -- Check if the count of 1s in A is even
  B <= '1' when (A'length mod 2 = 0) else '0';
end Behavioral;


library ieee;
use ieee.std_logic_1164.all;

-- Main component

entity Combinational_Circuit is
  generic(
    N : integer range 1 to 8
  );
  port(
    A, B : in std_logic_vector(N-1 downto 0);
    C : out std_logic_vector(N downto 0)
  );
end Combinational_Circuit;

architecture Behavioral of Combinational_Circuit is
  -- Instantiate the Full_Adder component
  component Full_Adder is
    port(
      A, B, Cin : in std_logic;
      Sum, Cout : out std_logic
    );
  end component;

  -- Instantiate the Output_Generator component
  component Output_Generator is
    generic(
      N : integer range 2 to 7
    );
    port(
      A : in std_logic_vector(N-1 downto 0);
      B : in std_logic;
      C : out std_logic_vector(N downto 0)
    );
  end component;

  -- Instantiate the Even_Count_Checker component
  component Even_Count_Checker is
    generic(
      N : integer range 1 to 8
    );
    port(
      A : in std_logic_vector(N-1 downto 0);
      B : out std_logic
    );
  end component;

  signal Sum, Cout : std_logic;
  signal Result : std_logic_vector(N downto 0);
begin
  -- Instantiate N-bit adder
  Adder: for i in 0 to N-1 generate
    Full_Adder_i: Full_Adder
      port map(
        A => A(i),
        B => B(i),
        Cin => Cout,
        Sum => Sum,
        Cout => Cout
      );
  end generate;

  -- Instantiate output generator
  Output_Gen: Output_Generator
    generic map(
      N => N
    )
    port map(
      A => A, -- Connect the correct input signal
      B => Cout,
      C => Result
    );

  -- Instantiate even count checker
  Even_Count: Even_Count_Checker
    generic map(
      N => N
    )
    port map(
      A => A,
      B => Result(N)
    );

  C <= Result; -- Assign the output vector Result to the output port C
end Behavioral;
