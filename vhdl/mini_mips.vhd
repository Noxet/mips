library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use work.records_pkg.all;
use work.subtypes_pkg.all;
use work.constants_pkg.all;
use work.components_pkg.all;

entity mini_mips is
    port (
        clk         : in  std_logic;
        rst_n       : in  std_logic;
        mini_mips_i : in  mini_mips_in_t;
        mini_mips_o : out mini_mips_out_t);
end mini_mips;

architecture Behavioral of mini_mips is

    -- insert signals here --
    signal s_writeback_data : word_s;     --from the mux with chosen output by MemtoReg
    signal s_exe_result : word_s;
    signal s_MemtoReg : std_logic;
    signal s_regs_b : word_s;

    -- --
    signal s_id_ctrl_regWrite : std_logic;
    signal s_id_ctrl_RegDst : std_logic;
    signal s_id_exe_reg_a : word_s;
    signal s_id_ctrl_opcode : std_logic_vector(5 downto 0);
    signal s_id_exe_shamt : std_logic_vector(4 downto 0);
    signal s_id_exe_funct : std_logic_vector(5 downto 0);
    signal s_id_exe_immidiate : word_s;
    signal s_exe_ctrl_alu_src_b : std_logic;
    signal s_exe_ctrl_op : ctrl_op_s;
    
    signal s_if_exe_pc_plus1 : imem_s; -- next PC from IF to EXE
    signal s_exe_if_branch_pc : imem_s; -- branch PC address
    signal s_if_PCSrc : std_logic; -- selects next PC
    signal s_ctrl_branch : std_logic;
    signal s_exe_branch : std_logic; -- flag for branching
    
    signal dummy_zero : std_logic := '0';
        
begin

	test_proc: process(clk)
	begin
		if rising_edge(clk) then
			mini_mips_o.alu_result <= s_exe_result(15 downto 0); -- ONLY FOR POST PNR SIMULATION !! --
		end if;
	end process;

    -- signals which go to the memories but also somewhere else inside the MIPS
    mini_mips_o.dmem_addr <= s_exe_result(11 downto 0);
    mini_mips_o.dmem_data <= s_regs_b;
    
    -- branch logic that controls the next pc in IF stage
    s_if_PCSrc <= s_exe_branch;
    
    -- MUX in WB stage, controlled by MemtoReg
    with s_MemtoReg select
        s_writeback_data <=
        mini_mips_i.dmem_data when '1',
        s_exe_result          when others;

    if_top_inst: if_top
        port map (
            --IN
            clk         =>  clk,
            rst_n       =>  rst_n,
            if_top_i.halt_i      =>  '0',         --is this necessary?
            if_top_i.branch_pc => s_exe_if_branch_pc,
            if_top_i.PCSrc  => s_if_PCSrc,
            --OUT
            if_top_o.imem_addr   =>  mini_mips_o.imem_addr,
            if_top_o.pc_plus1 => s_if_exe_pc_plus1
            );

    id_top_inst: id_top
        port map (
            clk         =>  clk,
            rst_n       =>  rst_n,
            --IN
            id_top_i.instruction        =>  mini_mips_i.imem_data,
            id_top_i.writeback_data     =>  s_writeback_data,
            id_top_i.forward_a          =>  '0', --
            id_top_i.forward_b          =>  '0', --
            id_top_i.RegWrite           =>  s_id_ctrl_regWrite,
            id_top_i.RegDst             =>  s_id_ctrl_RegDst,
            --OUT
            id_top_o.reg_a              =>  s_id_exe_reg_a,
            id_top_o.reg_b              =>  s_regs_b,
            id_top_o.instr_31_26        =>  s_id_ctrl_opcode,
            id_top_o.instr_10_6         =>  s_id_exe_shamt,
            id_top_o.instr_5_0          =>  s_id_exe_funct,
            id_top_o.sign_extend        =>  s_id_exe_immidiate
                 );

    exe_top_inst: exe_top
        port map (
            clk    =>  clk,
            rst_n  =>  rst_n,
            --IN
            exe_top_i.shamt        =>  s_id_exe_shamt,
            exe_top_i.regs_a       =>  s_id_exe_reg_a,
            exe_top_i.regs_b       =>  s_regs_b,
            exe_top_i.alu_src_b    =>  s_exe_ctrl_alu_src_b,
            exe_top_i.immidiate    =>  s_id_exe_immidiate,
            exe_top_i.op           =>  s_exe_ctrl_op,
            exe_top_i.funct        =>  s_id_exe_funct,
            exe_top_i.pc_plus1          => s_if_exe_pc_plus1,
            --OUT
            exe_top_o.result       =>  s_exe_result,
            exe_top_o.branch         => s_exe_branch,
            exe_top_o.branch_pc    => s_exe_if_branch_pc
            );
    
    
    ctrl_inst: controller
        port map (
            --IN
            ctrl_i.opcode       =>  s_id_ctrl_opcode,
            --OUT
            ctrl_o.regDst       =>  s_id_ctrl_RegDst,
            ctrl_o.ALUsrc_B     =>  s_exe_ctrl_alu_src_b,
            ctrl_o.memtoReg     =>  s_MemtoReg,
            ctrl_o.regWrite     =>  s_id_ctrl_regWrite,
            ctrl_o.memWen_n     =>  mini_mips_o.dmem_wen_n,
            ctrl_o.cALU_OP      =>  s_exe_ctrl_op,
            ctrl_o.branch       => s_ctrl_branch
            
            );
    
end Behavioral;
