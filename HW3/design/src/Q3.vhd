-- 1. Make a package and define the image and filter and the types, functions and procedures you are going to use
-- Define package "image_filter"
package image_filter is
    type image_type is array (0 to 29, 0 to 29) of integer range 0 to 255;
    type filter_type is array (0 to 2, 0 to 2) of real range -1.0 to 1.0;
    function convolution (window : image_type; filter : filter_type) return real;
end image_filter;

-- Implement package body "image_filter"
package body image_filter is
    function convolution (window : image_type; filter : filter_type) return real is
        variable result : real := 0.0;
    begin
        for i in 0 to 2 loop
            for j in 0 to 2 loop
                result := result + real(window(i, j)) * filter(i, j);
            end loop;
        end loop;
        return result / 9.0;
    end convolution;
end image_filter;


-- 2. Make the convolution unit with 2 inputs and 1 output( you can also pass the whole image to unit with index instead of passing window)
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.image_filter.all;

entity convolution_unit is
    port (
        clk : in std_logic;
        reset : in std_logic;
        window : in image_type;
        filter : in filter_type;
        result : out real
    );
end convolution_unit;

architecture rtl of convolution_unit is
    signal result_reg : real := 0.0;
begin
    process (clk, reset)
    begin
        if reset = '1' then
            result_reg <= 0.0;
        elsif rising_edge(clk) then
            result_reg <= convolution(window, filter);
        end if;
    end process;
    result <= result_reg;
end rtl;

-- 3. Make the Main components with the generic integer on N that indicates number of Convolution units that we are going to use
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.image_filter.all;

entity main is
    generic (
        N : integer := 1
    );
    port (
        clk : in std_logic;
        reset : in std_logic;
        image : in image_type;
        filter : in filter_type;
        result : out real
    );
end main;

architecture rtl of main is
    component convolution_unit is
        port (
            clk : in std_logic;
            reset : in std_logic;
            window : in image_type;
            filter : in filter_type;
            result : out real
        );
    end component;

    signal result_reg : real := 0.0;
    signal window_reg : image_type := (others => (others => 0));
    signal filter_reg : filter_type := (others => (others => 0.0));
    signal result_unit : real := 0.0;
begin
    process (clk, reset)
    begin
        if reset = '1' then
            result_reg <= 0.0;
            window_reg <= (others => (others => 0));
            filter_reg <= (others => (others => 0.0));
        elsif rising_edge(clk) then
            result_reg <= result_unit;
            window_reg <= window_reg;
            filter_reg <= filter_reg;
        end if;
    end process;

    unit : for i in 0 to N - 1 generate
        unit_i : convolution_unit
            port map (
                clk => clk,
                reset => reset,
                window => window_reg,
                filter => filter_reg,
                result => result_unit
            );
    end generate;

    result <= result_reg;
end rtl;

-- 4. Show the result feature map(29*29 of Real)(bonus for saving the result into a txt file) About using multiple units its up to you how to handle it

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.image_filter.all;
library std;
use std.textio.all;

entity feature_map is
    generic (
        N : integer := 1
    );
    port (
        clk : in std_logic;
        reset : in std_logic;
        image : in image_type;
        filter : in filter_type;
        feature_map : out image_type
    );
end feature_map;

architecture rtl of feature_map is
    component main is
        generic (
            N : integer := 1
        );
        port (
            clk : in std_logic;
            reset : in std_logic;
            image : in image_type;
            filter : in filter_type;
            result : out real
        );
    end component;

    signal result : real := 0.0;
    signal result_reg : real := 0.0;
    signal window_reg : image_type := (others => (others => 0));
    signal filter_reg : filter_type := (others => (others => 0.0));
    signal feature_map_reg : image_type := (others => (others => 0));

    file file_handle : text open write_mode is "feature_map.txt";
begin
    process (clk, reset)
        variable line : line;
    begin
        if reset = '1' then
            result_reg <= 0.0;
            window_reg <= (others => (others => 0));
            filter_reg <= (others => (others => 0.0));
            feature_map_reg <= (others => (others => 0));
        elsif rising_edge(clk) then
            result_reg <= result;
            window_reg <= window_reg;
            filter_reg <= filter_reg;
            feature_map_reg <= feature_map_reg;
        end if;

        if reset = '1' then
            write(line, "Feature Map");
            writeline(file_handle, line);
            for i in 0 to 29 loop
                for j in 0 to 29 loop
                    write(line, integer'image(feature_map_reg(i, j)));
                    writeline(file_handle, line);
                end loop;
            end loop;
        elsif rising_edge(clk) then
            write(line, "Feature Map");
            writeline(file_handle, line);
            for i in 0 to 29 loop
                for j in 0 to 29 loop
                    write(line, integer'image(feature_map_reg(i, j)));
                    writeline(file_handle, line);
                end loop;
            end loop;
        end if;
    end process;

    unit : for i in 0 to N - 1 generate
        unit_i : main
            port map (
                clk => clk,
                reset => reset,
                image => image,
                filter => filter,
                result => result
            );
    end generate;

    feature_map <= feature_map_reg;
end rtl;