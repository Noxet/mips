library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use work.records_pkg.all;
use work.subtypes_pkg.all;
use work.constants_pkg.all;

use work.components_pkg.all;

entity id_top is
    
    port (
        clk      : in  std_logic;
        rst_n    : in  std_logic;
        id_top_i : in  id_top_in_t;
        id_top_o : out id_top_out_t);

end id_top;

architecture Behavioral of id_top is

    signal s_adrwrite : std_logic_vector(4 downto 0);

begin  -- Behavioral

    --the MUX in to the register choosing the input write_register
    with id_top_i.regdst select
        s_adrwrite <=
        id_top_i.instruction(20 downto 16) when '0',
        id_top_i.instruction(15 downto 11) when others;

    --the direct outputs from instruction
    id_top_o.instr_31_26 <= id_top_i.instruction(31 downto 26);
    id_top_o.instr_10_6 <= id_top_i.instruction(10 downto 6);
    id_top_o.instr_5_0 <= id_top_i.instruction(5 downto 0);

    --deciding the output sign extend
    id_top_o.sign_extend(31 downto 16) <= (31 downto 16 => id_top_i.instruction(15));
    id_top_o.sign_extend(15 downto 0) <= id_top_i.instruction(15 downto 0);
    
    --the regfile instantiation
    regfile_inst: regfile
        port map(
            clk => clk,
            rst_n => rst_n,
            --insignals
            regfile_i.adrread0          => id_top_i.instruction(25 downto 21), -- read reg 1
            regfile_i.adrread1          => id_top_i.instruction(20 downto 16), -- read reg 2
            regfile_i.adrwrite          => s_adrwrite,                         -- dest reg
            regfile_i.write_data        => id_top_i.writeback_data,
            regfile_i.wr_en             => id_top_i.RegWrite,
            regfile_i.forward_a         => id_top_i.forward_a,
            regfile_i.forward_b         => id_top_i.forward_b,
            --outsignals
            regfile_o.read_data0        => id_top_o.reg_a,
            regfile_o.read_data1        => id_top_o.reg_b
            );
    
end Behavioral;
