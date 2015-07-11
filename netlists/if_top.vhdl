
library IEEE,IO65LPHVT_SF_1V8_50A_7M4X0Y2Z,CORE65LPHVT;

use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

entity if_top_DW01_inc_0 is

   port( A : in std_logic_vector (11 downto 0);  SUM : out std_logic_vector (11
         downto 0));

end if_top_DW01_inc_0;

architecture SYN_rpl of if_top_DW01_inc_0 is

   component HS65_LHS_XOR2X3
      port( A, B : in std_logic;  Z : out std_logic);
   end component;
   
   component HS65_LH_IVX9
      port( A : in std_logic;  Z : out std_logic);
   end component;
   
   component HS65_LH_HA1X4
      port( A0, B0 : in std_logic;  CO, S0 : out std_logic);
   end component;
   
   signal carry_11_port, carry_10_port, carry_9_port, carry_8_port, 
      carry_7_port, carry_6_port, carry_5_port, carry_4_port, carry_3_port, 
      carry_2_port : std_logic;

begin
   
   U1_1_10 : HS65_LH_HA1X4 port map( A0 => A(10), B0 => carry_10_port, CO => 
                           carry_11_port, S0 => SUM(10));
   U1_1_9 : HS65_LH_HA1X4 port map( A0 => A(9), B0 => carry_9_port, CO => 
                           carry_10_port, S0 => SUM(9));
   U1_1_8 : HS65_LH_HA1X4 port map( A0 => A(8), B0 => carry_8_port, CO => 
                           carry_9_port, S0 => SUM(8));
   U1_1_7 : HS65_LH_HA1X4 port map( A0 => A(7), B0 => carry_7_port, CO => 
                           carry_8_port, S0 => SUM(7));
   U1_1_6 : HS65_LH_HA1X4 port map( A0 => A(6), B0 => carry_6_port, CO => 
                           carry_7_port, S0 => SUM(6));
   U1_1_5 : HS65_LH_HA1X4 port map( A0 => A(5), B0 => carry_5_port, CO => 
                           carry_6_port, S0 => SUM(5));
   U1_1_4 : HS65_LH_HA1X4 port map( A0 => A(4), B0 => carry_4_port, CO => 
                           carry_5_port, S0 => SUM(4));
   U1_1_3 : HS65_LH_HA1X4 port map( A0 => A(3), B0 => carry_3_port, CO => 
                           carry_4_port, S0 => SUM(3));
   U1_1_2 : HS65_LH_HA1X4 port map( A0 => A(2), B0 => carry_2_port, CO => 
                           carry_3_port, S0 => SUM(2));
   U1_1_1 : HS65_LH_HA1X4 port map( A0 => A(1), B0 => A(0), CO => carry_2_port,
                           S0 => SUM(1));
   U1 : HS65_LH_IVX9 port map( A => A(0), Z => SUM(0));
   U2 : HS65_LHS_XOR2X3 port map( A => carry_11_port, B => A(11), Z => SUM(11))
                           ;

end SYN_rpl;

library IEEE,IO65LPHVT_SF_1V8_50A_7M4X0Y2Z,CORE65LPHVT;

use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

entity pc is

   port( clk, rst_n, halt_i : in std_logic;  npc_i : in std_logic_vector (11 
         downto 0);  pc_o : out std_logic_vector (11 downto 0));

end pc;

architecture SYN_behavioral of pc is

   component HS65_LH_DFPSQX9
      port( D, CP, SN : in std_logic;  Q : out std_logic);
   end component;

begin
   
   pc_o_reg_11_inst : HS65_LH_DFPSQX9 port map( D => npc_i(11), CP => clk, SN 
                           => rst_n, Q => pc_o(11));
   pc_o_reg_10_inst : HS65_LH_DFPSQX9 port map( D => npc_i(10), CP => clk, SN 
                           => rst_n, Q => pc_o(10));
   pc_o_reg_9_inst : HS65_LH_DFPSQX9 port map( D => npc_i(9), CP => clk, SN => 
                           rst_n, Q => pc_o(9));
   pc_o_reg_8_inst : HS65_LH_DFPSQX9 port map( D => npc_i(8), CP => clk, SN => 
                           rst_n, Q => pc_o(8));
   pc_o_reg_7_inst : HS65_LH_DFPSQX9 port map( D => npc_i(7), CP => clk, SN => 
                           rst_n, Q => pc_o(7));
   pc_o_reg_6_inst : HS65_LH_DFPSQX9 port map( D => npc_i(6), CP => clk, SN => 
                           rst_n, Q => pc_o(6));
   pc_o_reg_5_inst : HS65_LH_DFPSQX9 port map( D => npc_i(5), CP => clk, SN => 
                           rst_n, Q => pc_o(5));
   pc_o_reg_4_inst : HS65_LH_DFPSQX9 port map( D => npc_i(4), CP => clk, SN => 
                           rst_n, Q => pc_o(4));
   pc_o_reg_3_inst : HS65_LH_DFPSQX9 port map( D => npc_i(3), CP => clk, SN => 
                           rst_n, Q => pc_o(3));
   pc_o_reg_2_inst : HS65_LH_DFPSQX9 port map( D => npc_i(2), CP => clk, SN => 
                           rst_n, Q => pc_o(2));
   pc_o_reg_1_inst : HS65_LH_DFPSQX9 port map( D => npc_i(1), CP => clk, SN => 
                           rst_n, Q => pc_o(1));
   pc_o_reg_0_inst : HS65_LH_DFPSQX9 port map( D => npc_i(0), CP => clk, SN => 
                           rst_n, Q => pc_o(0));

end SYN_behavioral;

library IEEE,IO65LPHVT_SF_1V8_50A_7M4X0Y2Z,CORE65LPHVT;

use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

entity if_top is

   port( clk, rst_n : in std_logic;  if_top_i : in std_logic_vector (13 downto 
         0);  if_top_o : out std_logic_vector (23 downto 0));

end if_top;

architecture SYN_behavioral of if_top is

   component HS65_LH_IVX9
      port( A : in std_logic;  Z : out std_logic);
   end component;
   
   component HS65_LH_AO22X9
      port( A, B, C, D : in std_logic;  Z : out std_logic);
   end component;
   
   component if_top_DW01_inc_0
      port( A : in std_logic_vector (11 downto 0);  SUM : out std_logic_vector 
            (11 downto 0));
   end component;
   
   component pc
      port( clk, rst_n, halt_i : in std_logic;  npc_i : in std_logic_vector (11
            downto 0);  pc_o : out std_logic_vector (11 downto 0));
   end component;
   
   signal if_top_o_IMEM_ADDR_11_port, if_top_o_IMEM_ADDR_10_port, 
      if_top_o_IMEM_ADDR_9_port, if_top_o_IMEM_ADDR_8_port, 
      if_top_o_IMEM_ADDR_7_port, if_top_o_IMEM_ADDR_6_port, 
      if_top_o_IMEM_ADDR_5_port, if_top_o_IMEM_ADDR_4_port, 
      if_top_o_IMEM_ADDR_3_port, if_top_o_IMEM_ADDR_2_port, 
      if_top_o_IMEM_ADDR_1_port, if_top_o_IMEM_ADDR_0_port, 
      if_top_o_PC_PLUS1_11_port, if_top_o_PC_PLUS1_10_port, 
      if_top_o_PC_PLUS1_9_port, if_top_o_PC_PLUS1_8_port, 
      if_top_o_PC_PLUS1_7_port, if_top_o_PC_PLUS1_6_port, 
      if_top_o_PC_PLUS1_5_port, if_top_o_PC_PLUS1_4_port, 
      if_top_o_PC_PLUS1_3_port, if_top_o_PC_PLUS1_2_port, 
      if_top_o_PC_PLUS1_1_port, if_top_o_PC_PLUS1_0_port, s_npc_11_port, 
      s_npc_10_port, s_npc_9_port, s_npc_8_port, s_npc_7_port, s_npc_6_port, 
      s_npc_5_port, s_npc_4_port, s_npc_3_port, s_npc_2_port, s_npc_1_port, 
      s_npc_0_port, n2 : std_logic;

begin
   if_top_o <= ( if_top_o_IMEM_ADDR_11_port, if_top_o_IMEM_ADDR_10_port, 
      if_top_o_IMEM_ADDR_9_port, if_top_o_IMEM_ADDR_8_port, 
      if_top_o_IMEM_ADDR_7_port, if_top_o_IMEM_ADDR_6_port, 
      if_top_o_IMEM_ADDR_5_port, if_top_o_IMEM_ADDR_4_port, 
      if_top_o_IMEM_ADDR_3_port, if_top_o_IMEM_ADDR_2_port, 
      if_top_o_IMEM_ADDR_1_port, if_top_o_IMEM_ADDR_0_port, 
      if_top_o_PC_PLUS1_11_port, if_top_o_PC_PLUS1_10_port, 
      if_top_o_PC_PLUS1_9_port, if_top_o_PC_PLUS1_8_port, 
      if_top_o_PC_PLUS1_7_port, if_top_o_PC_PLUS1_6_port, 
      if_top_o_PC_PLUS1_5_port, if_top_o_PC_PLUS1_4_port, 
      if_top_o_PC_PLUS1_3_port, if_top_o_PC_PLUS1_2_port, 
      if_top_o_PC_PLUS1_1_port, if_top_o_PC_PLUS1_0_port );
   
   pc_inst : pc port map( clk => clk, rst_n => rst_n, halt_i => if_top_i(13), 
                           npc_i(11) => s_npc_11_port, npc_i(10) => 
                           s_npc_10_port, npc_i(9) => s_npc_9_port, npc_i(8) =>
                           s_npc_8_port, npc_i(7) => s_npc_7_port, npc_i(6) => 
                           s_npc_6_port, npc_i(5) => s_npc_5_port, npc_i(4) => 
                           s_npc_4_port, npc_i(3) => s_npc_3_port, npc_i(2) => 
                           s_npc_2_port, npc_i(1) => s_npc_1_port, npc_i(0) => 
                           s_npc_0_port, pc_o(11) => if_top_o_IMEM_ADDR_11_port
                           , pc_o(10) => if_top_o_IMEM_ADDR_10_port, pc_o(9) =>
                           if_top_o_IMEM_ADDR_9_port, pc_o(8) => 
                           if_top_o_IMEM_ADDR_8_port, pc_o(7) => 
                           if_top_o_IMEM_ADDR_7_port, pc_o(6) => 
                           if_top_o_IMEM_ADDR_6_port, pc_o(5) => 
                           if_top_o_IMEM_ADDR_5_port, pc_o(4) => 
                           if_top_o_IMEM_ADDR_4_port, pc_o(3) => 
                           if_top_o_IMEM_ADDR_3_port, pc_o(2) => 
                           if_top_o_IMEM_ADDR_2_port, pc_o(1) => 
                           if_top_o_IMEM_ADDR_1_port, pc_o(0) => 
                           if_top_o_IMEM_ADDR_0_port);
   add_37 : if_top_DW01_inc_0 port map( A(11) => if_top_o_IMEM_ADDR_11_port, 
                           A(10) => if_top_o_IMEM_ADDR_10_port, A(9) => 
                           if_top_o_IMEM_ADDR_9_port, A(8) => 
                           if_top_o_IMEM_ADDR_8_port, A(7) => 
                           if_top_o_IMEM_ADDR_7_port, A(6) => 
                           if_top_o_IMEM_ADDR_6_port, A(5) => 
                           if_top_o_IMEM_ADDR_5_port, A(4) => 
                           if_top_o_IMEM_ADDR_4_port, A(3) => 
                           if_top_o_IMEM_ADDR_3_port, A(2) => 
                           if_top_o_IMEM_ADDR_2_port, A(1) => 
                           if_top_o_IMEM_ADDR_1_port, A(0) => 
                           if_top_o_IMEM_ADDR_0_port, SUM(11) => 
                           if_top_o_PC_PLUS1_11_port, SUM(10) => 
                           if_top_o_PC_PLUS1_10_port, SUM(9) => 
                           if_top_o_PC_PLUS1_9_port, SUM(8) => 
                           if_top_o_PC_PLUS1_8_port, SUM(7) => 
                           if_top_o_PC_PLUS1_7_port, SUM(6) => 
                           if_top_o_PC_PLUS1_6_port, SUM(5) => 
                           if_top_o_PC_PLUS1_5_port, SUM(4) => 
                           if_top_o_PC_PLUS1_4_port, SUM(3) => 
                           if_top_o_PC_PLUS1_3_port, SUM(2) => 
                           if_top_o_PC_PLUS1_2_port, SUM(1) => 
                           if_top_o_PC_PLUS1_1_port, SUM(0) => 
                           if_top_o_PC_PLUS1_0_port);
   U15 : HS65_LH_AO22X9 port map( A => if_top_o_PC_PLUS1_11_port, B => n2, C =>
                           if_top_i(12), D => if_top_i(0), Z => s_npc_11_port);
   U16 : HS65_LH_AO22X9 port map( A => if_top_o_PC_PLUS1_7_port, B => n2, C => 
                           if_top_i(8), D => if_top_i(0), Z => s_npc_7_port);
   U17 : HS65_LH_AO22X9 port map( A => if_top_o_PC_PLUS1_8_port, B => n2, C => 
                           if_top_i(9), D => if_top_i(0), Z => s_npc_8_port);
   U18 : HS65_LH_AO22X9 port map( A => if_top_o_PC_PLUS1_9_port, B => n2, C => 
                           if_top_i(0), D => if_top_i(10), Z => s_npc_9_port);
   U19 : HS65_LH_AO22X9 port map( A => if_top_o_PC_PLUS1_10_port, B => n2, C =>
                           if_top_i(11), D => if_top_i(0), Z => s_npc_10_port);
   U20 : HS65_LH_AO22X9 port map( A => if_top_o_PC_PLUS1_1_port, B => n2, C => 
                           if_top_i(2), D => if_top_i(0), Z => s_npc_1_port);
   U21 : HS65_LH_AO22X9 port map( A => if_top_o_PC_PLUS1_2_port, B => n2, C => 
                           if_top_i(3), D => if_top_i(0), Z => s_npc_2_port);
   U22 : HS65_LH_AO22X9 port map( A => if_top_o_PC_PLUS1_3_port, B => n2, C => 
                           if_top_i(4), D => if_top_i(0), Z => s_npc_3_port);
   U23 : HS65_LH_AO22X9 port map( A => if_top_o_PC_PLUS1_4_port, B => n2, C => 
                           if_top_i(5), D => if_top_i(0), Z => s_npc_4_port);
   U24 : HS65_LH_AO22X9 port map( A => if_top_o_PC_PLUS1_5_port, B => n2, C => 
                           if_top_i(6), D => if_top_i(0), Z => s_npc_5_port);
   U25 : HS65_LH_AO22X9 port map( A => if_top_o_PC_PLUS1_6_port, B => n2, C => 
                           if_top_i(7), D => if_top_i(0), Z => s_npc_6_port);
   U26 : HS65_LH_AO22X9 port map( A => if_top_o_PC_PLUS1_0_port, B => n2, C => 
                           if_top_i(1), D => if_top_i(0), Z => s_npc_0_port);
   U27 : HS65_LH_IVX9 port map( A => if_top_i(0), Z => n2);

end SYN_behavioral;
