library ieee;
use ieee.std_logic_1164.all;

entity recursive_functions_entity_tb is
end recursive_functions_entity_tb;

architecture TB_ARCHITECTURE of recursive_functions_entity_tb is

    -- Component declaration of the tested unit
    component recursive_functions_entity
        port (
            BCD_In : in std_logic_vector;
            Binary_Out : out std_logic_vector
        );
    end component;

    -- Stimulus signals
    signal BCD_In : std_logic_vector(3 downto 0);
    -- Observed signals
    signal Binary_Out : std_logic_vector(7 downto 0);

begin

    -- Unit Under Test (UUT) port map
    UUT : recursive_functions_entity
        port map (
            BCD_In => BCD_In,
            Binary_Out => Binary_Out
        );

    -- Stimulus process
    stimulus_proc: process
    begin
        -- Initialize stimulus values
        BCD_In <= "0000";
        wait for 10 ns;
        
        BCD_In <= "0101";
        wait for 10 ns;
        
        BCD_In <= "1111";
        wait for 10 ns;
        
        BCD_In <= "0010";
        wait for 10 ns;
        
        BCD_In <= "1001";
        wait for 10 ns;
        
        wait;
    end process stimulus_proc;

end TB_ARCHITECTURE;


configuration TESTBENCH_FOR_recursive_functions_entity of recursive_functions_entity_tb is
	for TB_ARCHITECTURE
		for UUT : recursive_functions_entity
			use entity work.recursive_functions_entity(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_recursive_functions_entity;