library IEEE;--, IO65LPHVT_SF_1V8_50A_7M4X0Y2Z;
use IEEE.std_logic_1164.all;
--use IO65LPHVT_SF_1V8_50A_7M4X0Y2Z.all;

-- Our packages
use work.records_pkg.all;
use work.subtypes_pkg.all;
use work.constants_pkg.all;
use work.components_pkg.all;

entity mini_mips_fakepad is
  port (
    clk         : in  std_logic;
    rst_n       : in  std_logic
    --alu_result  : out std_logic_vector(15 downto 0)
  );
end mini_mips_fakepad;

architecture Behavioral of mini_mips_fakepad is

  
  signal s_mini_mips_i : mini_mips_in_t;
  signal s_mini_mips_o : mini_mips_out_t;

  -- For the pad/memoriy-ports which have constant inputs -- 
  signal HIGH, LOW : std_logic;

  -- Constants for the memories --
  constant Fault_file_name           : STRING  := "ST_SPHDL_4096x32m8_L_faults.txt";
  constant ConfigFault               : Boolean := FALSE;
  constant max_faults                : Natural := 20;
  constant MEM_INITIALIZE            : BOOLEAN := TRUE;  -- FALSE
  constant BinaryInit                : INTEGER := 1;  -- 0
  constant InitFileName              : STRING  := "/h/dk/w/ael10jso/mips_project/vhdl/mips_pipeline/mem/program.cde";
  constant Corruption_Read_Violation : BOOLEAN := TRUE;
  constant Debug_mode                : String  := "ALL_WARNING_MODE";
  constant InstancePath              : String  := "ST_SPHDL_4096x32m8_L";
  
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
  
begin  -- Behavioral
  
  ---- ALU RESULT OUT TO PADS ----
  --alu_result <= s_mini_mips_o.alu_result;

  HIGH <= '1';
  LOW <= '0';

  mini_mips_inst: mini_mips_pipeline
    port map (
      clk => clk,
      rst_n => rst_n,
      mini_mips_i => s_mini_mips_i,
      mini_mips_o => s_mini_mips_o
    );

  imem_inst : ST_SPHDL_4096x32m8_L
    generic map (
      Fault_file_name           => Fault_file_name,
      ConfigFault               => ConfigFault,
      max_faults                => max_faults,
      MEM_INITIALIZE            => MEM_INITIALIZE,
      BinaryInit                => BinaryInit,
      InitFileName              => InitFileName,
      Corruption_Read_Violation => Corruption_Read_Violation,
      Debug_mode                => Debug_mode,
      InstancePath              => InstancePath)
    port map (
      Q => s_mini_mips_i.imem_data, --s_imem_to_top_imem_data,
      RY => OPEN,     -- "Memory Handshake signal"
      CK => clk,
      CSN => '0',     -- Active low
      TBYPASS => '0', -- Active high, memory bypass in test mode for datapath checking
      WEN => HIGH,     -- Active low, shall not write to Imem, at least for now
      A => s_mini_mips_o.imem_addr, --s_top_to_imem_imem_addr,
      D => (others => '0')  -- THIS SHOULD LATER BE CONNECTED TO PADS, WITH A
                               -- BOOTLOADER OR SOMETHING SIMILAR
      );

  -- The data memory --
  dmem_inst: ST_SPHDL_4096x32m8_L      
    generic map (
      Fault_file_name           => Fault_file_name,
      ConfigFault               => ConfigFault,
      max_faults                => max_faults,
      MEM_INITIALIZE            => MEM_INITIALIZE,
      BinaryInit                => BinaryInit,
      InitFileName              => "/h/dk/w/ael10jso/mips_project/vhdl/mips_pipeline/mem/dmem_init.cde",
      Corruption_Read_Violation => Corruption_Read_Violation,
      Debug_mode                => Debug_mode,
      InstancePath              => InstancePath)
    port map(
      Q => s_mini_mips_i.dmem_data, --s_dmem_to_top_dmem_data,
      RY => OPEN,      -- "Memory Handshake signal"
      CK => clk,
      CSN => '0',      -- Active low
      TBYPASS => '0',  -- Active high, memory bypass in test mode for datapath checking
      WEN => s_mini_mips_o.dmem_wen_n, --s_dmem_wen_n,
      A => s_mini_mips_o.dmem_addr, --s_top_to_dmem_dmem_addr,
      D => s_mini_mips_o.dmem_data --s_top_to_dmem_dmem_data
      );

end Behavioral;
