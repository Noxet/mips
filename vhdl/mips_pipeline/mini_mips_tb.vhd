library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

use work.records_pkg.all;
use work.subtypes_pkg.all;
use work.constants_pkg.all;

entity mini_mips_tb is
end;

architecture bench of mini_mips_tb is

  component mini_mips_pipeline
      port (
          clk         : in  std_logic;
          rst_n       : in  std_logic;
          mini_mips_i : in  mini_mips_in_t;
          mini_mips_o : out mini_mips_out_t);
  end component mini_mips_pipeline;

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

  
  constant Fault_file_name           : STRING  := "ST_SPHDL_4096x32m8_L_faults.txt";
  constant ConfigFault               : Boolean := FALSE;
  constant max_faults                : Natural := 20;
  constant MEM_INITIALIZE            : BOOLEAN := TRUE;  -- FLASE
  constant BinaryInit                : INTEGER := 1;  -- 0
  constant InitFileName              : STRING  := "/h/dk/w/ael10jso/mips_project/vhdl/mips_pipeline/mem/program.cde";
  constant Corruption_Read_Violation : BOOLEAN := TRUE;
  constant Debug_mode                : String  := "ALL_WARNING_MODE";
  constant InstancePath              : String  := "ST_SPHDL_4096x32m8_L";

  signal clk: std_logic;
  signal rst_n: std_logic;
  signal mini_mips_i: mini_mips_in_t;
  signal mini_mips_o: mini_mips_out_t;
  
  signal dummy_zero_array : std_logic_vector(31 downto 0) := (others => '0');

  constant clk_period : time := 10ns;

  signal counter : unsigned(11 downto 0) := (others => '0');
begin

  uut: mini_mips_pipeline port map ( clk         => clk,
                            rst_n       => rst_n,
                            mini_mips_i => mini_mips_i,
                            mini_mips_o => mini_mips_o );

  -- The instruction memory --
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
      Q => mini_mips_i.imem_data,
      RY => OPEN,     -- "Memory Handshake signal"
      CK => clk,
      CSN => '0',     -- Active low
      TBYPASS => '0', -- Active high, memory bypass in test mode for datapath checking
      WEN => '1',     -- Active low, never write to I-mem (not yet at least)
      A => mini_mips_o.imem_addr,
      D => dummy_zero_array
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
      Q => mini_mips_i.dmem_data,
      RY => OPEN,      -- "Memory Handshake signal"
      CK => clk,
      CSN => '0',      -- Active low
      TBYPASS => '0',  -- Active high, memory bypass in test mode for datapath checking
      WEN => mini_mips_o.dmem_wen_n,
      A => mini_mips_o.dmem_addr,
      D => mini_mips_o.dmem_data
      );

  clk_proc: process
  begin
    clk <= '1';
    wait for clk_period/2;
    clk <= '0';
    wait for clk_period/2;
  end process;

--  addiu 1 1 2 -- add register 1 with immidiate 2, store in 1 (res = 2) 
--  addiu 1 1 6 -- add register 1 with immidiate 6, store in 1 (res = 8)
--  addiu 1 2 2 -- add register 1 with immidiate 2, store in 2 (res = 10)
--  sll   1 3 2 -- shift register 1 two times left, store in 3 (res = 32)
--  srl   2 4 1 -- shift register 2 one time rigt, store in 4  (res = 5)    
--  sltu  4 2 5 -- if register 4 < register 2, store 1 in 5    (res = 1)
--  and   1 2 6 -- and register 1 with register 2, store in 6  (res = 8)
--  or    2 6 7 -- or register 5 with register 6, store in 7   (res = 9)
  
  WaveGen_Proc: process
  begin
    rst_n <= '0';
    wait for 4*clk_period;
    rst_n <= '1';
    
    wait;
    

  end process;

end;
