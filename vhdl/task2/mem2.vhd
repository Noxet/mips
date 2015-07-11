-- -----------------------------------------------------------------------------
--
--  Title      :  Mini-MIPS memory entity.
--             :
--  Developers :  Niels Haandbaek -- c958307@student.dtu.dk (version 1.0)
--             :  Michael Kristensen -- c973396@student.dtu.dk (version 2.0)
--             :  Hans Holten-Lund -- hahl@imm.dtu.dk (version 3.0)
--             :
--  Purpose    :  This design contains a small memory for the Mini-MIPS CPU.     
--             :  The memory loads data from the SPIM .log in "filename"
--             :  Data will be loaded, if mem_load is "data". And instructions
--             :  are loaded if mem_load is "inst".
--             :  The memory has built-in address decoding, specified by
--             :  "base_addr" and "memsize".
--             :
--  Notes      :  Keep the memorysize 'memsize' as small as possible,
--             :  to speedup simulation.
--             :
--  Revision   :  1.0    08-08-1999  Initial version
--             :  2.0    12-09-2002  New: fileformat, read/write/hold-processes
--             :  3.0    14-03-2005  Bootstrap code in instmem at 0x00000000
--                                   Text placed in 0x00400000
--                                   Data now located at 0x10010000
--                                   Reads unmodified PCSpim 7.1 .log files
--
-- -----------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- This is the memory model that should be used in task two. Write a small test 
-- bench for the memory and examine the behaviour if needed.
--------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_arith.ALL;
USE STD.textio.ALL;
USE WORK.types.ALL;

ENTITY mem2 IS   
    GENERIC (filename   : STRING  := "";    -- Name of memory load file
             memsize    : NATURAL := 2048;  -- Size of memory (32-bit words)
                                            -- MUST be a power of 2
             n          : NATURAL := 0;     -- Number of hold cycles (wait states)
             Tclock     : TIME := 50 ns;    -- Length of clock-period.
             read_delay : TIME := 0 ns;     -- Propagation delay for read.
             mem_load   : STRING := "inst"; -- Load "inst" or "data" from file.
             base_addr  : word_t := X"00000000" ); -- Base address.
    PORT (clk   : IN    bit_t;              -- The clock.
          reset : IN    bit_t;              -- reset signal
          addr  : IN    word_t;             -- The address bus.
          data  : INOUT word_t;             -- The data bus.
          rw    : IN    bit_t;              -- Read/Write signal.
          req   : IN    bit_t;              -- Request memory operation signal.
          hold  : OUT   bit_t);             -- Hold signal.
END mem2;   

--------------------------------------------------------------------------------
-- Notice how signal attributes are used to ensure that all signals have been 
-- held stable for the appropriate amount of time.
--------------------------------------------------------------------------------

ARCHITECTURE behaviour OF mem2 IS

  SUBTYPE MemAddr IS INTEGER RANGE 0 TO memsize - 1;
  TYPE MemType    IS ARRAY(MemAddr) OF word_t;

  SHARED VARIABLE Memory  : MemType;       -- memory array      
  
  PROCEDURE loadmemoryfromfile (
    CONSTANT filename : IN STRING;
    CONSTANT mem_load : IN STRING) IS

    FILE memfile     : TEXT OPEN READ_MODE IS filename;
    VARIABLE memline : LINE;
    VARIABLE tmp     : word_t;
    VARIABLE line_no : NATURAL := 0;
    VARIABLE address : NATURAL := 0;
    VARIABLE str     : STRING(1 TO 6);
    VARIABLE datamem : BOOLEAN := FALSE;
    VARIABLE i       : NATURAL := 0;

    VARIABLE state   : integer := 0;

    PROCEDURE read_hex(myline : INOUT LINE; word : OUT word_t) IS
      VARIABLE ch             :       CHARACTER;
      VARIABLE digit          :       INTEGER;
      VARIABLE part           :       word_t;

    BEGIN

      ch:='0';
      WHILE NOT (ch='x') LOOP -- Scan until we get to an x
        READ(myline, ch);
      END LOOP;

      -- Read the inst/data word
      FOR i IN 0 TO 7 LOOP
        READ(myline, ch);
        IF ch >= '0' AND ch    <= '9' THEN
          digit := CHARACTER'POS(ch) - CHARACTER'POS('0');
        ELSIF ch >= 'A' AND ch <= 'F' THEN
          digit := CHARACTER'POS(ch) - CHARACTER'POS('A') + 10;
        ELSIF ch >= 'a' AND ch <= 'f' THEN
          digit := CHARACTER'POS(ch) - CHARACTER'POS('a') + 10;
        ELSE
          REPORT "Error in memoryfile : " & filename & " on line " & INTEGER'IMAGE(line_no) SEVERITY ERROR;
        END IF;

        part(31-i*4 DOWNTO 28-i*4) := CONV_STD_LOGIC_VECTOR(digit, 4);
      END LOOP;
      word := part;
    END read_hex;

  BEGIN

    i := 0;
    state := 0;
    WHILE NOT ENDFILE(memfile) LOOP

      CASE state IS
        WHEN 0 => -- initial state
          READLINE(memfile, memline);
          IF memline'LENGTH >= 1 THEN
            READ(memline, str);
            IF str = "Text S" THEN
              READLINE(memfile, memline); -- Skip the "===" line
              line_no := line_no + 1;
              state := 1;
            END IF;
          END IF;
        WHEN 1 => -- reading the TEXT segment
          READLINE(memfile, memline);
          IF memline'LENGTH >= 1 THEN
            -- Skip the address
            read_hex(memline,tmp);

            read_hex(memline, tmp);
            IF mem_load = "inst" THEN
              Memory(i) := tmp;
              i := i + 1;
            END IF;
          ELSE
            IF mem_load = "inst" THEN
              Memory(i) := X"00000000";
              i := i + 1;
            END IF;
            state := 2;
          END IF;
        WHEN 2 => -- Search for the DATA segment (skipping KERNEL code)
          READLINE(memfile, memline);
          IF memline'LENGTH >= 1 THEN
            READ(memline, str);
            IF str = "Data S" THEN
              READLINE(memfile, memline); -- Skip the "===" line
              READLINE(memfile, memline); -- Skip the "DATA" line
              READLINE(memfile, memline); -- Skip the "[0x10000000]...[]" line
              state := 3;
              i := 0;
              line_no := line_no + 3;
            END IF;
          END IF;
        WHEN 3 => -- reading the DATA segment
          READLINE(memfile, memline);
          IF memline'LENGTH >= 50 THEN
            -- Skip address
            read_hex(memline, tmp);
            
            read_hex(memline, tmp);
            IF mem_load = "data" THEN
              Memory(i) := tmp;
              i := i + 1;
            END IF;
            read_hex(memline, tmp);
            IF mem_load = "data" THEN
              Memory(i) := tmp;
              i := i + 1;
            END IF;
            read_hex(memline, tmp);
            IF mem_load = "data" THEN
              Memory(i) := tmp;
              i := i + 1;
            END IF;
            read_hex(memline, tmp);
            IF mem_load = "data" THEN
              Memory(i) := tmp;
              i := i + 1;
            END IF;
          ELSE
            state := 4;
          END IF;
        WHEN 4 => -- Done, just keep reading till end of file...
          READLINE(memfile, memline);
        WHEN others =>
          REPORT "Error in memoryfile : " & filename & ", unexpected : " & str SEVERITY ERROR;
      END CASE;     

      line_no := line_no + 1;
    END LOOP;
  END LoadMemoryFromFile;
  
  SIGNAL holdcnt      : NATURAL := 0;
  SIGNAL readRequest  : BOOLEAN := false;
  SIGNAL writeRequest : BOOLEAN := false;
  SIGNAL addressValid : BOOLEAN := false;
  SIGNAL dataValid    : BOOLEAN := false;
  SIGNAL hold_i       : bit_t;
  
BEGIN

  hold <= hold_i;

-- control signals for memory read/write
  hold_i <= '0' after read_delay WHEN holdcnt = 0 ELSE 
       	   '1' after read_delay;

  addressValid <= addr'STABLE(n * Tclock);
  dataValid    <= data'STABLE(n * Tclock);

  readRequest <= req = '1' AND req'STABLE(n * Tclock) AND
                 rw = '1' AND rw'STABLE(n * Tclock);

  writeRequest <= req = '1' AND req'STABLE(n * Tclock) AND
                  rw = '0' AND rw'STABLE(n * Tclock);


-- automatically load memory from file when simulation starts
  load_mem : PROCESS
  BEGIN
    IF (filename /= "") THEN
      loadmemoryfromfile(filename,mem_load);
    END IF;
    WAIT;                               -- suspend process
  END PROCESS load_mem;

-- keep track of hold signal
  hold_management : PROCESS(clk, reset)
  BEGIN
    IF reset = '0' then
       holdcnt <= 0;
    ELSIF clk'EVENT AND clk = '0' THEN
      IF req = '1' THEN
        IF holdcnt < n THEN             --still not held for n clockcycles   
          holdcnt <= holdcnt + 1;
        ELSE                            --n'th clockcycle
          holdcnt <= 0;                 --reset hldcnt for next req.
        END IF;
      END IF;
    END IF;
  END PROCESS hold_management;

-- handle a write to memory
  memwrite : PROCESS(clk, reset)
    VARIABLE address : INTEGER;
  BEGIN
  IF reset = '0' then
    -- do nothing...
  ELSIF clk'EVENT AND clk = '1' THEN
      IF writeRequest AND hold_i = '0' THEN
        IF addressValid AND dataValid THEN
          address := CONV_INTEGER(UNSIGNED(addr(31 downto 2)))
                     -CONV_INTEGER(UNSIGNED(base_addr(31 downto 2)));
          IF address >= 0 AND address < memsize THEN
            Memory(address) := data;
            REPORT "Datawrite, address=" & integer'image(address) severity note;
            REPORT "Datawrite, value=" & integer'image(conv_integer(signed(data))) severity note;
          ELSE
            REPORT "MEMORYWRITE beyond limits, increase 'memsize'" SEVERITY WARNING;
          END IF;
        ELSIF addressValid THEN         -- address valid, but data isn't
          address := CONV_INTEGER(UNSIGNED(addr(31 downto 2)))
                     -CONV_INTEGER(UNSIGNED(base_addr(31 downto 2)));
          IF address >= 0 AND address < memsize THEN
            Memory(address) := (OTHERS => 'X');  --write random data
          ELSE
            REPORT "MEMORYWRITE beyond limits, increase 'memsize'" SEVERITY WARNING;
          END IF;
          REPORT "DATA was NOT stable, too bad!" SEVERITY WARNING;
        ELSE                            -- data valid, but address isn't
          Memory(0) := data;            --write data to a random address
          REPORT "ADDRESS was NOT stable, too bad!" SEVERITY WARNING;
        END IF;
      END IF;
    END IF;
  END PROCESS memwrite;

-- handle a read from memory
  memread: PROCESS(addr, addressValid, readRequest, hold_i, clk)
    VARIABLE address : INTEGER;
    VARIABLE readData : word_t;
  BEGIN
  IF addressValid AND readRequest AND hold_i = '0' AND clk = '0' THEN
    address := CONV_INTEGER(UNSIGNED(addr(31 downto 2)))
               -CONV_INTEGER(UNSIGNED(base_addr(31 downto 2)));
    IF address >= 0 AND address < memsize THEN
      readData := Memory(address);
    ELSE
      address := CONV_INTEGER(UNSIGNED(addr(31 downto 0)));
      IF address >= 0 AND address < 28 THEN -- Boot-loader at 0
        CASE address IS
          WHEN 0 => readData := X"3c011001";  -- lui $1,0x1001
          WHEN 4 => readData := X"343d1ffc";  -- ori $sp,$1,0x1ffc
          WHEN 8 => readData := X"3c011000";  -- lui $1,0x1000
          WHEN 12 => readData := X"343c8000"; -- ori $gp,$1,0x8000
          WHEN 16 => readData := X"3c020040"; -- lui $v0,0x00400000
          WHEN 20 => readData := X"00400008"; -- jr $v0
          WHEN 24 => readData := X"00000000"; -- nop
          WHEN others =>
            REPORT "Memoryread: Address error" SEVERITY WARNING;
        END CASE;
      ELSE
        readData := (others => 'U');
        REPORT "MEMORYREAD beyond limits, increase 'memsize'" severity WARNING;
      END IF;
    END if;
  ELSE
    readData := (OTHERS => 'Z');
  END IF;

  data <= readData after read_delay;
  END PROCESS memread;
  
END behaviour;
