library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


-- Package definition
package convolution_pkg is
  type grayscale_array is array (natural range <>) of integer range 0 to 255;
  type filter_array is array (natural range <>, natural range <>) of real range 0.0 to 1.0;
  
  function convolution_unit(window: in grayscale_array; filter: in filter_array) return real;
  
  procedure main_component(image: in grayscale_array(0 to 29, 0 to 29);
                           filter: in filter_array(0 to 2, 0 to 2);
                           num_units: in integer;
                           feature_map: out grayscale_array(0 to 28, 0 to 28));
end convolution_pkg;

-- Package body
package body convolution_pkg is
  function convolution_unit(window: in grayscale_array; filter: in filter_array) return real is
    variable result: real := 0.0;
  begin
    result := (window(0)(0) * filter(0, 0) +
               window(0)(1) * filter(0, 1) +
               window(0)(2) * filter(0, 2) +
               window(1)(0) * filter(1, 0) +
               window(1)(1) * filter(1, 1) +
               window(1)(2) * filter(1, 2) +
               window(2)(0) * filter(2, 0) +
               window(2)(1) * filter(2, 1) +
               window(2)(2) * filter(2, 2)) / 9.0;
    return result;
  end convolution_unit;
  
  procedure main_component(image: in grayscale_array(0 to 29, 0 to 29);
                           filter: in filter_array(0 to 2, 0 to 2);
                           num_units: in integer;
                           feature_map: out grayscale_array(0 to 28, 0 to 28)) is
    variable window: grayscale_array(0 to 2, 0 to 2);
  begin
    for i in 0 to 28 loop
      for j in 0 to 28 loop
        for k in 0 to num_units-1 loop
          for m in 0 to 2 loop
            for n in 0 to 2 loop
              window(m)(n) := image(i+m)(j+n);
            end loop;
          end loop;
          feature_map(i)(j) := integer(convolution_unit(window, filter));
        end loop;
      end loop;
    end loop;
  end main_component;
end convolution_pkg;
