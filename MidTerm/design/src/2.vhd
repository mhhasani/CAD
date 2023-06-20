library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Full_Adder is
  port (
    a, b, cin : in std_logic;   -- Input signals: a, b, and cin (carry-in)
    sum, cout : out std_logic  -- Output signals: sum and cout (carry-out)
  );
end Full_Adder;

architecture Behavioral of Full_Adder is
begin
  sum <= a xor b xor cin;                            -- Calculate the sum using XOR gates
  cout <= (a and b) or (cin and (a xor b));          -- Calculate the carry-out using AND and OR gates
end Behavioral;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Half_Adder is
  port (
    a, b : in std_logic;      -- Input signals: a and b
    sum, cout : out std_logic -- Output signals: sum and cout (carry-out)
  );
end Half_Adder;

architecture Behavioral of Half_Adder is
begin
  sum <= a xor b;             -- Calculate the sum using XOR gate
  cout <= a and b;            -- Calculate the carry-out using AND gate
end Behavioral;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BCD_Adder is
  generic (
    n : integer := 3         -- Generic parameter: number of bits per BCD digit
  );
  port (
    input  : in  std_logic_vector(10 * n * 4 - 1 downto 0);    -- Input signal: BCD numbers to be added
    sum_out: out std_logic_vector(10 * n * 4 - 1 downto 0)     -- Output signal: sum of BCD numbers
  );
end BCD_Adder;

architecture Behavioral of BCD_Adder is
  component Full_Adder is
    port (
      a, b, cin : in  std_logic;
      sum, cout : out std_logic
    );
  end component;

  component Half_Adder is
    port (
      a, b : in  std_logic;
      sum, cout : out std_logic
    );
  end component;

  signal carry      : std_logic_vector(n - 1 downto 0);                -- Signal: carry bits for each BCD digit
  signal digit_sums : std_logic_vector(10 * n * 4 - 1 downto 0);      -- Signal: sum of each BCD digit
  signal bcd_num    : std_logic_vector(10 * n * 4 - 1 downto 0);      -- Signal: BCD numbers

begin
  bcd_num <= input;

  gen_nums: for i in 0 to 9 generate   -- Generate loop for each BCD digit (0 to 9)
    gen_carry: for j in 0 to n - 2 generate   -- Generate loop for carry bits (0 to n-2)
      Full_Adder_inst: Full_Adder port map (
        a    => bcd_num((i + 1) * n * 4 - (j * 4 + 1)),   -- Connect BCD number bits to the Full Adder inputs
        b    => bcd_num((i + 1) * n * 4 - (j * 4 + 2)),
        cin  => carry(j),                                 -- Connect carry bit from the previous BCD digit
        sum  => digit_sums((i + 1) * n * 4 - (j * 4 + 1)), -- Connect sum bit to the digit_sums signal
        cout => carry(j + 1)                              -- Connect carry-out to the carry signal
      );
    end generate gen_carry;

    gen_sum: for j in 0 to n - 2 generate    -- Generate loop for sum bits (0 to n-2)
      Half_Adder_inst: Half_Adder port map (
        a    => bcd_num((i + 1) * n * 4 - (j * 4 + 3)),   -- Connect BCD number bits to the Half Adder inputs
        b    => bcd_num((i + 1) * n * 4 - (j * 4 + 4)),
        sum  => digit_sums((i + 1) * n * 4 - (j * 4 + 3)), -- Connect sum bit to the digit_sums signal
        cout => carry(n - 1)                             -- Connect carry-out to the carry signal
      );
    end generate gen_sum;
  end generate gen_nums;

  sum_out <= std_logic_vector(unsigned(bcd_num(10 * n * 4 - 1 downto 10 * n * 4 - 4)) + unsigned(digit_sums));  -- Calculate the sum of BCD numbers

end Behavioral;
