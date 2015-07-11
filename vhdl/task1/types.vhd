-- -----------------------------------------------------------------------------
--
--  Title      :  Useful types and constants in a nice package.
--             :
--  Developers :  Niels Haandbaek -- c958307@student.dtu.dk
--             :  Michael Kristensen - c973396@student.dtu.dk
--             :  Hans Holten-Lund - hahl@imm.dtu.dk
--             :  Chenxin Zhang - Chenxin.Zhang@eit.lth.se
--             :
--  Purpose    :  This design contains a package with types and constants. The
--             :  types are std_logic_vector's with names and sizes that 
--             :  correspond to the standard MIPS notation.
--             :
--  Revision   :  1.0  27-08-99  Initial version
--             :  2.0  01-09-02  Modified to 32-bit MIPS
--             :  2.1  29-09-03  Added andi,ori,xori
--             :  3.0  03-02-05  Now compatible with GCC (int only)!
--             :                 Added sllv,srlv,srav,bltz,bgez,blez,bgtz,
--             :                 slti,sltiu,jalr
--             ;  4.0  06-12-10  Added multu, mfhi, mflo
--
-- -----------------------------------------------------------------------------

--------------------------------------------------------------------------------
--    Type name |  MIPS name | size in bits 
--        bit_t |     bit    | 1
--       byte_t |    byte    | 8
--   halfword_t |  halfword  | 16
--       word_t |    word    | 32
-- doubleword_t | doubleword | 64
-- The constants can be used to set all bits in a signal or variable of type 
-- byte_t, halfword_t, word_t and doubleword_t to either '0', '1', 'X' or 'Z'.
--------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

PACKAGE types IS
    SUBTYPE bit_t           IS std_logic;
    SUBTYPE byte_t          IS std_logic_vector(7 DOWNTO 0);
    SUBTYPE halfword_t      IS std_logic_vector(15 DOWNTO 0);
    SUBTYPE word_t          IS std_logic_vector(31 DOWNTO 0);
    SUBTYPE doubleword_t    IS std_logic_vector(63 DOWNTO 0);
    
    CONSTANT BYTE_ZERO:     byte_t := "00000000";
    CONSTANT BYTE_ONE:      byte_t := "11111111";
    CONSTANT BYTE_X:        byte_t := "XXXXXXXX";
    CONSTANT BYTE_Z:        byte_t := "ZZZZZZZZ";
    
    CONSTANT HALFWORD_ZERO: halfword_t := byte_zero & byte_zero;
    CONSTANT HALFWORD_ONE:  halfword_t := byte_one & byte_one;
    CONSTANT HALFWORD_X:    halfword_t := byte_x & byte_x;
    CONSTANT HALFWORD_Z:    halfword_t := byte_z & byte_z;
    
    CONSTANT WORD_ZERO:     word_t := halfword_zero & halfword_zero;
    CONSTANT WORD_ONE:      word_t := halfword_one & halfword_one;
    CONSTANT WORD_X:        word_t := halfword_x & halfword_x;
    CONSTANT WORD_Z:        word_t := halfword_z & halfword_z;
    
    CONSTANT DOUBLEWORD_ZERO:   doubleword_t := word_zero & word_zero;
    CONSTANT DOUBLEWORD_ONE:    doubleword_t := word_one & word_one;
    CONSTANT DOUBLEWORD_X:      doubleword_t := word_x & word_x;
    CONSTANT DOUBLEWORD_Z:      doubleword_t := word_z & word_z;

    -- Mini-MIPS specific types and constants.
    SUBTYPE OpCode          IS std_logic_vector(5 DOWNTO 0);
    SUBTYPE FuncCode        IS std_logic_vector(5 DOWNTO 0);

    SUBTYPE RegAddr         IS INTEGER RANGE 0 TO 31;
    TYPE RegType            IS ARRAY(RegAddr) OF word_t;

    -- These constants enable easier-to-read identification of instructions.
    -- Opcode field
    CONSTANT OP_RFORMAT:    OpCode := "000000";
    CONSTANT OP_BLTZ_BGEZ:  OpCode := "000001";
    CONSTANT OP_J:          OpCode := "000010";
    CONSTANT OP_JAL:        OpCode := "000011";
    CONSTANT OP_BEQ:        OpCode := "000100";
    CONSTANT OP_BNE:        OpCode := "000101";
    CONSTANT OP_BLEZ:       OpCode := "000110";
    CONSTANT OP_BGTZ:       OpCode := "000111";
    CONSTANT OP_ADDIU:      OpCode := "001001";
    CONSTANT OP_SLTI:       OpCode := "001010";
    CONSTANT OP_SLTIU:      OpCode := "001011";
    CONSTANT OP_ANDI:       OpCode := "001100";
    CONSTANT OP_ORI:        OpCode := "001101";
    CONSTANT OP_XORI:       OpCode := "001110";
    CONSTANT OP_LUI:        OpCode := "001111";
    CONSTANT OP_LW:         OpCode := "100011";
    CONSTANT OP_SW:         OpCode := "101011";

    -- Function field
    CONSTANT FUNCT_SLL:     FuncCode := "000000";
    CONSTANT FUNCT_SRL:     FuncCode := "000010";
    CONSTANT FUNCT_SRA:     FuncCode := "000011";
    CONSTANT FUNCT_SLLV:    FuncCode := "000100";
    CONSTANT FUNCT_SRLV:    FuncCode := "000110";
    CONSTANT FUNCT_SRAV:    FuncCode := "000111";
    CONSTANT FUNCT_JR:      FuncCode := "001000";
    CONSTANT FUNCT_JALR:    FuncCode := "001001";
    CONSTANT FUNCT_MFHI:    FuncCode := "001010";
    CONSTANT FUNCT_MFLO:    FuncCode := "001100";
    CONSTANT FUNCT_MULTU:   FuncCode := "011001";
    CONSTANT FUNCT_ADDU:    FuncCode := "100001";
    CONSTANT FUNCT_SUBU:    FuncCode := "100011";
    CONSTANT FUNCT_AND:     FuncCode := "100100";
    CONSTANT FUNCT_OR: 	    FuncCode := "100101";
    CONSTANT FUNCT_XOR:     FuncCode := "100110";
    CONSTANT FUNCT_NOR:     FuncCode := "100111";
    CONSTANT FUNCT_SLT:     FuncCode := "101010";
    CONSTANT FUNCT_SLTU:    FuncCode := "101011";

END types;

PACKAGE BODY types IS

END types;
