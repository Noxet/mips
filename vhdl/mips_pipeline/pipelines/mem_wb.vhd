library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use work.records_pkg.all;
use work.subtypes_pkg.all;
use work.constants_pkg.all;

entity mem_wb is
    port (
        clk     : in std_logic;
        rst_n   : in std_logic;
        halt_i  : in std_logic;
        MEM_WB_i : in MEM_WB_t;
        MEM_WB_o : out MEM_WB_t
    );
end mem_wb;

architecture Behavioral of mem_wb is
  
  signal mem_wb_c, mem_wb_n : MEM_WB_t;
  
begin
  
    clk_proc: process(clk, rst_n)
    begin
        if rst_n = '0' then
                MEM_WB_c.alu_res <= (others => '0');
                MEM_WB_c.write_reg <= (others => '0');
                MEM_WB_c.memToReg <= '0';
                MEM_WB_c.regWrite <= '0';
        elsif rising_edge(clk) then
            
            mem_wb_c <= mem_wb_n;
        end if;
    end process;
    
    halt_proc: process(halt_i, mem_wb_c, MEM_WB_i)
    begin
        if halt_i = '0' then
            mem_wb_n <= MEM_WB_i;
        else
            mem_wb_n <= mem_wb_c;
        end if;
    end process;
    
    MEM_WB_o <= mem_wb_c;
  
end architecture;   