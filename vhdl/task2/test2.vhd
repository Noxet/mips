-- -----------------------------------------------------------------------------
--
--  Title      :  Testbench for task two of the Mini-MIPS project.
--             :
--  Developers :  Niels Haandbaek -- c958307@student.dtu.dk
--             :  Michael Kristensen -- c973396@student.dtu.dk
--             :  Hans Holten-Lund -- hahl@imm.dtu.dk
--             ;  Chenxin Zhang -- Chenxin.Zhang@eit.lth.se
--             :
--  Purpose    :  This design contains a testbench for the CPU build in task 
--             :  two. It uses two external memory banks, one for instructions
--             :  and one for data.
--             :
--  Revision   :  1.0    09-09-99    Initial version
--             :  2.0    08-08-02    Modified to 32-bit Mini-MIPS
--             :  2.1    24-02-03    Changed data-memory HOLD cycles to 0,
--                                   (Also try 1 cycle delay to test HOLD)
--             :  3.0    14-03-05    Now uses the new memory model.
--             ;  3.1    10-12-10    A few updates.
--              
-- -----------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE WORK.types.ALL;

ENTITY mips IS
END mips;

ARCHITECTURE structure OF mips IS
    CONSTANT CLK_PERIOD : TIME := 50 ns;
    CONSTANT RESET_LEVEL : std_logic := '0';    -- Active low reset

    COMPONENT clock 
        GENERIC (period:        TIME := CLK_PERIOD);
        PORT (clk:              OUT std_logic := '0');
    END COMPONENT;

    COMPONENT mem2
        GENERIC (filename:      STRING  := "";
                 memsize:       INTEGER := 2048;
                 n:             NATURAL := 0;
                 Tclock:        TIME := 50 ns;
                 read_delay:    TIME := 0 ns;
                 mem_load:      STRING := "inst";
                 base_addr:     word_t := X"00000000"
                 );
        PORT (clk:        IN    bit_t;              
              reset:      IN    bit_t;
              addr:       IN    word_t;         
              data:       INOUT word_t;       
              rw:         IN    bit_t;              
              req:        IN    bit_t;              
              hold:       OUT   bit_t);             
    END COMPONENT;   

    COMPONENT cpu2 
        PORT (clk :       IN    bit_t;           
              reset:      IN    bit_t;           
              instaddr:   OUT   word_t;      
              inst:       INOUT word_t;      
              instreq:    OUT   bit_t;           
              instrw:     OUT   bit_t;           
              insthold:   IN    bit_t;           
              dataaddr:   OUT   word_t;      
              data:       INOUT word_t;      
              datareq:    OUT   bit_t;           
              datarw:     OUT   bit_t;           
              datahold:   IN    bit_t);          
    END COMPONENT;

    SIGNAL clk:      bit_t;
    SIGNAL reset:    bit_t;

    SIGNAL instaddr: word_t;
    SIGNAL inst_bus: word_t;
    SIGNAL instreq:  bit_t;
    SIGNAL instrw:   bit_t;
    SIGNAL insthold: bit_t;

    SIGNAL dataaddr: word_t;
    SIGNAL data_bus: word_t;
    SIGNAL datareq:  bit_t;
    SIGNAL datarw:   bit_t;
    SIGNAL datahold: bit_t;

    SIGNAL instmap: word_t;
    SIGNAL datamap: word_t;
    
BEGIN
    -- reset is active-low
    reset <= RESET_LEVEL, not RESET_LEVEL AFTER (CLK_PERIOD + CLK_PERIOD/2);

    SysClk: clock
        PORT MAP (clk      => clk);

    Processor: cpu2
        PORT MAP (clk      => clk,
                  reset    => reset,
                  instaddr => instaddr,
                  inst     => inst_bus,
                  instreq  => instreq,
                  instrw   => instrw,
                  insthold => insthold,
                  dataaddr => dataaddr,
                  data     => data_bus,
                  datareq  => datareq,
                  datarw   => datarw,
                  datahold => datahold);

    InstMem: mem2
        PORT MAP (addr     => instaddr,
                  data     => inst_bus,
                  req      => instreq,
                  rw       => instrw,
                  hold     => insthold,
                  clk      => clk,
                  reset    => reset);

    DataMem: mem2
        PORT MAP (addr     => dataaddr,
                  data     => data_bus,
                  req      => datareq,
                  rw       => datarw,
                  hold     => datahold,
                  clk      => clk,
                  reset    => reset);

END structure;

-------------------------------------------------------------------------------- 
-- A configuration for the testbench. This configuration will make the cpu load
-- the file "fib2.log" when a simulation is started.
-------------------------------------------------------------------------------- 

CONFIGURATION testfib OF mips IS
    FOR structure
        FOR SysClk: clock
            USE ENTITY WORK.clock(behaviour)
                GENERIC MAP(period => CLK_PERIOD);
        END FOR;

        FOR Processor: cpu2
                USE ENTITY WORK.cpu2(structure);
        END FOR;
    
        FOR InstMem: mem2
            USE ENTITY WORK.mem2(behaviour)
                GENERIC MAP(filename => "fib2.log",
                            n        => 0, -- HOLD cycles
                            Tclock   => CLK_PERIOD,
                            mem_load => "inst",
                            base_addr=> X"00400000");
        END FOR;
    
        FOR DataMem: mem2
            USE ENTITY WORK.mem2(behaviour)
                GENERIC MAP(filename => "fib2.log",
                            n        => 0, -- HOLD cycles
                            Tclock   => CLK_PERIOD,
                            mem_load => "data",
                            base_addr=> X"10010000");
        END FOR;
    END FOR;
END testfib;

-------------------------------------------------------------------------------- 
-- A configuration for the testbench. This configuration will make the cpu load
-- the file "sqrt2.log" when a simulation is started.
-------------------------------------------------------------------------------- 

CONFIGURATION testsqrt OF mips IS
    FOR structure
        FOR SysClk: clock
            USE ENTITY WORK.clock(behaviour)
                GENERIC MAP(period => CLK_PERIOD);
        END FOR;

        FOR Processor: cpu2
                USE ENTITY WORK.cpu2(structure);
        END FOR;
    
        FOR InstMem: mem2
            USE ENTITY WORK.mem2(behaviour)
                GENERIC MAP(filename => "sqrt2.log",
                            n        => 0, -- HOLD cycles
                            Tclock   => CLK_PERIOD,
                            mem_load => "inst",
                            base_addr=> X"00400000");
        END FOR;
    
        FOR DataMem: mem2
            USE ENTITY WORK.mem2(behaviour)
                GENERIC MAP(filename => "sqrt2.log",
                            n        => 0, -- HOLD cycles
                            Tclock   => CLK_PERIOD,
                            mem_load => "data",
                            base_addr=> X"10010000");
        END FOR;
    END FOR;
END testsqrt;
