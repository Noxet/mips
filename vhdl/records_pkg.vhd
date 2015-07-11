library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.subtypes_pkg.all;

package records_pkg is
  
    -- MINI_MIPS_TOP IN
    type mini_mips_in_t is record
        dmem_data : word_s;
        --imem_addr    : imem_s;
        imem_data    : word_s;
    end record mini_mips_in_t;
    
    -- MINI_MIPS_TOP OUT
    type mini_mips_out_t is record
        dmem_addr       : dmem_s;
        dmem_data       : word_s;             -- data for writing to dmem
        imem_addr       : imem_s;
        dmem_wen_n      : std_logic;
		alu_result : std_logic_vector(15 downto 0);  ---- ONLY FOR POST PNR SIMULATION ----
    end record mini_mips_out_t;

    -- EXE_TOP RECORD IN
    type exe_top_in_t is record
        --exe signals
        shamt       : std_logic_vector(4 downto 0);
        regs_a      : word_s;
        regs_b      : word_s;
        alu_src_b   : std_logic;
        immidiate   : word_s;
        op          : std_logic_vector(3 downto 0);
        funct       : std_logic_vector(5 downto 0);
        pc_plus1         : imem_s;                   -- calculate branch_pc
    end record exe_top_in_t;
    
    -- EXE_TOP RECORD OUT
    type exe_top_out_t is record
        branch      : std_logic;
        branch_pc : imem_s;
        result    : word_s;
    end record exe_top_out_t;
    
    -- ALU RECORD IN
    type alu_in_t is record
        src_a : word_s;
        src_b : word_s;
        op    : std_logic_vector(4 downto 0);
        shamt : std_logic_vector(4 downto 0);
    end record alu_in_t;
    
    -- ALU RECORD OUT
    type alu_out_t is record
		    branch   : std_logic;
        result : word_s;
    end record alu_out_t;

    -- ALU_CTRL RECORD IN
    type alu_ctrl_in_t is record
        op      : std_logic_vector(3 downto 0);
        funct   : std_logic_vector(5 downto 0);
    end record alu_ctrl_in_t;

    -- ALU_CTRL RECORD OUT
    type alu_ctrl_out_t is record
        op      : std_logic_vector(4 downto 0);
    end record;

    -- "64" bits register in ALU (2*32 bits)
    type hi_lo_t is record
        HI : word_s;
        LO : word_s;
    end record hi_lo_t;
    
    -- IF_TOP_RECORD IN
    type if_top_in_t is record
        halt_i    : std_logic;
        branch_pc : imem_s;
        PCSrc     : std_logic; -- controlling next pc, due to branches.
    end record if_top_in_t;
    
    -- IF_TOP_RECORD_OUT
    type if_top_out_t is record
        imem_addr : imem_s;
        pc_plus1       : imem_s; -- standard next pc
    end record if_top_out_t;

    -- ID_TOP RECORD IN
    type id_top_in_t is record
        instruction     : word_s;
        writeback_data  : word_s;
        forward_a       : std_logic;
        forward_b       : std_logic;
        RegWrite        : std_logic;
        RegDst          : std_logic;
    end record id_top_in_t;

    type id_top_out_t is record
        reg_a       : word_s;
        reg_b       : word_s;
        instr_31_26 : std_logic_vector(5 downto 0);
        instr_10_6  : std_logic_vector(4 downto 0);
        instr_5_0   : std_logic_vector(5 downto 0);
        sign_extend : word_s;
    end record id_top_out_t;

    -- REGFILE IN
    type regfile_in_t is record
        adrread0 : std_logic_vector(4 downto 0);
        adrread1 : std_logic_vector(4 downto 0);
        adrwrite : std_logic_vector(4 downto 0);
        write_data : word_s;
        forward_a  : std_logic;            -- forward write_data to read0 (srcA)
        forward_b  : std_logic;            -- forward write_data to read1 (srcB)
        wr_en : std_logic;
    end record regfile_in_t;

    -- REGFILE OUT
    type regfile_out_t is record
        read_data0 : word_s;
        read_data1 : word_s;
    end record regfile_out_t;

    -- CONTROLLER IN
    type ctrl_in_t is record
        opcode : std_logic_vector(5 downto 0);
    end record ctrl_in_t;

    -- CONTROLLER OUT
    type ctrl_out_t is record
        regDst : std_logic;
        ALUsrc_B : std_logic;
        memtoReg : std_logic;
        regWrite : std_logic;
        memWen_n : std_logic; -- active LOW!!
        branch : std_logic;
        cALU_OP : ctrl_op_s;
    end record ctrl_out_t;
    
    ------------------------------------------------------------
    -------------------- PIPELINE RECORDS ----------------------
    ------------------------------------------------------------
    
    -- IF/ID
    type IF_ID_t is record
        pc_plus1     : imem_s;
    end record IF_ID_t;
    
    -- ID/EXE
    type ID_EXE_t is record
        regA : word_s;
        regB : word_s;
        shamt : std_logic_vector(4 downto 0);
        funct : std_logic_vector(5 downto 0);
        sign_extend  : word_s; -- immidiate
        -- Controller pipelined signals
        regDst : std_logic;
        ALUsrc_B : std_logic;
        memtoReg : std_logic;
        regWrite : std_logic;
        memWen_n : std_logic; -- active LOW!!
        cALU_OP : ctrl_op_s;
    end record ID_EXE_t;
    
    -- EXE/MEM
    type EXE_MEM_t is record
        alu_res : word_s;
        dmem_data : dmem_s;
        -- Controller pipelined signals
        memtoReg : std_logic;
        regWrite : std_logic;
        memWen_n : std_logic; -- active LOW!!
    end record EXE_MEM_t;
    
    -- MEM/WB
    type MEM_WB_t is record
        alu_res   : word_s;
        -- Controller pipelined signals
        memtoReg : std_logic;
        regWrite : std_logic;
    end record MEM_WB_t;
    
end records_pkg;

package body records_pkg is

end records_pkg;
