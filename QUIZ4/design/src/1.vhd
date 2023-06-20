-- Component for 1-bit full adder
library ieee;
use ieee.std_logic_1164.all;
  
entity FullAdder is
    Port ( A, B, Cin : in std_logic;
           Sum, Cout : out std_logic);
end FullAdder;

architecture Behavioral of FullAdder is
begin
    Sum <= A xor B xor Cin;
    Cout <= (A and B) or (Cin and (A xor B));
end Behavioral;


-- Component for N-bit adder using FullAdder component 
library ieee;
use ieee.std_logic_1164.all;

entity NBitAdder is
    generic (N : integer range 2 to 9);
    Port ( A, B : in std_logic_vector(N-1 downto 0);
           Cin : in std_logic;
           Sum : out std_logic_vector(N-1 downto 0);
           Cout : out std_logic);
end NBitAdder;

architecture Behavioral of NBitAdder is
    component FullAdder is
        Port ( A, B, Cin : in std_logic;
               Sum, Cout : out std_logic);
    end component;

    signal Carry : std_logic;
begin
    Carry <= Cin;
    Adder: for i in 0 to N-1 generate
        FA: FullAdder port map(A(i), B(i), Carry, Sum(i), Carry);
    end generate;
    Cout <= Carry;
end Behavioral;


-- Component for counting the number of 1s in the input and returning 1 if count is even  
library ieee;
use ieee.std_logic_1164.all;

entity CountAndReturnEven is
    generic (N : integer range 2 to 9);
    Port ( A : in std_logic_vector(N-1 downto 0);
           EvenCount : out std_logic);
end CountAndReturnEven;

architecture Behavioral of CountAndReturnEven is
    signal Count : integer range 0 to N;
begin
    process(A)
    begin
        Count <= 0;
        for i in 0 to N-1 loop
            if A(i) = '1' then
                Count <= Count + 1;
            end if;
        end loop;
    end process;

    EvenCount <= '1' when Count mod 2 = 0 else '0';
end Behavioral;


-- Main circuit    
library ieee;
use ieee.std_logic_1164.all;

entity CombinationalCircuit is
    generic (N : integer range 2 to 9);
    Port ( A, B : in std_logic_vector(N-1 downto 0);
           C : out std_logic_vector(N-1 downto 0));
end CombinationalCircuit;

architecture Behavioral of CombinationalCircuit is
    component NBitAdder is
        generic (N : integer range 2 to 9);
        Port ( A, B : in std_logic_vector(N-1 downto 0);
               Cin : in std_logic;
               Sum : out std_logic_vector(N-1 downto 0);
               Cout : out std_logic);
    end component;

    component CountAndReturnEven is
        generic (N : integer range 2 to 9);
        Port ( A : in std_logic_vector(N-1 downto 0);
               EvenCount : out std_logic);
    end component;

    signal Sum : std_logic_vector(N-1 downto 0);
    signal EvenCount : std_logic;
begin
    Adder: NBitAdder generic map(N) port map(A, B, '0', Sum, open);
    Counter: CountAndReturnEven generic map(N) port map(A, EvenCount);
    C <= Sum when EvenCount = '1' else (others => '0');
end Behavioral;


-- Component for generating the output   
  
library ieee;
use ieee.std_logic_1164.all;

entity OutputGenerator is
    generic (N : integer range 2 to 9);
    Port ( NORResult : in std_logic;
           Sum : in std_logic_vector(N-1 downto 0);
           Output : out std_logic_vector(N-1 downto 0));
end OutputGenerator;

architecture Behavioral of OutputGenerator is
begin
    Output <= NORResult & Sum;
end Behavioral;
