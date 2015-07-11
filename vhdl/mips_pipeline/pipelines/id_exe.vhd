library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use work.records_pkg.all;
use work.subtypes_pkg.all;
use work.constants_pkg.all;

entity id_exe is
    port (
        clk     : in std_logic;
        rst_n   : in std_logic;
        halt_i  : in std_logic;
        ID_EXE_i : in ID_EXE_t;
        ID_EXE_o : out ID_EXE_t
    );
end id_exe;

architecture Behavioral of id_exe is
  
  signal id_exe_c, id_exe_n : ID_EXE_t;
  
begin
  
    clk_proc: process(clk, rst_n)
    begin
      if rst_n = '0' then
              ID_EXE_c.regA <= (others => '0');
              ID_EXE_c.regB <= (others => '0');
              ID_EXE_c.shamt <= (others => '0');
              ID_EXE_c.funct <= (others => '0');
              ID_EXE_c.sign_extend <= (others => '0');
              ID_EXE_c.pc_plus1 <= (others => '0');
              ID_EXE_c.RS <= (others => '0');
              ID_EXE_c.RT <= (others => '0');
              ID_EXE_c.RD <= (others => '0');
              ID_EXE_c.aluSrc_b <= '0';
              ID_EXE_c.memToReg <= '0';
              ID_EXE_c.regWrite <= '0';
              ID_EXE_c.memWen_n <= '1'; -- no no write mr Peter no no
              ID_EXE_c.cAlu_op <= (others => '0');
              ID_EXE_c.regDst <= '0';
          elsif rising_edge(clk) then
            id_exe_c <= id_exe_n;
        end if;
    end process;
    
    
    halt_proc: process(halt_i, id_exe_c, ID_EXE_i)
    begin
      
        if halt_i = '0' then
            id_exe_n <= ID_EXE_i;
        else
            id_exe_n <= id_exe_c;
        end if;
    end process;
    
    ID_EXE_o <= id_exe_c;
  
end architecture;
