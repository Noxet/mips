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

    signal src_a, src_b : word_s;      --signal between mux and ALU 
    signal op_aluCtrl_alu : std_logic_vector(4 downto 0);
    signal s_branch_src : std_logic_vector(1 downto 0);
    signal s_RegDst : std_logic_vector(4 downto 0);

begin
  
    -- the MUX in to the register choosing the input write_register --
    with exe_top_i.RegDst select s_RegDst <= exe_top_i.RT when '0',
                                             exe_top_i.RD when others;
  
    -- the MUX setting the destination to 31 if we have JAL --
    with op_aluCtrl_alu select exe_top_o.write_reg <= "11111" when ALU_OP_JAL,
                                                      s_RegDst when others;
    -- sets pc as input A to alu when we have JAL --                                                  
    with op_aluCtrl_alu select src_a <= "00000000000000000000" & exe_top_i.pc_plus1 when ALU_OP_JAL,
                                        exe_top_i.regs_a when others;

    with exe_top_i.alu_src_b select
        src_b <= exe_top_i.immidiate when '1', -- mux to src_B for ALU
                 exe_top_i.regs_b when others;    
            
    -- calculate the branch pc (npc + offset)                 --
    -- choose either the calulated or regs_a if branch is JR  --
    with s_branch_src select
      exe_top_o.branch_pc <= std_logic_vector(signed(exe_top_i.pc_plus1) + signed(exe_top_i.immidiate(11 downto 0))) when "00", -- ALL OTHER HOPP
                             exe_top_i.regs_a(11 downto 0) when "01",         -- JR
                             exe_top_i.immidiate(11 downto 0) when others;    -- J / JAL
                             
    
    
    exe_top_o.dmem_data <= exe_top_i.regs_b;
      
    alu_inst: alu
    port map(
        clk             => clk,
        rst_n           => rst_n,
        -- input to top --
        alu_i.src_a     => src_a,     --from exe_top to alu
        alu_i.src_b     => src_b,                -- either regs_b or immidiate
        alu_i.op        => op_aluCtrl_alu,       --op from alu ctrl 
        alu_i.shamt     => exe_top_i.shamt,      --shift amount from exe_top 
        -- output from top --
        alu_o.result    => exe_top_o.result,     --the result from alu out of top
        alu_o.branch      => exe_top_o.branch
        );

    alu_ctrl_inst: alu_ctrl
    port map(
        alu_ctrl_i.op       => exe_top_i.op,
        alu_ctrl_i.funct    => exe_top_i.funct,
        alu_ctrl_o.op       => op_aluCtrl_alu,
        alu_ctrl_o.branch_src => s_branch_src
        );
end Behavioral;
