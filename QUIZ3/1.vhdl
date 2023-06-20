library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity GCD_LCM is
    Port ( num1 : in  integer;        -- Input port for num1
           num2 : in  integer;        -- Input port for num2
           gcd  : out integer;        -- Output port for GCD
           lcm  : out integer);       -- Output port for LCM
end GCD_LCM;

architecture Behavioral of GCD_LCM is

    signal a : integer;                -- Signal to hold num1
    signal b : integer;                -- Signal to hold num2
    signal temp : integer;             -- Signal to hold temporary value
    signal gcd_val : integer;          -- Signal to hold GCD value

begin

    process (num1, num2)               -- Process triggered on num1 and num2 changes
    begin
        a <= num1;                     -- Assign num1 to signal a
        b <= num2;                     -- Assign num2 to signal b
        
        while b /= 0 loop             -- Loop until b becomes 0
            temp <= b;                 -- Assign b to temporary signal temp
            b <= a mod b;              -- Assign the remainder of a divided by b to b
            a <= temp;                 -- Assign the previous value of b (stored in temp) to a
        end loop;
        
        gcd_val <= a;                  -- Assign the final GCD value to gcd_val
        
        gcd <= gcd_val;                -- Assign gcd_val to output port gcd
        lcm <= (num1 * num2) / gcd_val; -- Calculate LCM using num1, num2, and gcd_val and assign it to output port lcm
    end process;

end Behavioral;
