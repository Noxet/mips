library ieee;
use ieee.std_logic_1164.all;
use work.constants_pkg.all;
use work.records_pkg.all;
use work.subtypes_pkg.all;

entity hazard_detection is

  port (
    hd_i : hazard_detection_in_t;
    hd_o : hazard_detection_out_t);

end hazard_detection;

architecture behavioral of hazard_detection is
  
begin
    
  hazard_detection: process(hazard_detection_i)
  begin
    
    
    
  end process;
  
end behavioral;
