--  
--  
--  ------------------------------------------------------------
--    STMicroelectronics N.V. 2010
--   All rights reserved. Reproduction in whole or part is prohibited  without the written consent of the copyright holder.                                                                                                                                                                                                                                                                                                                           
--    STMicroelectronics RESERVES THE RIGHTS TO MAKE CHANGES WITHOUT  NOTICE AT ANY TIME.
--  STMicroelectronics MAKES NO WARRANTY,  EXPRESSED, IMPLIED OR STATUTORY, INCLUDING BUT NOT LIMITED TO ANY IMPLIED  WARRANTY OR MERCHANTABILITY OR FITNESS FOR ANY PARTICULAR PURPOSE,  OR THAT THE USE WILL NOT INFRINGE ANY THIRD PARTY PATENT,  COPYRIGHT OR TRADEMARK.
--  STMicroelectronics SHALL NOT BE LIABLE  FOR ANY LOSS OR DAMAGE ARISING FROM THE USE OF ITS LIBRARIES OR  SOFTWARE.
--    STMicroelectronics
--   850, Rue Jean Monnet
--   BP 16 - 38921 Crolles Cedex - France
--   Central R&D / DAIS.
--                                                                                                                                                                                                                                                                                                                                                                             
--    
--  
--  ------------------------------------------------------------
--  
--  
--    User           : sophie dumont           
--    Project        : CMP_EIT_100823          
--    Division       : Not known               
--    Creation date  : 23 August 2010          
--    Generator mode : MemConfMAT10/distributed
--    
--    WebGen configuration           : C65LP_ST_SPHDL:335,22:MemConfMAT10/distributed:2.4.a-00
--  
--    HDL C65_ST_SP Compiler version : 4.5@20081008.0 (UPT date)                               
--    
--  
--  For more information about the cuts or the generation environment, please
--  refer to files uk.env and ugnGuiSetupDB in directory DESIGN_DATA.
--   
--  
--  



------------------------------------------------------------------------------
--  Function         : Entity FOR VHDL funct model
--  Release Date     : Nov, 2006
--  Last Modified By : ZZ
--  Version          : 4.0
------------------------------------------------------------------------------

--------------------- START OF HEADER ---------------------------
-- This Header Gives Information about the parameters & options present in the Model

-- words = 128
-- bits  = 32
-- mux   = 8 
-- 
-- 
-- 
-- 
-- 
----------------------END OF HEADER -------------------------------

LIBRARY IEEE;                   USE IEEE.STD_LOGIC_1164.ALL;
                                USE IEEE.STD_LOGIC_ARITH.ALL;
                                USE STD.TEXTIO.ALL;

ENTITY  ST_SPHDL_128x32m8_L IS

--synopsys synthesis_off
    GENERIC (
        Words : Natural := 128;
        Bits : Natural := 32;
        Addr : Natural := 7;
        mux : Natural := 8;


        ConfigFault : Boolean := FALSE;
        max_faults : Natural := 20;
        Fault_file_name : STRING := "ST_SPHDL_128x32m8_L_faults.txt";
        -- generics for Memory initialization
        MEM_INITIALIZE  : BOOLEAN := FALSE;
        BinaryInit      : INTEGER := 0;
        InitFileName    : STRING  := "ST_SPHDL_128x32m8_L.cde";
        Corruption_Read_Violation : BOOLEAN := TRUE;
        
        InstancePath : String := "ST_SPHDL_128x32m8_L";
        Debug_mode : String := "ALL_WARNING_MODE"
    );
--synopsys synthesis_on
    PORT (
        Q : OUT std_logic_vector(31 DOWNTO 0);
        RY : OUT std_logic;
        CK : IN std_logic;
        CSN : IN std_logic;
        TBYPASS : IN std_logic;
        WEN : IN std_logic;
        A : IN std_logic_vector(6 DOWNTO 0);
        D : IN std_logic_vector(31 DOWNTO 0)   
) ;    
END ST_SPHDL_128x32m8_L;







LIBRARY IEEE;                   
   USE IEEE.STD_LOGIC_1164.ALL;
   USE IEEE.STD_LOGIC_ARITH.ALL;
   USE IEEE.STD_LOGIC_TEXTIO.ALL;
LIBRARY STD;
   USE STD.TEXTIO.ALL;
   USE STD.STANDARD.ALL;


ARCHITECTURE VHDL_FUNCT of ST_SPHDL_128x32m8_L IS

--synopsys synthesis_off

-- list of input signals after filtering-----------
    SIGNAL Aint   : std_logic_vector(Addr-1 DOWNTO 0);
    SIGNAL Dint   : std_logic_vector(Bits-1 DOWNTO 0);
    SIGNAL Mint   : std_logic_vector(Bits-1 DOWNTO 0);
    SIGNAL CKint  : std_logic;
    SIGNAL CSNint : std_logic;
    SIGNAL CSNinternal : std_logic;
    SIGNAL WENint : std_logic;
    SIGNAL TBYPASSint  : std_logic;
    
    SIGNAL RYint  : std_logic := '1';
    
      

    SIGNAL Qint   : std_logic_vector(Bits-1 DOWNTO 0);
    




   
   SIGNAL fault_repair_flag : bit_vector(max_faults-1 DOWNTO 0) := (OTHERS => '1');
   SIGNAL fcnt : integer := 0;
   
   type stuckfault is array (Natural RANGE <>) of std_logic_vector(Bits-1 DOWNTO 0);
   SIGNAL stuck_at_0fault : stuckfault(max_faults-1 DOWNTO 0);
    
   type faultlocn is array (Natural RANGE <>) of integer;
   SIGNAL FailureLocn : faultlocn(0 to max_faults-1);
   SIGNAL debug_level : std_logic_vector(1 DOWNTO 0) := (OTHERS => '0');
--- AddrFilter puts all the bits of address bits TO 'X' or 'U' IF one of the bit is equal TO 'X' or 'U'--------------------------

    FUNCTION AddrFilter(Input : std_logic_vector) RETURN std_logic_vector IS
        VARIABLE UFound : Boolean := FALSE;
        VARIABLE Output : std_logic_vector(Input'RANGE);
    BEGIN
        FOR i IN Input'RANGE LOOP
            IF (Input(i) = 'U') THEN
                UFound := TRUE;
                EXIT;
            END IF;
        END LOOP;
        IF (UFound) THEN
            Output := (OTHERS => 'U');
        ELSIF (is_x(Input)) THEN
            Output := (OTHERS => 'X');
        ELSE
            Output := to_x01(Input);
        END IF;
        RETURN Output;
    END AddrFilter;

 function to_integer (oper : std_logic_vector) return integer is
      variable value     : integer := 0;
      variable temp_no   : integer := 1;
      variable temp_oper : std_logic_vector(oper'range) := oper;
      variable index     : integer := 1;
   begin
      ASSERT oper'length <= 31
      REPORT "argument is too large in to_integer, only lower 31 bits will be taken"
      SEVERITY WARNING;

      IF (not (is_X(oper))) then
         for I in temp_oper'reverse_range LOOP
            case (temp_oper(I)) is
               when '1' =>
                  value := value + temp_no;
               when others =>
                  null;
            END case;
            index := index + 1;
            exit when index > 31;
            temp_no := temp_no + temp_no;
         END LOOP;
      else
         ASSERT FALSE
         REPORT "WARNING: Illegal value detected in the conversion of to_integer"
         SEVERITY WARNING;

         value := 0;
      END IF;
      return (value);
   END to_integer;


--synopsys synthesis_on

BEGIN

--synopsys synthesis_off

  --------------------------------- Filter Block --------------------------- 
   Filter : BLOCK
        
        BEGIN
            Dint   <= to_ux01(D);
            CKint  <= to_ux01(CK);
            CSNinternal <= to_ux01(CSN);
            WENint <= to_ux01(WEN);
            TBYPASSint  <= to_ux01(TBYPASS);
            



	    Mint   <= (Others => '0');


            Aint <= AddrFilter(A);  -- IF one of the bits is equal TO 'X'
                                        -- or 'U' all bits are put TO this value

            
            CSNint <= (CSNinternal OR TBYPASSint );                            
        END BLOCK;
  

-------------------------------------------------------------------------------


ReadWrite : PROCESS (CKint, CSNint, TBYPASSint, Dint )

        SUBTYPE MType IS std_logic_vector(D'RANGE);
        TYPE MemType IS ARRAY (Natural RANGE <>) OF std_logic_vector(D'RANGE);
        VARIABLE Mem      : MemType(Words-1 DOWNTO 0);
        
        VARIABLE isMessageDisplayed : BOOLEAN := FALSE;
        
        CONSTANT WordX    : std_logic_vector(D'RANGE) := (OTHERS => 'X');
        CONSTANT WordU    : std_logic_vector(D'RANGE) := (OTHERS => 'U');
   
        file FAULT_ADDRESS_FILE : TEXT; 
        VARIABLE fileOpenStatus : FILE_OPEN_STATUS := NAME_ERROR;
        VARIABLE mode : FILE_OPEN_KIND := READ_MODE;
        VARIABLE FILE_READ : Boolean := TRUE; 

        variable i : integer := 0;
        variable k : integer := 0;
        VARIABLE mssgcnt : std_logic := 'X';
        VARIABLE fault_line : LINE;
        VARIABLE fault_word : integer := 0;
        VARIABLE fault_bit : integer := 0;
        VARIABLE std_fault_word : std_logic_vector(Addr-1 DOWNTO 0) := (OTHERS => '0');
        VARIABLE stuck0 : std_logic_vector(Bits-1 DOWNTO 0) := (OTHERS => '1');
        type faults is array (Natural RANGE <>) of integer;
        VARIABLE fault_row_add : faults(0 to max_faults-1);

        CONSTANT RepairFlag1 : bit_vector(max_faults-1 DOWNTO 0) := (OTHERS => '1');
        VARIABLE j : integer := 0;
        VARIABLE Fault_repaired_flag : Boolean := TRUE;

        VARIABLE FAULT_INFO_LINE : LINE;
        VARIABLE INFO_LINE : LINE;
        file OUTPUT: TEXT  open WRITE_MODE is "STD_OUTPUT";
        VARIABLE PrevCSN  : std_logic;
        VARIABLE WENreg  : std_logic;
        VARIABLE Q_last  : std_logic_vector(D'RANGE);
        VARIABLE RY_last : std_logic; 
        
    FUNCTION InitMem (FileName : String) RETURN MemType IS
 
       FILE     InitFile : Text ;
       VARIABLE InitLine : Line;
       VARIABLE Address : Natural;
       VARIABLE Value1 : MType;
       VARIABLE Value2 : MType;
       VARIABLE Contents : MemType(Words-1 DOWNTO 0);
       VARIABLE Good : Boolean;
       VARIABLE tmp: STD_ULOGIC_VECTOR(((((Bits-1)/4)+1)*4 - 1) DOWNTO 0);
       VARIABLE tmp1: STD_ULOGIC_VECTOR((Bits-1) DOWNTO 0);
       VARIABLE fileOpenStatus : FILE_OPEN_STATUS := NAME_ERROR;
       VARIABLE mode : FILE_OPEN_KIND := READ_MODE;


   BEGIN

       -- file format is:
       -- one <value> per line starting at <address>=0
       -- <value> is a std_logic_vector
       -- expressed according to parameter <Format>:
       -- BinaryInit = 1 means Binary (default)
       -- BinaryInit = 0 means Hexadecimal

       FILE_OPEN(fileOpenStatus,InitFile, InitFileName, mode);
       IF (fileOpenStatus = OPEN_OK OR fileOpenStatus = STATUS_ERROR) THEN
       Address := 0;
       ReadFile: WHILE (NOT ENDFILE(InitFile)) LOOP
           readline(InitFile, InitLine);
           Good := TRUE;
           CASE BinaryInit IS
               WHEN 1 =>
                   read(InitLine, Value2, Good);
               WHEN 0 =>
                   HREAD(InitLine, tmp, GOOD);
                   for j in 0 to bits-1 loop
                       tmp1(j) := tmp(j);
                   end loop;
                   Value1 := STD_LOGIC_VECTOR(tmp1);

               WHEN OTHERS =>
                   ASSERT FALSE  REPORT "(" & InstancePath & ")" &  "  RAM Initialization failed: bad format. " SEVERITY WARNING;
           END CASE;
           IF Good THEN
               IF (Address = Words) THEN
                        ASSERT FALSE REPORT "(" & InstancePath & ")" &  "  Too many data words in the personality file. " SEVERITY WARNING;
               END IF;
               CASE BinaryInit IS
                   WHEN 1 =>
                       Contents(Address) := Value2;
                   WHEN 0 =>
                       Contents(Address) := Value1;        -- (Q'left downto 0);
                   WHEN OTHERS =>
                       NULL;
               END CASE;
           ELSE
                ASSERT FALSE REPORT "(" & InstancePath & ")" &  "  RAM Initialization failed " SEVERITY WARNING;
           END IF;
           Address := Address+1;
       END LOOP ReadFile;

       IF (Address /= Words) THEN
           ASSERT FALSE REPORT "(" & InstancePath & ")" &  "  Words in the personality file less than that given by address bounds. " SEVERITY WARNING;
       END IF;
       ELSE --else of if(fileOpenStatus)
          ASSERT FALSE
          REPORT "Unable to read Code File. "
          SEVERITY WARNING;
       END IF; -- end of if(fileOpenStatus)
       RETURN Contents;
   END InitMem;
      
      -- HEX code file reading
 
      PROCEDURE Char2QuadBits(C: Character; RESULT: out Bit_Vector(3 downto 0); GOOD: out Boolean; ISSUE_ERROR: in Boolean) IS
      BEGIN
      CASE c IS
        WHEN '0' => RESULT :=  x"0"; good := TRUE;
        WHEN '1' => RESULT :=  x"1"; good := TRUE;
        WHEN '2' => RESULT :=  x"2"; good := TRUE;
        WHEN '3' => RESULT :=  x"3"; good := TRUE;
        WHEN '4' => RESULT :=  x"4"; good := TRUE;
        WHEN '5' => RESULT :=  x"5"; good := TRUE;
        WHEN '6' => RESULT :=  x"6"; good := TRUE;
        WHEN '7' => RESULT :=  x"7"; good := TRUE;
        WHEN '8' => RESULT :=  x"8"; good := TRUE;
        WHEN '9' => RESULT :=  x"9"; good := TRUE;
        WHEN 'A' => RESULT :=  x"A"; good := TRUE;
        WHEN 'B' => RESULT :=  x"B"; good := TRUE;
        WHEN 'C' => RESULT :=  x"C"; good := TRUE;
        WHEN 'D' => RESULT :=  x"D"; good := TRUE;
        WHEN 'E' => RESULT :=  x"E"; good := TRUE;
        WHEN 'F' => RESULT :=  x"F"; good := TRUE;

        WHEN 'a' => RESULT :=  x"A"; good := TRUE;
        WHEN 'b' => RESULT :=  x"B"; good := TRUE;
        WHEN 'c' => RESULT :=  x"C"; good := TRUE;
        WHEN 'd' => RESULT :=  x"D"; good := TRUE;
        WHEN 'e' => RESULT :=  x"E"; good := TRUE;
        WHEN 'f' => RESULT :=  x"F"; good := TRUE;
        WHEN others =>
          IF ISSUE_ERROR THEN
                ASSERT ((NOW = 0 ns) or (to_integer(debug_level) >= 2)) REPORT "(" & InstancePath & ")" &  " (MSG_ID 801 ) HREAD Error: Read a '" & c & "' , expected a Hex character (0-F). " SEVERITY WARNING;
          END IF;
              good := FALSE;
      END CASE;
   END Char2QuadBits;

   -- Reading Hex code file
   PROCEDURE HREAD(L:inout LINE; VALUE:out BIT_VECTOR;GOOD: out BOOLEAN) is
        VARIABLE ok: boolean;
        VARIABLE c:  character;
        CONSTANT ne: integer := (value'length-1)/4;
        VARIABLE bv: bit_vector(0 to value'length-1);
        VARIABLE s:  string(1 to ne);
    BEGIN
        LOOP                                    -- skip white space
           read(l,c);
           EXIT when ((c /= ' ') and (c /= CR) and (c /= HT));
        END LOOP;

        Char2QuadBits(c, bv(0 to 3), ok, TRUE);
        IF not ok THEN
           good := FALSE;
           RETURN;
        END IF;
        if ( ne >= 1) then
           read(L, s, ok);
           if not ok then
              good := FALSE;
              return;
           end if;
        end if;
   
        if value'length mod 4 /= 0 then
           for i in 1 to ne-1 loop
              Char2QuadBits(s(i), bv(4*i to 4*i+3), ok, TRUE);
              if not ok then
                 good := FALSE;
                 return;
              end if;
           end loop;
        else
           for i in 1 to ne loop
              Char2QuadBits(s(i), bv(4*i to 4*i+3), ok, TRUE);
              if not ok then
                 good := FALSE;
                 return;
              end if;
           end loop;
        end if;
        good := TRUE;
        value := bv;
    end HREAD;

PROCEDURE WriteCycleMaskBased (CONSTANT Address : IN std_logic_vector(Addr-1 DOWNTO 0);
                           CONSTANT Data : IN std_logic_vector(Bits-1 DOWNTO 0);
                           CONSTANT Mask : IN std_logic_vector(Bits-1 DOWNTO 0)) IS

     VARIABLE V_Location : Natural;
     VARIABLE D_temp     : std_logic_vector(Bits-1 DOWNTO 0);

     BEGIN
     
        IF(is_x(Address(0))) THEN
           ASSERT ((NOW = 0 ns) or (to_integer(debug_level) >= 2)) REPORT "(" & InstancePath & ")" &  " (MSG_ID 009 ) Illegal Value on Address Bus during Write Cycle. Memory Corrupted " SEVERITY WARNING;
           mem := (OTHERS => (OTHERS => 'X'));
        ELSE
           V_location := to_integer(Address); 
           IF (V_Location >= Words) THEN
              ASSERT ((NOW = 0 ns) or (to_integer(debug_level) >= 2)) REPORT "(" & InstancePath & ")" &  " (MSG_ID 702 ) Address Out Of Range during Write Cycle. " SEVERITY WARNING;
           ELSE
              D_temp := Mem(V_location);
           END IF;
	
           FOR i in 0 TO Bits-1 LOOP
              IF (Mask(i) = '0') then
                D_temp(i) := Data(i);
              elsif (is_x(Mask(i)) AND (D_temp(i) /= Data(i)) ) then
                D_temp(i) := 'X';
              END IF;
           END LOOP;
                   
	   IF ( V_Location < Words) THEN	   
              Mem(V_Location) := D_temp;
	   END IF;
         END IF;  
    
END WriteCycleMaskBased;    

PROCEDURE ReadCycle (CONSTANT Address : IN std_logic_vector;
                     SIGNAL S_Q    : OUT std_logic_vector(Bits-1 DOWNTO 0)) IS

        VARIABLE V_Location : Natural;
        VARIABLE new_data   : std_logic_vector(Bits-1 DOWNTO 0);
            
        BEGIN
            
        IF(is_x(Address(0))) THEN
           IF(Corruption_Read_Violation) THEN
              ASSERT ((NOW = 0 ns) or (to_integer(debug_level) >= 2)) REPORT "(" & InstancePath & ")" &  " (MSG_ID 010 ) Illegal Value on Address Bus during Read Cycle. Memory and Output Corrupted " SEVERITY WARNING;
              mem := (OTHERS => (OTHERS => 'X')); 
           ELSE   
              ASSERT ((NOW = 0 ns) or (to_integer(debug_level) >= 2)) REPORT "(" & InstancePath & ")" &  " (MSG_ID 010 ) Illegal Value on Address Bus during Read Cycle. Output Corrupted " SEVERITY WARNING;
           END IF;   
	   S_Q <= TRANSPORT WordX AFTER 1 ns;
        ELSE
           V_Location := to_integer(Address);
           IF (V_Location >= Words) THEN
              ASSERT ((NOW = 0 ns) or (to_integer(debug_level) >= 2)) REPORT "(" & InstancePath & ")" &  " (MSG_ID 703 ) Address Out Of Range during Read Cycle. " SEVERITY WARNING;
	      S_Q <= TRANSPORT WordX AFTER 1 ns;
           ELSE
              new_data := MEM(V_Location);
              S_Q <= TRANSPORT new_data AFTER 1 ns;
           END IF;
        END IF;  
        
END ReadCycle;

        
PROCEDURE Read_WriteMaskBased (    SIGNAL CKint : IN std_logic;
                          CONSTANT CSNint  : IN std_logic;
                          CONSTANT  WENint : IN std_logic;
                          CONSTANT Aint    : IN std_logic_vector(Addr-1 DOWNTO 0);
                          CONSTANT Dint    : IN std_logic_vector(BITS-1 DOWNTO 0);
			  CONSTANT Mint    : IN std_logic_vector(BITS-1 DOWNTO 0);
                          SIGNAL Temp_Qint      : OUT std_logic_vector(BITS-1 DOWNTO 0)) IS 

         VARIABLE D_temp     : std_logic_vector(BITS-1 DOWNTO 0);
         VARIABLE prev_temp     : std_logic_vector(BITS-1 DOWNTO 0);
         VARIABLE V_location : NATURAL;
                          
         BEGIN 

                IF (WENint = '0' AND CSNint = '0') THEN
                    WriteCycleMaskBased( Address  => Aint,
                                         Data  => Dint,
			                 Mask => Mint);

	        ELSIF (WENint = '1' AND CSNint = '0') THEN
                    ReadCycle( Address  => Aint,
                              S_Q      => Temp_Qint);
 

                ELSIF (is_x(WENint) AND CSNint = '0') THEN
                    IF(is_x(Aint(0))) THEN
                        ASSERT ((NOW = 0 ns) or (to_integer(debug_level) >= 2)) REPORT "(" & InstancePath & ")" &  " (MSG_ID 009 ) Illegal Value on Address Bus during Write Cycle. Memory Corrupted " SEVERITY WARNING;
                        mem := (OTHERS => (OTHERS => 'X'));
                        Temp_Qint <= TRANSPORT WordX AFTER 1 ns;
                    ELSE   
                        V_location := to_integer(Aint); 
		        IF (V_Location >= Words) THEN
                           ASSERT ((NOW = 0 ns) or (to_integer(debug_level) >= 2)) REPORT "(" & InstancePath & ")" &  " (MSG_ID 702 ) Address Out Of Range during Write Cycle. " SEVERITY WARNING;
		           Temp_Qint <= TRANSPORT WordX AFTER 1 ns;
              	        ELSE
                           D_temp := Mem(V_location);
                           prev_temp := Mem(V_location);
                           --calculating data to write in memory
                           FOR i in 0 TO Bits-1 LOOP
                             IF (Mint(i) /= '1' AND (D_temp(i) /= Dint(i))) then
                               D_temp(i) := 'X';
                             END IF;
                           END LOOP;
                           
                           Mem(V_Location) := D_temp;

                           --calculating output
                           FOR i in 0 TO Bits-1 LOOP
                             IF (prev_temp(i) /= Qint(i)) then
                               Temp_Qint(i) <= 'X' AFTER 1 ns;
                             END IF;
                           END LOOP;

               	        END IF;
                    END IF;

                ELSIF (is_x(CSNint)) THEN 
                    Temp_Qint <= TRANSPORT WordX;
                    mem := (OTHERS => (OTHERS => 'X'));    
                END IF;
END Read_WriteMaskBased;



BEGIN 

--Display of messages at 0 time
IF(NOW = 0 ns AND NOT(isMessageDisplayed)) THEN
IF (debug_mode = "ALL_WARNING_MODE") THEN
  debug_level <= (Others => '0');
ELSIF (debug_mode = "NO_WARNING_MODE") THEN
  debug_level <= "10";  
END IF;
  IF(debug_mode = "ALL_WARNING_MODE" OR debug_mode = "BIST_WARNING_MODE") THEN
  isMessageDisplayed := TRUE;
  WRITE(INFO_LINE, InstancePath);
  WRITE(INFO_LINE, STRING'(" : INFORMATION"));
  WRITELINE(OUTPUT, INFO_LINE);

  WRITE(INFO_LINE, STRING'("*******************************"));
  WRITELINE(OUTPUT, INFO_LINE); 
  
  WRITE(INFO_LINE, STRING'("This is a purely FUNCTIONAL MODEL"));
  WRITELINE(OUTPUT, INFO_LINE);

  IF(debug_mode = "ALL_WARNING_MODE") THEN
    WRITE(INFO_LINE, STRING'("All Messages are Switched ON"));
  ELSIF(debug_mode = "BIST_WARNING_MODE") THEN
    WRITE(INFO_LINE, STRING'("Contention Related Messages are Switched OFF"));
  END IF;  
  WRITELINE(OUTPUT, INFO_LINE);

  IF(ConfigFault) THEN
    WRITE(INFO_LINE, STRING'("Configurable Fault Functionality is ON"));
  ELSE
    WRITE(INFO_LINE, STRING'("Configurable Fault Functionality is OFF"));
  END IF;
  WRITELINE(OUTPUT, INFO_LINE);

  WRITE(INFO_LINE, STRING'("*******************************"));
  WRITELINE(OUTPUT, INFO_LINE);
    
  END IF;
END IF;



--------------RAM INITIALIZATION------------
IF (NOW = 0 ns AND MEM_INITIALIZE = TRUE) THEN
   Mem := InitMem(InitFileName);
END IF;

-----------------------------------------------
-- CONFIGURABLE FAULT MODEL FUNCTIONALITY  ----
------------------------------------------------
if (ConfigFault)  then
   
IF (NOW = 0 ns) THEN
   FILE_OPEN(fileOpenStatus,FAULT_ADDRESS_FILE ,Fault_file_name, mode);
   IF ((fileOpenStatus = OPEN_OK OR fileOpenStatus = STATUS_ERROR) ) THEN
   IF (FILE_READ = TRUE) THEN
   READ_LOOP:WHILE not ENDFILE(FAULT_ADDRESS_FILE) loop
              READLINE(FAULT_ADDRESS_FILE,fault_line);
              READ(fault_line,fault_word);
              READ(fault_line,fault_bit);

        for k in bits-1 downto 0 loop
              if (k = fault_bit) then
                stuck0(k) := '0';
              else
                stuck0(k) := '1';
              end if;
            end loop;
            stuck_at_0fault(i) <= stuck0;      
       
        FailureLocn(i) <= fault_word;
        std_fault_word := CONV_STD_LOGIC_VECTOR(fault_word,Addr);
   i := i+1;
   END LOOP;
   FILE_READ := FALSE;
   END IF;
   ELSE --else of if(fileOpenStatus)
        ASSERT FALSE
        REPORT "Unable to read Fault File. No faults inserted"
        SEVERITY WARNING;
   END IF;
   fcnt <= i;
END IF;

for n in 0 to  fcnt-1 loop
fault_repair_flag(n) <= '0';
end loop;
       Fault_repaired_flag := TRUE;
       FOR j in 0 to fcnt-1 loop
                if (fault_repair_flag(j) /= '1') then
                        Fault_repaired_flag := FALSE;
                        Mem(FailureLocn(j)) := Mem(FailureLocn(j)) and (stuck_at_0fault(j));
                end if; 
       end loop;
 end if;


IF(CKint'EVENT AND CKint = '1' AND CKint'LAST_VALUE = '0') THEN
   PrevCSN := CSNint;
   WENreg := WENint;
END IF;
   IF(CKint'EVENT AND CKint = '1' AND CKint'LAST_VALUE = '0' AND CSNint /= '1') THEN 
   
    
      Read_WriteMaskBased(CKint, CSNint, WENint, Aint, Dint, Mint, Qint);
    
   ELSIF(CKint'EVENT AND (CKint = 'X' OR CKint = 'U') AND CKint'LAST_VALUE = '0' AND CSNint /= '1' ) THEN
      MEM := (OTHERS => (OTHERS=>'X'));
      --writing out 'X'
      Qint <= TRANSPORT (OTHERS => 'X') AFTER 1 ns;
   ELSIF (CKint'EVENT AND (CKint = 'X' OR CKint = 'U') AND  CKint'LAST_VALUE = '1' AND (CSNint /= '1' OR PrevCSN /= '1')) THEN
      Mem := (OTHERS => (OTHERS=> CKint));
      --writing out 'X'
      Qint <= TRANSPORT (OTHERS => 'X') AFTER 1 ns;
   END IF;
   IF(CSNint'EVENT AND CSNint /= '1' AND (CKint = 'X' OR CKint = 'U')) THEN
      Mem := (OTHERS => (OTHERS=> CKint));
      --writing out 'X'
      Qint <= TRANSPORT (OTHERS => 'X') AFTER 1 ns;
   END IF;


IF ( TBYPASSint'EVENT) THEN
   IF(TBYPASSint = '1') THEN
      Qint  <= TRANSPORT Dint;
      
   ELSIF (TBYPASSint /= '1') THEN
      Qint  <= TRANSPORT (OTHERS => 'X');
      
   END IF;   
END IF;        

IF(Dint'EVENT AND TBYPASSint = '1') THEN
   Qint  <= TRANSPORT Dint;
   
END IF;   

   



   



--RY FUNCTIONALITY

IF  (CKint'EVENT AND CKint = '1' AND CKint'LAST_VALUE = '0' AND CSNint /= '1' AND TBYPASSint = '0') THEN 
        IF ( CSNint = '0' ) THEN
                RYint  <= TRANSPORT '0' AFTER 1 ns;
        ELSE
                RYint  <= TRANSPORT CSNint;
        END IF;
ELSIF (CKint'EVENT AND (CKint = 'X' OR CKint = 'U') AND CKint'LAST_VALUE = '0' AND CSNint /= '1' ) THEN
        RYint <= TRANSPORT 'X';
ELSIF (CKint'EVENT AND (CKint = 'X' OR CKint = 'U') AND CKint'LAST_VALUE = '1' AND (CSNint /= '1' OR PrevCSN /= '1') ) THEN
        RYint <= TRANSPORT 'X';
ELSIF (CKint'EVENT AND CKint = '0' AND CKint'LAST_VALUE = '1' AND PrevCSN = '0' AND TBYPASSint = '0') THEN
        RYint <= TRANSPORT '1' AFTER 1 ns;
END IF;

IF (CSNint'EVENT AND CSNint /= '1' AND (CKint = 'X' OR CKint = 'U')) THEN
        RYint <= TRANSPORT 'X';
END IF;

IF(TBYPASSint'EVENT AND TBYPASSint /= '0') THEN
        RYint <= TRANSPORT 'X';
END IF;   
   


END PROCESS ReadWrite ;

---------- Functionality for output scheduling -----------

QProc : PROCESS (Qint)
BEGIN

    Q <= TRANSPORT Qint ;

END PROCESS QProc;   


RYProc : PROCESS (RYint)
BEGIN

    RY <= TRANSPORT RYint;

END PROCESS RYProc;

        
-- synopsys synthesis_on
        
END VHDL_FUNCT ;



 
CONFIGURATION Cfg_ST_SPHDL_128x32m8_L_VHDL_FUNCT OF ST_SPHDL_128x32m8_L IS
    FOR VHDL_FUNCT
    END FOR;
END Cfg_ST_SPHDL_128x32m8_L_VHDL_FUNCT;

CONFIGURATION Cfg_ST_SPHDL_128x32m8_L OF ST_SPHDL_128x32m8_L IS
    FOR VHDL_FUNCT
    END FOR;
END Cfg_ST_SPHDL_128x32m8_L;






------------------------------------------------------------------------------
--  Function         : Entity FOR VHDL funct model
--  Release Date     : Nov, 2006
--  Last Modified By : ZZ
--  Version          : 4.0
------------------------------------------------------------------------------

--------------------- START OF HEADER ---------------------------
-- This Header Gives Information about the parameters & options present in the Model

-- words = 4096
-- bits  = 32
-- mux   = 8 
-- 
-- 
-- 
-- 
-- 
----------------------END OF HEADER -------------------------------

LIBRARY IEEE;                   USE IEEE.STD_LOGIC_1164.ALL;
                                USE IEEE.STD_LOGIC_ARITH.ALL;
                                USE STD.TEXTIO.ALL;

ENTITY  ST_SPHDL_4096x32m8_L IS

--synopsys synthesis_off
    GENERIC (
        Words : Natural := 4096;
        Bits : Natural := 32;
        Addr : Natural := 12;
        mux : Natural := 8;


        ConfigFault : Boolean := FALSE;
        max_faults : Natural := 20;
        Fault_file_name : STRING := "./ST_SPHDL_4096x32m8_L_faults.txt";
        -- generics for Memory initialization
        MEM_INITIALIZE  : BOOLEAN := TRUE; -- FALSE
        BinaryInit      : INTEGER := 1; -- 0
        InitFileName    : STRING  := "./program.cde";
        Corruption_Read_Violation : BOOLEAN := TRUE;
        
        InstancePath : String := "./ST_SPHDL_4096x32m8_L";
        Debug_mode : String := "ALL_WARNING_MODE"
    );
--synopsys synthesis_on
    PORT (
        Q : OUT std_logic_vector(31 DOWNTO 0);
        RY : OUT std_logic;
        CK : IN std_logic;
        CSN : IN std_logic;
        TBYPASS : IN std_logic;
        WEN : IN std_logic;
        A : IN std_logic_vector(11 DOWNTO 0);
        D : IN std_logic_vector(31 DOWNTO 0)   
) ;    
END ST_SPHDL_4096x32m8_L;







LIBRARY IEEE;                   
   USE IEEE.STD_LOGIC_1164.ALL;
   USE IEEE.STD_LOGIC_ARITH.ALL;
   USE IEEE.STD_LOGIC_TEXTIO.ALL;
LIBRARY STD;
   USE STD.TEXTIO.ALL;
   USE STD.STANDARD.ALL;


ARCHITECTURE VHDL_FUNCT of ST_SPHDL_4096x32m8_L IS

--synopsys synthesis_off

-- list of input signals after filtering-----------
    SIGNAL Aint   : std_logic_vector(Addr-1 DOWNTO 0);
    SIGNAL Dint   : std_logic_vector(Bits-1 DOWNTO 0);
    SIGNAL Mint   : std_logic_vector(Bits-1 DOWNTO 0);
    SIGNAL CKint  : std_logic;
    SIGNAL CSNint : std_logic;
    SIGNAL CSNinternal : std_logic;
    SIGNAL WENint : std_logic;
    SIGNAL TBYPASSint  : std_logic;
    
    SIGNAL RYint  : std_logic := '1';
    
      

    SIGNAL Qint   : std_logic_vector(Bits-1 DOWNTO 0);
    




   
   SIGNAL fault_repair_flag : bit_vector(max_faults-1 DOWNTO 0) := (OTHERS => '1');
   SIGNAL fcnt : integer := 0;
   
   type stuckfault is array (Natural RANGE <>) of std_logic_vector(Bits-1 DOWNTO 0);
   SIGNAL stuck_at_0fault : stuckfault(max_faults-1 DOWNTO 0);
    
   type faultlocn is array (Natural RANGE <>) of integer;
   SIGNAL FailureLocn : faultlocn(0 to max_faults-1);
   SIGNAL debug_level : std_logic_vector(1 DOWNTO 0) := (OTHERS => '0');
--- AddrFilter puts all the bits of address bits TO 'X' or 'U' IF one of the bit is equal TO 'X' or 'U'--------------------------

    FUNCTION AddrFilter(Input : std_logic_vector) RETURN std_logic_vector IS
        VARIABLE UFound : Boolean := FALSE;
        VARIABLE Output : std_logic_vector(Input'RANGE);
    BEGIN
        FOR i IN Input'RANGE LOOP
            IF (Input(i) = 'U') THEN
                UFound := TRUE;
                EXIT;
            END IF;
        END LOOP;
        IF (UFound) THEN
            Output := (OTHERS => 'U');
        ELSIF (is_x(Input)) THEN
            Output := (OTHERS => 'X');
        ELSE
            Output := to_x01(Input);
        END IF;
        RETURN Output;
    END AddrFilter;

 function to_integer (oper : std_logic_vector) return integer is
      variable value     : integer := 0;
      variable temp_no   : integer := 1;
      variable temp_oper : std_logic_vector(oper'range) := oper;
      variable index     : integer := 1;
   begin
      ASSERT oper'length <= 31
      REPORT "argument is too large in to_integer, only lower 31 bits will be taken"
      SEVERITY WARNING;

      IF (not (is_X(oper))) then
         for I in temp_oper'reverse_range LOOP
            case (temp_oper(I)) is
               when '1' =>
                  value := value + temp_no;
               when others =>
                  null;
            END case;
            index := index + 1;
            exit when index > 31;
            temp_no := temp_no + temp_no;
         END LOOP;
      else
         ASSERT FALSE
         REPORT "WARNING: Illegal value detected in the conversion of to_integer"
         SEVERITY WARNING;

         value := 0;
      END IF;
      return (value);
   END to_integer;


--synopsys synthesis_on

BEGIN

--synopsys synthesis_off

  --------------------------------- Filter Block --------------------------- 
   Filter : BLOCK
        
        BEGIN
            Dint   <= to_ux01(D);
            CKint  <= to_ux01(CK);
            CSNinternal <= to_ux01(CSN);
            WENint <= to_ux01(WEN);
            TBYPASSint  <= to_ux01(TBYPASS);
            



	    Mint   <= (Others => '0');


            Aint <= AddrFilter(A);  -- IF one of the bits is equal TO 'X'
                                        -- or 'U' all bits are put TO this value

            
            CSNint <= (CSNinternal OR TBYPASSint );                            
        END BLOCK;
  

-------------------------------------------------------------------------------


ReadWrite : PROCESS (CKint, CSNint, TBYPASSint, Dint )

        SUBTYPE MType IS std_logic_vector(D'RANGE);
        TYPE MemType IS ARRAY (Natural RANGE <>) OF std_logic_vector(D'RANGE);
        VARIABLE Mem      : MemType(Words-1 DOWNTO 0);
        
        VARIABLE isMessageDisplayed : BOOLEAN := FALSE;
        
        CONSTANT WordX    : std_logic_vector(D'RANGE) := (OTHERS => 'X');
        CONSTANT WordU    : std_logic_vector(D'RANGE) := (OTHERS => 'U');
   
        file FAULT_ADDRESS_FILE : TEXT; 
        VARIABLE fileOpenStatus : FILE_OPEN_STATUS := NAME_ERROR;
        VARIABLE mode : FILE_OPEN_KIND := READ_MODE;
        VARIABLE FILE_READ : Boolean := TRUE; 

        variable i : integer := 0;
        variable k : integer := 0;
        VARIABLE mssgcnt : std_logic := 'X';
        VARIABLE fault_line : LINE;
        VARIABLE fault_word : integer := 0;
        VARIABLE fault_bit : integer := 0;
        VARIABLE std_fault_word : std_logic_vector(Addr-1 DOWNTO 0) := (OTHERS => '0');
        VARIABLE stuck0 : std_logic_vector(Bits-1 DOWNTO 0) := (OTHERS => '1');
        type faults is array (Natural RANGE <>) of integer;
        VARIABLE fault_row_add : faults(0 to max_faults-1);

        CONSTANT RepairFlag1 : bit_vector(max_faults-1 DOWNTO 0) := (OTHERS => '1');
        VARIABLE j : integer := 0;
        VARIABLE Fault_repaired_flag : Boolean := TRUE;

        VARIABLE FAULT_INFO_LINE : LINE;
        VARIABLE INFO_LINE : LINE;
        file OUTPUT: TEXT  open WRITE_MODE is "STD_OUTPUT";
        VARIABLE PrevCSN  : std_logic;
        VARIABLE WENreg  : std_logic;
        VARIABLE Q_last  : std_logic_vector(D'RANGE);
        VARIABLE RY_last : std_logic; 
        
    FUNCTION InitMem (FileName : String) RETURN MemType IS
 
       FILE     InitFile : Text ;
       VARIABLE InitLine : Line;
       VARIABLE Address : Natural;
       VARIABLE Value1 : MType;
       VARIABLE Value2 : MType;
       VARIABLE Contents : MemType(Words-1 DOWNTO 0);
       VARIABLE Good : Boolean;
       VARIABLE tmp: STD_ULOGIC_VECTOR(((((Bits-1)/4)+1)*4 - 1) DOWNTO 0);
       VARIABLE tmp1: STD_ULOGIC_VECTOR((Bits-1) DOWNTO 0);
       VARIABLE fileOpenStatus : FILE_OPEN_STATUS := NAME_ERROR;
       VARIABLE mode : FILE_OPEN_KIND := READ_MODE;


   BEGIN

       -- file format is:
       -- one <value> per line starting at <address>=0
       -- <value> is a std_logic_vector
       -- expressed according to parameter <Format>:
       -- BinaryInit = 1 means Binary (default)
       -- BinaryInit = 0 means Hexadecimal

       FILE_OPEN(fileOpenStatus,InitFile, InitFileName, mode);
       IF (fileOpenStatus = OPEN_OK OR fileOpenStatus = STATUS_ERROR) THEN
       Address := 0;
       ReadFile: WHILE (NOT ENDFILE(InitFile)) LOOP
           readline(InitFile, InitLine);
           Good := TRUE;
           CASE BinaryInit IS
               WHEN 1 =>
                   read(InitLine, Value2, Good);
               WHEN 0 =>
                   HREAD(InitLine, tmp, GOOD);
                   for j in 0 to bits-1 loop
                       tmp1(j) := tmp(j);
                   end loop;
                   Value1 := STD_LOGIC_VECTOR(tmp1);

               WHEN OTHERS =>
                   ASSERT FALSE  REPORT "(" & InstancePath & ")" &  "  RAM Initialization failed: bad format. " SEVERITY WARNING;
           END CASE;
           IF Good THEN
               IF (Address = Words) THEN
                        ASSERT FALSE REPORT "(" & InstancePath & ")" &  "  Too many data words in the personality file. " SEVERITY WARNING;
               END IF;
               CASE BinaryInit IS
                   WHEN 1 =>
                       Contents(Address) := Value2;
                   WHEN 0 =>
                       Contents(Address) := Value1;        -- (Q'left downto 0);
                   WHEN OTHERS =>
                       NULL;
               END CASE;
           ELSE
                ASSERT FALSE REPORT "(" & InstancePath & ")" &  "  RAM Initialization failed " SEVERITY WARNING;
           END IF;
           Address := Address+1;
       END LOOP ReadFile;

       IF (Address /= Words) THEN
           ASSERT FALSE REPORT "(" & InstancePath & ")" &  "  Words in the personality file less than that given by address bounds. " SEVERITY WARNING;
       END IF;
       ELSE --else of if(fileOpenStatus)
          ASSERT FALSE
          REPORT "Unable to read Code File. "
          SEVERITY WARNING;
       END IF; -- end of if(fileOpenStatus)
       RETURN Contents;
   END InitMem;
      
      -- HEX code file reading
 
      PROCEDURE Char2QuadBits(C: Character; RESULT: out Bit_Vector(3 downto 0); GOOD: out Boolean; ISSUE_ERROR: in Boolean) IS
      BEGIN
      CASE c IS
        WHEN '0' => RESULT :=  x"0"; good := TRUE;
        WHEN '1' => RESULT :=  x"1"; good := TRUE;
        WHEN '2' => RESULT :=  x"2"; good := TRUE;
        WHEN '3' => RESULT :=  x"3"; good := TRUE;
        WHEN '4' => RESULT :=  x"4"; good := TRUE;
        WHEN '5' => RESULT :=  x"5"; good := TRUE;
        WHEN '6' => RESULT :=  x"6"; good := TRUE;
        WHEN '7' => RESULT :=  x"7"; good := TRUE;
        WHEN '8' => RESULT :=  x"8"; good := TRUE;
        WHEN '9' => RESULT :=  x"9"; good := TRUE;
        WHEN 'A' => RESULT :=  x"A"; good := TRUE;
        WHEN 'B' => RESULT :=  x"B"; good := TRUE;
        WHEN 'C' => RESULT :=  x"C"; good := TRUE;
        WHEN 'D' => RESULT :=  x"D"; good := TRUE;
        WHEN 'E' => RESULT :=  x"E"; good := TRUE;
        WHEN 'F' => RESULT :=  x"F"; good := TRUE;

        WHEN 'a' => RESULT :=  x"A"; good := TRUE;
        WHEN 'b' => RESULT :=  x"B"; good := TRUE;
        WHEN 'c' => RESULT :=  x"C"; good := TRUE;
        WHEN 'd' => RESULT :=  x"D"; good := TRUE;
        WHEN 'e' => RESULT :=  x"E"; good := TRUE;
        WHEN 'f' => RESULT :=  x"F"; good := TRUE;
        WHEN others =>
          IF ISSUE_ERROR THEN
                ASSERT ((NOW = 0 ns) or (to_integer(debug_level) >= 2)) REPORT "(" & InstancePath & ")" &  " (MSG_ID 801 ) HREAD Error: Read a '" & c & "' , expected a Hex character (0-F). " SEVERITY WARNING;
          END IF;
              good := FALSE;
      END CASE;
   END Char2QuadBits;

   -- Reading Hex code file
   PROCEDURE HREAD(L:inout LINE; VALUE:out BIT_VECTOR;GOOD: out BOOLEAN) is
        VARIABLE ok: boolean;
        VARIABLE c:  character;
        CONSTANT ne: integer := (value'length-1)/4;
        VARIABLE bv: bit_vector(0 to value'length-1);
        VARIABLE s:  string(1 to ne);
    BEGIN
        LOOP                                    -- skip white space
           read(l,c);
           EXIT when ((c /= ' ') and (c /= CR) and (c /= HT));
        END LOOP;

        Char2QuadBits(c, bv(0 to 3), ok, TRUE);
        IF not ok THEN
           good := FALSE;
           RETURN;
        END IF;
        if ( ne >= 1) then
           read(L, s, ok);
           if not ok then
              good := FALSE;
              return;
           end if;
        end if;
   
        if value'length mod 4 /= 0 then
           for i in 1 to ne-1 loop
              Char2QuadBits(s(i), bv(4*i to 4*i+3), ok, TRUE);
              if not ok then
                 good := FALSE;
                 return;
              end if;
           end loop;
        else
           for i in 1 to ne loop
              Char2QuadBits(s(i), bv(4*i to 4*i+3), ok, TRUE);
              if not ok then
                 good := FALSE;
                 return;
              end if;
           end loop;
        end if;
        good := TRUE;
        value := bv;
    end HREAD;

PROCEDURE WriteCycleMaskBased (CONSTANT Address : IN std_logic_vector(Addr-1 DOWNTO 0);
                           CONSTANT Data : IN std_logic_vector(Bits-1 DOWNTO 0);
                           CONSTANT Mask : IN std_logic_vector(Bits-1 DOWNTO 0)) IS

     VARIABLE V_Location : Natural;
     VARIABLE D_temp     : std_logic_vector(Bits-1 DOWNTO 0);

     BEGIN
     
        IF(is_x(Address(0))) THEN
           ASSERT ((NOW = 0 ns) or (to_integer(debug_level) >= 2)) REPORT "(" & InstancePath & ")" &  " (MSG_ID 009 ) Illegal Value on Address Bus during Write Cycle. Memory Corrupted " SEVERITY WARNING;
           mem := (OTHERS => (OTHERS => 'X'));
        ELSE
           V_location := to_integer(Address); 
           IF (V_Location >= Words) THEN
              ASSERT ((NOW = 0 ns) or (to_integer(debug_level) >= 2)) REPORT "(" & InstancePath & ")" &  " (MSG_ID 702 ) Address Out Of Range during Write Cycle. " SEVERITY WARNING;
           ELSE
              D_temp := Mem(V_location);
           END IF;
	
           FOR i in 0 TO Bits-1 LOOP
              IF (Mask(i) = '0') then
                D_temp(i) := Data(i);
              elsif (is_x(Mask(i)) AND (D_temp(i) /= Data(i)) ) then
                D_temp(i) := 'X';
              END IF;
           END LOOP;
                   
	   IF ( V_Location < Words) THEN	   
              Mem(V_Location) := D_temp;
	   END IF;
         END IF;  
    
END WriteCycleMaskBased;    

PROCEDURE ReadCycle (CONSTANT Address : IN std_logic_vector;
                     SIGNAL S_Q    : OUT std_logic_vector(Bits-1 DOWNTO 0)) IS

        VARIABLE V_Location : Natural;
        VARIABLE new_data   : std_logic_vector(Bits-1 DOWNTO 0);
            
        BEGIN
            
        IF(is_x(Address(0))) THEN
           IF(Corruption_Read_Violation) THEN
              ASSERT ((NOW = 0 ns) or (to_integer(debug_level) >= 2)) REPORT "(" & InstancePath & ")" &  " (MSG_ID 010 ) Illegal Value on Address Bus during Read Cycle. Memory and Output Corrupted " SEVERITY WARNING;
              mem := (OTHERS => (OTHERS => 'X')); 
           ELSE   
              ASSERT ((NOW = 0 ns) or (to_integer(debug_level) >= 2)) REPORT "(" & InstancePath & ")" &  " (MSG_ID 010 ) Illegal Value on Address Bus during Read Cycle. Output Corrupted " SEVERITY WARNING;
           END IF;   
	   S_Q <= TRANSPORT WordX AFTER 1 ns;
        ELSE
           V_Location := to_integer(Address);
           IF (V_Location >= Words) THEN
              ASSERT ((NOW = 0 ns) or (to_integer(debug_level) >= 2)) REPORT "(" & InstancePath & ")" &  " (MSG_ID 703 ) Address Out Of Range during Read Cycle. " SEVERITY WARNING;
	      S_Q <= TRANSPORT WordX AFTER 1 ns;
           ELSE
              new_data := MEM(V_Location);
              S_Q <= TRANSPORT new_data AFTER 1 ns;
           END IF;
        END IF;  
        
END ReadCycle;

        
PROCEDURE Read_WriteMaskBased (    SIGNAL CKint : IN std_logic;
                          CONSTANT CSNint  : IN std_logic;
                          CONSTANT  WENint : IN std_logic;
                          CONSTANT Aint    : IN std_logic_vector(Addr-1 DOWNTO 0);
                          CONSTANT Dint    : IN std_logic_vector(BITS-1 DOWNTO 0);
			  CONSTANT Mint    : IN std_logic_vector(BITS-1 DOWNTO 0);
                          SIGNAL Temp_Qint      : OUT std_logic_vector(BITS-1 DOWNTO 0)) IS 

         VARIABLE D_temp     : std_logic_vector(BITS-1 DOWNTO 0);
         VARIABLE prev_temp     : std_logic_vector(BITS-1 DOWNTO 0);
         VARIABLE V_location : NATURAL;
                          
         BEGIN 

                IF (WENint = '0' AND CSNint = '0') THEN
                    WriteCycleMaskBased( Address  => Aint,
                                         Data  => Dint,
			                 Mask => Mint);

	        ELSIF (WENint = '1' AND CSNint = '0') THEN
                    ReadCycle( Address  => Aint,
                              S_Q      => Temp_Qint);
 

                ELSIF (is_x(WENint) AND CSNint = '0') THEN
                    IF(is_x(Aint(0))) THEN
                        ASSERT ((NOW = 0 ns) or (to_integer(debug_level) >= 2)) REPORT "(" & InstancePath & ")" &  " (MSG_ID 009 ) Illegal Value on Address Bus during Write Cycle. Memory Corrupted " SEVERITY WARNING;
                        mem := (OTHERS => (OTHERS => 'X'));
                        Temp_Qint <= TRANSPORT WordX AFTER 1 ns;
                    ELSE   
                        V_location := to_integer(Aint); 
		        IF (V_Location >= Words) THEN
                           ASSERT ((NOW = 0 ns) or (to_integer(debug_level) >= 2)) REPORT "(" & InstancePath & ")" &  " (MSG_ID 702 ) Address Out Of Range during Write Cycle. " SEVERITY WARNING;
		           Temp_Qint <= TRANSPORT WordX AFTER 1 ns;
              	        ELSE
                           D_temp := Mem(V_location);
                           prev_temp := Mem(V_location);
                           --calculating data to write in memory
                           FOR i in 0 TO Bits-1 LOOP
                             IF (Mint(i) /= '1' AND (D_temp(i) /= Dint(i))) then
                               D_temp(i) := 'X';
                             END IF;
                           END LOOP;
                           
                           Mem(V_Location) := D_temp;

                           --calculating output
                           FOR i in 0 TO Bits-1 LOOP
                             IF (prev_temp(i) /= Qint(i)) then
                               Temp_Qint(i) <= 'X' AFTER 1 ns;
                             END IF;
                           END LOOP;

               	        END IF;
                    END IF;

                ELSIF (is_x(CSNint)) THEN 
                    Temp_Qint <= TRANSPORT WordX;
                    mem := (OTHERS => (OTHERS => 'X'));    
                END IF;
END Read_WriteMaskBased;



BEGIN 

--Display of messages at 0 time
IF(NOW = 0 ns AND NOT(isMessageDisplayed)) THEN
IF (debug_mode = "ALL_WARNING_MODE") THEN
  debug_level <= (Others => '0');
ELSIF (debug_mode = "NO_WARNING_MODE") THEN
  debug_level <= "10";  
END IF;
  IF(debug_mode = "ALL_WARNING_MODE" OR debug_mode = "BIST_WARNING_MODE") THEN
  isMessageDisplayed := TRUE;
  WRITE(INFO_LINE, InstancePath);
  WRITE(INFO_LINE, STRING'(" : INFORMATION"));
  WRITELINE(OUTPUT, INFO_LINE);

  WRITE(INFO_LINE, STRING'("*******************************"));
  WRITELINE(OUTPUT, INFO_LINE); 
  
  WRITE(INFO_LINE, STRING'("This is a purely FUNCTIONAL MODEL"));
  WRITELINE(OUTPUT, INFO_LINE);

  IF(debug_mode = "ALL_WARNING_MODE") THEN
    WRITE(INFO_LINE, STRING'("All Messages are Switched ON"));
  ELSIF(debug_mode = "BIST_WARNING_MODE") THEN
    WRITE(INFO_LINE, STRING'("Contention Related Messages are Switched OFF"));
  END IF;  
  WRITELINE(OUTPUT, INFO_LINE);

  IF(ConfigFault) THEN
    WRITE(INFO_LINE, STRING'("Configurable Fault Functionality is ON"));
  ELSE
    WRITE(INFO_LINE, STRING'("Configurable Fault Functionality is OFF"));
  END IF;
  WRITELINE(OUTPUT, INFO_LINE);

  WRITE(INFO_LINE, STRING'("*******************************"));
  WRITELINE(OUTPUT, INFO_LINE);
    
  END IF;
END IF;



--------------RAM INITIALIZATION------------
IF (NOW = 0 ns AND MEM_INITIALIZE = TRUE) THEN
   Mem := InitMem(InitFileName);
END IF;

-----------------------------------------------
-- CONFIGURABLE FAULT MODEL FUNCTIONALITY  ----
------------------------------------------------
if (ConfigFault)  then
   
IF (NOW = 0 ns) THEN
   FILE_OPEN(fileOpenStatus,FAULT_ADDRESS_FILE ,Fault_file_name, mode);
   IF ((fileOpenStatus = OPEN_OK OR fileOpenStatus = STATUS_ERROR) ) THEN
   IF (FILE_READ = TRUE) THEN
   READ_LOOP:WHILE not ENDFILE(FAULT_ADDRESS_FILE) loop
              READLINE(FAULT_ADDRESS_FILE,fault_line);
              READ(fault_line,fault_word);
              READ(fault_line,fault_bit);

        for k in bits-1 downto 0 loop
              if (k = fault_bit) then
                stuck0(k) := '0';
              else
                stuck0(k) := '1';
              end if;
            end loop;
            stuck_at_0fault(i) <= stuck0;      
       
        FailureLocn(i) <= fault_word;
        std_fault_word := CONV_STD_LOGIC_VECTOR(fault_word,Addr);
   i := i+1;
   END LOOP;
   FILE_READ := FALSE;
   END IF;
   ELSE --else of if(fileOpenStatus)
        ASSERT FALSE
        REPORT "Unable to read Fault File. No faults inserted"
        SEVERITY WARNING;
   END IF;
   fcnt <= i;
END IF;

for n in 0 to  fcnt-1 loop
fault_repair_flag(n) <= '0';
end loop;
       Fault_repaired_flag := TRUE;
       FOR j in 0 to fcnt-1 loop
                if (fault_repair_flag(j) /= '1') then
                        Fault_repaired_flag := FALSE;
                        Mem(FailureLocn(j)) := Mem(FailureLocn(j)) and (stuck_at_0fault(j));
                end if; 
       end loop;
 end if;


IF(CKint'EVENT AND CKint = '1' AND CKint'LAST_VALUE = '0') THEN
   PrevCSN := CSNint;
   WENreg := WENint;
END IF;
   IF(CKint'EVENT AND CKint = '1' AND CKint'LAST_VALUE = '0' AND CSNint /= '1') THEN 
   
    
      Read_WriteMaskBased(CKint, CSNint, WENint, Aint, Dint, Mint, Qint);
    
   ELSIF(CKint'EVENT AND (CKint = 'X' OR CKint = 'U') AND CKint'LAST_VALUE = '0' AND CSNint /= '1' ) THEN
      MEM := (OTHERS => (OTHERS=>'X'));
      --writing out 'X'
      Qint <= TRANSPORT (OTHERS => 'X') AFTER 1 ns;
   ELSIF (CKint'EVENT AND (CKint = 'X' OR CKint = 'U') AND  CKint'LAST_VALUE = '1' AND (CSNint /= '1' OR PrevCSN /= '1')) THEN
      Mem := (OTHERS => (OTHERS=> CKint));
      --writing out 'X'
      Qint <= TRANSPORT (OTHERS => 'X') AFTER 1 ns;
   END IF;
   IF(CSNint'EVENT AND CSNint /= '1' AND (CKint = 'X' OR CKint = 'U')) THEN
      Mem := (OTHERS => (OTHERS=> CKint));
      --writing out 'X'
      Qint <= TRANSPORT (OTHERS => 'X') AFTER 1 ns;
   END IF;


IF ( TBYPASSint'EVENT) THEN
   IF(TBYPASSint = '1') THEN
      Qint  <= TRANSPORT Dint;
      
   ELSIF (TBYPASSint /= '1') THEN
      Qint  <= TRANSPORT (OTHERS => 'X');
      
   END IF;   
END IF;        

IF(Dint'EVENT AND TBYPASSint = '1') THEN
   Qint  <= TRANSPORT Dint;
   
END IF;   

   



   



--RY FUNCTIONALITY

IF  (CKint'EVENT AND CKint = '1' AND CKint'LAST_VALUE = '0' AND CSNint /= '1' AND TBYPASSint = '0') THEN 
        IF ( CSNint = '0' ) THEN
                RYint  <= TRANSPORT '0' AFTER 1 ns;
        ELSE
                RYint  <= TRANSPORT CSNint;
        END IF;
ELSIF (CKint'EVENT AND (CKint = 'X' OR CKint = 'U') AND CKint'LAST_VALUE = '0' AND CSNint /= '1' ) THEN
        RYint <= TRANSPORT 'X';
ELSIF (CKint'EVENT AND (CKint = 'X' OR CKint = 'U') AND CKint'LAST_VALUE = '1' AND (CSNint /= '1' OR PrevCSN /= '1') ) THEN
        RYint <= TRANSPORT 'X';
ELSIF (CKint'EVENT AND CKint = '0' AND CKint'LAST_VALUE = '1' AND PrevCSN = '0' AND TBYPASSint = '0') THEN
        RYint <= TRANSPORT '1' AFTER 1 ns;
END IF;

IF (CSNint'EVENT AND CSNint /= '1' AND (CKint = 'X' OR CKint = 'U')) THEN
        RYint <= TRANSPORT 'X';
END IF;

IF(TBYPASSint'EVENT AND TBYPASSint /= '0') THEN
        RYint <= TRANSPORT 'X';
END IF;   
   


END PROCESS ReadWrite ;

---------- Functionality for output scheduling -----------

QProc : PROCESS (Qint)
BEGIN

    Q <= TRANSPORT Qint ;

END PROCESS QProc;   


RYProc : PROCESS (RYint)
BEGIN

    RY <= TRANSPORT RYint;

END PROCESS RYProc;

        
-- synopsys synthesis_on
        
END VHDL_FUNCT ;



 
CONFIGURATION Cfg_ST_SPHDL_4096x32m8_L_VHDL_FUNCT OF ST_SPHDL_4096x32m8_L IS
    FOR VHDL_FUNCT
    END FOR;
END Cfg_ST_SPHDL_4096x32m8_L_VHDL_FUNCT;

CONFIGURATION Cfg_ST_SPHDL_4096x32m8_L OF ST_SPHDL_4096x32m8_L IS
    FOR VHDL_FUNCT
    END FOR;
END Cfg_ST_SPHDL_4096x32m8_L;






------------------------------------------------------------------------------
--  Function         : Entity FOR VHDL funct model
--  Release Date     : Nov, 2006
--  Last Modified By : ZZ
--  Version          : 4.0
------------------------------------------------------------------------------

--------------------- START OF HEADER ---------------------------
-- This Header Gives Information about the parameters & options present in the Model

-- words = 1024
-- bits  = 32
-- mux   = 8 
-- 
-- 
-- 
-- 
-- 
----------------------END OF HEADER -------------------------------

LIBRARY IEEE;                   USE IEEE.STD_LOGIC_1164.ALL;
                                USE IEEE.STD_LOGIC_ARITH.ALL;
                                USE STD.TEXTIO.ALL;

ENTITY  ST_SPHDL_1024x32m8_L IS

--synopsys synthesis_off
    GENERIC (
        Words : Natural := 1024;
        Bits : Natural := 32;
        Addr : Natural := 10;
        mux : Natural := 8;


        ConfigFault : Boolean := FALSE;
        max_faults : Natural := 20;
        Fault_file_name : STRING := "ST_SPHDL_1024x32m8_L_faults.txt";
        -- generics for Memory initialization
        MEM_INITIALIZE  : BOOLEAN := FALSE;
        BinaryInit      : INTEGER := 0;
        InitFileName    : STRING  := "ST_SPHDL_1024x32m8_L.cde";
        Corruption_Read_Violation : BOOLEAN := TRUE;
        
        InstancePath : String := "ST_SPHDL_1024x32m8_L";
        Debug_mode : String := "ALL_WARNING_MODE"
    );
--synopsys synthesis_on
    PORT (
        Q : OUT std_logic_vector(31 DOWNTO 0);
        RY : OUT std_logic;
        CK : IN std_logic;
        CSN : IN std_logic;
        TBYPASS : IN std_logic;
        WEN : IN std_logic;
        A : IN std_logic_vector(9 DOWNTO 0);
        D : IN std_logic_vector(31 DOWNTO 0)   
) ;    
END ST_SPHDL_1024x32m8_L;







LIBRARY IEEE;                   
   USE IEEE.STD_LOGIC_1164.ALL;
   USE IEEE.STD_LOGIC_ARITH.ALL;
   USE IEEE.STD_LOGIC_TEXTIO.ALL;
LIBRARY STD;
   USE STD.TEXTIO.ALL;
   USE STD.STANDARD.ALL;


ARCHITECTURE VHDL_FUNCT of ST_SPHDL_1024x32m8_L IS

--synopsys synthesis_off

-- list of input signals after filtering-----------
    SIGNAL Aint   : std_logic_vector(Addr-1 DOWNTO 0);
    SIGNAL Dint   : std_logic_vector(Bits-1 DOWNTO 0);
    SIGNAL Mint   : std_logic_vector(Bits-1 DOWNTO 0);
    SIGNAL CKint  : std_logic;
    SIGNAL CSNint : std_logic;
    SIGNAL CSNinternal : std_logic;
    SIGNAL WENint : std_logic;
    SIGNAL TBYPASSint  : std_logic;
    
    SIGNAL RYint  : std_logic := '1';
    
      

    SIGNAL Qint   : std_logic_vector(Bits-1 DOWNTO 0);
    




   
   SIGNAL fault_repair_flag : bit_vector(max_faults-1 DOWNTO 0) := (OTHERS => '1');
   SIGNAL fcnt : integer := 0;
   
   type stuckfault is array (Natural RANGE <>) of std_logic_vector(Bits-1 DOWNTO 0);
   SIGNAL stuck_at_0fault : stuckfault(max_faults-1 DOWNTO 0);
    
   type faultlocn is array (Natural RANGE <>) of integer;
   SIGNAL FailureLocn : faultlocn(0 to max_faults-1);
   SIGNAL debug_level : std_logic_vector(1 DOWNTO 0) := (OTHERS => '0');
--- AddrFilter puts all the bits of address bits TO 'X' or 'U' IF one of the bit is equal TO 'X' or 'U'--------------------------

    FUNCTION AddrFilter(Input : std_logic_vector) RETURN std_logic_vector IS
        VARIABLE UFound : Boolean := FALSE;
        VARIABLE Output : std_logic_vector(Input'RANGE);
    BEGIN
        FOR i IN Input'RANGE LOOP
            IF (Input(i) = 'U') THEN
                UFound := TRUE;
                EXIT;
            END IF;
        END LOOP;
        IF (UFound) THEN
            Output := (OTHERS => 'U');
        ELSIF (is_x(Input)) THEN
            Output := (OTHERS => 'X');
        ELSE
            Output := to_x01(Input);
        END IF;
        RETURN Output;
    END AddrFilter;

 function to_integer (oper : std_logic_vector) return integer is
      variable value     : integer := 0;
      variable temp_no   : integer := 1;
      variable temp_oper : std_logic_vector(oper'range) := oper;
      variable index     : integer := 1;
   begin
      ASSERT oper'length <= 31
      REPORT "argument is too large in to_integer, only lower 31 bits will be taken"
      SEVERITY WARNING;

      IF (not (is_X(oper))) then
         for I in temp_oper'reverse_range LOOP
            case (temp_oper(I)) is
               when '1' =>
                  value := value + temp_no;
               when others =>
                  null;
            END case;
            index := index + 1;
            exit when index > 31;
            temp_no := temp_no + temp_no;
         END LOOP;
      else
         ASSERT FALSE
         REPORT "WARNING: Illegal value detected in the conversion of to_integer"
         SEVERITY WARNING;

         value := 0;
      END IF;
      return (value);
   END to_integer;


--synopsys synthesis_on

BEGIN

--synopsys synthesis_off

  --------------------------------- Filter Block --------------------------- 
   Filter : BLOCK
        
        BEGIN
            Dint   <= to_ux01(D);
            CKint  <= to_ux01(CK);
            CSNinternal <= to_ux01(CSN);
            WENint <= to_ux01(WEN);
            TBYPASSint  <= to_ux01(TBYPASS);
            



	    Mint   <= (Others => '0');


            Aint <= AddrFilter(A);  -- IF one of the bits is equal TO 'X'
                                        -- or 'U' all bits are put TO this value

            
            CSNint <= (CSNinternal OR TBYPASSint );                            
        END BLOCK;
  

-------------------------------------------------------------------------------


ReadWrite : PROCESS (CKint, CSNint, TBYPASSint, Dint )

        SUBTYPE MType IS std_logic_vector(D'RANGE);
        TYPE MemType IS ARRAY (Natural RANGE <>) OF std_logic_vector(D'RANGE);
        VARIABLE Mem      : MemType(Words-1 DOWNTO 0);
        
        VARIABLE isMessageDisplayed : BOOLEAN := FALSE;
        
        CONSTANT WordX    : std_logic_vector(D'RANGE) := (OTHERS => 'X');
        CONSTANT WordU    : std_logic_vector(D'RANGE) := (OTHERS => 'U');
   
        file FAULT_ADDRESS_FILE : TEXT; 
        VARIABLE fileOpenStatus : FILE_OPEN_STATUS := NAME_ERROR;
        VARIABLE mode : FILE_OPEN_KIND := READ_MODE;
        VARIABLE FILE_READ : Boolean := TRUE; 

        variable i : integer := 0;
        variable k : integer := 0;
        VARIABLE mssgcnt : std_logic := 'X';
        VARIABLE fault_line : LINE;
        VARIABLE fault_word : integer := 0;
        VARIABLE fault_bit : integer := 0;
        VARIABLE std_fault_word : std_logic_vector(Addr-1 DOWNTO 0) := (OTHERS => '0');
        VARIABLE stuck0 : std_logic_vector(Bits-1 DOWNTO 0) := (OTHERS => '1');
        type faults is array (Natural RANGE <>) of integer;
        VARIABLE fault_row_add : faults(0 to max_faults-1);

        CONSTANT RepairFlag1 : bit_vector(max_faults-1 DOWNTO 0) := (OTHERS => '1');
        VARIABLE j : integer := 0;
        VARIABLE Fault_repaired_flag : Boolean := TRUE;

        VARIABLE FAULT_INFO_LINE : LINE;
        VARIABLE INFO_LINE : LINE;
        file OUTPUT: TEXT  open WRITE_MODE is "STD_OUTPUT";
        VARIABLE PrevCSN  : std_logic;
        VARIABLE WENreg  : std_logic;
        VARIABLE Q_last  : std_logic_vector(D'RANGE);
        VARIABLE RY_last : std_logic; 
        
    FUNCTION InitMem (FileName : String) RETURN MemType IS
 
       FILE     InitFile : Text ;
       VARIABLE InitLine : Line;
       VARIABLE Address : Natural;
       VARIABLE Value1 : MType;
       VARIABLE Value2 : MType;
       VARIABLE Contents : MemType(Words-1 DOWNTO 0);
       VARIABLE Good : Boolean;
       VARIABLE tmp: STD_ULOGIC_VECTOR(((((Bits-1)/4)+1)*4 - 1) DOWNTO 0);
       VARIABLE tmp1: STD_ULOGIC_VECTOR((Bits-1) DOWNTO 0);
       VARIABLE fileOpenStatus : FILE_OPEN_STATUS := NAME_ERROR;
       VARIABLE mode : FILE_OPEN_KIND := READ_MODE;


   BEGIN

       -- file format is:
       -- one <value> per line starting at <address>=0
       -- <value> is a std_logic_vector
       -- expressed according to parameter <Format>:
       -- BinaryInit = 1 means Binary (default)
       -- BinaryInit = 0 means Hexadecimal

       FILE_OPEN(fileOpenStatus,InitFile, InitFileName, mode);
       IF (fileOpenStatus = OPEN_OK OR fileOpenStatus = STATUS_ERROR) THEN
       Address := 0;
       ReadFile: WHILE (NOT ENDFILE(InitFile)) LOOP
           readline(InitFile, InitLine);
           Good := TRUE;
           CASE BinaryInit IS
               WHEN 1 =>
                   read(InitLine, Value2, Good);
               WHEN 0 =>
                   HREAD(InitLine, tmp, GOOD);
                   for j in 0 to bits-1 loop
                       tmp1(j) := tmp(j);
                   end loop;
                   Value1 := STD_LOGIC_VECTOR(tmp1);

               WHEN OTHERS =>
                   ASSERT FALSE  REPORT "(" & InstancePath & ")" &  "  RAM Initialization failed: bad format. " SEVERITY WARNING;
           END CASE;
           IF Good THEN
               IF (Address = Words) THEN
                        ASSERT FALSE REPORT "(" & InstancePath & ")" &  "  Too many data words in the personality file. " SEVERITY WARNING;
               END IF;
               CASE BinaryInit IS
                   WHEN 1 =>
                       Contents(Address) := Value2;
                   WHEN 0 =>
                       Contents(Address) := Value1;        -- (Q'left downto 0);
                   WHEN OTHERS =>
                       NULL;
               END CASE;
           ELSE
                ASSERT FALSE REPORT "(" & InstancePath & ")" &  "  RAM Initialization failed " SEVERITY WARNING;
           END IF;
           Address := Address+1;
       END LOOP ReadFile;

       IF (Address /= Words) THEN
           ASSERT FALSE REPORT "(" & InstancePath & ")" &  "  Words in the personality file less than that given by address bounds. " SEVERITY WARNING;
       END IF;
       ELSE --else of if(fileOpenStatus)
          ASSERT FALSE
          REPORT "Unable to read Code File. "
          SEVERITY WARNING;
       END IF; -- end of if(fileOpenStatus)
       RETURN Contents;
   END InitMem;
      
      -- HEX code file reading
 
      PROCEDURE Char2QuadBits(C: Character; RESULT: out Bit_Vector(3 downto 0); GOOD: out Boolean; ISSUE_ERROR: in Boolean) IS
      BEGIN
      CASE c IS
        WHEN '0' => RESULT :=  x"0"; good := TRUE;
        WHEN '1' => RESULT :=  x"1"; good := TRUE;
        WHEN '2' => RESULT :=  x"2"; good := TRUE;
        WHEN '3' => RESULT :=  x"3"; good := TRUE;
        WHEN '4' => RESULT :=  x"4"; good := TRUE;
        WHEN '5' => RESULT :=  x"5"; good := TRUE;
        WHEN '6' => RESULT :=  x"6"; good := TRUE;
        WHEN '7' => RESULT :=  x"7"; good := TRUE;
        WHEN '8' => RESULT :=  x"8"; good := TRUE;
        WHEN '9' => RESULT :=  x"9"; good := TRUE;
        WHEN 'A' => RESULT :=  x"A"; good := TRUE;
        WHEN 'B' => RESULT :=  x"B"; good := TRUE;
        WHEN 'C' => RESULT :=  x"C"; good := TRUE;
        WHEN 'D' => RESULT :=  x"D"; good := TRUE;
        WHEN 'E' => RESULT :=  x"E"; good := TRUE;
        WHEN 'F' => RESULT :=  x"F"; good := TRUE;

        WHEN 'a' => RESULT :=  x"A"; good := TRUE;
        WHEN 'b' => RESULT :=  x"B"; good := TRUE;
        WHEN 'c' => RESULT :=  x"C"; good := TRUE;
        WHEN 'd' => RESULT :=  x"D"; good := TRUE;
        WHEN 'e' => RESULT :=  x"E"; good := TRUE;
        WHEN 'f' => RESULT :=  x"F"; good := TRUE;
        WHEN others =>
          IF ISSUE_ERROR THEN
                ASSERT ((NOW = 0 ns) or (to_integer(debug_level) >= 2)) REPORT "(" & InstancePath & ")" &  " (MSG_ID 801 ) HREAD Error: Read a '" & c & "' , expected a Hex character (0-F). " SEVERITY WARNING;
          END IF;
              good := FALSE;
      END CASE;
   END Char2QuadBits;

   -- Reading Hex code file
   PROCEDURE HREAD(L:inout LINE; VALUE:out BIT_VECTOR;GOOD: out BOOLEAN) is
        VARIABLE ok: boolean;
        VARIABLE c:  character;
        CONSTANT ne: integer := (value'length-1)/4;
        VARIABLE bv: bit_vector(0 to value'length-1);
        VARIABLE s:  string(1 to ne);
    BEGIN
        LOOP                                    -- skip white space
           read(l,c);
           EXIT when ((c /= ' ') and (c /= CR) and (c /= HT));
        END LOOP;

        Char2QuadBits(c, bv(0 to 3), ok, TRUE);
        IF not ok THEN
           good := FALSE;
           RETURN;
        END IF;
        if ( ne >= 1) then
           read(L, s, ok);
           if not ok then
              good := FALSE;
              return;
           end if;
        end if;
   
        if value'length mod 4 /= 0 then
           for i in 1 to ne-1 loop
              Char2QuadBits(s(i), bv(4*i to 4*i+3), ok, TRUE);
              if not ok then
                 good := FALSE;
                 return;
              end if;
           end loop;
        else
           for i in 1 to ne loop
              Char2QuadBits(s(i), bv(4*i to 4*i+3), ok, TRUE);
              if not ok then
                 good := FALSE;
                 return;
              end if;
           end loop;
        end if;
        good := TRUE;
        value := bv;
    end HREAD;

PROCEDURE WriteCycleMaskBased (CONSTANT Address : IN std_logic_vector(Addr-1 DOWNTO 0);
                           CONSTANT Data : IN std_logic_vector(Bits-1 DOWNTO 0);
                           CONSTANT Mask : IN std_logic_vector(Bits-1 DOWNTO 0)) IS

     VARIABLE V_Location : Natural;
     VARIABLE D_temp     : std_logic_vector(Bits-1 DOWNTO 0);

     BEGIN
     
        IF(is_x(Address(0))) THEN
           ASSERT ((NOW = 0 ns) or (to_integer(debug_level) >= 2)) REPORT "(" & InstancePath & ")" &  " (MSG_ID 009 ) Illegal Value on Address Bus during Write Cycle. Memory Corrupted " SEVERITY WARNING;
           mem := (OTHERS => (OTHERS => 'X'));
        ELSE
           V_location := to_integer(Address); 
           IF (V_Location >= Words) THEN
              ASSERT ((NOW = 0 ns) or (to_integer(debug_level) >= 2)) REPORT "(" & InstancePath & ")" &  " (MSG_ID 702 ) Address Out Of Range during Write Cycle. " SEVERITY WARNING;
           ELSE
              D_temp := Mem(V_location);
           END IF;
	
           FOR i in 0 TO Bits-1 LOOP
              IF (Mask(i) = '0') then
                D_temp(i) := Data(i);
              elsif (is_x(Mask(i)) AND (D_temp(i) /= Data(i)) ) then
                D_temp(i) := 'X';
              END IF;
           END LOOP;
                   
	   IF ( V_Location < Words) THEN	   
              Mem(V_Location) := D_temp;
	   END IF;
         END IF;  
    
END WriteCycleMaskBased;    

PROCEDURE ReadCycle (CONSTANT Address : IN std_logic_vector;
                     SIGNAL S_Q    : OUT std_logic_vector(Bits-1 DOWNTO 0)) IS

        VARIABLE V_Location : Natural;
        VARIABLE new_data   : std_logic_vector(Bits-1 DOWNTO 0);
            
        BEGIN
            
        IF(is_x(Address(0))) THEN
           IF(Corruption_Read_Violation) THEN
              ASSERT ((NOW = 0 ns) or (to_integer(debug_level) >= 2)) REPORT "(" & InstancePath & ")" &  " (MSG_ID 010 ) Illegal Value on Address Bus during Read Cycle. Memory and Output Corrupted " SEVERITY WARNING;
              mem := (OTHERS => (OTHERS => 'X')); 
           ELSE   
              ASSERT ((NOW = 0 ns) or (to_integer(debug_level) >= 2)) REPORT "(" & InstancePath & ")" &  " (MSG_ID 010 ) Illegal Value on Address Bus during Read Cycle. Output Corrupted " SEVERITY WARNING;
           END IF;   
	   S_Q <= TRANSPORT WordX AFTER 1 ns;
        ELSE
           V_Location := to_integer(Address);
           IF (V_Location >= Words) THEN
              ASSERT ((NOW = 0 ns) or (to_integer(debug_level) >= 2)) REPORT "(" & InstancePath & ")" &  " (MSG_ID 703 ) Address Out Of Range during Read Cycle. " SEVERITY WARNING;
	      S_Q <= TRANSPORT WordX AFTER 1 ns;
           ELSE
              new_data := MEM(V_Location);
              S_Q <= TRANSPORT new_data AFTER 1 ns;
           END IF;
        END IF;  
        
END ReadCycle;

        
PROCEDURE Read_WriteMaskBased (    SIGNAL CKint : IN std_logic;
                          CONSTANT CSNint  : IN std_logic;
                          CONSTANT  WENint : IN std_logic;
                          CONSTANT Aint    : IN std_logic_vector(Addr-1 DOWNTO 0);
                          CONSTANT Dint    : IN std_logic_vector(BITS-1 DOWNTO 0);
			  CONSTANT Mint    : IN std_logic_vector(BITS-1 DOWNTO 0);
                          SIGNAL Temp_Qint      : OUT std_logic_vector(BITS-1 DOWNTO 0)) IS 

         VARIABLE D_temp     : std_logic_vector(BITS-1 DOWNTO 0);
         VARIABLE prev_temp     : std_logic_vector(BITS-1 DOWNTO 0);
         VARIABLE V_location : NATURAL;
                          
         BEGIN 

                IF (WENint = '0' AND CSNint = '0') THEN
                    WriteCycleMaskBased( Address  => Aint,
                                         Data  => Dint,
			                 Mask => Mint);

	        ELSIF (WENint = '1' AND CSNint = '0') THEN
                    ReadCycle( Address  => Aint,
                              S_Q      => Temp_Qint);
 

                ELSIF (is_x(WENint) AND CSNint = '0') THEN
                    IF(is_x(Aint(0))) THEN
                        ASSERT ((NOW = 0 ns) or (to_integer(debug_level) >= 2)) REPORT "(" & InstancePath & ")" &  " (MSG_ID 009 ) Illegal Value on Address Bus during Write Cycle. Memory Corrupted " SEVERITY WARNING;
                        mem := (OTHERS => (OTHERS => 'X'));
                        Temp_Qint <= TRANSPORT WordX AFTER 1 ns;
                    ELSE   
                        V_location := to_integer(Aint); 
		        IF (V_Location >= Words) THEN
                           ASSERT ((NOW = 0 ns) or (to_integer(debug_level) >= 2)) REPORT "(" & InstancePath & ")" &  " (MSG_ID 702 ) Address Out Of Range during Write Cycle. " SEVERITY WARNING;
		           Temp_Qint <= TRANSPORT WordX AFTER 1 ns;
              	        ELSE
                           D_temp := Mem(V_location);
                           prev_temp := Mem(V_location);
                           --calculating data to write in memory
                           FOR i in 0 TO Bits-1 LOOP
                             IF (Mint(i) /= '1' AND (D_temp(i) /= Dint(i))) then
                               D_temp(i) := 'X';
                             END IF;
                           END LOOP;
                           
                           Mem(V_Location) := D_temp;

                           --calculating output
                           FOR i in 0 TO Bits-1 LOOP
                             IF (prev_temp(i) /= Qint(i)) then
                               Temp_Qint(i) <= 'X' AFTER 1 ns;
                             END IF;
                           END LOOP;

               	        END IF;
                    END IF;

                ELSIF (is_x(CSNint)) THEN 
                    Temp_Qint <= TRANSPORT WordX;
                    mem := (OTHERS => (OTHERS => 'X'));    
                END IF;
END Read_WriteMaskBased;



BEGIN 

--Display of messages at 0 time
IF(NOW = 0 ns AND NOT(isMessageDisplayed)) THEN
IF (debug_mode = "ALL_WARNING_MODE") THEN
  debug_level <= (Others => '0');
ELSIF (debug_mode = "NO_WARNING_MODE") THEN
  debug_level <= "10";  
END IF;
  IF(debug_mode = "ALL_WARNING_MODE" OR debug_mode = "BIST_WARNING_MODE") THEN
  isMessageDisplayed := TRUE;
  WRITE(INFO_LINE, InstancePath);
  WRITE(INFO_LINE, STRING'(" : INFORMATION"));
  WRITELINE(OUTPUT, INFO_LINE);

  WRITE(INFO_LINE, STRING'("*******************************"));
  WRITELINE(OUTPUT, INFO_LINE); 
  
  WRITE(INFO_LINE, STRING'("This is a purely FUNCTIONAL MODEL"));
  WRITELINE(OUTPUT, INFO_LINE);

  IF(debug_mode = "ALL_WARNING_MODE") THEN
    WRITE(INFO_LINE, STRING'("All Messages are Switched ON"));
  ELSIF(debug_mode = "BIST_WARNING_MODE") THEN
    WRITE(INFO_LINE, STRING'("Contention Related Messages are Switched OFF"));
  END IF;  
  WRITELINE(OUTPUT, INFO_LINE);

  IF(ConfigFault) THEN
    WRITE(INFO_LINE, STRING'("Configurable Fault Functionality is ON"));
  ELSE
    WRITE(INFO_LINE, STRING'("Configurable Fault Functionality is OFF"));
  END IF;
  WRITELINE(OUTPUT, INFO_LINE);

  WRITE(INFO_LINE, STRING'("*******************************"));
  WRITELINE(OUTPUT, INFO_LINE);
    
  END IF;
END IF;



--------------RAM INITIALIZATION------------
IF (NOW = 0 ns AND MEM_INITIALIZE = TRUE) THEN
   Mem := InitMem(InitFileName);
END IF;

-----------------------------------------------
-- CONFIGURABLE FAULT MODEL FUNCTIONALITY  ----
------------------------------------------------
if (ConfigFault)  then
   
IF (NOW = 0 ns) THEN
   FILE_OPEN(fileOpenStatus,FAULT_ADDRESS_FILE ,Fault_file_name, mode);
   IF ((fileOpenStatus = OPEN_OK OR fileOpenStatus = STATUS_ERROR) ) THEN
   IF (FILE_READ = TRUE) THEN
   READ_LOOP:WHILE not ENDFILE(FAULT_ADDRESS_FILE) loop
              READLINE(FAULT_ADDRESS_FILE,fault_line);
              READ(fault_line,fault_word);
              READ(fault_line,fault_bit);

        for k in bits-1 downto 0 loop
              if (k = fault_bit) then
                stuck0(k) := '0';
              else
                stuck0(k) := '1';
              end if;
            end loop;
            stuck_at_0fault(i) <= stuck0;      
       
        FailureLocn(i) <= fault_word;
        std_fault_word := CONV_STD_LOGIC_VECTOR(fault_word,Addr);
   i := i+1;
   END LOOP;
   FILE_READ := FALSE;
   END IF;
   ELSE --else of if(fileOpenStatus)
        ASSERT FALSE
        REPORT "Unable to read Fault File. No faults inserted"
        SEVERITY WARNING;
   END IF;
   fcnt <= i;
END IF;

for n in 0 to  fcnt-1 loop
fault_repair_flag(n) <= '0';
end loop;
       Fault_repaired_flag := TRUE;
       FOR j in 0 to fcnt-1 loop
                if (fault_repair_flag(j) /= '1') then
                        Fault_repaired_flag := FALSE;
                        Mem(FailureLocn(j)) := Mem(FailureLocn(j)) and (stuck_at_0fault(j));
                end if; 
       end loop;
 end if;


IF(CKint'EVENT AND CKint = '1' AND CKint'LAST_VALUE = '0') THEN
   PrevCSN := CSNint;
   WENreg := WENint;
END IF;
   IF(CKint'EVENT AND CKint = '1' AND CKint'LAST_VALUE = '0' AND CSNint /= '1') THEN 
   
    
      Read_WriteMaskBased(CKint, CSNint, WENint, Aint, Dint, Mint, Qint);
    
   ELSIF(CKint'EVENT AND (CKint = 'X' OR CKint = 'U') AND CKint'LAST_VALUE = '0' AND CSNint /= '1' ) THEN
      MEM := (OTHERS => (OTHERS=>'X'));
      --writing out 'X'
      Qint <= TRANSPORT (OTHERS => 'X') AFTER 1 ns;
   ELSIF (CKint'EVENT AND (CKint = 'X' OR CKint = 'U') AND  CKint'LAST_VALUE = '1' AND (CSNint /= '1' OR PrevCSN /= '1')) THEN
      Mem := (OTHERS => (OTHERS=> CKint));
      --writing out 'X'
      Qint <= TRANSPORT (OTHERS => 'X') AFTER 1 ns;
   END IF;
   IF(CSNint'EVENT AND CSNint /= '1' AND (CKint = 'X' OR CKint = 'U')) THEN
      Mem := (OTHERS => (OTHERS=> CKint));
      --writing out 'X'
      Qint <= TRANSPORT (OTHERS => 'X') AFTER 1 ns;
   END IF;


IF ( TBYPASSint'EVENT) THEN
   IF(TBYPASSint = '1') THEN
      Qint  <= TRANSPORT Dint;
      
   ELSIF (TBYPASSint /= '1') THEN
      Qint  <= TRANSPORT (OTHERS => 'X');
      
   END IF;   
END IF;        

IF(Dint'EVENT AND TBYPASSint = '1') THEN
   Qint  <= TRANSPORT Dint;
   
END IF;   

   



   



--RY FUNCTIONALITY

IF  (CKint'EVENT AND CKint = '1' AND CKint'LAST_VALUE = '0' AND CSNint /= '1' AND TBYPASSint = '0') THEN 
        IF ( CSNint = '0' ) THEN
                RYint  <= TRANSPORT '0' AFTER 1 ns;
        ELSE
                RYint  <= TRANSPORT CSNint;
        END IF;
ELSIF (CKint'EVENT AND (CKint = 'X' OR CKint = 'U') AND CKint'LAST_VALUE = '0' AND CSNint /= '1' ) THEN
        RYint <= TRANSPORT 'X';
ELSIF (CKint'EVENT AND (CKint = 'X' OR CKint = 'U') AND CKint'LAST_VALUE = '1' AND (CSNint /= '1' OR PrevCSN /= '1') ) THEN
        RYint <= TRANSPORT 'X';
ELSIF (CKint'EVENT AND CKint = '0' AND CKint'LAST_VALUE = '1' AND PrevCSN = '0' AND TBYPASSint = '0') THEN
        RYint <= TRANSPORT '1' AFTER 1 ns;
END IF;

IF (CSNint'EVENT AND CSNint /= '1' AND (CKint = 'X' OR CKint = 'U')) THEN
        RYint <= TRANSPORT 'X';
END IF;

IF(TBYPASSint'EVENT AND TBYPASSint /= '0') THEN
        RYint <= TRANSPORT 'X';
END IF;   
   


END PROCESS ReadWrite ;

---------- Functionality for output scheduling -----------

QProc : PROCESS (Qint)
BEGIN

    Q <= TRANSPORT Qint ;

END PROCESS QProc;   


RYProc : PROCESS (RYint)
BEGIN

    RY <= TRANSPORT RYint;

END PROCESS RYProc;

        
-- synopsys synthesis_on
        
END VHDL_FUNCT ;



 
CONFIGURATION Cfg_ST_SPHDL_1024x32m8_L_VHDL_FUNCT OF ST_SPHDL_1024x32m8_L IS
    FOR VHDL_FUNCT
    END FOR;
END Cfg_ST_SPHDL_1024x32m8_L_VHDL_FUNCT;

CONFIGURATION Cfg_ST_SPHDL_1024x32m8_L OF ST_SPHDL_1024x32m8_L IS
    FOR VHDL_FUNCT
    END FOR;
END Cfg_ST_SPHDL_1024x32m8_L;






------------------------------------------------------------------------------
--  Function         : Entity FOR VHDL funct model
--  Release Date     : Nov, 2006
--  Last Modified By : ZZ
--  Version          : 4.0
------------------------------------------------------------------------------

--------------------- START OF HEADER ---------------------------
-- This Header Gives Information about the parameters & options present in the Model

-- words = 352
-- bits  = 12
-- mux   = 8 
-- 
-- 
-- 
-- 
-- 
----------------------END OF HEADER -------------------------------

LIBRARY IEEE;                   USE IEEE.STD_LOGIC_1164.ALL;
                                USE IEEE.STD_LOGIC_ARITH.ALL;
                                USE STD.TEXTIO.ALL;

ENTITY  ST_SPHDL_352x12m8_L IS

--synopsys synthesis_off
    GENERIC (
        Words : Natural := 352;
        Bits : Natural := 12;
        Addr : Natural := 9;
        mux : Natural := 8;


        ConfigFault : Boolean := FALSE;
        max_faults : Natural := 20;
        Fault_file_name : STRING := "ST_SPHDL_352x12m8_L_faults.txt";
        -- generics for Memory initialization
        MEM_INITIALIZE  : BOOLEAN := FALSE;
        BinaryInit      : INTEGER := 0;
        InitFileName    : STRING  := "ST_SPHDL_352x12m8_L.cde";
        Corruption_Read_Violation : BOOLEAN := TRUE;
        
        InstancePath : String := "ST_SPHDL_352x12m8_L";
        Debug_mode : String := "ALL_WARNING_MODE"
    );
--synopsys synthesis_on
    PORT (
        Q : OUT std_logic_vector(11 DOWNTO 0);
        RY : OUT std_logic;
        CK : IN std_logic;
        CSN : IN std_logic;
        TBYPASS : IN std_logic;
        WEN : IN std_logic;
        A : IN std_logic_vector(8 DOWNTO 0);
        D : IN std_logic_vector(11 DOWNTO 0)   
) ;    
END ST_SPHDL_352x12m8_L;







LIBRARY IEEE;                   
   USE IEEE.STD_LOGIC_1164.ALL;
   USE IEEE.STD_LOGIC_ARITH.ALL;
   USE IEEE.STD_LOGIC_TEXTIO.ALL;
LIBRARY STD;
   USE STD.TEXTIO.ALL;
   USE STD.STANDARD.ALL;


ARCHITECTURE VHDL_FUNCT of ST_SPHDL_352x12m8_L IS

--synopsys synthesis_off

-- list of input signals after filtering-----------
    SIGNAL Aint   : std_logic_vector(Addr-1 DOWNTO 0);
    SIGNAL Dint   : std_logic_vector(Bits-1 DOWNTO 0);
    SIGNAL Mint   : std_logic_vector(Bits-1 DOWNTO 0);
    SIGNAL CKint  : std_logic;
    SIGNAL CSNint : std_logic;
    SIGNAL CSNinternal : std_logic;
    SIGNAL WENint : std_logic;
    SIGNAL TBYPASSint  : std_logic;
    
    SIGNAL RYint  : std_logic := '1';
    
      

    SIGNAL Qint   : std_logic_vector(Bits-1 DOWNTO 0);
    




   
   SIGNAL fault_repair_flag : bit_vector(max_faults-1 DOWNTO 0) := (OTHERS => '1');
   SIGNAL fcnt : integer := 0;
   
   type stuckfault is array (Natural RANGE <>) of std_logic_vector(Bits-1 DOWNTO 0);
   SIGNAL stuck_at_0fault : stuckfault(max_faults-1 DOWNTO 0);
    
   type faultlocn is array (Natural RANGE <>) of integer;
   SIGNAL FailureLocn : faultlocn(0 to max_faults-1);
   SIGNAL debug_level : std_logic_vector(1 DOWNTO 0) := (OTHERS => '0');
--- AddrFilter puts all the bits of address bits TO 'X' or 'U' IF one of the bit is equal TO 'X' or 'U'--------------------------

    FUNCTION AddrFilter(Input : std_logic_vector) RETURN std_logic_vector IS
        VARIABLE UFound : Boolean := FALSE;
        VARIABLE Output : std_logic_vector(Input'RANGE);
    BEGIN
        FOR i IN Input'RANGE LOOP
            IF (Input(i) = 'U') THEN
                UFound := TRUE;
                EXIT;
            END IF;
        END LOOP;
        IF (UFound) THEN
            Output := (OTHERS => 'U');
        ELSIF (is_x(Input)) THEN
            Output := (OTHERS => 'X');
        ELSE
            Output := to_x01(Input);
        END IF;
        RETURN Output;
    END AddrFilter;

 function to_integer (oper : std_logic_vector) return integer is
      variable value     : integer := 0;
      variable temp_no   : integer := 1;
      variable temp_oper : std_logic_vector(oper'range) := oper;
      variable index     : integer := 1;
   begin
      ASSERT oper'length <= 31
      REPORT "argument is too large in to_integer, only lower 31 bits will be taken"
      SEVERITY WARNING;

      IF (not (is_X(oper))) then
         for I in temp_oper'reverse_range LOOP
            case (temp_oper(I)) is
               when '1' =>
                  value := value + temp_no;
               when others =>
                  null;
            END case;
            index := index + 1;
            exit when index > 31;
            temp_no := temp_no + temp_no;
         END LOOP;
      else
         ASSERT FALSE
         REPORT "WARNING: Illegal value detected in the conversion of to_integer"
         SEVERITY WARNING;

         value := 0;
      END IF;
      return (value);
   END to_integer;


--synopsys synthesis_on

BEGIN

--synopsys synthesis_off

  --------------------------------- Filter Block --------------------------- 
   Filter : BLOCK
        
        BEGIN
            Dint   <= to_ux01(D);
            CKint  <= to_ux01(CK);
            CSNinternal <= to_ux01(CSN);
            WENint <= to_ux01(WEN);
            TBYPASSint  <= to_ux01(TBYPASS);
            



	    Mint   <= (Others => '0');


            Aint <= AddrFilter(A);  -- IF one of the bits is equal TO 'X'
                                        -- or 'U' all bits are put TO this value

            
            CSNint <= (CSNinternal OR TBYPASSint );                            
        END BLOCK;
  

-------------------------------------------------------------------------------


ReadWrite : PROCESS (CKint, CSNint, TBYPASSint, Dint )

        SUBTYPE MType IS std_logic_vector(D'RANGE);
        TYPE MemType IS ARRAY (Natural RANGE <>) OF std_logic_vector(D'RANGE);
        VARIABLE Mem      : MemType(Words-1 DOWNTO 0);
        
        VARIABLE isMessageDisplayed : BOOLEAN := FALSE;
        
        CONSTANT WordX    : std_logic_vector(D'RANGE) := (OTHERS => 'X');
        CONSTANT WordU    : std_logic_vector(D'RANGE) := (OTHERS => 'U');
   
        file FAULT_ADDRESS_FILE : TEXT; 
        VARIABLE fileOpenStatus : FILE_OPEN_STATUS := NAME_ERROR;
        VARIABLE mode : FILE_OPEN_KIND := READ_MODE;
        VARIABLE FILE_READ : Boolean := TRUE; 

        variable i : integer := 0;
        variable k : integer := 0;
        VARIABLE mssgcnt : std_logic := 'X';
        VARIABLE fault_line : LINE;
        VARIABLE fault_word : integer := 0;
        VARIABLE fault_bit : integer := 0;
        VARIABLE std_fault_word : std_logic_vector(Addr-1 DOWNTO 0) := (OTHERS => '0');
        VARIABLE stuck0 : std_logic_vector(Bits-1 DOWNTO 0) := (OTHERS => '1');
        type faults is array (Natural RANGE <>) of integer;
        VARIABLE fault_row_add : faults(0 to max_faults-1);

        CONSTANT RepairFlag1 : bit_vector(max_faults-1 DOWNTO 0) := (OTHERS => '1');
        VARIABLE j : integer := 0;
        VARIABLE Fault_repaired_flag : Boolean := TRUE;

        VARIABLE FAULT_INFO_LINE : LINE;
        VARIABLE INFO_LINE : LINE;
        file OUTPUT: TEXT  open WRITE_MODE is "STD_OUTPUT";
        VARIABLE PrevCSN  : std_logic;
        VARIABLE WENreg  : std_logic;
        VARIABLE Q_last  : std_logic_vector(D'RANGE);
        VARIABLE RY_last : std_logic; 
        
    FUNCTION InitMem (FileName : String) RETURN MemType IS
 
       FILE     InitFile : Text ;
       VARIABLE InitLine : Line;
       VARIABLE Address : Natural;
       VARIABLE Value1 : MType;
       VARIABLE Value2 : MType;
       VARIABLE Contents : MemType(Words-1 DOWNTO 0);
       VARIABLE Good : Boolean;
       VARIABLE tmp: STD_ULOGIC_VECTOR(((((Bits-1)/4)+1)*4 - 1) DOWNTO 0);
       VARIABLE tmp1: STD_ULOGIC_VECTOR((Bits-1) DOWNTO 0);
       VARIABLE fileOpenStatus : FILE_OPEN_STATUS := NAME_ERROR;
       VARIABLE mode : FILE_OPEN_KIND := READ_MODE;


   BEGIN

       -- file format is:
       -- one <value> per line starting at <address>=0
       -- <value> is a std_logic_vector
       -- expressed according to parameter <Format>:
       -- BinaryInit = 1 means Binary (default)
       -- BinaryInit = 0 means Hexadecimal

       FILE_OPEN(fileOpenStatus,InitFile, InitFileName, mode);
       IF (fileOpenStatus = OPEN_OK OR fileOpenStatus = STATUS_ERROR) THEN
       Address := 0;
       ReadFile: WHILE (NOT ENDFILE(InitFile)) LOOP
           readline(InitFile, InitLine);
           Good := TRUE;
           CASE BinaryInit IS
               WHEN 1 =>
                   read(InitLine, Value2, Good);
               WHEN 0 =>
                   HREAD(InitLine, tmp, GOOD);
                   for j in 0 to bits-1 loop
                       tmp1(j) := tmp(j);
                   end loop;
                   Value1 := STD_LOGIC_VECTOR(tmp1);

               WHEN OTHERS =>
                   ASSERT FALSE  REPORT "(" & InstancePath & ")" &  "  RAM Initialization failed: bad format. " SEVERITY WARNING;
           END CASE;
           IF Good THEN
               IF (Address = Words) THEN
                        ASSERT FALSE REPORT "(" & InstancePath & ")" &  "  Too many data words in the personality file. " SEVERITY WARNING;
               END IF;
               CASE BinaryInit IS
                   WHEN 1 =>
                       Contents(Address) := Value2;
                   WHEN 0 =>
                       Contents(Address) := Value1;        -- (Q'left downto 0);
                   WHEN OTHERS =>
                       NULL;
               END CASE;
           ELSE
                ASSERT FALSE REPORT "(" & InstancePath & ")" &  "  RAM Initialization failed " SEVERITY WARNING;
           END IF;
           Address := Address+1;
       END LOOP ReadFile;

       IF (Address /= Words) THEN
           ASSERT FALSE REPORT "(" & InstancePath & ")" &  "  Words in the personality file less than that given by address bounds. " SEVERITY WARNING;
       END IF;
       ELSE --else of if(fileOpenStatus)
          ASSERT FALSE
          REPORT "Unable to read Code File. "
          SEVERITY WARNING;
       END IF; -- end of if(fileOpenStatus)
       RETURN Contents;
   END InitMem;
      
      -- HEX code file reading
 
      PROCEDURE Char2QuadBits(C: Character; RESULT: out Bit_Vector(3 downto 0); GOOD: out Boolean; ISSUE_ERROR: in Boolean) IS
      BEGIN
      CASE c IS
        WHEN '0' => RESULT :=  x"0"; good := TRUE;
        WHEN '1' => RESULT :=  x"1"; good := TRUE;
        WHEN '2' => RESULT :=  x"2"; good := TRUE;
        WHEN '3' => RESULT :=  x"3"; good := TRUE;
        WHEN '4' => RESULT :=  x"4"; good := TRUE;
        WHEN '5' => RESULT :=  x"5"; good := TRUE;
        WHEN '6' => RESULT :=  x"6"; good := TRUE;
        WHEN '7' => RESULT :=  x"7"; good := TRUE;
        WHEN '8' => RESULT :=  x"8"; good := TRUE;
        WHEN '9' => RESULT :=  x"9"; good := TRUE;
        WHEN 'A' => RESULT :=  x"A"; good := TRUE;
        WHEN 'B' => RESULT :=  x"B"; good := TRUE;
        WHEN 'C' => RESULT :=  x"C"; good := TRUE;
        WHEN 'D' => RESULT :=  x"D"; good := TRUE;
        WHEN 'E' => RESULT :=  x"E"; good := TRUE;
        WHEN 'F' => RESULT :=  x"F"; good := TRUE;

        WHEN 'a' => RESULT :=  x"A"; good := TRUE;
        WHEN 'b' => RESULT :=  x"B"; good := TRUE;
        WHEN 'c' => RESULT :=  x"C"; good := TRUE;
        WHEN 'd' => RESULT :=  x"D"; good := TRUE;
        WHEN 'e' => RESULT :=  x"E"; good := TRUE;
        WHEN 'f' => RESULT :=  x"F"; good := TRUE;
        WHEN others =>
          IF ISSUE_ERROR THEN
                ASSERT ((NOW = 0 ns) or (to_integer(debug_level) >= 2)) REPORT "(" & InstancePath & ")" &  " (MSG_ID 801 ) HREAD Error: Read a '" & c & "' , expected a Hex character (0-F). " SEVERITY WARNING;
          END IF;
              good := FALSE;
      END CASE;
   END Char2QuadBits;

   -- Reading Hex code file
   PROCEDURE HREAD(L:inout LINE; VALUE:out BIT_VECTOR;GOOD: out BOOLEAN) is
        VARIABLE ok: boolean;
        VARIABLE c:  character;
        CONSTANT ne: integer := (value'length-1)/4;
        VARIABLE bv: bit_vector(0 to value'length-1);
        VARIABLE s:  string(1 to ne);
    BEGIN
        LOOP                                    -- skip white space
           read(l,c);
           EXIT when ((c /= ' ') and (c /= CR) and (c /= HT));
        END LOOP;

        Char2QuadBits(c, bv(0 to 3), ok, TRUE);
        IF not ok THEN
           good := FALSE;
           RETURN;
        END IF;
        if ( ne >= 1) then
           read(L, s, ok);
           if not ok then
              good := FALSE;
              return;
           end if;
        end if;
   
        if value'length mod 4 /= 0 then
           for i in 1 to ne-1 loop
              Char2QuadBits(s(i), bv(4*i to 4*i+3), ok, TRUE);
              if not ok then
                 good := FALSE;
                 return;
              end if;
           end loop;
        else
           for i in 1 to ne loop
              Char2QuadBits(s(i), bv(4*i to 4*i+3), ok, TRUE);
              if not ok then
                 good := FALSE;
                 return;
              end if;
           end loop;
        end if;
        good := TRUE;
        value := bv;
    end HREAD;

PROCEDURE WriteCycleMaskBased (CONSTANT Address : IN std_logic_vector(Addr-1 DOWNTO 0);
                           CONSTANT Data : IN std_logic_vector(Bits-1 DOWNTO 0);
                           CONSTANT Mask : IN std_logic_vector(Bits-1 DOWNTO 0)) IS

     VARIABLE V_Location : Natural;
     VARIABLE D_temp     : std_logic_vector(Bits-1 DOWNTO 0);

     BEGIN
     
        IF(is_x(Address(0))) THEN
           ASSERT ((NOW = 0 ns) or (to_integer(debug_level) >= 2)) REPORT "(" & InstancePath & ")" &  " (MSG_ID 009 ) Illegal Value on Address Bus during Write Cycle. Memory Corrupted " SEVERITY WARNING;
           mem := (OTHERS => (OTHERS => 'X'));
        ELSE
           V_location := to_integer(Address); 
           IF (V_Location >= Words) THEN
              ASSERT ((NOW = 0 ns) or (to_integer(debug_level) >= 2)) REPORT "(" & InstancePath & ")" &  " (MSG_ID 702 ) Address Out Of Range during Write Cycle. " SEVERITY WARNING;
           ELSE
              D_temp := Mem(V_location);
           END IF;
	
           FOR i in 0 TO Bits-1 LOOP
              IF (Mask(i) = '0') then
                D_temp(i) := Data(i);
              elsif (is_x(Mask(i)) AND (D_temp(i) /= Data(i)) ) then
                D_temp(i) := 'X';
              END IF;
           END LOOP;
                   
	   IF ( V_Location < Words) THEN	   
              Mem(V_Location) := D_temp;
	   END IF;
         END IF;  
    
END WriteCycleMaskBased;    

PROCEDURE ReadCycle (CONSTANT Address : IN std_logic_vector;
                     SIGNAL S_Q    : OUT std_logic_vector(Bits-1 DOWNTO 0)) IS

        VARIABLE V_Location : Natural;
        VARIABLE new_data   : std_logic_vector(Bits-1 DOWNTO 0);
            
        BEGIN
            
        IF(is_x(Address(0))) THEN
           IF(Corruption_Read_Violation) THEN
              ASSERT ((NOW = 0 ns) or (to_integer(debug_level) >= 2)) REPORT "(" & InstancePath & ")" &  " (MSG_ID 010 ) Illegal Value on Address Bus during Read Cycle. Memory and Output Corrupted " SEVERITY WARNING;
              mem := (OTHERS => (OTHERS => 'X')); 
           ELSE   
              ASSERT ((NOW = 0 ns) or (to_integer(debug_level) >= 2)) REPORT "(" & InstancePath & ")" &  " (MSG_ID 010 ) Illegal Value on Address Bus during Read Cycle. Output Corrupted " SEVERITY WARNING;
           END IF;   
	   S_Q <= TRANSPORT WordX AFTER 1 ns;
        ELSE
           V_Location := to_integer(Address);
           IF (V_Location >= Words) THEN
              ASSERT ((NOW = 0 ns) or (to_integer(debug_level) >= 2)) REPORT "(" & InstancePath & ")" &  " (MSG_ID 703 ) Address Out Of Range during Read Cycle. " SEVERITY WARNING;
	      S_Q <= TRANSPORT WordX AFTER 1 ns;
           ELSE
              new_data := MEM(V_Location);
              S_Q <= TRANSPORT new_data AFTER 1 ns;
           END IF;
        END IF;  
        
END ReadCycle;

        
PROCEDURE Read_WriteMaskBased (    SIGNAL CKint : IN std_logic;
                          CONSTANT CSNint  : IN std_logic;
                          CONSTANT  WENint : IN std_logic;
                          CONSTANT Aint    : IN std_logic_vector(Addr-1 DOWNTO 0);
                          CONSTANT Dint    : IN std_logic_vector(BITS-1 DOWNTO 0);
			  CONSTANT Mint    : IN std_logic_vector(BITS-1 DOWNTO 0);
                          SIGNAL Temp_Qint      : OUT std_logic_vector(BITS-1 DOWNTO 0)) IS 

         VARIABLE D_temp     : std_logic_vector(BITS-1 DOWNTO 0);
         VARIABLE prev_temp     : std_logic_vector(BITS-1 DOWNTO 0);
         VARIABLE V_location : NATURAL;
                          
         BEGIN 

                IF (WENint = '0' AND CSNint = '0') THEN
                    WriteCycleMaskBased( Address  => Aint,
                                         Data  => Dint,
			                 Mask => Mint);

	        ELSIF (WENint = '1' AND CSNint = '0') THEN
                    ReadCycle( Address  => Aint,
                              S_Q      => Temp_Qint);
 

                ELSIF (is_x(WENint) AND CSNint = '0') THEN
                    IF(is_x(Aint(0))) THEN
                        ASSERT ((NOW = 0 ns) or (to_integer(debug_level) >= 2)) REPORT "(" & InstancePath & ")" &  " (MSG_ID 009 ) Illegal Value on Address Bus during Write Cycle. Memory Corrupted " SEVERITY WARNING;
                        mem := (OTHERS => (OTHERS => 'X'));
                        Temp_Qint <= TRANSPORT WordX AFTER 1 ns;
                    ELSE   
                        V_location := to_integer(Aint); 
		        IF (V_Location >= Words) THEN
                           ASSERT ((NOW = 0 ns) or (to_integer(debug_level) >= 2)) REPORT "(" & InstancePath & ")" &  " (MSG_ID 702 ) Address Out Of Range during Write Cycle. " SEVERITY WARNING;
		           Temp_Qint <= TRANSPORT WordX AFTER 1 ns;
              	        ELSE
                           D_temp := Mem(V_location);
                           prev_temp := Mem(V_location);
                           --calculating data to write in memory
                           FOR i in 0 TO Bits-1 LOOP
                             IF (Mint(i) /= '1' AND (D_temp(i) /= Dint(i))) then
                               D_temp(i) := 'X';
                             END IF;
                           END LOOP;
                           
                           Mem(V_Location) := D_temp;

                           --calculating output
                           FOR i in 0 TO Bits-1 LOOP
                             IF (prev_temp(i) /= Qint(i)) then
                               Temp_Qint(i) <= 'X' AFTER 1 ns;
                             END IF;
                           END LOOP;

               	        END IF;
                    END IF;

                ELSIF (is_x(CSNint)) THEN 
                    Temp_Qint <= TRANSPORT WordX;
                    mem := (OTHERS => (OTHERS => 'X'));    
                END IF;
END Read_WriteMaskBased;



BEGIN 

--Display of messages at 0 time
IF(NOW = 0 ns AND NOT(isMessageDisplayed)) THEN
IF (debug_mode = "ALL_WARNING_MODE") THEN
  debug_level <= (Others => '0');
ELSIF (debug_mode = "NO_WARNING_MODE") THEN
  debug_level <= "10";  
END IF;
  IF(debug_mode = "ALL_WARNING_MODE" OR debug_mode = "BIST_WARNING_MODE") THEN
  isMessageDisplayed := TRUE;
  WRITE(INFO_LINE, InstancePath);
  WRITE(INFO_LINE, STRING'(" : INFORMATION"));
  WRITELINE(OUTPUT, INFO_LINE);

  WRITE(INFO_LINE, STRING'("*******************************"));
  WRITELINE(OUTPUT, INFO_LINE); 
  
  WRITE(INFO_LINE, STRING'("This is a purely FUNCTIONAL MODEL"));
  WRITELINE(OUTPUT, INFO_LINE);

  IF(debug_mode = "ALL_WARNING_MODE") THEN
    WRITE(INFO_LINE, STRING'("All Messages are Switched ON"));
  ELSIF(debug_mode = "BIST_WARNING_MODE") THEN
    WRITE(INFO_LINE, STRING'("Contention Related Messages are Switched OFF"));
  END IF;  
  WRITELINE(OUTPUT, INFO_LINE);

  IF(ConfigFault) THEN
    WRITE(INFO_LINE, STRING'("Configurable Fault Functionality is ON"));
  ELSE
    WRITE(INFO_LINE, STRING'("Configurable Fault Functionality is OFF"));
  END IF;
  WRITELINE(OUTPUT, INFO_LINE);

  WRITE(INFO_LINE, STRING'("*******************************"));
  WRITELINE(OUTPUT, INFO_LINE);
    
  END IF;
END IF;



--------------RAM INITIALIZATION------------
IF (NOW = 0 ns AND MEM_INITIALIZE = TRUE) THEN
   Mem := InitMem(InitFileName);
END IF;

-----------------------------------------------
-- CONFIGURABLE FAULT MODEL FUNCTIONALITY  ----
------------------------------------------------
if (ConfigFault)  then
   
IF (NOW = 0 ns) THEN
   FILE_OPEN(fileOpenStatus,FAULT_ADDRESS_FILE ,Fault_file_name, mode);
   IF ((fileOpenStatus = OPEN_OK OR fileOpenStatus = STATUS_ERROR) ) THEN
   IF (FILE_READ = TRUE) THEN
   READ_LOOP:WHILE not ENDFILE(FAULT_ADDRESS_FILE) loop
              READLINE(FAULT_ADDRESS_FILE,fault_line);
              READ(fault_line,fault_word);
              READ(fault_line,fault_bit);

        for k in bits-1 downto 0 loop
              if (k = fault_bit) then
                stuck0(k) := '0';
              else
                stuck0(k) := '1';
              end if;
            end loop;
            stuck_at_0fault(i) <= stuck0;      
       
        FailureLocn(i) <= fault_word;
        std_fault_word := CONV_STD_LOGIC_VECTOR(fault_word,Addr);
   i := i+1;
   END LOOP;
   FILE_READ := FALSE;
   END IF;
   ELSE --else of if(fileOpenStatus)
        ASSERT FALSE
        REPORT "Unable to read Fault File. No faults inserted"
        SEVERITY WARNING;
   END IF;
   fcnt <= i;
END IF;

for n in 0 to  fcnt-1 loop
fault_repair_flag(n) <= '0';
end loop;
       Fault_repaired_flag := TRUE;
       FOR j in 0 to fcnt-1 loop
                if (fault_repair_flag(j) /= '1') then
                        Fault_repaired_flag := FALSE;
                        Mem(FailureLocn(j)) := Mem(FailureLocn(j)) and (stuck_at_0fault(j));
                end if; 
       end loop;
 end if;


IF(CKint'EVENT AND CKint = '1' AND CKint'LAST_VALUE = '0') THEN
   PrevCSN := CSNint;
   WENreg := WENint;
END IF;
   IF(CKint'EVENT AND CKint = '1' AND CKint'LAST_VALUE = '0' AND CSNint /= '1') THEN 
   
    
      Read_WriteMaskBased(CKint, CSNint, WENint, Aint, Dint, Mint, Qint);
    
   ELSIF(CKint'EVENT AND (CKint = 'X' OR CKint = 'U') AND CKint'LAST_VALUE = '0' AND CSNint /= '1' ) THEN
      MEM := (OTHERS => (OTHERS=>'X'));
      --writing out 'X'
      Qint <= TRANSPORT (OTHERS => 'X') AFTER 1 ns;
   ELSIF (CKint'EVENT AND (CKint = 'X' OR CKint = 'U') AND  CKint'LAST_VALUE = '1' AND (CSNint /= '1' OR PrevCSN /= '1')) THEN
      Mem := (OTHERS => (OTHERS=> CKint));
      --writing out 'X'
      Qint <= TRANSPORT (OTHERS => 'X') AFTER 1 ns;
   END IF;
   IF(CSNint'EVENT AND CSNint /= '1' AND (CKint = 'X' OR CKint = 'U')) THEN
      Mem := (OTHERS => (OTHERS=> CKint));
      --writing out 'X'
      Qint <= TRANSPORT (OTHERS => 'X') AFTER 1 ns;
   END IF;


IF ( TBYPASSint'EVENT) THEN
   IF(TBYPASSint = '1') THEN
      Qint  <= TRANSPORT Dint;
      
   ELSIF (TBYPASSint /= '1') THEN
      Qint  <= TRANSPORT (OTHERS => 'X');
      
   END IF;   
END IF;        

IF(Dint'EVENT AND TBYPASSint = '1') THEN
   Qint  <= TRANSPORT Dint;
   
END IF;   

   



   



--RY FUNCTIONALITY

IF  (CKint'EVENT AND CKint = '1' AND CKint'LAST_VALUE = '0' AND CSNint /= '1' AND TBYPASSint = '0') THEN 
        IF ( CSNint = '0' ) THEN
                RYint  <= TRANSPORT '0' AFTER 1 ns;
        ELSE
                RYint  <= TRANSPORT CSNint;
        END IF;
ELSIF (CKint'EVENT AND (CKint = 'X' OR CKint = 'U') AND CKint'LAST_VALUE = '0' AND CSNint /= '1' ) THEN
        RYint <= TRANSPORT 'X';
ELSIF (CKint'EVENT AND (CKint = 'X' OR CKint = 'U') AND CKint'LAST_VALUE = '1' AND (CSNint /= '1' OR PrevCSN /= '1') ) THEN
        RYint <= TRANSPORT 'X';
ELSIF (CKint'EVENT AND CKint = '0' AND CKint'LAST_VALUE = '1' AND PrevCSN = '0' AND TBYPASSint = '0') THEN
        RYint <= TRANSPORT '1' AFTER 1 ns;
END IF;

IF (CSNint'EVENT AND CSNint /= '1' AND (CKint = 'X' OR CKint = 'U')) THEN
        RYint <= TRANSPORT 'X';
END IF;

IF(TBYPASSint'EVENT AND TBYPASSint /= '0') THEN
        RYint <= TRANSPORT 'X';
END IF;   
   


END PROCESS ReadWrite ;

---------- Functionality for output scheduling -----------

QProc : PROCESS (Qint)
BEGIN

    Q <= TRANSPORT Qint ;

END PROCESS QProc;   


RYProc : PROCESS (RYint)
BEGIN

    RY <= TRANSPORT RYint;

END PROCESS RYProc;

        
-- synopsys synthesis_on
        
END VHDL_FUNCT ;



 
CONFIGURATION Cfg_ST_SPHDL_352x12m8_L_VHDL_FUNCT OF ST_SPHDL_352x12m8_L IS
    FOR VHDL_FUNCT
    END FOR;
END Cfg_ST_SPHDL_352x12m8_L_VHDL_FUNCT;

CONFIGURATION Cfg_ST_SPHDL_352x12m8_L OF ST_SPHDL_352x12m8_L IS
    FOR VHDL_FUNCT
    END FOR;
END Cfg_ST_SPHDL_352x12m8_L;






------------------------------------------------------------------------------
--  Function         : Entity FOR VHDL funct model
--  Release Date     : Nov, 2006
--  Last Modified By : ZZ
--  Version          : 4.0
------------------------------------------------------------------------------

--------------------- START OF HEADER ---------------------------
-- This Header Gives Information about the parameters & options present in the Model

-- words = 1024
-- bits  = 40
-- mux   = 8 
-- 
-- 
-- 
-- 
-- 
----------------------END OF HEADER -------------------------------

LIBRARY IEEE;                   USE IEEE.STD_LOGIC_1164.ALL;
                                USE IEEE.STD_LOGIC_ARITH.ALL;
                                USE STD.TEXTIO.ALL;

ENTITY  ST_SPHDL_1024x40m8_L IS

--synopsys synthesis_off
    GENERIC (
        Words : Natural := 1024;
        Bits : Natural := 40;
        Addr : Natural := 10;
        mux : Natural := 8;


        ConfigFault : Boolean := FALSE;
        max_faults : Natural := 20;
        Fault_file_name : STRING := "ST_SPHDL_1024x40m8_L_faults.txt";
        -- generics for Memory initialization
        MEM_INITIALIZE  : BOOLEAN := FALSE;
        BinaryInit      : INTEGER := 0;
        InitFileName    : STRING  := "ST_SPHDL_1024x40m8_L.cde";
        Corruption_Read_Violation : BOOLEAN := TRUE;
        
        InstancePath : String := "ST_SPHDL_1024x40m8_L";
        Debug_mode : String := "ALL_WARNING_MODE"
    );
--synopsys synthesis_on
    PORT (
        Q : OUT std_logic_vector(39 DOWNTO 0);
        RY : OUT std_logic;
        CK : IN std_logic;
        CSN : IN std_logic;
        TBYPASS : IN std_logic;
        WEN : IN std_logic;
        A : IN std_logic_vector(9 DOWNTO 0);
        D : IN std_logic_vector(39 DOWNTO 0)   
) ;    
END ST_SPHDL_1024x40m8_L;







LIBRARY IEEE;                   
   USE IEEE.STD_LOGIC_1164.ALL;
   USE IEEE.STD_LOGIC_ARITH.ALL;
   USE IEEE.STD_LOGIC_TEXTIO.ALL;
LIBRARY STD;
   USE STD.TEXTIO.ALL;
   USE STD.STANDARD.ALL;


ARCHITECTURE VHDL_FUNCT of ST_SPHDL_1024x40m8_L IS

--synopsys synthesis_off

-- list of input signals after filtering-----------
    SIGNAL Aint   : std_logic_vector(Addr-1 DOWNTO 0);
    SIGNAL Dint   : std_logic_vector(Bits-1 DOWNTO 0);
    SIGNAL Mint   : std_logic_vector(Bits-1 DOWNTO 0);
    SIGNAL CKint  : std_logic;
    SIGNAL CSNint : std_logic;
    SIGNAL CSNinternal : std_logic;
    SIGNAL WENint : std_logic;
    SIGNAL TBYPASSint  : std_logic;
    
    SIGNAL RYint  : std_logic := '1';
    
      

    SIGNAL Qint   : std_logic_vector(Bits-1 DOWNTO 0);
    




   
   SIGNAL fault_repair_flag : bit_vector(max_faults-1 DOWNTO 0) := (OTHERS => '1');
   SIGNAL fcnt : integer := 0;
   
   type stuckfault is array (Natural RANGE <>) of std_logic_vector(Bits-1 DOWNTO 0);
   SIGNAL stuck_at_0fault : stuckfault(max_faults-1 DOWNTO 0);
    
   type faultlocn is array (Natural RANGE <>) of integer;
   SIGNAL FailureLocn : faultlocn(0 to max_faults-1);
   SIGNAL debug_level : std_logic_vector(1 DOWNTO 0) := (OTHERS => '0');
--- AddrFilter puts all the bits of address bits TO 'X' or 'U' IF one of the bit is equal TO 'X' or 'U'--------------------------

    FUNCTION AddrFilter(Input : std_logic_vector) RETURN std_logic_vector IS
        VARIABLE UFound : Boolean := FALSE;
        VARIABLE Output : std_logic_vector(Input'RANGE);
    BEGIN
        FOR i IN Input'RANGE LOOP
            IF (Input(i) = 'U') THEN
                UFound := TRUE;
                EXIT;
            END IF;
        END LOOP;
        IF (UFound) THEN
            Output := (OTHERS => 'U');
        ELSIF (is_x(Input)) THEN
            Output := (OTHERS => 'X');
        ELSE
            Output := to_x01(Input);
        END IF;
        RETURN Output;
    END AddrFilter;

 function to_integer (oper : std_logic_vector) return integer is
      variable value     : integer := 0;
      variable temp_no   : integer := 1;
      variable temp_oper : std_logic_vector(oper'range) := oper;
      variable index     : integer := 1;
   begin
      ASSERT oper'length <= 31
      REPORT "argument is too large in to_integer, only lower 31 bits will be taken"
      SEVERITY WARNING;

      IF (not (is_X(oper))) then
         for I in temp_oper'reverse_range LOOP
            case (temp_oper(I)) is
               when '1' =>
                  value := value + temp_no;
               when others =>
                  null;
            END case;
            index := index + 1;
            exit when index > 31;
            temp_no := temp_no + temp_no;
         END LOOP;
      else
         ASSERT FALSE
         REPORT "WARNING: Illegal value detected in the conversion of to_integer"
         SEVERITY WARNING;

         value := 0;
      END IF;
      return (value);
   END to_integer;


--synopsys synthesis_on

BEGIN

--synopsys synthesis_off

  --------------------------------- Filter Block --------------------------- 
   Filter : BLOCK
        
        BEGIN
            Dint   <= to_ux01(D);
            CKint  <= to_ux01(CK);
            CSNinternal <= to_ux01(CSN);
            WENint <= to_ux01(WEN);
            TBYPASSint  <= to_ux01(TBYPASS);
            



	    Mint   <= (Others => '0');


            Aint <= AddrFilter(A);  -- IF one of the bits is equal TO 'X'
                                        -- or 'U' all bits are put TO this value

            
            CSNint <= (CSNinternal OR TBYPASSint );                            
        END BLOCK;
  

-------------------------------------------------------------------------------


ReadWrite : PROCESS (CKint, CSNint, TBYPASSint, Dint )

        SUBTYPE MType IS std_logic_vector(D'RANGE);
        TYPE MemType IS ARRAY (Natural RANGE <>) OF std_logic_vector(D'RANGE);
        VARIABLE Mem      : MemType(Words-1 DOWNTO 0);
        
        VARIABLE isMessageDisplayed : BOOLEAN := FALSE;
        
        CONSTANT WordX    : std_logic_vector(D'RANGE) := (OTHERS => 'X');
        CONSTANT WordU    : std_logic_vector(D'RANGE) := (OTHERS => 'U');
   
        file FAULT_ADDRESS_FILE : TEXT; 
        VARIABLE fileOpenStatus : FILE_OPEN_STATUS := NAME_ERROR;
        VARIABLE mode : FILE_OPEN_KIND := READ_MODE;
        VARIABLE FILE_READ : Boolean := TRUE; 

        variable i : integer := 0;
        variable k : integer := 0;
        VARIABLE mssgcnt : std_logic := 'X';
        VARIABLE fault_line : LINE;
        VARIABLE fault_word : integer := 0;
        VARIABLE fault_bit : integer := 0;
        VARIABLE std_fault_word : std_logic_vector(Addr-1 DOWNTO 0) := (OTHERS => '0');
        VARIABLE stuck0 : std_logic_vector(Bits-1 DOWNTO 0) := (OTHERS => '1');
        type faults is array (Natural RANGE <>) of integer;
        VARIABLE fault_row_add : faults(0 to max_faults-1);

        CONSTANT RepairFlag1 : bit_vector(max_faults-1 DOWNTO 0) := (OTHERS => '1');
        VARIABLE j : integer := 0;
        VARIABLE Fault_repaired_flag : Boolean := TRUE;

        VARIABLE FAULT_INFO_LINE : LINE;
        VARIABLE INFO_LINE : LINE;
        file OUTPUT: TEXT  open WRITE_MODE is "STD_OUTPUT";
        VARIABLE PrevCSN  : std_logic;
        VARIABLE WENreg  : std_logic;
        VARIABLE Q_last  : std_logic_vector(D'RANGE);
        VARIABLE RY_last : std_logic; 
        
    FUNCTION InitMem (FileName : String) RETURN MemType IS
 
       FILE     InitFile : Text ;
       VARIABLE InitLine : Line;
       VARIABLE Address : Natural;
       VARIABLE Value1 : MType;
       VARIABLE Value2 : MType;
       VARIABLE Contents : MemType(Words-1 DOWNTO 0);
       VARIABLE Good : Boolean;
       VARIABLE tmp: STD_ULOGIC_VECTOR(((((Bits-1)/4)+1)*4 - 1) DOWNTO 0);
       VARIABLE tmp1: STD_ULOGIC_VECTOR((Bits-1) DOWNTO 0);
       VARIABLE fileOpenStatus : FILE_OPEN_STATUS := NAME_ERROR;
       VARIABLE mode : FILE_OPEN_KIND := READ_MODE;


   BEGIN

       -- file format is:
       -- one <value> per line starting at <address>=0
       -- <value> is a std_logic_vector
       -- expressed according to parameter <Format>:
       -- BinaryInit = 1 means Binary (default)
       -- BinaryInit = 0 means Hexadecimal

       FILE_OPEN(fileOpenStatus,InitFile, InitFileName, mode);
       IF (fileOpenStatus = OPEN_OK OR fileOpenStatus = STATUS_ERROR) THEN
       Address := 0;
       ReadFile: WHILE (NOT ENDFILE(InitFile)) LOOP
           readline(InitFile, InitLine);
           Good := TRUE;
           CASE BinaryInit IS
               WHEN 1 =>
                   read(InitLine, Value2, Good);
               WHEN 0 =>
                   HREAD(InitLine, tmp, GOOD);
                   for j in 0 to bits-1 loop
                       tmp1(j) := tmp(j);
                   end loop;
                   Value1 := STD_LOGIC_VECTOR(tmp1);

               WHEN OTHERS =>
                   ASSERT FALSE  REPORT "(" & InstancePath & ")" &  "  RAM Initialization failed: bad format. " SEVERITY WARNING;
           END CASE;
           IF Good THEN
               IF (Address = Words) THEN
                        ASSERT FALSE REPORT "(" & InstancePath & ")" &  "  Too many data words in the personality file. " SEVERITY WARNING;
               END IF;
               CASE BinaryInit IS
                   WHEN 1 =>
                       Contents(Address) := Value2;
                   WHEN 0 =>
                       Contents(Address) := Value1;        -- (Q'left downto 0);
                   WHEN OTHERS =>
                       NULL;
               END CASE;
           ELSE
                ASSERT FALSE REPORT "(" & InstancePath & ")" &  "  RAM Initialization failed " SEVERITY WARNING;
           END IF;
           Address := Address+1;
       END LOOP ReadFile;

       IF (Address /= Words) THEN
           ASSERT FALSE REPORT "(" & InstancePath & ")" &  "  Words in the personality file less than that given by address bounds. " SEVERITY WARNING;
       END IF;
       ELSE --else of if(fileOpenStatus)
          ASSERT FALSE
          REPORT "Unable to read Code File. "
          SEVERITY WARNING;
       END IF; -- end of if(fileOpenStatus)
       RETURN Contents;
   END InitMem;
      
      -- HEX code file reading
 
      PROCEDURE Char2QuadBits(C: Character; RESULT: out Bit_Vector(3 downto 0); GOOD: out Boolean; ISSUE_ERROR: in Boolean) IS
      BEGIN
      CASE c IS
        WHEN '0' => RESULT :=  x"0"; good := TRUE;
        WHEN '1' => RESULT :=  x"1"; good := TRUE;
        WHEN '2' => RESULT :=  x"2"; good := TRUE;
        WHEN '3' => RESULT :=  x"3"; good := TRUE;
        WHEN '4' => RESULT :=  x"4"; good := TRUE;
        WHEN '5' => RESULT :=  x"5"; good := TRUE;
        WHEN '6' => RESULT :=  x"6"; good := TRUE;
        WHEN '7' => RESULT :=  x"7"; good := TRUE;
        WHEN '8' => RESULT :=  x"8"; good := TRUE;
        WHEN '9' => RESULT :=  x"9"; good := TRUE;
        WHEN 'A' => RESULT :=  x"A"; good := TRUE;
        WHEN 'B' => RESULT :=  x"B"; good := TRUE;
        WHEN 'C' => RESULT :=  x"C"; good := TRUE;
        WHEN 'D' => RESULT :=  x"D"; good := TRUE;
        WHEN 'E' => RESULT :=  x"E"; good := TRUE;
        WHEN 'F' => RESULT :=  x"F"; good := TRUE;

        WHEN 'a' => RESULT :=  x"A"; good := TRUE;
        WHEN 'b' => RESULT :=  x"B"; good := TRUE;
        WHEN 'c' => RESULT :=  x"C"; good := TRUE;
        WHEN 'd' => RESULT :=  x"D"; good := TRUE;
        WHEN 'e' => RESULT :=  x"E"; good := TRUE;
        WHEN 'f' => RESULT :=  x"F"; good := TRUE;
        WHEN others =>
          IF ISSUE_ERROR THEN
                ASSERT ((NOW = 0 ns) or (to_integer(debug_level) >= 2)) REPORT "(" & InstancePath & ")" &  " (MSG_ID 801 ) HREAD Error: Read a '" & c & "' , expected a Hex character (0-F). " SEVERITY WARNING;
          END IF;
              good := FALSE;
      END CASE;
   END Char2QuadBits;

   -- Reading Hex code file
   PROCEDURE HREAD(L:inout LINE; VALUE:out BIT_VECTOR;GOOD: out BOOLEAN) is
        VARIABLE ok: boolean;
        VARIABLE c:  character;
        CONSTANT ne: integer := (value'length-1)/4;
        VARIABLE bv: bit_vector(0 to value'length-1);
        VARIABLE s:  string(1 to ne);
    BEGIN
        LOOP                                    -- skip white space
           read(l,c);
           EXIT when ((c /= ' ') and (c /= CR) and (c /= HT));
        END LOOP;

        Char2QuadBits(c, bv(0 to 3), ok, TRUE);
        IF not ok THEN
           good := FALSE;
           RETURN;
        END IF;
        if ( ne >= 1) then
           read(L, s, ok);
           if not ok then
              good := FALSE;
              return;
           end if;
        end if;
   
        if value'length mod 4 /= 0 then
           for i in 1 to ne-1 loop
              Char2QuadBits(s(i), bv(4*i to 4*i+3), ok, TRUE);
              if not ok then
                 good := FALSE;
                 return;
              end if;
           end loop;
        else
           for i in 1 to ne loop
              Char2QuadBits(s(i), bv(4*i to 4*i+3), ok, TRUE);
              if not ok then
                 good := FALSE;
                 return;
              end if;
           end loop;
        end if;
        good := TRUE;
        value := bv;
    end HREAD;

PROCEDURE WriteCycleMaskBased (CONSTANT Address : IN std_logic_vector(Addr-1 DOWNTO 0);
                           CONSTANT Data : IN std_logic_vector(Bits-1 DOWNTO 0);
                           CONSTANT Mask : IN std_logic_vector(Bits-1 DOWNTO 0)) IS

     VARIABLE V_Location : Natural;
     VARIABLE D_temp     : std_logic_vector(Bits-1 DOWNTO 0);

     BEGIN
     
        IF(is_x(Address(0))) THEN
           ASSERT ((NOW = 0 ns) or (to_integer(debug_level) >= 2)) REPORT "(" & InstancePath & ")" &  " (MSG_ID 009 ) Illegal Value on Address Bus during Write Cycle. Memory Corrupted " SEVERITY WARNING;
           mem := (OTHERS => (OTHERS => 'X'));
        ELSE
           V_location := to_integer(Address); 
           IF (V_Location >= Words) THEN
              ASSERT ((NOW = 0 ns) or (to_integer(debug_level) >= 2)) REPORT "(" & InstancePath & ")" &  " (MSG_ID 702 ) Address Out Of Range during Write Cycle. " SEVERITY WARNING;
           ELSE
              D_temp := Mem(V_location);
           END IF;
	
           FOR i in 0 TO Bits-1 LOOP
              IF (Mask(i) = '0') then
                D_temp(i) := Data(i);
              elsif (is_x(Mask(i)) AND (D_temp(i) /= Data(i)) ) then
                D_temp(i) := 'X';
              END IF;
           END LOOP;
                   
	   IF ( V_Location < Words) THEN	   
              Mem(V_Location) := D_temp;
	   END IF;
         END IF;  
    
END WriteCycleMaskBased;    

PROCEDURE ReadCycle (CONSTANT Address : IN std_logic_vector;
                     SIGNAL S_Q    : OUT std_logic_vector(Bits-1 DOWNTO 0)) IS

        VARIABLE V_Location : Natural;
        VARIABLE new_data   : std_logic_vector(Bits-1 DOWNTO 0);
            
        BEGIN
            
        IF(is_x(Address(0))) THEN
           IF(Corruption_Read_Violation) THEN
              ASSERT ((NOW = 0 ns) or (to_integer(debug_level) >= 2)) REPORT "(" & InstancePath & ")" &  " (MSG_ID 010 ) Illegal Value on Address Bus during Read Cycle. Memory and Output Corrupted " SEVERITY WARNING;
              mem := (OTHERS => (OTHERS => 'X')); 
           ELSE   
              ASSERT ((NOW = 0 ns) or (to_integer(debug_level) >= 2)) REPORT "(" & InstancePath & ")" &  " (MSG_ID 010 ) Illegal Value on Address Bus during Read Cycle. Output Corrupted " SEVERITY WARNING;
           END IF;   
	   S_Q <= TRANSPORT WordX AFTER 1 ns;
        ELSE
           V_Location := to_integer(Address);
           IF (V_Location >= Words) THEN
              ASSERT ((NOW = 0 ns) or (to_integer(debug_level) >= 2)) REPORT "(" & InstancePath & ")" &  " (MSG_ID 703 ) Address Out Of Range during Read Cycle. " SEVERITY WARNING;
	      S_Q <= TRANSPORT WordX AFTER 1 ns;
           ELSE
              new_data := MEM(V_Location);
              S_Q <= TRANSPORT new_data AFTER 1 ns;
           END IF;
        END IF;  
        
END ReadCycle;

        
PROCEDURE Read_WriteMaskBased (    SIGNAL CKint : IN std_logic;
                          CONSTANT CSNint  : IN std_logic;
                          CONSTANT  WENint : IN std_logic;
                          CONSTANT Aint    : IN std_logic_vector(Addr-1 DOWNTO 0);
                          CONSTANT Dint    : IN std_logic_vector(BITS-1 DOWNTO 0);
			  CONSTANT Mint    : IN std_logic_vector(BITS-1 DOWNTO 0);
                          SIGNAL Temp_Qint      : OUT std_logic_vector(BITS-1 DOWNTO 0)) IS 

         VARIABLE D_temp     : std_logic_vector(BITS-1 DOWNTO 0);
         VARIABLE prev_temp     : std_logic_vector(BITS-1 DOWNTO 0);
         VARIABLE V_location : NATURAL;
                          
         BEGIN 

                IF (WENint = '0' AND CSNint = '0') THEN
                    WriteCycleMaskBased( Address  => Aint,
                                         Data  => Dint,
			                 Mask => Mint);

	        ELSIF (WENint = '1' AND CSNint = '0') THEN
                    ReadCycle( Address  => Aint,
                              S_Q      => Temp_Qint);
 

                ELSIF (is_x(WENint) AND CSNint = '0') THEN
                    IF(is_x(Aint(0))) THEN
                        ASSERT ((NOW = 0 ns) or (to_integer(debug_level) >= 2)) REPORT "(" & InstancePath & ")" &  " (MSG_ID 009 ) Illegal Value on Address Bus during Write Cycle. Memory Corrupted " SEVERITY WARNING;
                        mem := (OTHERS => (OTHERS => 'X'));
                        Temp_Qint <= TRANSPORT WordX AFTER 1 ns;
                    ELSE   
                        V_location := to_integer(Aint); 
		        IF (V_Location >= Words) THEN
                           ASSERT ((NOW = 0 ns) or (to_integer(debug_level) >= 2)) REPORT "(" & InstancePath & ")" &  " (MSG_ID 702 ) Address Out Of Range during Write Cycle. " SEVERITY WARNING;
		           Temp_Qint <= TRANSPORT WordX AFTER 1 ns;
              	        ELSE
                           D_temp := Mem(V_location);
                           prev_temp := Mem(V_location);
                           --calculating data to write in memory
                           FOR i in 0 TO Bits-1 LOOP
                             IF (Mint(i) /= '1' AND (D_temp(i) /= Dint(i))) then
                               D_temp(i) := 'X';
                             END IF;
                           END LOOP;
                           
                           Mem(V_Location) := D_temp;

                           --calculating output
                           FOR i in 0 TO Bits-1 LOOP
                             IF (prev_temp(i) /= Qint(i)) then
                               Temp_Qint(i) <= 'X' AFTER 1 ns;
                             END IF;
                           END LOOP;

               	        END IF;
                    END IF;

                ELSIF (is_x(CSNint)) THEN 
                    Temp_Qint <= TRANSPORT WordX;
                    mem := (OTHERS => (OTHERS => 'X'));    
                END IF;
END Read_WriteMaskBased;



BEGIN 

--Display of messages at 0 time
IF(NOW = 0 ns AND NOT(isMessageDisplayed)) THEN
IF (debug_mode = "ALL_WARNING_MODE") THEN
  debug_level <= (Others => '0');
ELSIF (debug_mode = "NO_WARNING_MODE") THEN
  debug_level <= "10";  
END IF;
  IF(debug_mode = "ALL_WARNING_MODE" OR debug_mode = "BIST_WARNING_MODE") THEN
  isMessageDisplayed := TRUE;
  WRITE(INFO_LINE, InstancePath);
  WRITE(INFO_LINE, STRING'(" : INFORMATION"));
  WRITELINE(OUTPUT, INFO_LINE);

  WRITE(INFO_LINE, STRING'("*******************************"));
  WRITELINE(OUTPUT, INFO_LINE); 
  
  WRITE(INFO_LINE, STRING'("This is a purely FUNCTIONAL MODEL"));
  WRITELINE(OUTPUT, INFO_LINE);

  IF(debug_mode = "ALL_WARNING_MODE") THEN
    WRITE(INFO_LINE, STRING'("All Messages are Switched ON"));
  ELSIF(debug_mode = "BIST_WARNING_MODE") THEN
    WRITE(INFO_LINE, STRING'("Contention Related Messages are Switched OFF"));
  END IF;  
  WRITELINE(OUTPUT, INFO_LINE);

  IF(ConfigFault) THEN
    WRITE(INFO_LINE, STRING'("Configurable Fault Functionality is ON"));
  ELSE
    WRITE(INFO_LINE, STRING'("Configurable Fault Functionality is OFF"));
  END IF;
  WRITELINE(OUTPUT, INFO_LINE);

  WRITE(INFO_LINE, STRING'("*******************************"));
  WRITELINE(OUTPUT, INFO_LINE);
    
  END IF;
END IF;



--------------RAM INITIALIZATION------------
IF (NOW = 0 ns AND MEM_INITIALIZE = TRUE) THEN
   Mem := InitMem(InitFileName);
END IF;

-----------------------------------------------
-- CONFIGURABLE FAULT MODEL FUNCTIONALITY  ----
------------------------------------------------
if (ConfigFault)  then
   
IF (NOW = 0 ns) THEN
   FILE_OPEN(fileOpenStatus,FAULT_ADDRESS_FILE ,Fault_file_name, mode);
   IF ((fileOpenStatus = OPEN_OK OR fileOpenStatus = STATUS_ERROR) ) THEN
   IF (FILE_READ = TRUE) THEN
   READ_LOOP:WHILE not ENDFILE(FAULT_ADDRESS_FILE) loop
              READLINE(FAULT_ADDRESS_FILE,fault_line);
              READ(fault_line,fault_word);
              READ(fault_line,fault_bit);

        for k in bits-1 downto 0 loop
              if (k = fault_bit) then
                stuck0(k) := '0';
              else
                stuck0(k) := '1';
              end if;
            end loop;
            stuck_at_0fault(i) <= stuck0;      
       
        FailureLocn(i) <= fault_word;
        std_fault_word := CONV_STD_LOGIC_VECTOR(fault_word,Addr);
   i := i+1;
   END LOOP;
   FILE_READ := FALSE;
   END IF;
   ELSE --else of if(fileOpenStatus)
        ASSERT FALSE
        REPORT "Unable to read Fault File. No faults inserted"
        SEVERITY WARNING;
   END IF;
   fcnt <= i;
END IF;

for n in 0 to  fcnt-1 loop
fault_repair_flag(n) <= '0';
end loop;
       Fault_repaired_flag := TRUE;
       FOR j in 0 to fcnt-1 loop
                if (fault_repair_flag(j) /= '1') then
                        Fault_repaired_flag := FALSE;
                        Mem(FailureLocn(j)) := Mem(FailureLocn(j)) and (stuck_at_0fault(j));
                end if; 
       end loop;
 end if;


IF(CKint'EVENT AND CKint = '1' AND CKint'LAST_VALUE = '0') THEN
   PrevCSN := CSNint;
   WENreg := WENint;
END IF;
   IF(CKint'EVENT AND CKint = '1' AND CKint'LAST_VALUE = '0' AND CSNint /= '1') THEN 
   
    
      Read_WriteMaskBased(CKint, CSNint, WENint, Aint, Dint, Mint, Qint);
    
   ELSIF(CKint'EVENT AND (CKint = 'X' OR CKint = 'U') AND CKint'LAST_VALUE = '0' AND CSNint /= '1' ) THEN
      MEM := (OTHERS => (OTHERS=>'X'));
      --writing out 'X'
      Qint <= TRANSPORT (OTHERS => 'X') AFTER 1 ns;
   ELSIF (CKint'EVENT AND (CKint = 'X' OR CKint = 'U') AND  CKint'LAST_VALUE = '1' AND (CSNint /= '1' OR PrevCSN /= '1')) THEN
      Mem := (OTHERS => (OTHERS=> CKint));
      --writing out 'X'
      Qint <= TRANSPORT (OTHERS => 'X') AFTER 1 ns;
   END IF;
   IF(CSNint'EVENT AND CSNint /= '1' AND (CKint = 'X' OR CKint = 'U')) THEN
      Mem := (OTHERS => (OTHERS=> CKint));
      --writing out 'X'
      Qint <= TRANSPORT (OTHERS => 'X') AFTER 1 ns;
   END IF;


IF ( TBYPASSint'EVENT) THEN
   IF(TBYPASSint = '1') THEN
      Qint  <= TRANSPORT Dint;
      
   ELSIF (TBYPASSint /= '1') THEN
      Qint  <= TRANSPORT (OTHERS => 'X');
      
   END IF;   
END IF;        

IF(Dint'EVENT AND TBYPASSint = '1') THEN
   Qint  <= TRANSPORT Dint;
   
END IF;   

   



   



--RY FUNCTIONALITY

IF  (CKint'EVENT AND CKint = '1' AND CKint'LAST_VALUE = '0' AND CSNint /= '1' AND TBYPASSint = '0') THEN 
        IF ( CSNint = '0' ) THEN
                RYint  <= TRANSPORT '0' AFTER 1 ns;
        ELSE
                RYint  <= TRANSPORT CSNint;
        END IF;
ELSIF (CKint'EVENT AND (CKint = 'X' OR CKint = 'U') AND CKint'LAST_VALUE = '0' AND CSNint /= '1' ) THEN
        RYint <= TRANSPORT 'X';
ELSIF (CKint'EVENT AND (CKint = 'X' OR CKint = 'U') AND CKint'LAST_VALUE = '1' AND (CSNint /= '1' OR PrevCSN /= '1') ) THEN
        RYint <= TRANSPORT 'X';
ELSIF (CKint'EVENT AND CKint = '0' AND CKint'LAST_VALUE = '1' AND PrevCSN = '0' AND TBYPASSint = '0') THEN
        RYint <= TRANSPORT '1' AFTER 1 ns;
END IF;

IF (CSNint'EVENT AND CSNint /= '1' AND (CKint = 'X' OR CKint = 'U')) THEN
        RYint <= TRANSPORT 'X';
END IF;

IF(TBYPASSint'EVENT AND TBYPASSint /= '0') THEN
        RYint <= TRANSPORT 'X';
END IF;   
   


END PROCESS ReadWrite ;

---------- Functionality for output scheduling -----------

QProc : PROCESS (Qint)
BEGIN

    Q <= TRANSPORT Qint ;

END PROCESS QProc;   


RYProc : PROCESS (RYint)
BEGIN

    RY <= TRANSPORT RYint;

END PROCESS RYProc;

        
-- synopsys synthesis_on
        
END VHDL_FUNCT ;



 
CONFIGURATION Cfg_ST_SPHDL_1024x40m8_L_VHDL_FUNCT OF ST_SPHDL_1024x40m8_L IS
    FOR VHDL_FUNCT
    END FOR;
END Cfg_ST_SPHDL_1024x40m8_L_VHDL_FUNCT;

CONFIGURATION Cfg_ST_SPHDL_1024x40m8_L OF ST_SPHDL_1024x40m8_L IS
    FOR VHDL_FUNCT
    END FOR;
END Cfg_ST_SPHDL_1024x40m8_L;






------------------------------------------------------------------------------
--  Function         : Entity FOR VHDL funct model
--  Release Date     : Nov, 2006
--  Last Modified By : ZZ
--  Version          : 4.0
------------------------------------------------------------------------------

--------------------- START OF HEADER ---------------------------
-- This Header Gives Information about the parameters & options present in the Model

-- words = 128
-- bits  = 8
-- mux   = 8 
-- 
-- 
-- 
-- 
-- 
----------------------END OF HEADER -------------------------------

LIBRARY IEEE;                   USE IEEE.STD_LOGIC_1164.ALL;
                                USE IEEE.STD_LOGIC_ARITH.ALL;
                                USE STD.TEXTIO.ALL;

ENTITY  ST_SPHDL_128x8m8_L IS

--synopsys synthesis_off
    GENERIC (
        Words : Natural := 128;
        Bits : Natural := 8;
        Addr : Natural := 7;
        mux : Natural := 8;


        ConfigFault : Boolean := FALSE;
        max_faults : Natural := 20;
        Fault_file_name : STRING := "ST_SPHDL_128x8m8_L_faults.txt";
        -- generics for Memory initialization
        MEM_INITIALIZE  : BOOLEAN := FALSE;
        BinaryInit      : INTEGER := 0;
        InitFileName    : STRING  := "ST_SPHDL_128x8m8_L.cde";
        Corruption_Read_Violation : BOOLEAN := TRUE;
        
        InstancePath : String := "ST_SPHDL_128x8m8_L";
        Debug_mode : String := "ALL_WARNING_MODE"
    );
--synopsys synthesis_on
    PORT (
        Q : OUT std_logic_vector(7 DOWNTO 0);
        RY : OUT std_logic;
        CK : IN std_logic;
        CSN : IN std_logic;
        TBYPASS : IN std_logic;
        WEN : IN std_logic;
        A : IN std_logic_vector(6 DOWNTO 0);
        D : IN std_logic_vector(7 DOWNTO 0)   
) ;    
END ST_SPHDL_128x8m8_L;







LIBRARY IEEE;                   
   USE IEEE.STD_LOGIC_1164.ALL;
   USE IEEE.STD_LOGIC_ARITH.ALL;
   USE IEEE.STD_LOGIC_TEXTIO.ALL;
LIBRARY STD;
   USE STD.TEXTIO.ALL;
   USE STD.STANDARD.ALL;


ARCHITECTURE VHDL_FUNCT of ST_SPHDL_128x8m8_L IS

--synopsys synthesis_off

-- list of input signals after filtering-----------
    SIGNAL Aint   : std_logic_vector(Addr-1 DOWNTO 0);
    SIGNAL Dint   : std_logic_vector(Bits-1 DOWNTO 0);
    SIGNAL Mint   : std_logic_vector(Bits-1 DOWNTO 0);
    SIGNAL CKint  : std_logic;
    SIGNAL CSNint : std_logic;
    SIGNAL CSNinternal : std_logic;
    SIGNAL WENint : std_logic;
    SIGNAL TBYPASSint  : std_logic;
    
    SIGNAL RYint  : std_logic := '1';
    
      

    SIGNAL Qint   : std_logic_vector(Bits-1 DOWNTO 0);
    




   
   SIGNAL fault_repair_flag : bit_vector(max_faults-1 DOWNTO 0) := (OTHERS => '1');
   SIGNAL fcnt : integer := 0;
   
   type stuckfault is array (Natural RANGE <>) of std_logic_vector(Bits-1 DOWNTO 0);
   SIGNAL stuck_at_0fault : stuckfault(max_faults-1 DOWNTO 0);
    
   type faultlocn is array (Natural RANGE <>) of integer;
   SIGNAL FailureLocn : faultlocn(0 to max_faults-1);
   SIGNAL debug_level : std_logic_vector(1 DOWNTO 0) := (OTHERS => '0');
--- AddrFilter puts all the bits of address bits TO 'X' or 'U' IF one of the bit is equal TO 'X' or 'U'--------------------------

    FUNCTION AddrFilter(Input : std_logic_vector) RETURN std_logic_vector IS
        VARIABLE UFound : Boolean := FALSE;
        VARIABLE Output : std_logic_vector(Input'RANGE);
    BEGIN
        FOR i IN Input'RANGE LOOP
            IF (Input(i) = 'U') THEN
                UFound := TRUE;
                EXIT;
            END IF;
        END LOOP;
        IF (UFound) THEN
            Output := (OTHERS => 'U');
        ELSIF (is_x(Input)) THEN
            Output := (OTHERS => 'X');
        ELSE
            Output := to_x01(Input);
        END IF;
        RETURN Output;
    END AddrFilter;

 function to_integer (oper : std_logic_vector) return integer is
      variable value     : integer := 0;
      variable temp_no   : integer := 1;
      variable temp_oper : std_logic_vector(oper'range) := oper;
      variable index     : integer := 1;
   begin
      ASSERT oper'length <= 31
      REPORT "argument is too large in to_integer, only lower 31 bits will be taken"
      SEVERITY WARNING;

      IF (not (is_X(oper))) then
         for I in temp_oper'reverse_range LOOP
            case (temp_oper(I)) is
               when '1' =>
                  value := value + temp_no;
               when others =>
                  null;
            END case;
            index := index + 1;
            exit when index > 31;
            temp_no := temp_no + temp_no;
         END LOOP;
      else
         ASSERT FALSE
         REPORT "WARNING: Illegal value detected in the conversion of to_integer"
         SEVERITY WARNING;

         value := 0;
      END IF;
      return (value);
   END to_integer;


--synopsys synthesis_on

BEGIN

--synopsys synthesis_off

  --------------------------------- Filter Block --------------------------- 
   Filter : BLOCK
        
        BEGIN
            Dint   <= to_ux01(D);
            CKint  <= to_ux01(CK);
            CSNinternal <= to_ux01(CSN);
            WENint <= to_ux01(WEN);
            TBYPASSint  <= to_ux01(TBYPASS);
            



	    Mint   <= (Others => '0');


            Aint <= AddrFilter(A);  -- IF one of the bits is equal TO 'X'
                                        -- or 'U' all bits are put TO this value

            
            CSNint <= (CSNinternal OR TBYPASSint );                            
        END BLOCK;
  

-------------------------------------------------------------------------------


ReadWrite : PROCESS (CKint, CSNint, TBYPASSint, Dint )

        SUBTYPE MType IS std_logic_vector(D'RANGE);
        TYPE MemType IS ARRAY (Natural RANGE <>) OF std_logic_vector(D'RANGE);
        VARIABLE Mem      : MemType(Words-1 DOWNTO 0);
        
        VARIABLE isMessageDisplayed : BOOLEAN := FALSE;
        
        CONSTANT WordX    : std_logic_vector(D'RANGE) := (OTHERS => 'X');
        CONSTANT WordU    : std_logic_vector(D'RANGE) := (OTHERS => 'U');
   
        file FAULT_ADDRESS_FILE : TEXT; 
        VARIABLE fileOpenStatus : FILE_OPEN_STATUS := NAME_ERROR;
        VARIABLE mode : FILE_OPEN_KIND := READ_MODE;
        VARIABLE FILE_READ : Boolean := TRUE; 

        variable i : integer := 0;
        variable k : integer := 0;
        VARIABLE mssgcnt : std_logic := 'X';
        VARIABLE fault_line : LINE;
        VARIABLE fault_word : integer := 0;
        VARIABLE fault_bit : integer := 0;
        VARIABLE std_fault_word : std_logic_vector(Addr-1 DOWNTO 0) := (OTHERS => '0');
        VARIABLE stuck0 : std_logic_vector(Bits-1 DOWNTO 0) := (OTHERS => '1');
        type faults is array (Natural RANGE <>) of integer;
        VARIABLE fault_row_add : faults(0 to max_faults-1);

        CONSTANT RepairFlag1 : bit_vector(max_faults-1 DOWNTO 0) := (OTHERS => '1');
        VARIABLE j : integer := 0;
        VARIABLE Fault_repaired_flag : Boolean := TRUE;

        VARIABLE FAULT_INFO_LINE : LINE;
        VARIABLE INFO_LINE : LINE;
        file OUTPUT: TEXT  open WRITE_MODE is "STD_OUTPUT";
        VARIABLE PrevCSN  : std_logic;
        VARIABLE WENreg  : std_logic;
        VARIABLE Q_last  : std_logic_vector(D'RANGE);
        VARIABLE RY_last : std_logic; 
        
    FUNCTION InitMem (FileName : String) RETURN MemType IS
 
       FILE     InitFile : Text ;
       VARIABLE InitLine : Line;
       VARIABLE Address : Natural;
       VARIABLE Value1 : MType;
       VARIABLE Value2 : MType;
       VARIABLE Contents : MemType(Words-1 DOWNTO 0);
       VARIABLE Good : Boolean;
       VARIABLE tmp: STD_ULOGIC_VECTOR(((((Bits-1)/4)+1)*4 - 1) DOWNTO 0);
       VARIABLE tmp1: STD_ULOGIC_VECTOR((Bits-1) DOWNTO 0);
       VARIABLE fileOpenStatus : FILE_OPEN_STATUS := NAME_ERROR;
       VARIABLE mode : FILE_OPEN_KIND := READ_MODE;


   BEGIN

       -- file format is:
       -- one <value> per line starting at <address>=0
       -- <value> is a std_logic_vector
       -- expressed according to parameter <Format>:
       -- BinaryInit = 1 means Binary (default)
       -- BinaryInit = 0 means Hexadecimal

       FILE_OPEN(fileOpenStatus,InitFile, InitFileName, mode);
       IF (fileOpenStatus = OPEN_OK OR fileOpenStatus = STATUS_ERROR) THEN
       Address := 0;
       ReadFile: WHILE (NOT ENDFILE(InitFile)) LOOP
           readline(InitFile, InitLine);
           Good := TRUE;
           CASE BinaryInit IS
               WHEN 1 =>
                   read(InitLine, Value2, Good);
               WHEN 0 =>
                   HREAD(InitLine, tmp, GOOD);
                   for j in 0 to bits-1 loop
                       tmp1(j) := tmp(j);
                   end loop;
                   Value1 := STD_LOGIC_VECTOR(tmp1);

               WHEN OTHERS =>
                   ASSERT FALSE  REPORT "(" & InstancePath & ")" &  "  RAM Initialization failed: bad format. " SEVERITY WARNING;
           END CASE;
           IF Good THEN
               IF (Address = Words) THEN
                        ASSERT FALSE REPORT "(" & InstancePath & ")" &  "  Too many data words in the personality file. " SEVERITY WARNING;
               END IF;
               CASE BinaryInit IS
                   WHEN 1 =>
                       Contents(Address) := Value2;
                   WHEN 0 =>
                       Contents(Address) := Value1;        -- (Q'left downto 0);
                   WHEN OTHERS =>
                       NULL;
               END CASE;
           ELSE
                ASSERT FALSE REPORT "(" & InstancePath & ")" &  "  RAM Initialization failed " SEVERITY WARNING;
           END IF;
           Address := Address+1;
       END LOOP ReadFile;

       IF (Address /= Words) THEN
           ASSERT FALSE REPORT "(" & InstancePath & ")" &  "  Words in the personality file less than that given by address bounds. " SEVERITY WARNING;
       END IF;
       ELSE --else of if(fileOpenStatus)
          ASSERT FALSE
          REPORT "Unable to read Code File. "
          SEVERITY WARNING;
       END IF; -- end of if(fileOpenStatus)
       RETURN Contents;
   END InitMem;
      
      -- HEX code file reading
 
      PROCEDURE Char2QuadBits(C: Character; RESULT: out Bit_Vector(3 downto 0); GOOD: out Boolean; ISSUE_ERROR: in Boolean) IS
      BEGIN
      CASE c IS
        WHEN '0' => RESULT :=  x"0"; good := TRUE;
        WHEN '1' => RESULT :=  x"1"; good := TRUE;
        WHEN '2' => RESULT :=  x"2"; good := TRUE;
        WHEN '3' => RESULT :=  x"3"; good := TRUE;
        WHEN '4' => RESULT :=  x"4"; good := TRUE;
        WHEN '5' => RESULT :=  x"5"; good := TRUE;
        WHEN '6' => RESULT :=  x"6"; good := TRUE;
        WHEN '7' => RESULT :=  x"7"; good := TRUE;
        WHEN '8' => RESULT :=  x"8"; good := TRUE;
        WHEN '9' => RESULT :=  x"9"; good := TRUE;
        WHEN 'A' => RESULT :=  x"A"; good := TRUE;
        WHEN 'B' => RESULT :=  x"B"; good := TRUE;
        WHEN 'C' => RESULT :=  x"C"; good := TRUE;
        WHEN 'D' => RESULT :=  x"D"; good := TRUE;
        WHEN 'E' => RESULT :=  x"E"; good := TRUE;
        WHEN 'F' => RESULT :=  x"F"; good := TRUE;

        WHEN 'a' => RESULT :=  x"A"; good := TRUE;
        WHEN 'b' => RESULT :=  x"B"; good := TRUE;
        WHEN 'c' => RESULT :=  x"C"; good := TRUE;
        WHEN 'd' => RESULT :=  x"D"; good := TRUE;
        WHEN 'e' => RESULT :=  x"E"; good := TRUE;
        WHEN 'f' => RESULT :=  x"F"; good := TRUE;
        WHEN others =>
          IF ISSUE_ERROR THEN
                ASSERT ((NOW = 0 ns) or (to_integer(debug_level) >= 2)) REPORT "(" & InstancePath & ")" &  " (MSG_ID 801 ) HREAD Error: Read a '" & c & "' , expected a Hex character (0-F). " SEVERITY WARNING;
          END IF;
              good := FALSE;
      END CASE;
   END Char2QuadBits;

   -- Reading Hex code file
   PROCEDURE HREAD(L:inout LINE; VALUE:out BIT_VECTOR;GOOD: out BOOLEAN) is
        VARIABLE ok: boolean;
        VARIABLE c:  character;
        CONSTANT ne: integer := (value'length-1)/4;
        VARIABLE bv: bit_vector(0 to value'length-1);
        VARIABLE s:  string(1 to ne);
    BEGIN
        LOOP                                    -- skip white space
           read(l,c);
           EXIT when ((c /= ' ') and (c /= CR) and (c /= HT));
        END LOOP;

        Char2QuadBits(c, bv(0 to 3), ok, TRUE);
        IF not ok THEN
           good := FALSE;
           RETURN;
        END IF;
        if ( ne >= 1) then
           read(L, s, ok);
           if not ok then
              good := FALSE;
              return;
           end if;
        end if;
   
        if value'length mod 4 /= 0 then
           for i in 1 to ne-1 loop
              Char2QuadBits(s(i), bv(4*i to 4*i+3), ok, TRUE);
              if not ok then
                 good := FALSE;
                 return;
              end if;
           end loop;
        else
           for i in 1 to ne loop
              Char2QuadBits(s(i), bv(4*i to 4*i+3), ok, TRUE);
              if not ok then
                 good := FALSE;
                 return;
              end if;
           end loop;
        end if;
        good := TRUE;
        value := bv;
    end HREAD;

PROCEDURE WriteCycleMaskBased (CONSTANT Address : IN std_logic_vector(Addr-1 DOWNTO 0);
                           CONSTANT Data : IN std_logic_vector(Bits-1 DOWNTO 0);
                           CONSTANT Mask : IN std_logic_vector(Bits-1 DOWNTO 0)) IS

     VARIABLE V_Location : Natural;
     VARIABLE D_temp     : std_logic_vector(Bits-1 DOWNTO 0);

     BEGIN
     
        IF(is_x(Address(0))) THEN
           ASSERT ((NOW = 0 ns) or (to_integer(debug_level) >= 2)) REPORT "(" & InstancePath & ")" &  " (MSG_ID 009 ) Illegal Value on Address Bus during Write Cycle. Memory Corrupted " SEVERITY WARNING;
           mem := (OTHERS => (OTHERS => 'X'));
        ELSE
           V_location := to_integer(Address); 
           IF (V_Location >= Words) THEN
              ASSERT ((NOW = 0 ns) or (to_integer(debug_level) >= 2)) REPORT "(" & InstancePath & ")" &  " (MSG_ID 702 ) Address Out Of Range during Write Cycle. " SEVERITY WARNING;
           ELSE
              D_temp := Mem(V_location);
           END IF;
	
           FOR i in 0 TO Bits-1 LOOP
              IF (Mask(i) = '0') then
                D_temp(i) := Data(i);
              elsif (is_x(Mask(i)) AND (D_temp(i) /= Data(i)) ) then
                D_temp(i) := 'X';
              END IF;
           END LOOP;
                   
	   IF ( V_Location < Words) THEN	   
              Mem(V_Location) := D_temp;
	   END IF;
         END IF;  
    
END WriteCycleMaskBased;    

PROCEDURE ReadCycle (CONSTANT Address : IN std_logic_vector;
                     SIGNAL S_Q    : OUT std_logic_vector(Bits-1 DOWNTO 0)) IS

        VARIABLE V_Location : Natural;
        VARIABLE new_data   : std_logic_vector(Bits-1 DOWNTO 0);
            
        BEGIN
            
        IF(is_x(Address(0))) THEN
           IF(Corruption_Read_Violation) THEN
              ASSERT ((NOW = 0 ns) or (to_integer(debug_level) >= 2)) REPORT "(" & InstancePath & ")" &  " (MSG_ID 010 ) Illegal Value on Address Bus during Read Cycle. Memory and Output Corrupted " SEVERITY WARNING;
              mem := (OTHERS => (OTHERS => 'X')); 
           ELSE   
              ASSERT ((NOW = 0 ns) or (to_integer(debug_level) >= 2)) REPORT "(" & InstancePath & ")" &  " (MSG_ID 010 ) Illegal Value on Address Bus during Read Cycle. Output Corrupted " SEVERITY WARNING;
           END IF;   
	   S_Q <= TRANSPORT WordX AFTER 1 ns;
        ELSE
           V_Location := to_integer(Address);
           IF (V_Location >= Words) THEN
              ASSERT ((NOW = 0 ns) or (to_integer(debug_level) >= 2)) REPORT "(" & InstancePath & ")" &  " (MSG_ID 703 ) Address Out Of Range during Read Cycle. " SEVERITY WARNING;
	      S_Q <= TRANSPORT WordX AFTER 1 ns;
           ELSE
              new_data := MEM(V_Location);
              S_Q <= TRANSPORT new_data AFTER 1 ns;
           END IF;
        END IF;  
        
END ReadCycle;

        
PROCEDURE Read_WriteMaskBased (    SIGNAL CKint : IN std_logic;
                          CONSTANT CSNint  : IN std_logic;
                          CONSTANT  WENint : IN std_logic;
                          CONSTANT Aint    : IN std_logic_vector(Addr-1 DOWNTO 0);
                          CONSTANT Dint    : IN std_logic_vector(BITS-1 DOWNTO 0);
			  CONSTANT Mint    : IN std_logic_vector(BITS-1 DOWNTO 0);
                          SIGNAL Temp_Qint      : OUT std_logic_vector(BITS-1 DOWNTO 0)) IS 

         VARIABLE D_temp     : std_logic_vector(BITS-1 DOWNTO 0);
         VARIABLE prev_temp     : std_logic_vector(BITS-1 DOWNTO 0);
         VARIABLE V_location : NATURAL;
                          
         BEGIN 

                IF (WENint = '0' AND CSNint = '0') THEN
                    WriteCycleMaskBased( Address  => Aint,
                                         Data  => Dint,
			                 Mask => Mint);

	        ELSIF (WENint = '1' AND CSNint = '0') THEN
                    ReadCycle( Address  => Aint,
                              S_Q      => Temp_Qint);
 

                ELSIF (is_x(WENint) AND CSNint = '0') THEN
                    IF(is_x(Aint(0))) THEN
                        ASSERT ((NOW = 0 ns) or (to_integer(debug_level) >= 2)) REPORT "(" & InstancePath & ")" &  " (MSG_ID 009 ) Illegal Value on Address Bus during Write Cycle. Memory Corrupted " SEVERITY WARNING;
                        mem := (OTHERS => (OTHERS => 'X'));
                        Temp_Qint <= TRANSPORT WordX AFTER 1 ns;
                    ELSE   
                        V_location := to_integer(Aint); 
		        IF (V_Location >= Words) THEN
                           ASSERT ((NOW = 0 ns) or (to_integer(debug_level) >= 2)) REPORT "(" & InstancePath & ")" &  " (MSG_ID 702 ) Address Out Of Range during Write Cycle. " SEVERITY WARNING;
		           Temp_Qint <= TRANSPORT WordX AFTER 1 ns;
              	        ELSE
                           D_temp := Mem(V_location);
                           prev_temp := Mem(V_location);
                           --calculating data to write in memory
                           FOR i in 0 TO Bits-1 LOOP
                             IF (Mint(i) /= '1' AND (D_temp(i) /= Dint(i))) then
                               D_temp(i) := 'X';
                             END IF;
                           END LOOP;
                           
                           Mem(V_Location) := D_temp;

                           --calculating output
                           FOR i in 0 TO Bits-1 LOOP
                             IF (prev_temp(i) /= Qint(i)) then
                               Temp_Qint(i) <= 'X' AFTER 1 ns;
                             END IF;
                           END LOOP;

               	        END IF;
                    END IF;

                ELSIF (is_x(CSNint)) THEN 
                    Temp_Qint <= TRANSPORT WordX;
                    mem := (OTHERS => (OTHERS => 'X'));    
                END IF;
END Read_WriteMaskBased;



BEGIN 

--Display of messages at 0 time
IF(NOW = 0 ns AND NOT(isMessageDisplayed)) THEN
IF (debug_mode = "ALL_WARNING_MODE") THEN
  debug_level <= (Others => '0');
ELSIF (debug_mode = "NO_WARNING_MODE") THEN
  debug_level <= "10";  
END IF;
  IF(debug_mode = "ALL_WARNING_MODE" OR debug_mode = "BIST_WARNING_MODE") THEN
  isMessageDisplayed := TRUE;
  WRITE(INFO_LINE, InstancePath);
  WRITE(INFO_LINE, STRING'(" : INFORMATION"));
  WRITELINE(OUTPUT, INFO_LINE);

  WRITE(INFO_LINE, STRING'("*******************************"));
  WRITELINE(OUTPUT, INFO_LINE); 
  
  WRITE(INFO_LINE, STRING'("This is a purely FUNCTIONAL MODEL"));
  WRITELINE(OUTPUT, INFO_LINE);

  IF(debug_mode = "ALL_WARNING_MODE") THEN
    WRITE(INFO_LINE, STRING'("All Messages are Switched ON"));
  ELSIF(debug_mode = "BIST_WARNING_MODE") THEN
    WRITE(INFO_LINE, STRING'("Contention Related Messages are Switched OFF"));
  END IF;  
  WRITELINE(OUTPUT, INFO_LINE);

  IF(ConfigFault) THEN
    WRITE(INFO_LINE, STRING'("Configurable Fault Functionality is ON"));
  ELSE
    WRITE(INFO_LINE, STRING'("Configurable Fault Functionality is OFF"));
  END IF;
  WRITELINE(OUTPUT, INFO_LINE);

  WRITE(INFO_LINE, STRING'("*******************************"));
  WRITELINE(OUTPUT, INFO_LINE);
    
  END IF;
END IF;



--------------RAM INITIALIZATION------------
IF (NOW = 0 ns AND MEM_INITIALIZE = TRUE) THEN
   Mem := InitMem(InitFileName);
END IF;

-----------------------------------------------
-- CONFIGURABLE FAULT MODEL FUNCTIONALITY  ----
------------------------------------------------
if (ConfigFault)  then
   
IF (NOW = 0 ns) THEN
   FILE_OPEN(fileOpenStatus,FAULT_ADDRESS_FILE ,Fault_file_name, mode);
   IF ((fileOpenStatus = OPEN_OK OR fileOpenStatus = STATUS_ERROR) ) THEN
   IF (FILE_READ = TRUE) THEN
   READ_LOOP:WHILE not ENDFILE(FAULT_ADDRESS_FILE) loop
              READLINE(FAULT_ADDRESS_FILE,fault_line);
              READ(fault_line,fault_word);
              READ(fault_line,fault_bit);

        for k in bits-1 downto 0 loop
              if (k = fault_bit) then
                stuck0(k) := '0';
              else
                stuck0(k) := '1';
              end if;
            end loop;
            stuck_at_0fault(i) <= stuck0;      
       
        FailureLocn(i) <= fault_word;
        std_fault_word := CONV_STD_LOGIC_VECTOR(fault_word,Addr);
   i := i+1;
   END LOOP;
   FILE_READ := FALSE;
   END IF;
   ELSE --else of if(fileOpenStatus)
        ASSERT FALSE
        REPORT "Unable to read Fault File. No faults inserted"
        SEVERITY WARNING;
   END IF;
   fcnt <= i;
END IF;

for n in 0 to  fcnt-1 loop
fault_repair_flag(n) <= '0';
end loop;
       Fault_repaired_flag := TRUE;
       FOR j in 0 to fcnt-1 loop
                if (fault_repair_flag(j) /= '1') then
                        Fault_repaired_flag := FALSE;
                        Mem(FailureLocn(j)) := Mem(FailureLocn(j)) and (stuck_at_0fault(j));
                end if; 
       end loop;
 end if;


IF(CKint'EVENT AND CKint = '1' AND CKint'LAST_VALUE = '0') THEN
   PrevCSN := CSNint;
   WENreg := WENint;
END IF;
   IF(CKint'EVENT AND CKint = '1' AND CKint'LAST_VALUE = '0' AND CSNint /= '1') THEN 
   
    
      Read_WriteMaskBased(CKint, CSNint, WENint, Aint, Dint, Mint, Qint);
    
   ELSIF(CKint'EVENT AND (CKint = 'X' OR CKint = 'U') AND CKint'LAST_VALUE = '0' AND CSNint /= '1' ) THEN
      MEM := (OTHERS => (OTHERS=>'X'));
      --writing out 'X'
      Qint <= TRANSPORT (OTHERS => 'X') AFTER 1 ns;
   ELSIF (CKint'EVENT AND (CKint = 'X' OR CKint = 'U') AND  CKint'LAST_VALUE = '1' AND (CSNint /= '1' OR PrevCSN /= '1')) THEN
      Mem := (OTHERS => (OTHERS=> CKint));
      --writing out 'X'
      Qint <= TRANSPORT (OTHERS => 'X') AFTER 1 ns;
   END IF;
   IF(CSNint'EVENT AND CSNint /= '1' AND (CKint = 'X' OR CKint = 'U')) THEN
      Mem := (OTHERS => (OTHERS=> CKint));
      --writing out 'X'
      Qint <= TRANSPORT (OTHERS => 'X') AFTER 1 ns;
   END IF;


IF ( TBYPASSint'EVENT) THEN
   IF(TBYPASSint = '1') THEN
      Qint  <= TRANSPORT Dint;
      
   ELSIF (TBYPASSint /= '1') THEN
      Qint  <= TRANSPORT (OTHERS => 'X');
      
   END IF;   
END IF;        

IF(Dint'EVENT AND TBYPASSint = '1') THEN
   Qint  <= TRANSPORT Dint;
   
END IF;   

   



   



--RY FUNCTIONALITY

IF  (CKint'EVENT AND CKint = '1' AND CKint'LAST_VALUE = '0' AND CSNint /= '1' AND TBYPASSint = '0') THEN 
        IF ( CSNint = '0' ) THEN
                RYint  <= TRANSPORT '0' AFTER 1 ns;
        ELSE
                RYint  <= TRANSPORT CSNint;
        END IF;
ELSIF (CKint'EVENT AND (CKint = 'X' OR CKint = 'U') AND CKint'LAST_VALUE = '0' AND CSNint /= '1' ) THEN
        RYint <= TRANSPORT 'X';
ELSIF (CKint'EVENT AND (CKint = 'X' OR CKint = 'U') AND CKint'LAST_VALUE = '1' AND (CSNint /= '1' OR PrevCSN /= '1') ) THEN
        RYint <= TRANSPORT 'X';
ELSIF (CKint'EVENT AND CKint = '0' AND CKint'LAST_VALUE = '1' AND PrevCSN = '0' AND TBYPASSint = '0') THEN
        RYint <= TRANSPORT '1' AFTER 1 ns;
END IF;

IF (CSNint'EVENT AND CSNint /= '1' AND (CKint = 'X' OR CKint = 'U')) THEN
        RYint <= TRANSPORT 'X';
END IF;

IF(TBYPASSint'EVENT AND TBYPASSint /= '0') THEN
        RYint <= TRANSPORT 'X';
END IF;   
   


END PROCESS ReadWrite ;

---------- Functionality for output scheduling -----------

QProc : PROCESS (Qint)
BEGIN

    Q <= TRANSPORT Qint ;

END PROCESS QProc;   


RYProc : PROCESS (RYint)
BEGIN

    RY <= TRANSPORT RYint;

END PROCESS RYProc;

        
-- synopsys synthesis_on
        
END VHDL_FUNCT ;



 
CONFIGURATION Cfg_ST_SPHDL_128x8m8_L_VHDL_FUNCT OF ST_SPHDL_128x8m8_L IS
    FOR VHDL_FUNCT
    END FOR;
END Cfg_ST_SPHDL_128x8m8_L_VHDL_FUNCT;

CONFIGURATION Cfg_ST_SPHDL_128x8m8_L OF ST_SPHDL_128x8m8_L IS
    FOR VHDL_FUNCT
    END FOR;
END Cfg_ST_SPHDL_128x8m8_L;



