library ieee;
use ieee.std_logic_1164.all;

use work.subtypes_pkg.all;

package constants_pkg is

    -- INPUT OPCODES TO CONTROLLER (REAL INSTRUCTION OPCODES)
    constant INSTR_R_TYPE       : instr_op_s := "000000";  -- 0x00
    constant INSTR_ADDIU        : instr_op_s := "001001";  -- 0x09
    constant INSTR_LUI          : instr_op_s := "001111";  -- 0x0F
    constant INSTR_LW           : instr_op_s := "100011";  -- 0x23
    constant INSTR_SW           : instr_op_s := "101011";  -- 0x2B
    constant INSTR_J            : instr_op_s := "000010";  -- 0x02
    constant INSTR_JAL          : instr_op_s := "000011";  -- 0x03
    constant INSTR_BEQ          : instr_op_s := "000100";  -- 0x04
    constant INSTR_BNE          : instr_op_s := "000101";  -- 0x05
    

    -- INPUT OPCODES TO ALU, FROM ALU_CTRL
    constant ALU_OP_ADDU        : alu_op_s := "00000";
    constant ALU_OP_SUBU        : alu_op_s := "00001";
    constant ALU_OP_MULTU       : alu_op_s := "00010";
    constant ALU_OP_AND         : alu_op_s := "00011";
    constant ALU_OP_OR          : alu_op_s := "00100";
    constant ALU_OP_XOR         : alu_op_s := "00101";
    constant ALU_OP_SLL         : alu_op_s := "00110";
    constant ALU_OP_SRL         : alu_op_s := "00111";
    constant ALU_OP_SRA         : alu_op_s := "01000";
    constant ALU_OP_SLT         : alu_op_s := "01001";
    constant ALU_OP_SLTU        : alu_op_s := "01010";
    constant ALU_OP_MFHI        : alu_op_s := "01011";
    constant ALU_OP_MFLO        : alu_op_s := "01100";
    constant ALU_OP_LUI         : alu_op_s := "01101";
    constant ALU_OP_LW          : alu_op_s := "01110";
    constant ALU_OP_SW          : alu_op_s := "01111";
    constant ALU_OP_J           : alu_op_s := "10000";
    constant ALU_OP_JAL         : alu_op_s := "10001";  
    constant ALU_OP_JR          : alu_op_s := "10010";
    constant ALU_OP_BEQ         : alu_op_s := "10011";
    constant ALU_OP_BNE         : alu_op_s := "10100";

    -- INPUT OPCODES TO ALU_CTRL, FROM CONTROLLER
    constant CTRL_OP_RTYPE      : ctrl_op_s := "0000";
    constant CTRL_OP_ADD        : ctrl_op_s := "0001";
    constant CTRL_OP_LUI        : ctrl_op_s := "0010";
    constant CTRL_OP_J          : ctrl_op_s := "0011";
    constant CTRL_OP_JAL        : ctrl_op_s := "0100";
    constant CTRL_OP_SUB        : ctrl_op_s := "0101";
    constant CTRL_OP_BEQ        : ctrl_op_s := "0110";
    constant CTRL_OP_BNE        : ctrl_op_s := "0111";

end constants_pkg;

package body constants_pkg is

    

end constants_pkg;
