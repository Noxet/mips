-- -----------------------------------------------------------------------------
--
--  Title      :  Mini-MIPS design project - task 1.
--             :
--  Developers :  Niels Haandbaek -- c958307@student.dtu.dk
--             :  Michael Kristensen -- c973396@student.dtu.dk
--        ***! :  PS: Replace with your own names!
--             :
--  Purpose    :  This design contains an entity for the CPU that must be build  
--             :  in task one of the Mini-MIPS design project. It contains an     
--             :  architecture skeleton for the entity as well.                
--             :
--  Notes      :  The architecture contains two memory banks (in the form of two
--             :  arrays) for the simplest possible memory interface.
--             :
--  Revision   :  1.0    25-08-98     Initial version
--             :  1.1    27-08-99     Added more comments and a nice header.
--             :                      All types were changed to use the new MIPS 
--             :                      types from the file types.vhd.
--             :  2.0    01-09-02     32-bit version + new memory format
--
-- -----------------------------------------------------------------------------

-------------------------------------------------------------------------------- 
-- The entity for task one. It has two input signals (clk and reset) and is 
-- therefore rather useless. 
-------------------------------------------------------------------------------- 

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_arith.ALL;
USE WORK.types.ALL;
USE WORK.mem1.ALL;

ENTITY cpu1 IS  
      GENERIC (programname: STRING := "");      -- name of memory load file.
      PORT (clk:        IN  bit_t;              -- The clock.
            reset:      IN  bit_t);             -- The reset signal.
END cpu1;

-------------------------------------------------------------------------------- 
-- The specification of the Mini-MIPS processor. You should modify this so that
-- it executes the Mini-MIPS instruction set. Each instruction must execute in
-- one clock-cycle. 
-------------------------------------------------------------------------------- 

ARCHITECTURE specification OF cpu1 IS 


BEGIN
      
  ----------------------------------------------------------------------------
  -- The main process. You should insert your code here. Make sure that it is    
  -- as short as possible.                                                      
  ----------------------------------------------------------------------------

  PROCESS 

  BEGIN 
    -- This bit loads a program or reports an error if programname = "".
    IF (programname /= "") THEN
      loadmemoryfromfile(programname);
    ELSE
      REPORT "No program specified!";
    END IF;
    
    -- Endless loop.
    LOOP
      
      IF clk'EVENT AND clk = '1' THEN

        -- Fill in the part that does the actual computation here.
        -- Use 'readinst' from mem1.vhd to fetch an instruction.


        
      END IF;   
        
      WAIT ON clk;
    END LOOP;
  END PROCESS;
END specification;
