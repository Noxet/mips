library ieee;
use ieee.std_logic_1164.all;
use work.records_pkg.all;
use work.subtypes_pkg.all;
use work.constants_pkg.all;

entity id_top_tb is
end entity id_top_tb;

architecture bench of id_top_tb is

  component id_top
      port (
          clk      : in  std_logic;
          rst_n    : in  std_logic;
          id_top_i : in  id_top_in_t;
          id_top_o : out id_top_out_t);
  end component;

  signal clk: std_logic;
  signal rst_n: std_logic;
  signal id_top_i: id_top_in_t := ((others => '0'), (others => '0'), '0', '0', '0', '0');
  signal id_top_o: id_top_out_t;

  signal opt : std_logic_vector(5 downto 0);
  signal rs, rt, rd : std_logic_vector(4 downto 0);
  

  constant clk_period : time := 10 ns;

begin

  uut: id_top port map ( clk      => clk,
                         rst_n    => rst_n,
                         id_top_i => id_top_i,
                         id_top_o => id_top_o );

  clk_proc: process
  begin 
      clk <= '1'; wait for clk_period/2;
      clk <= '0'; wait for clk_period/2;
  end process;
  

  stimulus: process
  begin
      rst_n <= '0';
      wait for clk_period;
      rst_n <= '1';
      wait until falling_edge(clk);

      --part of the instruction which simply passes through the id-stage
      id_top_i.instruction(31 downto 26) <= "101010";--output should be the same
      id_top_i.instruction(5 downto 0)   <= "101010";--func to alu control

      id_top_i.instruction(25 downto 21) <= "00011";--read register 1
      id_top_i.instruction(20 downto 16) <= "00000";--read register 2
     
      id_top_i.instruction(15 downto 11) <= "00011";--into the write register mux
      id_top_i.instruction(10 downto 6)  <= "00000";--mid bits to sign extend

      -- write to reg(3)
      id_top_i.RegWrite <= '1';
      id_top_i.RegDst <= '0';--writes from 15 downto 11
      id_top_i.writeback_data <= x"000000AB";
      
      wait until rising_edge(clk);

      -- read from reg(3)
      id_top_i.RegWrite <= '0';
      id_top_i.instruction(25 downto 21) <= "00011";

      wait until falling_edge(clk);

      assert id_top_o.reg_a = x"000000AB" report "read failed" severity error;
      
      --make sure that the instructions are sent out correctly
      assert id_top_o.instr_31_26 = "101010" report "instruction(31 downto 26) is outputted wrong" severity error;
      assert id_top_o.instr_5_0 = "101010" report "instruction(5 downto 0) is outputted wrong" severity error;

      --try to write to reg(0)
      id_top_i.RegWrite <= '1';
      id_top_i.RegDst   <= '1';--the mux to wr is set to read2("00000")
      id_top_i.writeback_data <= x"00000042";--set the writevalue

      wait until rising_edge(clk);

      id_top_i.RegWrite <= '0';

      wait until falling_edge(clk);

      --is reg(0) still 0 after we have written to it?
      assert id_top_o.reg_b = x"00000000" report "reg(0) isn't 0 after write to it" severity error;

      -- write to 2 random registers
      id_top_i.RegWrite <= '1';
      id_top_i.RegDst <= '0';--write to 15 downto 11
      id_top_i.instruction(15 downto 11) <= "10101";
      id_top_i.writeback_data <= x"89ABCDEF";

      wait until falling_edge(clk);

      id_top_i.instruction(15 downto 11) <= "01010";
      id_top_i.writeback_data <= x"FEDCBA98";

      wait until rising_edge(clk);

      --read from the two registers at the same time
      id_top_i.RegWrite <= '0';
      id_top_i.instruction(25 downto 21) <= "10101";
      id_top_i.instruction(20 downto 16) <= "01010";

      wait until falling_edge(clk);

      assert id_top_o.reg_a = x"89ABCDEF" report "read data0 failed" severity error;
      assert id_top_o.reg_b = x"FEDCBA98" report "read data1 failed" severity error;

      wait until rising_edge(clk);

      --check if the sign extend works
      id_top_i.instruction(15 downto 0) <= x"8000";

      wait until falling_edge(clk);
      
      assert id_top_o.sign_extend = x"FFFF8000" report "the sign extend gives a wrong output" severity error;

      wait;
  end process;


end;
