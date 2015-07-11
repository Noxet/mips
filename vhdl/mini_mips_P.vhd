library IEEE, IO65LPHVT_SF_1V8_50A_7M4X0Y2Z;
  use IEEE.std_logic_1164.all;
  use IO65LPHVT_SF_1V8_50A_7M4X0Y2Z.all;


-- Our packages
use work.records_pkg.all;
use work.subtypes_pkg.all;
use work.constants_pkg.all;
use work.components_pkg.all;

entity mini_mips_p is
  port (
    clk         : inout  std_logic;
    rst_n       : inout  std_logic;
	alu_result  : inout std_logic_vector(15 downto 0)  --- FOR POST PNR SIMULATION ONLY ---
	);
end mini_mips_p;

architecture Behavioral of mini_mips_p is

  -- Add internal signals here --
  signal clk_i, rst_n_i : std_logic;
  signal alu_result_i : std_logic_vector(15 downto 0);
  signal s_top_to_imem_imem_data : word_s;
  signal s_imem_to_top_imem_data : word_s;
  signal s_dmem_to_top_dmem_data : word_s;
  signal s_top_to_dmem_dmem_data : word_s;
  signal s_top_to_dmem_dmem_addr : dmem_s;
  signal s_top_to_imem_imem_addr : imem_s;
  signal s_dmem_wen_n : std_logic;

  -- For the pad/memoriy-ports which have constant inputs -- 
  signal HIGH, LOW : std_logic;

  -- Constants for the memories --
  constant Fault_file_name           : STRING  := "ST_SPHDL_4096x32m8_L_faults.txt";
  constant ConfigFault               : Boolean := FALSE;
  constant max_faults                : Natural := 20;
  constant MEM_INITIALIZE            : BOOLEAN := TRUE;  -- FALSE
  constant BinaryInit                : INTEGER := 1;  -- 0
  constant InitFileName              : STRING  := "/h/dk/w/ael10jso/mips_project/vhdl/mem/program.cde";
  constant Corruption_Read_Violation : BOOLEAN := TRUE;
  constant Debug_mode                : String  := "ALL_WARNING_MODE";
  constant InstancePath              : String  := "ST_SPHDL_4096x32m8_L";

  -- For the imem in-data, should later be removed when we have a bootloader --
  --signal s_dummy_zero_array : std_logic_vector(31 downto 0) := (others => '0');
  
begin  -- Behavioral

  HIGH <= '1';
  LOW <= '0';

  -- instantiating the top --
  mini_mips_inst: mini_mips
    port map (
      clk   => clk_i,
      rst_n => rst_n_i,
      -- in to top record --
      mini_mips_i.dmem_data => s_dmem_to_top_dmem_data,
      mini_mips_i.imem_data => s_imem_to_top_imem_data,
      -- out from top record --
      mini_mips_o.dmem_addr => s_top_to_dmem_dmem_addr,
      mini_mips_o.dmem_data => s_top_to_dmem_dmem_data,
      mini_mips_o.imem_addr => s_top_to_imem_imem_addr,
      mini_mips_o.dmem_wen_n => s_dmem_wen_n,

	  mini_mips_o.alu_result => alu_result_i			-- FOR POST PNR SIMULATION ONLY
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
      Q => s_imem_to_top_imem_data,
      RY => OPEN,     -- "Memory Handshake signal"
      CK => clk_i,
      CSN => LOW,     -- Active low
      TBYPASS => LOW, -- Active high, memory bypass in test mode for datapath checking
      WEN => HIGH,     -- Active low
      A => s_top_to_imem_imem_addr,
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
      InitFileName              => "/h/dk/w/ael10jso/mips_project/vhdl/mem/dmem_init.cde",
      Corruption_Read_Violation => Corruption_Read_Violation,
      Debug_mode                => Debug_mode,
      InstancePath              => InstancePath)
    port map(
      Q => s_dmem_to_top_dmem_data,
      RY => OPEN,      -- "Memory Handshake signal"
      CK => clk_i,
      CSN => LOW,      -- Active low
      TBYPASS => LOW,  -- Active high, memory bypass in test mode for datapath checking
      WEN => s_dmem_wen_n,
      A => s_top_to_dmem_dmem_addr,
      D => s_top_to_dmem_dmem_data
      );

  -- instantiating the pads here --
  clk_pad_in: BD2SCARUDQP_1V8_SF_LIN
    port map (
      IO   => clk,                      -- in to the pad
      ZI   => clk_i,                    -- out from the pad to our design
      A    => LOW,
      EN   => HIGH,
      TA   => LOW,
      TEN  => HIGH,
      TM   => LOW,
      PUN  => LOW,
      PDN  => LOW,
      HYST => LOW);

  rst_n_pad_in: BD2SCARUDQP_1V8_SF_LIN
    port map (
      IO   => rst_n,                      -- in to the pad
      ZI   => rst_n_i,                    -- out from the pad to our design
      A    => LOW,
      EN   => HIGH,
      TA   => LOW,
      TEN  => HIGH,
      TM   => LOW,
      PUN  => LOW,
      PDN  => LOW,
      HYST => LOW);

	-- OUT PADS FROM ALU
	out_pads: for i in 0 to 15 generate
		out_pad : BD2SCARUDQP_1V8_SF_LIN
		port map (
			IO => alu_result(i),		-- in to pad from the world
			ZI => alu_result_i(i),  	-- from pad to our design
			A    => LOW,
			EN   => HIGH,
			TA   => LOW,
			TEN  => HIGH,
			TM   => LOW,
			PUN  => LOW,
			PDN  => LOW,
			HYST => LOW
		);
	end generate out_pads;

end Behavioral;
