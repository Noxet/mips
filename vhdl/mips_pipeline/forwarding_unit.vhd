library ieee;
use ieee.std_logic_1164.all;
use work.constants_pkg.all;
use work.records_pkg.all;
use work.subtypes_pkg.all;

entity forwarding_unit is
  
  port (
    forwarding_unit_i : in  forwarding_unit_in_t;
    forwarding_unit_o : out forwarding_unit_out_t);

end forwarding_unit;

architecture behavioral of forwarding_unit is

begin  -- behavioral
  
  forwarding: process(forwarding_unit_i)
  begin
    -- see chapter 4.7 in "computer organization and design" by David A. Patterson & John L. Hennessy --
     if ((forwarding_unit_i.mem_in_RegWrite = '1') and (forwarding_unit_i.mem_in_write_reg /= "00000") and (forwarding_unit_i.mem_in_write_reg = forwarding_unit_i.exe_in_RS)) then 
        forwarding_unit_o.forward_A <= "10";
     elsif ((forwarding_unit_i.wb_in_RegWrite = '1') and (forwarding_unit_i.wb_in_write_reg /= "00000") and (forwarding_unit_i.wb_in_write_reg = forwarding_unit_i.exe_in_RS)) then           
        forwarding_unit_o.forward_A <= "01";
     else 
        forwarding_unit_o.forward_A <= "00";  
     end if;
     
     if ((forwarding_unit_i.mem_in_RegWrite = '1') and (forwarding_unit_i.mem_in_write_reg /= "00000") and (forwarding_unit_i.mem_in_write_reg = forwarding_unit_i.exe_in_RT)) then
        forwarding_unit_o.forward_B <= "10";
     elsif ((forwarding_unit_i.wb_in_RegWrite = '1') and (forwarding_unit_i.wb_in_write_reg /= "00000") and (forwarding_unit_i.wb_in_write_reg = forwarding_unit_i.exe_in_RT)) then  
        forwarding_unit_o.forward_B <= "01";
      else 
        forwarding_unit_o.forward_B <= "00";
     end if;
     
     if ((forwarding_unit_i.wb_in_RegWrite = '1') and (forwarding_unit_i.wb_in_write_reg /= "00000") and (forwarding_unit_i.wb_in_write_reg = forwarding_unit_i.id_out_RS)) then
        forwarding_unit_o.regfile_forward_A <= '1';
     else
        forwarding_unit_o.regfile_forward_A <= '0';
     end if;
     
     if ((forwarding_unit_i.wb_in_RegWrite = '1') and (forwarding_unit_i.wb_in_write_reg /= "00000") and (forwarding_unit_i.wb_in_write_reg = forwarding_unit_i.id_out_RT)) then
        forwarding_unit_o.regfile_forward_B <= '1';
     else
        forwarding_unit_o.regfile_forward_B <= '0';
     end if;   
  end process;  

end behavioral;
