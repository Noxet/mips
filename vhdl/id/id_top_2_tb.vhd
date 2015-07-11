library ieee;
use ieee.std_logic_1164.all;

use work.records_pkg.all;
use work.subtypes_pkg.all;
use work.constants_pkg.all;

-------------------------------------------------------------------------------

entity id_top_2_tb is

end id_top_2_tb;

-------------------------------------------------------------------------------

architecture testbench of id_top_2_tb is

    component id_top
        port (
            clk      : in  std_logic;
            rst_n    : in  std_logic;
            id_top_i : in  id_top_in_t;
            id_top_o : out id_top_out_t);
    end component;

    -- component ports
    signal clk      : std_logic;
    signal rst_n    : std_logic;
    signal id_top_i : id_top_in_t := ((others => '0'), (others => '0'),'0' ,'0', '0', '0');
    signal id_top_o : id_top_out_t;

    constant clk_period : time := 10 ns;

begin  -- testbench

    -- component instantiation
    DUT: id_top
        port map (
            clk      => clk,
            rst_n    => rst_n,
            id_top_i => id_top_i,
            id_top_o => id_top_o);

    clk_proc: process
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
      
      id_top_i.RegWrite <= '1';
      id_top_i.instruction(25 downto 21) <= "00011";
      id_top_i.instruction(20 downto 16) <= "00011";
      id_top_i.instruction(15 downto 11) <= "00011";
      id_top_i.writeback_data <= x"89ABCDEF";
      
      wait for clk_period;
      
    wait;
  end process WaveGen_Proc;

    
    

end testbench;

-------------------------------------------------------------------------------

configuration id_top_2_tb_testbench_cfg of id_top_2_tb is
    for testbench
    end for;
end id_top_2_tb_testbench_cfg;

-------------------------------------------------------------------------------
