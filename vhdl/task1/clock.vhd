-- -----------------------------------------------------------------------------
--
--  Title      :  Simple clock generator.
--             :
--  Developers :  Niels Haandbaek -- c958307@student.dtu.dk
--             :
--  Purpose    :  This design contains a clock generator.
--             :
--  Revision   :  1.0    27-8-99     Initial version
--              
-- -----------------------------------------------------------------------------

-------------------------------------------------------------------------------- 
-- A simple clock generator. The period is specified in a generic and defaults
-- to 50 ns.
-------------------------------------------------------------------------------- 

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY clock IS
    GENERIC (period:    TIME := 50 ns);
    PORT (clk:          OUT std_logic := '0');
END clock;

ARCHITECTURE behaviour OF clock IS
BEGIN
    PROCESS       
    BEGIN
        clk <= '1', '0' AFTER period/2;
        WAIT FOR period;
    END PROCESS;
END behaviour;
