-- -----------------------------------------------------------------------------
--
--  Title      :  Mini-MIPS structure entity.
--             :
--  Developers :  Niels Haandbaek -- c958307@student.dtu.dk
--             :  Michael Kristensen -- c973396@student.dtu.dk
--             :  Hans Holten-Lund -- hahl@imm.dtu.dk
--             :
--  Purpose    :  This design contains an entity for the CPU that must be built
--             :  in task two of the Mini-MIPS design project. It contains an 
--             :  architecture skeleton for the entity as well.                
--             :
--  Notes      :  This architecture uses external memory. Remember to implement 
--             :  the correct memory interface.                      
--             :
--  Revision   :  1.0    12-09-99     Initial version
--             :  2.0    08-08-02     Modified to 32-bit Mini-MIPS
--             :  3.0    14-03-05     Uses new memory model.
--             :                                                   
--              
-- -----------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- The entity for task two. Notice the additional signals for the instruction-
-- and data-memories.        
-- reset is active low.
--------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_arith.ALL;
USE WORK.types.ALL;

ENTITY cpu2 IS  
    PORT (clk :       IN    bit_t;            -- The clock.
          reset:      IN    bit_t;            -- The reset signal. Active low.
          instaddr:   OUT   word_t;           -- Address bus for instruction.
          inst:       INOUT word_t;           -- The instruction bus.
          instreq:    OUT   bit_t;            -- Request signal for instruction.
          instrw:     OUT   bit_t;            -- Read/Write signal for instruction.
          insthold:   IN    bit_t;            -- Hold signal for instruction.
          dataaddr:   OUT   word_t;           -- Address bus for data.
          data:       INOUT word_t;           -- The data bus.
          datareq:    OUT   bit_t;            -- Request signal for data.
          datarw:     OUT   bit_t;            -- Read/Write signal for data.
          datahold:   IN    bit_t);           -- Hold signal for data.
END cpu2;

--------------------------------------------------------------------------------
-- The desription of the Mini-MIPS processor. You should modify this so that
-- it implements a five-stage pipelined version of the Mini-MIPS.
--------------------------------------------------------------------------------

ARCHITECTURE structure OF cpu2 IS

-- All internal signals are defined here

BEGIN
    
--Simple test of memory
--inst <= word_z;
--instaddr <= X"00000000";
--instreq <= '1';
--instrw <= '1';

--Template for a registered process
--myprocess: process(clk,reset)
--begin
--  if reset = '0' then
--
--  elsif clk'event and clk='1' then
--
--  end if;
--end process test;

END structure;
