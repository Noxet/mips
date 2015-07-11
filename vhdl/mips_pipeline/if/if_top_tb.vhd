-------------------------------------------------------------------------------
-- Title      : Testbench for design "if_top"
-- Project    : 
-------------------------------------------------------------------------------
-- File       : if_top_tb.vhd
-- Author     : Jonathan Sönnerup  <noxet@uNoxet>
-- Company    : 
-- Created    : 2014-04-06
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
-- 2014-04-06  1.0      noxet	Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.records_pkg.all;
use work.subtypes_pkg.all;
use work.constants_pkg.all;

-------------------------------------------------------------------------------

entity if_top_tb is

end entity if_top_tb;

-------------------------------------------------------------------------------

architecture testbench of if_top_tb is

    -- component ports
    signal clk       : std_logic := '0';
    signal rst_n     : std_logic := '0';
    signal halt_i    : std_logic := '0';
    signal imem_addr : imem_s := (others => '0');
    signal branch_pc : imem_s := (others => '0');
    signal PCSrc : std_logic;
    signal pc_plus1 : imem_s := (others => '0');

    signal regfile_i : regfile_in_t := ((others => '0'), (others => '0'), (others => '0'), (others => '0'), '0', '0', '0');
    signal regfile_o : regfile_out_t;

    constant clk_period : time := 10 ns;

begin  -- architecture testbench

    clk_proc: process is
    begin  -- process clk_proc
        clk <= '1';
        wait for clk_period/2;
        clk <= '0';
        wait for clk_period/2;
    end process clk_proc;

    -- component instantiation
    DUT: entity work.if_top
        port map (
            clk       => clk,
            rst_n     => rst_n,
            if_top_i.halt_i    => halt_i,
            if_top_i.PCSrc     => PCSrc,
            if_top_i.branch_pc => branch_pc,
            if_top_o.imem_addr => imem_addr,
            if_top_o.pc_plus1  => pc_plus1
        );

    DUT_MEM: entity work.regfile
        port map (
            clk         => clk,
            rst_n       => rst_n,
            regfile_i => regfile_i,
            regfile_o => regfile_o);
    

    regfile_i.adrread0 <= imem_addr(4 downto 0);    

    
  -- waveform generation
  WaveGen_Proc: process
  begin
      rst_n <= '0'; wait for 4*clk_period;
      rst_n <= '1';

      regfile_i.adrread1 <= (others => '0');
      regfile_i.adrwrite <= (others => '0');
      regfile_i.write_data <= (others => '0');
      regfile_i.wr_en <= '1';
      
      halt_i <= '1'; 

      -- init I-mem with some data
      regfile_i.adrwrite <= "00000";    -- cant write to reg(0)
      regfile_i.write_data <= (others => '0'); wait for clk_period;
      regfile_i.adrwrite <= "00001";
      regfile_i.write_data <= x"11111111"; wait for clk_period;
      regfile_i.adrwrite <= "00010";
      regfile_i.write_data <= x"22222222"; wait for clk_period;
      regfile_i.adrwrite <= "00011";
      regfile_i.write_data <= x"33333333"; wait for clk_period;
      regfile_i.adrwrite <= "00100";
      regfile_i.write_data <= x"44444444"; wait for clk_period;

      regfile_i.wr_en <= '0';
      halt_i <= '0';
      wait for clk_period;

      assert imem_addr = imem_s(to_unsigned(1, imem_s'length)) report "pc count failed";
      assert regfile_o.read_data0 = x"11111111" report "read 0x11111111 form I-mem failed";
      wait for clk_period;
      -- imem_addr is 2
      wait for clk_period;
      -- imem_addr is 3
      
      halt_i <= '1';
      wait for clk_period;
      -- imem_addr is still 3
      assert imem_addr = imem_s(to_unsigned(3, imem_s'length)) report "halt failed";
      assert regfile_o.read_data0 = x"33333333" report "read 0x33333333 from I-mem failed";
      wait for clk_period;
      -- imem_addr is still 3
      halt_i <= '0';
      wait for clk_period;
      assert imem_addr = imem_s(to_unsigned(4, imem_s'length)) report "unhalt failed";
      assert regfile_o.read_data0 = x"44444444" report "read 0x44444444 from I-mem failed";
      
      

      wait;
  end process WaveGen_Proc;

    

end architecture testbench;

-------------------------------------------------------------------------------

configuration if_top_tb_testbench_cfg of if_top_tb is
    for testbench
    end for;
end if_top_tb_testbench_cfg;

-------------------------------------------------------------------------------
