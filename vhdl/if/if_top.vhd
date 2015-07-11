library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.records_pkg.all;
use work.constants_pkg.all;
use work.subtypes_pkg.all;
use work.components_pkg.all;

entity if_top is
    
    port (
        clk       : in  std_logic;
        rst_n     : in  std_logic;
        if_top_i  : in if_top_in_t;
        if_top_o  : out if_top_out_t);

end entity if_top;

architecture behavioral of if_top is

    component pc is
        port (
            clk    : in  std_logic;
            rst_n  : in  std_logic;
            halt_i : in  std_logic;
            npc_i  : in  imem_s;
            pc_o   : out imem_s);
    end component pc;

    signal s_pc_plus1 : imem_s; -- PC + 1
    signal s_npc : imem_s; -- next PC
    signal s_pc : imem_s; -- PC
    
begin  -- architecture behavioral
  
    s_pc_plus1 <= imem_s(unsigned(s_pc) + 1); -- PC + 1

    -- update next pc
    with if_top_i.PCSrc select
    s_npc <= s_pc_plus1 when '0',
             if_top_i.branch_pc when others;

    -- pc gives address to I-mem
    if_top_o.imem_addr <= s_pc;
    if_top_o.pc_plus1 <= s_pc_plus1; -- send this to branch calc

    pc_inst: pc
        port map (
            clk    => clk,
            rst_n  => rst_n,
            halt_i => if_top_i.halt_i,
            npc_i  => s_npc,
            pc_o   => s_pc);

end architecture behavioral;
