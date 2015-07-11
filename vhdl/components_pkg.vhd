library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.records_pkg.all;
use work.subtypes_pkg.all;
use work.constants_pkg.all;


package components_pkg is
  
    -- THE MIPS-TOP COMPONENT --
    component mini_mips
    port (
        clk         : in  std_logic;
        rst_n       : in  std_logic;
        mini_mips_i : in  mini_mips_in_t;
        mini_mips_o : out mini_mips_out_t);
    end component; 
    
    -- THE MEMORY COMPONENT --
    component ST_SPHDL_4096x32m8_L
    generic (
       Fault_file_name           : STRING;
       ConfigFault               : Boolean;
       max_faults                : Natural;
       MEM_INITIALIZE            : BOOLEAN;
       BinaryInit                : INTEGER;
       InitFileName              : STRING;
       Corruption_Read_Violation : BOOLEAN;
       Debug_mode                : String;
       InstancePath              : String);
    port (
      Q       : OUT std_logic_vector(31 DOWNTO 0);
      RY      : OUT std_logic;
      CK      : IN  std_logic;
      CSN     : IN  std_logic;
      TBYPASS : IN  std_logic;
      WEN     : IN  std_logic;
      A       : IN  std_logic_vector(11 DOWNTO 0);
      D       : IN  std_logic_vector(31 DOWNTO 0));
    end component;
    
    -- PAD COMPONENT --
    component BD2SCARUDQP_1V8_SF_LIN
    port( ZI :  out std_logic;
           A :  in std_logic;
          EN :  in std_logic;
          TA :  in std_logic;
         TEN :  in std_logic;
          TM :  in std_logic;
         PUN :  in std_logic;
         PDN :  in std_logic;
        HYST :  in std_logic;
          IO :  inout std_logic );  -- Pad Surface
  end component;
  
    component controller
    port (
        ctrl_i : in  ctrl_in_t;
        ctrl_o : out ctrl_out_t);
    end component;

    -- IF STAGE COMPONENTS --
    component if_top
        port (
            clk       : in  std_logic;
            rst_n     : in  std_logic;
            if_top_i  : in if_top_in_t;
            if_top_o  : out if_top_out_t);
    end component;
    
    component pc is
        port (
            clk    : in  std_logic;
            rst_n  : in  std_logic;
            halt_i : in  std_logic;
            npc_i  : in  imem_s;
            pc_o   : out imem_s);
    end component pc;

    -- ID STAGE COMPONENTS --
    component id_top
        port (
            clk      : in  std_logic;
            rst_n    : in  std_logic;
            id_top_i : in  id_top_in_t;
            id_top_o : out id_top_out_t);
    end component;
    
    component regfile
        port (
            clk       : in  std_logic;
            rst_n     : in  std_logic;
            regfile_i : in  regfile_in_t;
            regfile_o : out regfile_out_t);
    end component;

    -- EXE STAGE COMPONENTS --
    component exe_top
        port (
            clk       : in  std_logic;
            rst_n     : in  std_logic;
            exe_top_i : in  exe_top_in_t;
            exe_top_o : out exe_top_out_t);
    end component;
    
    component alu
        port(
            clk   : in  std_logic;
            rst_n   : in  std_logic;
            alu_i : in  alu_in_t;
            alu_o : out alu_out_t
            );
    end component;
    
    component alu_ctrl
        port(
            alu_ctrl_i : in  alu_ctrl_in_t;
            alu_ctrl_o : out alu_ctrl_out_t
            );
    end component;
    
    component if_id
        port(
            clk    : in std_logic;
            rst_n : in std_logic;
            halt_i : in std_logic;
            if_id_i : in IF_ID_t;
            if_id_o : out IF_ID_t
          );
    end component;
    
    component id_exe
        port(
            clk    : in std_logic;
            rst_n : in std_logic;
            halt_i : in std_logic;
            id_exe_i : in ID_EXE_t;
            id_exe_o : out ID_EXE_t
          );
    end component;
    
    component exe_mem
        port(
            clk    : in std_logic;
            rst_n : in std_logic;
            halt_i : in std_logic;
            exe_mem_i : in EXE_MEM_t;
            exe_mem_o : out EXE_MEM_t
          );
    end component;
    
    component mem_wb
        port(
            clk : in std_logic;
            rst_n : in std_logic;
            halt_i : in std_logic;
            mem_wb_i : in MEM_WB_t;
            mem_wb_o : out MEM_WB_t
          );   
    end component;
    
end components_pkg;




package body components_pkg is
end components_pkg;
