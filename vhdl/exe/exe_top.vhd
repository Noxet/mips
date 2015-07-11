library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

use work.records_pkg.all;
use work.subtypes_pkg.all;
use work.constants_pkg.all;

use work.components_pkg.all;

entity exe_top is
    port(
        clk       : in  std_logic;
        rst_n     : in  std_logic;
        exe_top_i : in  exe_top_in_t;
        exe_top_o : out exe_top_out_t
        );
end exe_top;

architecture Behavioral of exe_top is

    component alu_ctrl
        port(
            alu_ctrl_i : in  alu_ctrl_in_t;
            alu_ctrl_o : out alu_ctrl_out_t
            );
    end component;

    signal src_b : word_s;      --signal between mux and ALU
    signal op_aluCtrl_alu : std_logic_vector(4 downto 0);

begin

    with exe_top_i.alu_src_b select
        src_b <= exe_top_i.immidiate when '1', -- mux to src_B for ALU
                 exe_top_i.regs_b when others;    
            
    -- calculate the branch pc (npc + offset)
    exe_top_o.branch_pc <= std_logic_vector(signed(exe_top_i.pc_plus1) + signed(exe_top_i.immidiate(11 downto 0)));
      
    alu_inst: alu
    port map(
        clk             => clk,
        rst_n           => rst_n,
        -- input to top
        alu_i.src_a     => exe_top_i.regs_a,     --from exe_top to alu
        alu_i.src_b     => src_b,               --internal top signal
        alu_i.op        => op_aluCtrl_alu,      --op from alu ctrl 
        alu_i.shamt     => exe_top_i.shamt,     --shift amount from exe_top 
        -- output from top
        alu_o.result    => exe_top_o.result,     --the result from alu out of top
        alu_o.branch      => exe_top_o.branch
        );

    alu_ctrl_inst: alu_ctrl
    port map(
        alu_ctrl_i.op       => exe_top_i.op,
        alu_ctrl_i.funct    => exe_top_i.funct,
        alu_ctrl_o.op       => op_aluCtrl_alu 
        );
end Behavioral;
