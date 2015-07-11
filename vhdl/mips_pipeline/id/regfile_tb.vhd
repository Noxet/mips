-------------------------------------------------------------------------------
-- Title      : Testbench for design "regfile"
-- Project    : 
-------------------------------------------------------------------------------
-- File       : regfile_tb.vhd
-- Author     : Jonathan Sönnerup  <noxet@uNoxet>
-- Company    : 
-- Created    : 2014-04-04
-- Last update: 2014-04-10
-- Platform   : 
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2014 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2014-04-04  1.0      noxet	Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.records_pkg.all;
use work.subtypes_pkg.all;
use work.constants_pkg.all;

-------------------------------------------------------------------------------

entity regfile_tb is

end entity regfile_tb;

-------------------------------------------------------------------------------

architecture testbench of regfile_tb is

    -- component ports and some shit init
    signal clk       : std_logic := '0';
    signal rst_n     : std_logic := '1';
    signal regfile_i : regfile_in_t := ((others => '0'), (others => '0'), (others => '0'), (others => '0'), '0', '0', '0');
    signal regfile_o : regfile_out_t;

    constant clk_period : time := 10 ns;

begin  -- architecture testbench

    -- component instantiation
    DUT: entity work.regfile
        port map (
            clk       => clk,
            rst_n     => rst_n,
            regfile_i => regfile_i,
            regfile_o => regfile_o);

  clk_proc: process is
  begin  -- process clk_proc
      clk <= '1'; wait for clk_period/2;
      clk <= '0'; wait for clk_period/2;
  end process clk_proc;

  -- waveform generation
  WaveGen_Proc: process
  begin
    -- insert signal assignments here
      rst_n <= '0';
      wait for clk_period;
      rst_n <= '1';
      
      wait until falling_edge(clk);
      
      regfile_i.wr_en <= '1';
      regfile_i.adrwrite <= "00011";
      regfile_i.adrread0 <= "00011";
      regfile_i.write_data <= x"000000AB"; wait until falling_edge(clk);
      regfile_i.wr_en <= '0';
      regfile_i.forward_a <= '0';
      regfile_i.forward_b <= '0';
      
      regfile_i.adrread0 <= "00011"; wait until falling_edge(clk);
      assert regfile_o.read_data0 = x"000000AB" report "read failed";

      -- try to write to reg(0)
      regfile_i.wr_en <= '1';
      regfile_i.adrwrite <= "00000";
      regfile_i.write_data <= x"00000042"; wait until falling_edge(clk);
      regfile_i.wr_en <= '0';

      regfile_i.adrread1 <= "00000"; wait until falling_edge(clk);
      assert regfile_o.read_data1 = x"00000000" report "fail to write to reg(0) failed";

      -- write to 2 random registers
      regfile_i.wr_en <= '1';
      regfile_i.adrwrite <= "10101";
      regfile_i.write_data <= x"89ABCDEF";
      wait until falling_edge(clk);
      regfile_i.adrwrite <= "01010";
      regfile_i.write_data <= x"FEDCBA98";
      wait until falling_edge(clk);

      -- read these 2 registers simultaneously
      regfile_i.wr_en <= '0';
      regfile_i.adrread0 <= "10101";
      regfile_i.adrread1 <= "01010";
      wait until falling_edge(clk);
      assert regfile_o.read_data0 = x"89ABCDEF" report "read data0 failed";
      assert regfile_o.read_data1 = x"FEDCBA98" report "read data1 failed";

      regfile_i.wr_en <= '1';
      regfile_i.adrwrite <= "11100";
      regfile_i.adrread0 <= "11100";
      regfile_i.write_data <= regfile_o.read_data0;
      wait until falling_edge(clk);
      regfile_i.wr_en <= '0';
      wait until falling_edge(clk);
      wait until falling_edge(clk);

      regfile_i.wr_en <= '1';
      regfile_i.adrwrite <= "00100";
      regfile_i.adrread0 <= "00011";
      regfile_i.write_data <= x"42424242";
      regfile_i.forward_a <= '1';
      wait until falling_edge(clk);
      
      
    wait;
  end process WaveGen_Proc;

end architecture testbench;

-------------------------------------------------------------------------------

configuration regfile_tb_testbench_cfg of regfile_tb is
    for testbench
    end for;
end regfile_tb_testbench_cfg;

-------------------------------------------------------------------------------
