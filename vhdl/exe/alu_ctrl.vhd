library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.records_pkg.all;
use work.subtypes_pkg.all;
use work.constants_pkg.all;

entity alu_ctrl is
    
    port (
        alu_ctrl_i  : in  alu_ctrl_in_t;
        alu_ctrl_o : out alu_ctrl_out_t);
    
end alu_ctrl;

architecture Behavioral of alu_ctrl is

    -- ARITHMETIC
    constant CTRL_FUNC_ADDU      : std_logic_vector(5 downto 0) := "100001"; -- 0x21
    constant CTRL_FUNC_SUBU      : std_logic_vector(5 downto 0) := "100011"; -- 0x23
    constant CTRL_FUNC_MULTU     : std_logic_vector(5 downto 0) := "011001"; -- 0x19

    -- LOGICAL
    constant CTRL_FUNC_AND       : std_logic_vector(5 downto 0) := "100100"; -- 0x24
    constant CTRL_FUNC_OR        : std_logic_vector(5 downto 0) := "100101"; -- 0x25
    constant CTRL_FUNC_XOR       : std_logic_vector(5 downto 0) := "100110"; -- 0x26
    constant CTRL_FUNC_SLL       : std_logic_vector(5 downto 0) := "000000"; -- 0x00
    constant CTRL_FUNC_SRL       : std_logic_vector(5 downto 0) := "000010"; -- 0x02          
    constant CTRL_FUNC_SRA       : std_logic_vector(5 downto 0) := "000011"; -- 0x03
    constant CTRL_FUNC_SLT       : std_logic_vector(5 downto 0) := "101010"; -- 0x2A
    constant CTRL_FUNC_SLTU      : std_logic_vector(5 downto 0) := "101011"; -- 0x2B

    -- DATA TRANSFER
    constant CTRL_FUNC_MFHI      : std_logic_vector(5 downto 0) := "010000"; -- 0x10
    constant CTRL_FUNC_MFLO      : std_logic_vector(5 downto 0) := "010010"; -- 0x12

    -- UNCONDITIONAL JUMP
    constant CTRL_FUNC_JR        : std_logic_vector(5 downto 0) := "001000"; -- 0x08
    
begin  -- Behavioral

    -- purpose: the case statements choosing the signals to the alu
    -- type   : combinational
    -- inputs : alu_ctrl_i
    -- outputs: alu operations
    combinational: process (alu_ctrl_i)
    begin 
        case alu_ctrl_i.op is
            when CTRL_OP_RTYPE =>                   --all the r-type operations
                case alu_ctrl_i.funct is
                    -- ARITHMETIC
                when CTRL_FUNC_ADDU      => alu_ctrl_o.op <= ALU_OP_ADDU;
                when CTRL_FUNC_SUBU      => alu_ctrl_o.op <= ALU_OP_SUBU;
                when CTRL_FUNC_MULTU     => alu_ctrl_o.op <= ALU_OP_MULTU;

                -- LOGICAL
                when CTRL_FUNC_AND       => alu_ctrl_o.op <= ALU_OP_AND;
                when CTRL_FUNC_OR        => alu_ctrl_o.op <= ALU_OP_OR;
                when CTRL_FUNC_XOR       => alu_ctrl_o.op <= ALU_OP_XOR;
                when CTRL_FUNC_SLL       => alu_ctrl_o.op <= ALU_OP_SLL;
                when CTRL_FUNC_SRL       => alu_ctrl_o.op <= ALU_OP_SRL;
                when CTRL_FUNC_SRA       => alu_ctrl_o.op <= ALU_OP_SRA;
                when CTRL_FUNC_SLT       => alu_ctrl_o.op <= ALU_OP_SLT;
                when CTRL_FUNC_SLTU      => alu_ctrl_o.op <= ALU_OP_SLTU;

                -- DATA TRANSFER
                when CTRL_FUNC_MFHI      => alu_ctrl_o.op <= ALU_OP_MFHI;
                when CTRL_FUNC_MFLO      => alu_ctrl_o.op <= ALU_OP_MFLO;

                -- UNCONDITIONAL JUMP                  
                when CTRL_FUNC_JR        => alu_ctrl_o.op <= ALU_OP_JR;

                when others => null;
            end case;
    
        when CTRL_OP_ADD => alu_ctrl_o.op <= ALU_OP_ADDU; --ADDIU, LW, SW
        when CTRL_OP_LUI => alu_ctrl_o.op <= ALU_OP_LUI; --LUI only
        when CTRL_OP_J   => alu_ctrl_o.op <= ALU_OP_J;   --J only
        when CTRL_OP_JAL => alu_ctrl_o.op <= ALU_OP_JAL; --JAL only
        when CTRL_OP_BEQ => alu_ctrl_o.op <= ALU_OP_BEQ;
        when CTRL_OP_BNE => alu_ctrl_o.op <= ALU_OP_BNE;
        --when CTRL_OP_SUB => alu_ctrl_o.op <= ALU_OP_SUBU; --BEQ, BNE
        when others => null;
    end case;
end process combinational;

end Behavioral;
