library ieee;
use ieee.std_logic_1164.all;
use work.records_pkg.all;
use work.subtypes_pkg.all;
use work.constants_pkg.all;

--- ENTITY ---
entity alu_ctrl_tb is
end alu_ctrl_tb;
--- END ENTITY ---

architecture testbench of alu_ctrl_tb is

    component alu_ctrl
        port (
            alu_ctrl_i : in  alu_ctrl_in_t;
            alu_ctrl_o : out alu_ctrl_out_t);
    end component;

    -- component ports
    signal alu_ctrl_i : alu_ctrl_in_t;
    signal alu_ctrl_o : alu_ctrl_out_t;
    constant clk_period : time := 10 ns;

  -- clock
  signal Clk : std_logic := '1';

begin  -- testbench

    -- component instantiation
    DUT: alu_ctrl port map (
      alu_ctrl_i => alu_ctrl_i,
      alu_ctrl_o => alu_ctrl_o
    );

  -- clock generation
  Clk <= not Clk after 100 ps;

  -- waveform generation
  WaveGen_Proc: process
  begin
      --wait for clk_period;
      alu_ctrl_i.funct <= "000000";      --ADDU
       --constant from constant_pkg, should give output ADDU(00000)
      alu_ctrl_i.op <= CTRL_OP_RTYPE;   
      wait for clk_period;
      -- should still give the same output because the func shouldn't matter (00000)
      alu_ctrl_i.op <= CTRL_OP_ADD;
      wait for clk_period;
      -- the output should change to LUI(01101)
      alu_ctrl_i.op <= CTRL_OP_LUI;
      wait for clk_period;
      -- the output shouldn't shange because the op isn't an RTYPE(01101)
      alu_ctrl_i.funct <= "000011";      --AND
      wait for clk_period;
      -- the output should change to AND because the we now have an RTYPE with
      -- the func AND(00011)
      alu_ctrl_i.op <= CTRL_OP_RTYPE;
      wait for clk_period;
      --the output should change to MFLO(01100)
      alu_ctrl_i.funct <= "001100";
      wait for clk_period;
      --the output should change to J(01110)
      alu_ctrl_i.op <= CTRL_OP_J;
      wait for clk_period;
      --the output should change to SUBU(00001)
      alu_ctrl_i.op <= CTRL_OP_SUB;
      wait;
      --the sequence should be 00000->00000->01101->01101->00011->01100->01110->00001
      
  end process WaveGen_Proc;
end testbench;



