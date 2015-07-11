-- -----------------------------------------------------------------------------
--
--  Title      :  Memory procedures for Mini-MIPS task 1
--             :
--  Developers :  Michael Kristensen - c973396@student.dtu.dk
--             :  Hans Holten-Lund - hahl@imm.dtu.dk
--             :
--  Purpose    :  This design contains a package with memory procedures.
--             :  Compile to VHDL-93 standard.
--             :
--  Revision   :  1.0  01-09-02  Initial version
--             :  2.0  03-02-05  Places bootstrap code in 0x00000000
--                               Text placed in 0x00400000
--                               Data now located at 0x10010000
--                               Reads unmodified PCSpim 7.1 .log files
--
--
-- -----------------------------------------------------------------------------



LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_arith.ALL;
USE IEEE.std_logic_signed;
USE STD.textio.ALL;
USE WORK.types.ALL;

PACKAGE mem1 IS
    -- Change this to change memorysize
    CONSTANT MEMSIZE:       INTEGER := 2048;

    SUBTYPE memaddr         IS INTEGER RANGE 0 TO MEMSIZE - 1;
    TYPE memtype            IS ARRAY(memaddr) OF word_t;

    CONSTANT I_OFFSET : word_t := X"00400000";
    CONSTANT D_OFFSET : word_t := X"10010000";

    CONSTANT RC_REG : word_t := X"FFFF0000";
    CONSTANT RD_REG : word_t := X"FFFF0004";
    CONSTANT TC_REG : word_t := X"FFFF0008";
    CONSTANT TD_REG : word_t := X"FFFF000C";
    
    CONSTANT INST_OFFSET : INTEGER := CONV_INTEGER(UNSIGNED(I_OFFSET));
    CONSTANT DATA_OFFSET : INTEGER := CONV_INTEGER(UNSIGNED(D_OFFSET));

    CONSTANT RC_ADDR : INTEGER := CONV_INTEGER(UNSIGNED(RC_REG));
    CONSTANT RD_ADDR : INTEGER := CONV_INTEGER(UNSIGNED(RD_REG));
    CONSTANT TC_ADDR : INTEGER := CONV_INTEGER(UNSIGNED(TC_REG));
    CONSTANT TD_ADDR : INTEGER := CONV_INTEGER(UNSIGNED(TD_REG));

    PROCEDURE loadmemoryfromfile (CONSTANT filename : IN STRING);
    PROCEDURE readinst (VARIABLE address : IN INTEGER; VARIABLE data : OUT word_t);
    PROCEDURE readdata (VARIABLE address : IN INTEGER; VARIABLE data : OUT word_t);
    PROCEDURE writedata (VARIABLE address : IN INTEGER; VARIABLE data : IN word_t);

    SHARED VARIABLE IMemory : memtype;
    SHARED VARIABLE DMemory : memtype;
END mem1;


PACKAGE BODY mem1 IS

  ----------------------------------------------------------------------------
  -- Initialises the IMemory and DMemory arrays
  ----------------------------------------------------------------------------
  
  PROCEDURE loadmemoryfromfile (
    CONSTANT FILENAME : IN STRING) IS

    FILE memfile     : TEXT OPEN READ_MODE IS FILENAME;
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
            IMemory(i) := tmp;
            i := i + 1;
          ELSE
            IMemory(i) := X"00000000";
            i := i + 1;
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
            DMemory(i) := tmp;
            i := i + 1;
            read_hex(memline, tmp);
            DMemory(i) := tmp;
            i := i + 1;
            read_hex(memline, tmp);
            DMemory(i) := tmp;
            i := i + 1;
            read_hex(memline, tmp);
            DMemory(i) := tmp;
            i := i + 1;
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

  ----------------------------------------------------------------------------
  -- Fetches an instruction from IMemory array
  ----------------------------------------------------------------------------

   PROCEDURE readinst (
     VARIABLE address : IN INTEGER;
     VARIABLE data    : OUT word_t) IS

     VARIABLE addr         : word_t;
     VARIABLE word_address : INTEGER;

   BEGIN
     IF (address >= INST_OFFSET) AND (address < INST_OFFSET+memsize*4) THEN
       addr := CONV_STD_LOGIC_VECTOR(address, 32);
       IF addr(1 DOWNTO 0) /= "00" THEN
         REPORT "No unaligned loads in task1!" SEVERITY WARNING;
       ELSE
         addr := UNSIGNED(addr) - INST_OFFSET;
         addr := "00" & addr(31 DOWNTO 2);
         word_address := CONV_INTEGER(UNSIGNED(addr));
         data := IMemory(word_address);
       END IF;
     ELSIF (address >= 0) AND (address < 28) THEN -- Boot-loader at 0
       CASE address IS
         WHEN 0 => data := X"3c011001";  -- lui $1,0x1001
         WHEN 4 => data := X"343d1ffc";  -- ori $sp,$1,0x1ffc
         WHEN 8 => data := X"3c011000";  -- lui $1,0x1000
         WHEN 12 => data := X"343c8000"; -- ori $gp,$1,0x8000
         WHEN 16 => data := X"3c020040"; -- lui $v0,0x00400000
         WHEN 20 => data := X"00400008"; -- jr $v0
         WHEN 24 => data := X"00000000"; -- nop
         WHEN others =>
           REPORT "Memoryread: Address error" SEVERITY WARNING;
       END CASE;
     ELSE
       REPORT "Memoryread: Address error" SEVERITY WARNING;
     END IF;
   end readinst;


  ----------------------------------------------------------------------------
  -- Fetches a dataword from DMemory array
  ----------------------------------------------------------------------------

  PROCEDURE readdata (
     VARIABLE address : IN  INTEGER;
     VARIABLE data    : OUT word_t) IS

     VARIABLE addr         : word_t;
     VARIABLE word_address : INTEGER;

   BEGIN
     IF (address >= DATA_OFFSET) AND (address < DATA_OFFSET+memsize*4) THEN
       addr := CONV_STD_LOGIC_VECTOR(address, 32);
       IF addr(1 DOWNTO 0) /= "00" THEN
         REPORT "No unaligned loads in task1!" SEVERITY WARNING;
       ELSE
         addr := UNSIGNED(addr) - DATA_OFFSET;
         addr := "00" & addr(31 DOWNTO 2);
         word_address := CONV_INTEGER(UNSIGNED(addr));
         data := DMemory(word_address);
       END IF;
-- Edit this to simulate console IO
     ELSIF (address = TC_ADDR) THEN
       data := X"00000001"; 
     ELSIF (address = RC_ADDR) THEN
       data := X"00000001"; 
     ELSIF (address = RD_ADDR) THEN
       REPORT "Reading from receiver" SEVERITY WARNING;
       data := X"00000071"; -- ascii code for 'q'
     ELSE
       REPORT "Memoryread: Address error" SEVERITY WARNING;
     END IF;
   END readdata;


  ----------------------------------------------------------------------------
  -- Stores a dataword to DMemory array
  ----------------------------------------------------------------------------

   PROCEDURE writedata (
     VARIABLE address : IN INTEGER;
     VARIABLE data    : IN word_t) IS

     VARIABLE addr         : word_t;
     VARIABLE word_address : INTEGER;

   BEGIN
     IF (address >= DATA_OFFSET) AND (address < DATA_OFFSET+memsize*4) THEN
       addr := CONV_STD_LOGIC_VECTOR(address, 32);
       IF addr(1 DOWNTO 0) /= "00" THEN
         REPORT "No unaligned stores in task1!" SEVERITY WARNING;
       ELSE
         addr := UNSIGNED(addr) - DATA_OFFSET;
         addr := "00" & addr(31 DOWNTO 2);
         word_address := CONV_INTEGER(UNSIGNED(addr));
         DMemory(word_address) := data;
       END IF;
-- Edit this to simulate console IO
     ELSIF (address = TD_ADDR) THEN
       REPORT "Writing to transmitter" SEVERITY WARNING;
     ELSE
       REPORT "Memorywrite: Address error" SEVERITY WARNING;
     END IF;
   END writedata;

END mem1;

