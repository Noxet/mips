library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

use work.records_pkg.all;
use work.subtypes_pkg.all;
use work.constants_pkg.all;

use work.components_pkg.all;

entity alu_top is
    port(
        clk       : in  std_logic;
        rst_n     : in  std_logic;
        src_a     : in  word_s;
        src_b     : in  word_s;
        op        : in  std_logic_vector(4 downto 0);
        shamt     : in  std_logic_vector(4 downto 0);
        result    : out word_s;
        branch    : out std_logic
        );
end alu_top;

architecture Behavioral of alu_top is

  

begin
  
    
      
    alu_inst: alu
    port map(
        clk             => clk,
        rst_n           => rst_n,
        -- input to top --
        alu_i.src_a     => src_a,     --from exe_top to alu
        alu_i.src_b     => src_b,               --internal top signal
        alu_i.op        => op,      --op from alu ctrl 
        alu_i.shamt     => shamt,     --shift amount from exe_top 
        -- output from top --
        alu_o.result    => result,     --the result from alu out of top
        alu_o.branch      => branch
        );

end Behavioral;
