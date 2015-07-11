library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use work.records_pkg.all;
use work.subtypes_pkg.all;
use work.constants_pkg.all;

entity exe_mem is
    port (
        clk     : in std_logic;
        rst_n   : in std_logic;
        halt_i  : in std_logic;
        EXE_MEM_i : in EXE_MEM_t;
        EXE_MEM_o : out EXE_MEM_t
    );
end exe_mem;

architecture Behavioral of exe_mem is
  
    signal exe_mem_c, exe_mem_n : EXE_MEM_t;
  
begin
  
    clk_proc: process(clk, rst_n)
    begin
      
        if rst_n = '0' then  
                EXE_MEM_c.alu_res <= (others => '0');
                EXE_MEM_c.dmem_data <= (others => '0');
                EXE_MEM_c.write_reg <= (others => '0');
                EXE_MEM_c.memToReg <= '0';
                EXE_MEM_c.regWrite <= '0';
                EXE_MEM_c.memWen_n <= '1'; -- no no write mr Peter no no
        elsif rising_edge(clk) then
            
            exe_mem_c <= exe_mem_n;
        end if;
    end process;
    
    halt_proc: process(halt_i, exe_mem_c, EXE_MEM_i)
    begin
        if halt_i = '0' then
            exe_mem_n <= EXE_MEM_i;
        else
            exe_mem_n <= exe_mem_c;
        end if;
    end process;
  
    EXE_MEM_o <= exe_mem_c;
  
end architecture;