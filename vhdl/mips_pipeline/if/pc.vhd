library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.records_pkg.all;
use work.constants_pkg.all;
use work.subtypes_pkg.all;

entity pc is
    
    port (
        clk    : in  std_logic;
        rst_n  : in  std_logic;
        halt_i : in  std_logic;
        npc_i  : in  imem_s;
        pc_o   : out imem_s);

end entity pc;

architecture behavioral of pc is
	
	signal pc_c, pc_n : imem_s;

begin  -- architecture behavioral

    clk_proc: process (clk, rst_n) is
    begin  -- process clk_proc
        if rst_n = '0' then             -- asynchronous reset (active low)
            pc_c <= (others => '1');
        elsif rising_edge(clk) then  -- rising clock edge
                pc_c <= pc_n;
        end if;
    end process clk_proc;

	pc_o <= pc_c;

	halt_proc: process(halt_i, pc_c, npc_i)
	begin
		if halt_i = '1' then
			pc_n <= pc_c;
		else
			pc_n <= npc_i;
		end if;
	end process;

end architecture behavioral;
