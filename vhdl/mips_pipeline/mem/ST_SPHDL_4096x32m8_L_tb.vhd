-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-------------------------------------------------------------------------------

entity ST_SPHDL_4096x32m8_L_tb is

end ST_SPHDL_4096x32m8_L_tb;

-------------------------------------------------------------------------------

architecture testbench of ST_SPHDL_4096x32m8_L_tb is

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
  constant InitFileName              : STRING  := "/h/dk/w/ael10jso/mips_project/vhdl/mem/ST_SPHDL_4096x32m8_L.cde";
  constant Corruption_Read_Violation : BOOLEAN := TRUE;
  constant Debug_mode                : String  := "ALL_WARNING_MODE";
  constant InstancePath              : String  := "ST_SPHDL_4096x32m8_L";

  signal Q_i       : std_logic_vector(31 DOWNTO 0);
  signal RY_i      : std_logic;
  signal CK_i      : std_logic;
  signal CSN_i     : std_logic;
  signal TBYPASS_i : std_logic;
  signal WEN_i     : std_logic;
  signal A_i       : std_logic_vector(11 DOWNTO 0);
  signal D_i       : std_logic_vector(31 DOWNTO 0);

  signal clk : std_logic;
  constant clk_period : time := 10ns;

  signal counter : unsigned(11 downto 0) := (others => '0');
  

begin  -- testbench

  DUT: ST_SPHDL_4096x32m8_L
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
        Q       => Q_i,
        RY      => RY_i,
        CK      => clk,
        CSN     => CSN_i,
        TBYPASS => TBYPASS_i,
        WEN     => WEN_i,
        A       => A_i,
        D       => D_i);

  clk_proc: process
  begin
    clk <= '1';
    wait for clk_period/2;
    clk <= '0';
    wait for clk_period/2;
  end process;

  WaveGen_Proc: process(clk)
  begin
    if falling_edge(clk) then
      counter <=  counter + 1;
    end if;
  end process;

  CSN_i <= '0';
  WEN_i <= '1';
  TBYPASS_i <= '0';
  A_i <= std_logic_vector(counter);

end testbench;

-------------------------------------------------------------------------------
