library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package subtypes_pkg is

    -- GENERAL SUBTYPES
    subtype byte_s is std_logic_vector(7 downto 0);
    subtype word_s is std_logic_vector(31 downto 0);    -- word
    subtype uword_s is unsigned(31 downto 0);           -- unsigned word
    subtype sword_s is signed(31 downto 0);             -- signed word
    subtype dword_s is std_logic_vector(63 downto 0);   -- double word
    subtype udword_s is unsigned(63 downto 0);          -- unsigned double word

    -- MEMORY SUBTYPES
    subtype imem_s is std_logic_vector(11 downto 0);     -- for instr. mem addr.
    subtype dmem_s is std_logic_vector(11 downto 0);    -- data mem. addr

    subtype instr_op_s is std_logic_vector(5 downto 0);  -- controller
    subtype alu_op_s is std_logic_vector(4 downto 0);  -- ALU
    subtype ctrl_op_s is std_logic_vector(3 downto 0);  -- ALU controller
    
end subtypes_pkg;

package body subtypes_pkg is

end subtypes_pkg;
