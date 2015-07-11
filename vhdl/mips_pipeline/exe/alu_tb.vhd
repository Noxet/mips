-------------------------------------------------------------------------------
-- Title      : Testbench for design "alu"
-- Project    : 
-------------------------------------------------------------------------------
-- File       : alu_tb.vhd
-- Author     : Jonathan Sönnerup  <noxet@uNoxet>
-- Company    : 
-- Created    : 2014-03-28
-- Last update: 2014-04-11
-- Platform   : 
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2014 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2014-03-28  1.0      noxet	Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

use work.constants_pkg.all;
use work.subtypes_pkg.all;
use work.records_pkg.all;

-------------------------------------------------------------------------------

entity alu_tb is

end entity alu_tb;

-------------------------------------------------------------------------------

architecture testbench of alu_tb is

    -- component ports
    signal clk   : std_logic := '0';
    signal rst_n   : std_logic := '0';
    signal alu_i : alu_in_t;
    signal alu_o : alu_out_t;

    constant clk_period : time := 10 ns;

begin  -- architecture testbench

    -- component instantiation
    DUT: entity work.alu
        port map (
            clk   => clk,
            rst_n   => rst_n,
            alu_i => alu_i,
            alu_o => alu_o);

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
      alu_i.src_a <= (others => '0');
      alu_i.src_b <= (others => '0');
      alu_i.op <= (others => '0');
      alu_i.shamt <= (others => '0');
      rst_n <= '0';
      wait for 2*clk_period;
      rst_n <= '1';
      
      alu_i.src_a <= x"00000008";
      alu_i.src_b <= x"00000004";
      alu_i.op <= ALU_OP_ADDU; wait for clk_period;
      assert alu_o.result = x"0000000C" report "addu failed" severity error;
      
      alu_i.op <= ALU_OP_SUBU; wait for clk_period;
      assert alu_o.result = x"00000004" report "subu failed" severity error;
      
      alu_i.src_a <= x"0000000A";
      alu_i.src_b <= x"00000002";
      alu_i.op <= ALU_OP_AND; wait for clk_period;
      assert alu_o.result = x"00000002" report "and failed" severity error;
   
      alu_i.src_a <= x"0000000A";
      alu_i.src_b <= x"00000006";
      alu_i.op <= ALU_OP_OR; wait for clk_period;
      assert alu_o.result = x"0000000E" report "or failed" severity error;
         
      alu_i.op <= ALU_OP_XOR; wait for clk_period;
      assert alu_o.result = x"0000000C" report "xor failed" severity error;

      alu_i.src_b <= x"000000A3";
      alu_i.shamt <= "00010";
      alu_i.op <= ALU_OP_SLL; wait for clk_period;
      assert alu_o.result = x"0000028C" report "sll failed" severity error;

      alu_i.src_b <= x"ABCDEF98";
      alu_i.shamt <= "01010";
      alu_i.op <= ALU_OP_SRL; wait for clk_period;
      assert alu_o.result = x"002AF37B" report "srl failed" severity error;
            
      alu_i.src_a <= x"8000000A";       -- interpret as signed
      alu_i.src_b <= x"80000004";       -- interpret as signed
      -- A > B (signed)
      
      alu_i.op <=  ALU_OP_SLT; wait for clk_period;
      assert alu_o.result = x"00000000" report "slt failed" severity error;
      
      -- now B is larger than A
      alu_i.src_b <= x"8000000B"; wait for clk_period;      
      assert alu_o.result = x"00000001" report "slt 2 failed" severity error;

      -- A < B, should give 1
      alu_i.src_a <= x"0000000A";
      alu_i.src_b <= x"0000000B";
      alu_i.op <= ALU_OP_SLTU; wait for clk_period;
      assert alu_o.result = x"00000001" report "sltu failed" severity error;

      -- A > B, should give 0
      alu_i.src_a <= x"0000000B";
      alu_i.src_b <= x"0000000A";
      alu_i.op <= ALU_OP_SLTU; wait for clk_period;
      assert alu_o.result = x"00000000" report "sltu failed" severity error;

      alu_i.src_a <= x"00000002";
      alu_i.src_b <= x"00000003";
      alu_i.op <= ALU_OP_MULTU; wait for clk_period;
      assert alu_o.result = x"00000000" report "multu failed" severity error;

      alu_i.op <= ALU_OP_MFLO; wait for clk_period;
      assert alu_o.result = x"00000006" report "multu 2 failed" severity error;

      alu_i.src_a <= x"BBBBBBBB";
      alu_i.src_b <= x"CCCCCCCC";
      alu_i.op <= ALU_OP_MULTU; wait for clk_period;

      alu_i.op <= ALU_OP_MFHI; wait for clk_period;
      assert alu_o.result = x"962FC961" report "multu 3 failed" severity error;

      alu_i.op <= ALU_OP_MFLO; wait for clk_period;
      assert alu_o.result <= x"D0369D04" report "multu 4 failed" severity error;
      
      
      wait;
  end process WaveGen_Proc;

    

end architecture testbench;

-------------------------------------------------------------------------------

configuration alu_tb_testbench_cfg of alu_tb is
    for testbench
    end for;
end alu_tb_testbench_cfg;

-------------------------------------------------------------------------------
