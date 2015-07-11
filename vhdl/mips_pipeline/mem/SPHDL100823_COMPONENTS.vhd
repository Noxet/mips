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




library IEEE;
use IEEE.STD_LOGIC_1164.all;

package SPHDL100823_COMPONENTS is
component ST_SPHDL_128x32m8_L
--synopsys synthesis_off
   GENERIC (
        Fault_file_name : STRING := "ST_SPHDL_128x32m8_L_faults.txt";
        ConfigFault : Boolean := FALSE;
        max_faults : Natural := 20;
        -- generics for Memory initialization
        MEM_INITIALIZE  : BOOLEAN := FALSE;
        BinaryInit      : INTEGER := 0;
        InitFileName    : STRING  := "ST_SPHDL_128x32m8_L.cde";
        Corruption_Read_Violation : BOOLEAN := TRUE;
        Debug_mode : String := "ALL_WARNING_MODE";
        InstancePath : String := "ST_SPHDL_128x32m8_L"
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
end component;
component ST_SPHDL_4096x32m8_L
--synopsys synthesis_off
   GENERIC (
        Fault_file_name : STRING := "ST_SPHDL_4096x32m8_L_faults.txt";
        ConfigFault : Boolean := FALSE;
        max_faults : Natural := 20;
        -- generics for Memory initialization
        MEM_INITIALIZE  : BOOLEAN := FALSE;
        BinaryInit      : INTEGER := 0;
        InitFileName    : STRING  := "ST_SPHDL_4096x32m8_L.cde";
        Corruption_Read_Violation : BOOLEAN := TRUE;
        Debug_mode : String := "ALL_WARNING_MODE";
        InstancePath : String := "ST_SPHDL_4096x32m8_L"
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
        );
end component;
component ST_SPHDL_1024x32m8_L
--synopsys synthesis_off
   GENERIC (
        Fault_file_name : STRING := "ST_SPHDL_1024x32m8_L_faults.txt";
        ConfigFault : Boolean := FALSE;
        max_faults : Natural := 20;
        -- generics for Memory initialization
        MEM_INITIALIZE  : BOOLEAN := FALSE;
        BinaryInit      : INTEGER := 0;
        InitFileName    : STRING  := "ST_SPHDL_1024x32m8_L.cde";
        Corruption_Read_Violation : BOOLEAN := TRUE;
        Debug_mode : String := "ALL_WARNING_MODE";
        InstancePath : String := "ST_SPHDL_1024x32m8_L"
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
end component;
component ST_SPHDL_352x12m8_L
--synopsys synthesis_off
   GENERIC (
        Fault_file_name : STRING := "ST_SPHDL_352x12m8_L_faults.txt";
        ConfigFault : Boolean := FALSE;
        max_faults : Natural := 20;
        -- generics for Memory initialization
        MEM_INITIALIZE  : BOOLEAN := FALSE;
        BinaryInit      : INTEGER := 0;
        InitFileName    : STRING  := "ST_SPHDL_352x12m8_L.cde";
        Corruption_Read_Violation : BOOLEAN := TRUE;
        Debug_mode : String := "ALL_WARNING_MODE";
        InstancePath : String := "ST_SPHDL_352x12m8_L"
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
end component;
component ST_SPHDL_1024x40m8_L
--synopsys synthesis_off
   GENERIC (
        Fault_file_name : STRING := "ST_SPHDL_1024x40m8_L_faults.txt";
        ConfigFault : Boolean := FALSE;
        max_faults : Natural := 20;
        -- generics for Memory initialization
        MEM_INITIALIZE  : BOOLEAN := FALSE;
        BinaryInit      : INTEGER := 0;
        InitFileName    : STRING  := "ST_SPHDL_1024x40m8_L.cde";
        Corruption_Read_Violation : BOOLEAN := TRUE;
        Debug_mode : String := "ALL_WARNING_MODE";
        InstancePath : String := "ST_SPHDL_1024x40m8_L"
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
end component;
component ST_SPHDL_128x8m8_L
--synopsys synthesis_off
   GENERIC (
        Fault_file_name : STRING := "ST_SPHDL_128x8m8_L_faults.txt";
        ConfigFault : Boolean := FALSE;
        max_faults : Natural := 20;
        -- generics for Memory initialization
        MEM_INITIALIZE  : BOOLEAN := FALSE;
        BinaryInit      : INTEGER := 0;
        InitFileName    : STRING  := "ST_SPHDL_128x8m8_L.cde";
        Corruption_Read_Violation : BOOLEAN := TRUE;
        Debug_mode : String := "ALL_WARNING_MODE";
        InstancePath : String := "ST_SPHDL_128x8m8_L"
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
end component;
end SPHDL100823_COMPONENTS;


