library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;

package matrix_pkg is
    type complex is record
        real_part : integer;
        imag_part : integer;
    end record;
    type matrix is array (natural range <>, natural range <>) of complex;
    function add_matrix(a: matrix; b: matrix) return matrix;
    function mul_matrix(a: matrix; b: matrix) return matrix;
    procedure fill_matrix(a: out matrix);
    procedure print_matrix(a: matrix);
end matrix_pkg;

package body matrix_pkg is
    function add_matrix(a: matrix; b: matrix) return matrix is
        variable c : matrix(a'range(1), a'range(2));
    begin
        for i in a'range(1) loop
            for j in a'range(2) loop
                c(i, j).real_part := a(i, j).real_part + b(i, j).real_part;
                c(i, j).imag_part := a(i, j).imag_part + b(i, j).imag_part;
            end loop;
        end loop;
        return c;
    end add_matrix;

    function mul_matrix(a: matrix; b: matrix) return matrix is
        variable c : matrix(a'range(1), b'range(2));
    begin
        for i in a'range(1) loop
            for j in b'range(2) loop
                c(i, j).real_part := 0;
                c(i, j).imag_part := 0;
                for k in a'range(2) loop
                    c(i, j).real_part := c(i, j).real_part + a(i, k).real_part * b(k, j).real_part - a(i, k).imag_part * b(k, j).imag_part;
                    c(i, j).imag_part := c(i, j).imag_part + a(i, k).real_part * b(k, j).imag_part + a(i, k).imag_part * b(k, j).real_part;
                end loop;
            end loop;
        end loop;
        return c;
    end mul_matrix;

    procedure fill_matrix(a: out matrix) is
    begin
        for i in a'range(1) loop
            for j in a'range(2) loop
                a(i, j).real_part := i + j;
                a(i, j).imag_part := i - j;
            end loop;
        end loop;
    end fill_matrix;

    procedure print_matrix(a: matrix) is
    begin
        for i in a'range(1) loop
            for j in a'range(2) loop
                report "Real Part: " & integer'image(a(i, j).real_part) & ", Imaginary Part: " & integer'image(a(i, j).imag_part);
            end loop;
        end loop;
    end print_matrix;

end matrix_pkg;

