library ieee;
use ieee.std_logic_1164.all;

use work.constants_pkg.all;
use work.subtypes_pkg.all;
use work.records_pkg.all;

-------------------------------------------------------------------------------

entity alu_top_tb is

end entity alu_top_tb;

-------------------------------------------------------------------------------

architecture testbench of alu_top_tb is

    -- component ports
    signal clk   : std_logic := '0';
    signal rst_n   : std_logic := '0';
    signal src_a, src_b, result  : word_s;
    signal op, shamt : std_logic_vector(4 downto 0);
    signal branch : std_logic;

    constant clk_period : time := 10 ns;

    component alu_top
      port (
        clk    : in  std_logic;
        rst_n  : in  std_logic;
        src_a  : in  word_s;
        src_b  : in  word_s;
        op     : in  std_logic_vector(4 downto 0);
        shamt  : in  std_logic_vector(4 downto 0);
        result : out word_s;
        branch : out std_logic);
    end component;

begin  -- architecture testbench

    -- component instantiation
    DUT: alu_top
        port map (
            clk   => clk,
            rst_n   => rst_n,
            src_a => src_a,
            src_b => src_b,
            op => op,
            shamt => shamt,
            -- OUT --
            result => result,
            branch => branch
          );

  -- clock generation
    
  clk_proc: process
  begin
      clk <= '1';
      wait for clk_period/2;
      clk <= '0';
      wait for clk_period/2;
  end process;

  -- waveform generation
  WaveGen_Proc: process
  begin
      -- insert signal assignments here
      -- active low reset!
      src_a <= (others => '0');
      src_b <= (others => '0');
      op <= (others => '0');
      shamt <= (others => '0');
      rst_n <= '0';
      wait for 2*clk_period;
      rst_n <= '1';
      
      src_a <= x"00000008";
      src_b <= x"00000004";
      op <= ALU_OP_ADDU; wait for clk_period;
      assert result = x"0000000C" report "addu failed" severity error;
      
      op <= ALU_OP_SUBU; wait for clk_period;
      assert result = x"00000004" report "subu failed" severity error;
      
      src_a <= x"0000000A";
      src_b <= x"00000002";
      op <= ALU_OP_AND; wait for clk_period;
      assert result = x"00000002" report "and failed" severity error;
   
      src_a <= x"0000000A";
      src_b <= x"00000006";
      op <= ALU_OP_OR; wait for clk_period;
      assert result = x"0000000E" report "or failed" severity error;
         
      op <= ALU_OP_XOR; wait for clk_period;
      assert result = x"0000000C" report "xor failed" severity error;

      src_b <= x"000000A3";
      shamt <= "00010";
      op <= ALU_OP_SLL; wait for clk_period;
      assert result = x"0000028C" report "sll failed" severity error;

      src_b <= x"ABCDEF98";
      shamt <= "01010";
      op <= ALU_OP_SRL; wait for clk_period;
      assert result = x"002AF37B" report "srl failed" severity error;
            
      src_a <= x"8000000A";       -- interpret as signed
      src_b <= x"80000004";       -- interpret as signed
      -- A > B (signed)
      
      op <=  ALU_OP_SLT; wait for clk_period;
      assert result = x"00000000" report "slt failed" severity error;
      
      -- now B is larger than A
      src_b <= x"8000000B"; wait for clk_period;      
      assert result = x"00000001" report "slt 2 failed" severity error;

      -- A < B, should give 1
      src_a <= x"0000000A";
      src_b <= x"0000000B";
      op <= ALU_OP_SLTU; wait for clk_period;
      assert result = x"00000001" report "sltu failed" severity error;

      -- A > B, should give 0
      src_a <= x"0000000B";
      src_b <= x"0000000A";
      op <= ALU_OP_SLTU; wait for clk_period;
      assert result = x"00000000" report "sltu failed" severity error;

      src_a <= x"00000002";
      src_b <= x"00000003";
      op <= ALU_OP_MULTU; wait for clk_period;
      assert result = x"00000000" report "multu failed" severity error;

      op <= ALU_OP_MFLO; wait for clk_period;
      assert result = x"00000006" report "multu 2 failed" severity error;

      src_a <= x"BBBBBBBB";
      src_b <= x"CCCCCCCC";
      op <= ALU_OP_MULTU; wait for clk_period;

      op <= ALU_OP_MFHI; wait for clk_period;
      assert result = x"962FC961" report "multu 3 failed" severity error;

      op <= ALU_OP_MFLO; wait for clk_period;
      assert result <= x"D0369D04" report "multu 4 failed" severity error;
      
      
      wait;
  end process WaveGen_Proc;

    

end architecture testbench;
