library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use work.records_pkg.all;
use work.subtypes_pkg.all;
use work.constants_pkg.all;

entity if_id is
    port (
        clk     : in std_logic;
        rst_n   : in std_logic;
        halt_i  : in std_logic;
        IF_ID_i : in IF_ID_t;
        IF_ID_o : out IF_ID_t
    );
end if_id;

architecture Behavioral of if_id is
  
    signal if_id_c, if_id_n : IF_ID_t;
  
begin
  
    clk_proc: process(clk, rst_n)
    begin
      
        if rst_n = '0' then
                IF_ID_c.pc_plus1 <= (others => '0');
        elsif rising_edge(clk) then
            
            if_id_c <= if_id_n;
        end if;
    end process;
    
    halt_proc: process(halt_i, if_id_c, IF_ID_i)
    begin
        if halt_i = '0' then
            if_id_n <= IF_ID_i;
        else
            if_id_n <= if_id_c;
        end if;
    end process;
    
    IF_ID_o <= if_id_c;
  
end architecture;