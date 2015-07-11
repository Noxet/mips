library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use work.records_pkg.all;
use work.subtypes_pkg.all;
use work.constants_pkg.all;
use work.components_pkg.all;

entity mini_mips_pipeline is
    port (
        clk         : in  std_logic;
        rst_n       : in  std_logic;
        mini_mips_i : in  mini_mips_in_t;
        mini_mips_o : out mini_mips_out_t);
end mini_mips_pipeline;

architecture Behavioral of mini_mips_pipeline is

    -- signals from unpipelined design --
    signal s_exe_result : word_s;
    signal s_MemtoReg : std_logic;
    signal s_regs_b : word_s;

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
    
    signal s_ctrl_branch : std_logic;
    
    
    --signal dummy_zero : std_logic := '0';

    -- pipelined signals --
    signal s_if_out_pc_plus1_p, s_id_in_pc_plus1_p : imem_s;        -- pc plus 1 to IF/ID, from IF/ID
    
    signal s_id_out_regA_p, s_exe_in_regA_p : word_s;
    signal s_id_out_regB_p, s_exe_in_regB_p : word_s;
    signal s_id_out_shamt_p, s_exe_in_shamt_p : std_logic_vector(4 downto 0);
    signal s_id_out_funct_p, s_exe_in_funct_p : std_logic_vector(5 downto 0);
    signal s_id_out_sign_extend_p, s_exe_in_sign_extend_p : word_s;
    -- signal s_id_out_write_reg_p, s_exe_in_write_reg_p : std_logic_vector(4 downto 0);
    signal s_id_out_pc_plus1_p, s_exe_in_pc_plus1_p : imem_s;
    signal s_id_out_RS_p, s_exe_in_RS_p : std_logic_vector(4 downto 0);
    signal s_id_out_RT_p, s_exe_in_RT_p : std_logic_vector(4 downto 0);
    signal s_id_out_RD_p, s_exe_in_RD_p : std_logic_vector(4 downto 0);
    
    signal s_ctrl_out_ALUsrc_B_p, s_exe_in_ALUsrc_B_p : std_logic;
    signal s_ctrl_out_memtoReg_p, s_exe_in_memtoReg_p : std_logic;
    signal s_ctrl_out_regWrite_p, s_exe_in_regWrite_p : std_logic;
    signal s_ctrl_out_memWen_n_p, s_exe_in_memWen_n_p : std_logic; 
    signal s_ctrl_out_RegDst_p,   s_exe_in_RegDst_p   : std_logic;
    signal s_ctrl_out_cALU_OP_p,  s_exe_in_cALU_OP_p  : ctrl_op_s;
    
    signal s_exe_out_alu_res_p, s_mem_in_alu_res_p : word_s;
    signal s_exe_out_dmem_data_p, s_mem_in_dmem_data_p : word_s;
    signal s_exe_out_memtoReg_p, s_mem_in_memtoReg_p : std_logic;
    signal s_exe_out_regWrite_p, s_mem_in_regWrite_p : std_logic;
    signal s_exe_out_memWen_n_p, s_mem_in_memWen_n_p : std_logic;
    signal s_exe_out_write_reg_p, s_mem_in_write_reg_p : std_logic_vector(4 downto 0);
    
    signal s_mem_out_memtoReg_p, s_wb_in_memtoReg_p : std_logic;
    signal s_mem_out_regWrite_p, s_wb_in_regWrite_p : std_logic;
    signal s_mem_out_alu_res_p, s_wb_in_alu_res_p : word_s;
    signal s_mem_out_write_reg_p, s_wb_in_write_reg_p : std_logic_vector(4 downto 0);
    
    -- from the mux in WB to the Registers --
    signal s_writeback_data : word_s;     
    
    -- from exe_top to if_top, selects next PC --
    signal s_if_PCSrc : std_logic; 
    
    -- forwarding signals to the forwarding-muxes --
    signal s_forward_A : std_logic_vector(1 downto 0);
    signal s_forward_B : std_logic_vector(1 downto 0);
    
    -- the signals out from the forwarding muxes --
    signal s_src_a : word_s;
    signal s_src_b : word_s;
    
    -- the forwarding signals from the forwarding unit to the regfile --
    signal s_regfile_forward_A : std_logic;
    signal s_regfile_forward_B : std_logic;
    
    -- flag for branching --
    signal s_exe_branch : std_logic; 
      
begin
  
      --- FOR PADS ---
      --mini_mips_o.alu_result <= s_mem_in_alu_res_p(15 downto 0); -- take the pipelined signal after EXE stage
  
  
      -- pc_plus1 is pushed through the id-stage --
      s_id_out_pc_plus1_p <= s_id_in_pc_plus1_p;
      
      -- branch logic which controls the next pc in the IF stage --
      s_if_PCSrc <= s_exe_branch;
  
      -- signals from controller which are being pushed through the pipeline --
      s_exe_out_memtoReg_p <= s_exe_in_memtoReg_p;
      s_exe_out_regWrite_p <= s_exe_in_regWrite_p;
      s_exe_out_memWen_n_p <= s_exe_in_memWen_n_p;
      
      s_mem_out_memtoReg_p <= s_mem_in_memtoReg_p;
      s_mem_out_regWrite_p <= s_mem_in_regWrite_p;
      s_mem_out_write_reg_p <= s_mem_in_write_reg_p;
      
      s_mem_out_alu_res_p  <= s_mem_in_alu_res_p;
      
      -- the control signal to the mux in the wb stage --
      mini_mips_o.dmem_wen_n <= s_mem_in_memWen_n_p;
      
      
      -- data unt address to the dmem --
      mini_mips_o.dmem_data <= s_mem_in_dmem_data_p;
      mini_mips_o.dmem_addr <= s_mem_in_alu_res_p(11 downto 0);
      
      -- MUX in WB stage, controlled by MemtoReg --
      with s_wb_in_memtoReg_p select
        s_writeback_data <= mini_mips_i.dmem_data when '1', -- is reversed in book
                            s_wb_in_alu_res_p     when others;
                            
      -- The two muxes in the exe-stage, controlled by the forwarding unit --
      with s_forward_A select 
        s_src_a <= s_mem_in_alu_res_p when "10",
                   s_writeback_data when "01",
                   s_exe_in_regA_p when others; -- actually only "00"
      
      
      with s_forward_B select
        s_src_b <= s_mem_in_alu_res_p when "10",
                   s_writeback_data when "01",
                   s_exe_in_regB_p when others; -- actually only "00"
      
      ctrl_inst: controller
        port map (
            --IN
            ctrl_i.opcode       =>  s_id_ctrl_opcode,
            --OUT
            ctrl_o.regDst       =>  s_ctrl_out_RegDst_p,
            ctrl_o.ALUsrc_B     =>  s_ctrl_out_ALUsrc_B_p,
            ctrl_o.memtoReg     =>  s_ctrl_out_memtoReg_p,
            ctrl_o.regWrite     =>  s_ctrl_out_regWrite_p,
            ctrl_o.memWen_n     =>  s_ctrl_out_memWen_n_p,
            ctrl_o.cALU_OP      =>  s_ctrl_out_cALU_OP_p,
            ctrl_o.branch       =>  s_ctrl_branch
           
           );
      
      -- IF TOP --
      if_top_inst: if_top
        port map (
            clk         =>  clk,
            rst_n       =>  rst_n,
            -- IN --
            if_top_i.halt_i      =>  '0', --is this necessary?
            if_top_i.branch_pc => s_exe_if_branch_pc,             -- FIX FOX
            if_top_i.PCSrc  => s_if_PCSrc,                           
            -- OUT --
            if_top_o.imem_addr   =>  mini_mips_o.imem_addr,
            if_top_o.pc_plus1 => s_if_out_pc_plus1_p
            );
            
      -- IF/ID PIPELINE --
      if_id_inst: if_id
        port map (
            clk => clk,
            rst_n => rst_n,
            halt_i => '0',    -- FIX FOX
            -- IN --
            if_id_i.pc_plus1 => s_if_out_pc_plus1_p,
            -- OUT --
            if_id_o.pc_plus1 => s_id_in_pc_plus1_p
        );
          
    -- ID TOP --
    id_top_inst: id_top
        port map (
            clk         =>  clk,
            rst_n       =>  rst_n,
            -- IN --
            id_top_i.instruction        =>  mini_mips_i.imem_data,
            id_top_i.writeback_data     =>  s_writeback_data, -- origins from the mux in the wb-stage
            id_top_i.forward_a          =>  s_regfile_forward_A, --
            id_top_i.forward_b          =>  s_regfile_forward_B, --
            id_top_i.RegWrite           =>  s_wb_in_regWrite_p,
--            id_top_i.RegDst             =>  s_id_ctrl_RegDst,
            id_top_i.write_reg          =>  s_wb_in_write_reg_p,
            -- OUT --
            id_top_o.reg_a              =>  s_id_out_regA_p,
            id_top_o.reg_b              =>  s_id_out_regB_p,
            id_top_o.instr_31_26        =>  s_id_ctrl_opcode,
            id_top_o.instr_10_6         =>  s_id_out_shamt_p,
            id_top_o.instr_5_0          =>  s_id_out_funct_p,
            id_top_o.sign_extend        =>  s_id_out_sign_extend_p,
            -- id_top_o.write_reg          =>  s_id_out_write_reg_p,
            id_top_o.RS                 =>  s_id_out_RS_p,
            id_top_o.RT                 =>  s_id_out_RT_p, 
            id_top_o.RD                 =>  s_id_out_RD_p
        );
        
      -- ID/EXE PIPELINE -- 
    id_exe_inst: id_exe
        port map (
            clk    => clk,
            rst_n  => rst_n,
            halt_i => '0',
            -- IN --
            id_exe_i.regA         => s_id_out_regA_p,
            id_exe_i.regB         => s_id_out_regB_p,
            id_exe_i.shamt        => s_id_out_shamt_p,
            id_exe_i.funct        => s_id_out_funct_p,
            id_exe_i.sign_extend  => s_id_out_sign_extend_p,
            id_exe_i.ALUsrc_B     => s_ctrl_out_ALUsrc_B_p,
            id_exe_i.memtoReg     => s_ctrl_out_memtoReg_p,
            id_exe_i.regWrite     => s_ctrl_out_regWrite_p,
            id_exe_i.memWen_n     => s_ctrl_out_memWen_n_p,
            id_exe_i.cALU_OP      => s_ctrl_out_cALU_OP_p,
            id_exe_i.pc_plus1     => s_id_out_pc_plus1_p,
            id_exe_i.RegDst       => s_ctrl_out_RegDst_p,
            id_exe_i.RS           => s_id_out_RS_p,
            id_exe_i.RT           => s_id_out_RT_p,
            id_exe_i.RD           => s_id_out_RD_p,
            -- OUT --
            id_exe_o.regA         => s_exe_in_regA_p,
            id_exe_o.regB         => s_exe_in_regB_p,
            id_exe_o.shamt        => s_exe_in_shamt_p,
            id_exe_o.funct        => s_exe_in_funct_p,
            id_exe_o.sign_extend  => s_exe_in_sign_extend_p,
            id_exe_o.ALUsrc_B     => s_exe_in_ALUsrc_B_p,
            id_exe_o.memtoReg     => s_exe_in_memtoReg_p,
            id_exe_o.regWrite     => s_exe_in_regWrite_p,
            id_exe_o.memWen_n     => s_exe_in_memWen_n_p,
            id_exe_o.cALU_OP      => s_exe_in_cALU_OP_p,
            id_exe_o.pc_plus1     => s_exe_in_pc_plus1_p,
            id_exe_o.RegDst       => s_exe_in_RegDst_p,
            id_exe_o.RS           => s_exe_in_RS_p,
            id_exe_o.RT           => s_exe_in_RT_p,
            id_exe_o.RD           => s_exe_in_RD_p
        );
        
    -- EXE TOP --
    exe_top_inst: exe_top
        port map (
            clk    =>  clk,
            rst_n  =>  rst_n,
            -- IN --
            exe_top_i.shamt        =>  s_exe_in_shamt_p,
            exe_top_i.regs_a       =>  s_src_a,
            exe_top_i.regs_b       =>  s_src_b,
            exe_top_i.alu_src_b    =>  s_exe_in_ALUsrc_B_p,
            exe_top_i.immidiate    =>  s_exe_in_sign_extend_p,  -- immidiate signal
            exe_top_i.op           =>  s_exe_in_cALU_OP_p,
            exe_top_i.funct        =>  s_exe_in_funct_p,
            exe_top_i.pc_plus1     =>  s_exe_in_pc_plus1_p,
            exe_top_i.RegDst       =>  s_exe_in_RegDst_p,
            exe_top_i.RT           =>  s_exe_in_RT_p,
            exe_top_i.RD           =>  s_exe_in_RD_p,
            -- OUT --
            exe_top_o.result       =>  s_exe_out_alu_res_p,
            exe_top_o.branch       =>  s_exe_branch,
            exe_top_o.branch_pc    =>  s_exe_if_branch_pc,
            exe_top_o.write_reg    =>  s_exe_out_write_reg_p,
            exe_top_o.dmem_data    =>  s_exe_out_dmem_data_p
            );
            
    forwarding_unit_inst: forwarding_unit
    port map (
            -- IN --
            forwarding_unit_i.exe_in_RS => s_exe_in_RS_p,
            forwarding_unit_i.exe_in_RT => s_exe_in_RT_p,
            forwarding_unit_i.id_out_RS => s_id_out_RS_p,
            forwarding_unit_i.id_out_RT => s_id_out_RT_p,
            forwarding_unit_i.mem_in_write_reg => s_mem_in_write_reg_p,
            forwarding_unit_i.wb_in_write_reg => s_wb_in_write_reg_p,
            forwarding_unit_i.mem_in_regWrite => s_mem_in_regWrite_p,
            forwarding_unit_i.wb_in_regWrite => s_wb_in_regWrite_p,
            -- OUT --
            forwarding_unit_o.forward_A => s_forward_A,
            forwarding_unit_o.forward_B => s_forward_B,
            forwarding_unit_o.regfile_forward_A => s_regfile_forward_A,
            forwarding_unit_o.regfile_forward_B => s_regfile_forward_B
    );
    
    -- EXE/MEM PIPELINE --
    exe_mem_inst: exe_mem
        port map (
            clk => clk,
            rst_n => rst_n,
            halt_i => '0',     -- FIX FOX
            -- IN --
            exe_mem_i.alu_res => s_exe_out_alu_res_p,
            exe_mem_i.dmem_data => s_exe_out_dmem_data_p,
            exe_mem_i.memtoReg => s_exe_out_memtoReg_p,
            exe_mem_i.regWrite => s_exe_out_regWrite_p,
            exe_mem_i.memWen_n => s_exe_out_memWen_n_p,
            exe_mem_i.write_reg => s_exe_out_write_reg_p,
            -- OUT --
            exe_mem_o.alu_res => s_mem_in_alu_res_p,
            exe_mem_o.dmem_data => s_mem_in_dmem_data_p,
            exe_mem_o.memtoReg => s_mem_in_memtoReg_p,
            exe_mem_o.regWrite => s_mem_in_regWrite_p,
            exe_mem_o.memWen_n => s_mem_in_memWen_n_p,
            exe_mem_o.write_reg => s_mem_in_write_reg_p
        );
        
    -- MEM/WB PIPELINE --
    mem_wb_inst: mem_wb
        port map (
          clk => clk,
          rst_n => rst_n,
          halt_i => '0', -- FIX FOX
          -- IN --
          mem_wb_i.memtoReg => s_mem_out_memtoReg_p,
          mem_wb_i.regWrite => s_mem_out_regWrite_p,
          mem_wb_i.alu_res   => s_mem_out_alu_res_p,
          mem_wb_i.write_reg => s_mem_out_write_reg_p,
          -- OUT --
          mem_wb_o.memtoReg => s_wb_in_memtoReg_p,
          mem_wb_o.regWrite => s_wb_in_regWrite_p,
          mem_wb_o.alu_res   => s_wb_in_alu_res_p,
          mem_wb_o.write_reg => s_wb_in_write_reg_p
        );
             
end Behavioral;
