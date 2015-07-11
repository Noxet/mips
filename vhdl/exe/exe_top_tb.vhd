library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

use work.records_pkg.all;
use work.subtypes_pkg.all;
use work.constants_pkg.all;

entity exe_top_tb is
end;

architecture bench of exe_top_tb is

  component exe_top
      port(
          clk       : in  std_logic;
          rst       : in  std_logic;
          exe_top_i : in  exe_top_in_t;
          exe_top_o : out exe_top_out_t
          );
  end component;

  signal clk: std_logic;
  signal rst: std_logic;
  signal exe_top_i: exe_top_in_t;
  signal exe_top_o: exe_top_out_t;

  constant clk_period : time := 10 ns;
  
  -- ARITHMETIC
  constant CTRL_FUNC_ADDU      : std_logic_vector(5 downto 0) := "000000";
  constant CTRL_FUNC_SUBU      : std_logic_vector(5 downto 0) := "000001"; 
  constant CTRL_FUNC_MULTU     : std_logic_vector(5 downto 0) := "000010"; 

  -- LOGICAL
  constant CTRL_FUNC_AND       : std_logic_vector(5 downto 0) := "000011"; 
  constant CTRL_FUNC_OR        : std_logic_vector(5 downto 0) := "000100"; 
  constant CTRL_FUNC_XOR       : std_logic_vector(5 downto 0) := "000101"; 
  constant CTRL_FUNC_SLL       : std_logic_vector(5 downto 0) := "000110"; 
  constant CTRL_FUNC_SRL       : std_logic_vector(5 downto 0) := "000111";           
  constant CTRL_FUNC_SRA       : std_logic_vector(5 downto 0) := "001000";
  constant CTRL_FUNC_SLT       : std_logic_vector(5 downto 0) := "001001";
  constant CTRL_FUNC_SLTU      : std_logic_vector(5 downto 0) := "001010";

  -- DATA TRANSFER
  constant CTRL_FUNC_MFHI      : std_logic_vector(5 downto 0) := "001011";
  constant CTRL_FUNC_MFLO      : std_logic_vector(5 downto 0) := "001100";

  -- UNCONDITIONAL JUMP
  constant CTRL_FUNC_JR        : std_logic_vector(5 downto 0) := "001101";

begin

  uut: exe_top port map ( clk       => clk,
                          rst       => rst,
                          exe_top_i => exe_top_i,
                          exe_top_o => exe_top_o );

  -- clock generation
  clk_proc: process
  begin
      clk <= '1';
      wait for clk_period/2;
      clk <= '0';
      wait for clk_period/2;
  end process;
  
  WaveGen_Proc: process
  begin
      rst <= '0';                               --reset the top
      exe_top_i.shamt <= "00000";                --no shift amount
      exe_top_i.regs_a <= x"00000000";          --source A to the alu
      exe_top_i.alu_src_b <= '0';               --B source set to regs
      exe_top_i.immidiate <= x"00000000";       --immidiate input set to 0
      exe_top_i.regs_b <= x"00000000";          --register input set to 0
      exe_top_i.op <= "0000";                   --operation set to RTYPE
      exe_top_i.funct <= CTRL_FUNC_ADDU;              --function set to ADDU

      wait for clk_period;                      

      rst <= '1';                               --stop resetting
      exe_top_i.regs_a <= x"00000002";          --source A set to 2
      exe_top_i.regs_b <= x"00000003";          --the registers are set to 3

      wait for clk_period;
      
      --assert the previous clock cycle A+B=5
      assert exe_top_o.result = x"00000005" report "wrong result SRC_A(2) + REGS(3)" severity error;
      exe_top_i.alu_src_b <= '1';               --B source set to immidiate(which is 0)

      wait for clk_period;
      
      --assert that A(is still 2) + B(immidiate which is 0) = 2
      assert exe_top_o.result = x"00000002" report "wrong result SRC_A(2) + Immidiate(0)" severity error;
      exe_top_i.immidiate <= x"00000010";       --set immidiate(source B) to 16
      exe_top_i.funct <= CTRL_FUNC_MULTU;              --set funct to multu

      wait for clk_period;

      --we now have mult, the result is set to the HI and LO registers, so
      --result now is still 0
      assert exe_top_o.result = x"00000000" report "we have multiplied, but result isn't 0" severity error;
      exe_top_i.funct <= CTRL_FUNC_MFHI;              --set funct to MFHI, result = 0

      wait for clk_period;

      assert exe_top_o.result = x"00000000" report "MFHI isn't 0 after mult" severity error;
      exe_top_i.funct <= CTRL_FUNC_MFLO;              --set funct to MFLO, result = 32

      wait for clk_period;
      
      assert exe_top_o.result = x"00000020" report "MFLO isn't 32 after mult" severity error;
      exe_top_i.funct <= CTRL_FUNC_SLL;              --set funct to sll
      exe_top_i.shamt <= "00010";                --set shift amount to 2

      wait for clk_period;

      assert exe_top_o.result = x"00000040" report "shifted SRC_A two times left, result should be 8" severity error;
      exe_top_i.op <= "0001";                   --set op to ADD

      wait for clk_period;

      assert exe_top_o.result = x"00000012" report "SRC_A(2) + Immidiate(16) should be 18 but isn't" severity error;
      wait;
      
  end process;
end;
