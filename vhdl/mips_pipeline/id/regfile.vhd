library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.records_pkg.all;
use work.constants_pkg.all;
use work.subtypes_pkg.all;

entity regfile is
    
    port (
        clk       : in  std_logic;
        rst_n     : in  std_logic;
        regfile_i : in  regfile_in_t;
        regfile_o : out regfile_out_t);

end entity regfile;

architecture Behavioral of regfile is

    -- the registers in MIPS
    type storageT is array (31 downto 0) of word_s;
    signal registers : storageT;
    
begin  -- architecture Behavioral

    clk_proc: process (clk, rst_n) is
    begin  -- process clk_proc
        if rst_n = '0' then               -- asynchronous reset (active low)
            -- clear registers
            for I in 0 to 31 loop
                registers(I) <= (others => '0');
            end loop;  -- I
        elsif rising_edge(clk) then  -- rising clock edge
           if regfile_i.wr_en = '1' then
               -- reg(0) is always = 0, can't write to it
               if regfile_i.adrwrite /= "00000" then
                   registers(to_integer(unsigned(regfile_i.adrwrite))) <= regfile_i.write_data;
               else
                  registers(0) <= (others => '0');
              end if;
           end if; 
        end if;
    end process clk_proc;
    

    with regfile_i.forward_a select
        regfile_o.read_data0 <= regfile_i.write_data when '1',
        registers(to_integer(unsigned(regfile_i.adrread0))) when others;

    with regfile_i.forward_b select
        regfile_o.read_data1 <= regfile_i.write_data when '1',
        registers(to_integer(unsigned(regfile_i.adrread1))) when others;

end architecture Behavioral;
