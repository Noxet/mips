-- -----------------------------------------------------------------------------
--
--  Title      :  Testbench for task one of the Mini-MIPS design project.
--             :
--  Developers :  Niels Haandbaek -- c958307@student.dtu.dk
--             ;  Chenxin Zhang -- Chenxin.Zhang@eit.lth.se
--             :
--  Purpose    :  This design contains an architecture for the testbench used in 
--             :  task one of the Mini-MIPS design project. It instantiates one
--             :  component of the type cpu1 (defined in the file cpu1.vhd) and
--             :  a clock generator. 
--             :
-- Notes       :  This testbench is not suitable for task two because the cpu
--             :  entity will change and memory modules will be added.
--             :
--  Revision   :  1.0    25-8-98     Initial version
--             :  1.1    27-8-99     Added more comments and a nice header.
--             :                     All types were changed to use the new MIPS 
--             :                     types from the file types.vhd.
--             :  1.2    24-2-03     Configurations now use 50 ns clk periods
--             ;  1.3    06-12-10    A few updates.
--              
-- -----------------------------------------------------------------------------

-------------------------------------------------------------------------------- 
-- The testbench.
-------------------------------------------------------------------------------- 

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE WORK.types.ALL;

ENTITY testbench IS                      
END testbench;

-------------------------------------------------------------------------------- 
-- A simple architecture for the testbench. The program name used by the cpu
-- entity can be specified here or in a configuration.
-------------------------------------------------------------------------------- 

ARCHITECTURE structure OF testbench IS
    CONSTANT CLK_PERIOD : TIME := 50 ns;
    CONSTANT RESET_LEVEL : std_logic := '0';    -- Active low reset
    
    COMPONENT clock 
        GENERIC (period:    TIME := CLK_PERIOD);
        PORT (clk:      OUT std_logic := '0');
    END COMPONENT;

    COMPONENT cpu1   
        GENERIC (programname: STRING := "");     -- name of memory load file.
        PORT (clk:      IN  bit_t;              -- The clock signal.
              reset:    IN  bit_t);             -- The reset signal.
    END COMPONENT;

    SIGNAL clk, reset: bit_t;
   
BEGIN
  -- reset is active-low
  reset <= RESET_LEVEL, not RESET_LEVEL after (CLK_PERIOD + CLK_PERIOD/2);

  theclock: clock
        PORT MAP (clk);

   theCPU: cpu1
        PORT MAP (clk, reset);
END structure;

-------------------------------------------------------------------------------- 
-- Configuration 1 for the testbench. This configuration will make the cpu load
-- the file "fib.log" when a simulation is started.
-------------------------------------------------------------------------------- 

CONFIGURATION testfib OF testbench IS   
    FOR structure
        FOR theclock: clock
            USE ENTITY WORK.clock(behaviour)
            GENERIC MAP (period => CLK_PERIOD);
        END FOR;

        FOR theCPU: cpu1
            USE ENTITY WORK.cpu1(specification)
            GENERIC MAP (programname => "fib1.log");
        END FOR;
    END FOR;
END testfib;

-------------------------------------------------------------------------------- 
-- Configuration 2 for the testbench. This configuration will make the cpu 
-- load the file "sqrt.log" when a simulation is started.
-------------------------------------------------------------------------------- 

CONFIGURATION testsqrt OF testbench IS   
    FOR structure
        FOR theclock: clock
            USE ENTITY WORK.clock(behaviour)
            GENERIC MAP (period => CLK_PERIOD);
        END FOR;

        FOR theCPU: cpu1
            USE ENTITY WORK.cpu1(specification)
            GENERIC MAP (programname => "sqrt1.log");
        END FOR;
    END FOR;
END testsqrt;

---------------------------------------------------------------------------------- 
---- Configuration 3 for the testbench. This configuration will make the cpu 
---- load the file "hello.log" when a simulation is started.
---------------------------------------------------------------------------------- 

--CONFIGURATION testhello OF testbench IS   
--    FOR structure
--        FOR theclock: clock
--            USE ENTITY WORK.clock(behaviour)
--            GENERIC MAP (period => CLK_PERIOD);
--        END FOR;

--        FOR theCPU: cpu1
--            USE ENTITY WORK.cpu1(specification)
--            GENERIC MAP (programname => "hello.log");
--        END FOR;
--    END FOR;
--END testhello;

