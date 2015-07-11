
library IEEE,IO65LPHVT_SF_1V8_50A_7M4X0Y2Z,CORE65LPHVT;

use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

entity if_top_DW01_inc_0 is

   port( A : in std_logic_vector (11 downto 0);  SUM : out std_logic_vector (11
         downto 0));

end if_top_DW01_inc_0;

architecture SYN_rpl of if_top_DW01_inc_0 is

   component HS65_LH_IVX9
      port( A : in std_logic;  Z : out std_logic);
   end component;
   
   component HS65_LHS_XOR2X6
      port( A, B : in std_logic;  Z : out std_logic);
   end component;
   
   component HS65_LH_HA1X4
      port( A0, B0 : in std_logic;  CO, S0 : out std_logic);
   end component;
   
   signal carry_11_port, carry_10_port, carry_9_port, carry_8_port, 
      carry_7_port, carry_6_port, carry_5_port, carry_4_port, carry_3_port, 
      carry_2_port : std_logic;

begin
   
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
   U1_1_10 : HS65_LH_HA1X4 port map( A0 => A(10), B0 => carry_10_port, CO => 
                           carry_11_port, S0 => SUM(10));
   U1 : HS65_LHS_XOR2X6 port map( A => carry_11_port, B => A(11), Z => SUM(11))
                           ;
   U2 : HS65_LH_IVX9 port map( A => A(0), Z => SUM(0));

end SYN_rpl;

library IEEE,IO65LPHVT_SF_1V8_50A_7M4X0Y2Z,CORE65LPHVT;

use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

entity pc is

   port( clk, rst_n, halt_i : in std_logic;  npc_i : in std_logic_vector (11 
         downto 0);  pc_o : out std_logic_vector (11 downto 0));

end pc;

architecture SYN_behavioral of pc is

   component HS65_LH_IVX9
      port( A : in std_logic;  Z : out std_logic);
   end component;
   
   component HS65_LH_AO22X9
      port( A, B, C, D : in std_logic;  Z : out std_logic);
   end component;
   
   component HS65_LH_DFPSQX9
      port( D, CP, SN : in std_logic;  Q : out std_logic);
   end component;
   
   signal pc_o_11_port, pc_o_10_port, pc_o_9_port, pc_o_8_port, pc_o_7_port, 
      pc_o_6_port, pc_o_5_port, pc_o_4_port, pc_o_3_port, pc_o_2_port, 
      pc_o_1_port, pc_o_0_port, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, 
      n13, n15 : std_logic;

begin
   pc_o <= ( pc_o_11_port, pc_o_10_port, pc_o_9_port, pc_o_8_port, pc_o_7_port,
      pc_o_6_port, pc_o_5_port, pc_o_4_port, pc_o_3_port, pc_o_2_port, 
      pc_o_1_port, pc_o_0_port );
   
   pc_c_reg_11_inst : HS65_LH_DFPSQX9 port map( D => n13, CP => clk, SN => 
                           rst_n, Q => pc_o_11_port);
   pc_c_reg_10_inst : HS65_LH_DFPSQX9 port map( D => n12, CP => clk, SN => 
                           rst_n, Q => pc_o_10_port);
   pc_c_reg_9_inst : HS65_LH_DFPSQX9 port map( D => n11, CP => clk, SN => rst_n
                           , Q => pc_o_9_port);
   pc_c_reg_8_inst : HS65_LH_DFPSQX9 port map( D => n10, CP => clk, SN => rst_n
                           , Q => pc_o_8_port);
   pc_c_reg_7_inst : HS65_LH_DFPSQX9 port map( D => n9, CP => clk, SN => rst_n,
                           Q => pc_o_7_port);
   pc_c_reg_6_inst : HS65_LH_DFPSQX9 port map( D => n8, CP => clk, SN => rst_n,
                           Q => pc_o_6_port);
   pc_c_reg_5_inst : HS65_LH_DFPSQX9 port map( D => n7, CP => clk, SN => rst_n,
                           Q => pc_o_5_port);
   pc_c_reg_4_inst : HS65_LH_DFPSQX9 port map( D => n6, CP => clk, SN => rst_n,
                           Q => pc_o_4_port);
   pc_c_reg_3_inst : HS65_LH_DFPSQX9 port map( D => n5, CP => clk, SN => rst_n,
                           Q => pc_o_3_port);
   pc_c_reg_2_inst : HS65_LH_DFPSQX9 port map( D => n4, CP => clk, SN => rst_n,
                           Q => pc_o_2_port);
   pc_c_reg_1_inst : HS65_LH_DFPSQX9 port map( D => n3, CP => clk, SN => rst_n,
                           Q => pc_o_1_port);
   pc_c_reg_0_inst : HS65_LH_DFPSQX9 port map( D => n2, CP => clk, SN => rst_n,
                           Q => pc_o_0_port);
   U2 : HS65_LH_AO22X9 port map( A => pc_o_11_port, B => halt_i, C => npc_i(11)
                           , D => n15, Z => n13);
   U3 : HS65_LH_AO22X9 port map( A => pc_o_5_port, B => halt_i, C => npc_i(5), 
                           D => n15, Z => n7);
   U4 : HS65_LH_AO22X9 port map( A => pc_o_6_port, B => halt_i, C => npc_i(6), 
                           D => n15, Z => n8);
   U5 : HS65_LH_AO22X9 port map( A => pc_o_7_port, B => halt_i, C => npc_i(7), 
                           D => n15, Z => n9);
   U6 : HS65_LH_AO22X9 port map( A => pc_o_8_port, B => halt_i, C => npc_i(8), 
                           D => n15, Z => n10);
   U7 : HS65_LH_AO22X9 port map( A => pc_o_9_port, B => halt_i, C => npc_i(9), 
                           D => n15, Z => n11);
   U8 : HS65_LH_AO22X9 port map( A => pc_o_10_port, B => halt_i, C => npc_i(10)
                           , D => n15, Z => n12);
   U9 : HS65_LH_AO22X9 port map( A => pc_o_1_port, B => halt_i, C => npc_i(1), 
                           D => n15, Z => n3);
   U10 : HS65_LH_AO22X9 port map( A => pc_o_2_port, B => halt_i, C => npc_i(2),
                           D => n15, Z => n4);
   U11 : HS65_LH_AO22X9 port map( A => pc_o_3_port, B => halt_i, C => npc_i(3),
                           D => n15, Z => n5);
   U12 : HS65_LH_AO22X9 port map( A => pc_o_4_port, B => halt_i, C => npc_i(4),
                           D => n15, Z => n6);
   U13 : HS65_LH_AO22X9 port map( A => pc_o_0_port, B => halt_i, C => npc_i(0),
                           D => n15, Z => n2);
   U14 : HS65_LH_IVX9 port map( A => halt_i, Z => n15);

end SYN_behavioral;

library IEEE,IO65LPHVT_SF_1V8_50A_7M4X0Y2Z,CORE65LPHVT;

use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

entity controller is

   port( ctrl_i : in std_logic_vector (5 downto 0);  ctrl_o : out 
         std_logic_vector (9 downto 0));

end controller;

architecture SYN_behavioral of controller is

   component HS65_LH_IVX9
      port( A : in std_logic;  Z : out std_logic);
   end component;
   
   component HS65_LH_NAND2AX7
      port( A, B : in std_logic;  Z : out std_logic);
   end component;
   
   component HS65_LH_AOI12X2
      port( A, B, C : in std_logic;  Z : out std_logic);
   end component;
   
   component HS65_LH_NOR2X6
      port( A, B : in std_logic;  Z : out std_logic);
   end component;
   
   component HS65_LH_OAI21X3
      port( A, B, C : in std_logic;  Z : out std_logic);
   end component;
   
   component HS65_LH_NAND3X5
      port( A, B, C : in std_logic;  Z : out std_logic);
   end component;
   
   component HS65_LH_NAND3AX6
      port( A, B, C : in std_logic;  Z : out std_logic);
   end component;
   
   component HS65_LH_OAI212X5
      port( A, B, C, D, E : in std_logic;  Z : out std_logic);
   end component;
   
   component HS65_LH_NOR3X4
      port( A, B, C : in std_logic;  Z : out std_logic);
   end component;
   
   component HS65_LH_NOR4ABX2
      port( A, B, C, D : in std_logic;  Z : out std_logic);
   end component;
   
   component HS65_LH_AO212X4
      port( A, B, C, D, E : in std_logic;  Z : out std_logic);
   end component;
   
   component HS65_LH_AND2X4
      port( A, B : in std_logic;  Z : out std_logic);
   end component;
   
   signal ctrl_o_REGDST_port, ctrl_o_ALUSRC_B_port, ctrl_o_MEMTOREG_port, 
      ctrl_o_REGWRITE_port, ctrl_o_MEMWEN_N_port, ctrl_o_CALU_OP_1_port, 
      ctrl_o_CALU_OP_0_port, ctrl_o_CALU_OP_3_port, n7, n8, n9, n10, n11, n12, 
      n13, n14, n15, n16, n28, ctrl_o_BRANCH_port, n30, n31, n32 : std_logic;

begin
   ctrl_o <= ( ctrl_o_REGDST_port, ctrl_o_ALUSRC_B_port, ctrl_o_MEMTOREG_port, 
      ctrl_o_REGWRITE_port, ctrl_o_MEMWEN_N_port, ctrl_o_BRANCH_port, 
      ctrl_o_CALU_OP_3_port, ctrl_o_BRANCH_port, ctrl_o_CALU_OP_1_port, 
      ctrl_o_CALU_OP_0_port );
   
   ctrl_o_CALU_OP_3_port <= '0';
   U3 : HS65_LH_AND2X4 port map( A => n15, B => n13, Z => n8);
   U4 : HS65_LH_AO212X4 port map( A => n9, B => n11, C => n32, D => n10, E => 
                           ctrl_o_BRANCH_port, Z => ctrl_o_REGDST_port);
   U5 : HS65_LH_IVX9 port map( A => n14, Z => ctrl_o_BRANCH_port);
   U6 : HS65_LH_NOR3X4 port map( A => n28, B => ctrl_i(2), C => n30, Z => n9);
   U7 : HS65_LH_NOR3X4 port map( A => n28, B => ctrl_i(5), C => n31, Z => n16);
   U8 : HS65_LH_NAND3X5 port map( A => n9, B => n32, C => ctrl_i(5), Z => n12);
   U9 : HS65_LH_NAND3X5 port map( A => ctrl_i(2), B => n30, C => n11, Z => n14)
                           ;
   U10 : HS65_LH_NOR4ABX2 port map( A => n28, B => n31, C => ctrl_i(2), D => 
                           ctrl_i(5), Z => n10);
   U11 : HS65_LH_NOR3X4 port map( A => ctrl_i(4), B => ctrl_i(5), C => 
                           ctrl_i(3), Z => n11);
   U12 : HS65_LH_OAI212X5 port map( A => ctrl_i(4), B => n15, C => n28, D => 
                           n14, E => n12, Z => ctrl_o_CALU_OP_0_port);
   U13 : HS65_LH_NAND3AX6 port map( A => ctrl_i(2), B => n30, C => n16, Z => 
                           n15);
   U14 : HS65_LH_NAND3X5 port map( A => ctrl_i(1), B => n16, C => ctrl_i(2), Z 
                           => n13);
   U15 : HS65_LH_IVX9 port map( A => ctrl_i(0), Z => n28);
   U16 : HS65_LH_OAI21X3 port map( A => ctrl_i(4), B => n8, C => n12, Z => 
                           ctrl_o_ALUSRC_B_port);
   U17 : HS65_LH_OAI21X3 port map( A => ctrl_i(4), B => n13, C => n14, Z => 
                           ctrl_o_CALU_OP_1_port);
   U18 : HS65_LH_IVX9 port map( A => ctrl_i(1), Z => n30);
   U19 : HS65_LH_NOR2X6 port map( A => ctrl_i(3), B => n12, Z => 
                           ctrl_o_MEMTOREG_port);
   U20 : HS65_LH_IVX9 port map( A => ctrl_i(3), Z => n31);
   U21 : HS65_LH_AOI12X2 port map( A => n7, B => n8, C => ctrl_i(4), Z => 
                           ctrl_o_REGWRITE_port);
   U22 : HS65_LH_AOI12X2 port map( A => n9, B => n31, C => n10, Z => n7);
   U23 : HS65_LH_NAND2AX7 port map( A => n12, B => ctrl_i(3), Z => 
                           ctrl_o_MEMWEN_N_port);
   U24 : HS65_LH_IVX9 port map( A => ctrl_i(4), Z => n32);

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
      s_npc_0_port, n3 : std_logic;

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
   U2 : HS65_LH_AO22X9 port map( A => if_top_o_PC_PLUS1_11_port, B => n3, C => 
                           if_top_i(12), D => if_top_i(0), Z => s_npc_11_port);
   U3 : HS65_LH_AO22X9 port map( A => if_top_o_PC_PLUS1_5_port, B => n3, C => 
                           if_top_i(6), D => if_top_i(0), Z => s_npc_5_port);
   U4 : HS65_LH_AO22X9 port map( A => if_top_o_PC_PLUS1_6_port, B => n3, C => 
                           if_top_i(7), D => if_top_i(0), Z => s_npc_6_port);
   U5 : HS65_LH_AO22X9 port map( A => if_top_o_PC_PLUS1_7_port, B => n3, C => 
                           if_top_i(8), D => if_top_i(0), Z => s_npc_7_port);
   U6 : HS65_LH_AO22X9 port map( A => if_top_o_PC_PLUS1_8_port, B => n3, C => 
                           if_top_i(9), D => if_top_i(0), Z => s_npc_8_port);
   U7 : HS65_LH_AO22X9 port map( A => if_top_o_PC_PLUS1_9_port, B => n3, C => 
                           if_top_i(0), D => if_top_i(10), Z => s_npc_9_port);
   U8 : HS65_LH_AO22X9 port map( A => if_top_o_PC_PLUS1_10_port, B => n3, C => 
                           if_top_i(11), D => if_top_i(0), Z => s_npc_10_port);
   U9 : HS65_LH_AO22X9 port map( A => if_top_o_PC_PLUS1_1_port, B => n3, C => 
                           if_top_i(2), D => if_top_i(0), Z => s_npc_1_port);
   U10 : HS65_LH_AO22X9 port map( A => if_top_o_PC_PLUS1_2_port, B => n3, C => 
                           if_top_i(3), D => if_top_i(0), Z => s_npc_2_port);
   U11 : HS65_LH_AO22X9 port map( A => if_top_o_PC_PLUS1_3_port, B => n3, C => 
                           if_top_i(4), D => if_top_i(0), Z => s_npc_3_port);
   U12 : HS65_LH_AO22X9 port map( A => if_top_o_PC_PLUS1_4_port, B => n3, C => 
                           if_top_i(5), D => if_top_i(0), Z => s_npc_4_port);
   U13 : HS65_LH_AO22X9 port map( A => if_top_o_PC_PLUS1_0_port, B => n3, C => 
                           if_top_i(1), D => if_top_i(0), Z => s_npc_0_port);
   U14 : HS65_LH_IVX9 port map( A => if_top_i(0), Z => n3);

end SYN_behavioral;

library IEEE,IO65LPHVT_SF_1V8_50A_7M4X0Y2Z,CORE65LPHVT;

use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

entity mini_mips is

   port( clk, rst_n : in std_logic;  mini_mips_i : in std_logic_vector (63 
         downto 0);  mini_mips_o : out std_logic_vector (72 downto 0));

end mini_mips;

architecture SYN_Behavioral of mini_mips is

   component HS65_LH_AO22X9
      port( A, B, C, D : in std_logic;  Z : out std_logic);
   end component;
   
   component HS65_LH_IVX9
      port( A : in std_logic;  Z : out std_logic);
   end component;
   
   component HS65_LH_BFX9
      port( A : in std_logic;  Z : out std_logic);
   end component;
   
   component controller
      port( ctrl_i : in std_logic_vector (5 downto 0);  ctrl_o : out 
            std_logic_vector (9 downto 0));
   end component;
   
   component exe_top
      port( clk, rst_n : in std_logic;  exe_top_i : in std_logic_vector (123 
            downto 0);  exe_top_o : out std_logic_vector (44 downto 0));
   end component;
   
   component id_top
      port( clk, rst_n : in std_logic;  id_top_i : in std_logic_vector (67 
            downto 0);  id_top_o : out std_logic_vector (112 downto 0));
   end component;
   
   component if_top
      port( clk, rst_n : in std_logic;  if_top_i : in std_logic_vector (13 
            downto 0);  if_top_o : out std_logic_vector (23 downto 0));
   end component;
   
   component HS65_LH_DFPQX9
      port( D, CP : in std_logic;  Q : out std_logic);
   end component;
   
   signal X_Logic0_port, mini_mips_o_DMEM_ADDR_11_port, 
      mini_mips_o_DMEM_ADDR_10_port, mini_mips_o_DMEM_ADDR_9_port, 
      mini_mips_o_DMEM_ADDR_8_port, mini_mips_o_DMEM_ADDR_7_port, 
      mini_mips_o_DMEM_ADDR_6_port, mini_mips_o_DMEM_ADDR_5_port, 
      mini_mips_o_DMEM_ADDR_4_port, mini_mips_o_DMEM_ADDR_3_port, 
      mini_mips_o_DMEM_ADDR_2_port, mini_mips_o_DMEM_ADDR_1_port, 
      mini_mips_o_DMEM_ADDR_0_port, mini_mips_o_DMEM_DATA_31_port, 
      mini_mips_o_DMEM_DATA_30_port, mini_mips_o_DMEM_DATA_29_port, 
      mini_mips_o_DMEM_DATA_28_port, mini_mips_o_DMEM_DATA_27_port, 
      mini_mips_o_DMEM_DATA_26_port, mini_mips_o_DMEM_DATA_25_port, 
      mini_mips_o_DMEM_DATA_24_port, mini_mips_o_DMEM_DATA_23_port, 
      mini_mips_o_DMEM_DATA_22_port, mini_mips_o_DMEM_DATA_21_port, 
      mini_mips_o_DMEM_DATA_20_port, mini_mips_o_DMEM_DATA_19_port, 
      mini_mips_o_DMEM_DATA_18_port, mini_mips_o_DMEM_DATA_17_port, 
      mini_mips_o_DMEM_DATA_16_port, mini_mips_o_DMEM_DATA_15_port, 
      mini_mips_o_DMEM_DATA_14_port, mini_mips_o_DMEM_DATA_13_port, 
      mini_mips_o_DMEM_DATA_12_port, mini_mips_o_DMEM_DATA_11_port, 
      mini_mips_o_DMEM_DATA_10_port, mini_mips_o_DMEM_DATA_9_port, 
      mini_mips_o_DMEM_DATA_8_port, mini_mips_o_DMEM_DATA_7_port, 
      mini_mips_o_DMEM_DATA_6_port, mini_mips_o_DMEM_DATA_5_port, 
      mini_mips_o_DMEM_DATA_4_port, mini_mips_o_DMEM_DATA_3_port, 
      mini_mips_o_DMEM_DATA_2_port, mini_mips_o_DMEM_DATA_1_port, 
      mini_mips_o_DMEM_DATA_0_port, mini_mips_o_IMEM_ADDR_11_port, 
      mini_mips_o_IMEM_ADDR_10_port, mini_mips_o_IMEM_ADDR_9_port, 
      mini_mips_o_IMEM_ADDR_8_port, mini_mips_o_IMEM_ADDR_7_port, 
      mini_mips_o_IMEM_ADDR_6_port, mini_mips_o_IMEM_ADDR_5_port, 
      mini_mips_o_IMEM_ADDR_4_port, mini_mips_o_IMEM_ADDR_3_port, 
      mini_mips_o_IMEM_ADDR_2_port, mini_mips_o_IMEM_ADDR_1_port, 
      mini_mips_o_IMEM_ADDR_0_port, mini_mips_o_DMEM_WEN_N_port, 
      mini_mips_o_ALU_RESULT_15_port, mini_mips_o_ALU_RESULT_14_port, 
      mini_mips_o_ALU_RESULT_13_port, mini_mips_o_ALU_RESULT_12_port, 
      mini_mips_o_ALU_RESULT_11_port, mini_mips_o_ALU_RESULT_10_port, 
      mini_mips_o_ALU_RESULT_9_port, mini_mips_o_ALU_RESULT_8_port, 
      mini_mips_o_ALU_RESULT_7_port, mini_mips_o_ALU_RESULT_6_port, 
      mini_mips_o_ALU_RESULT_5_port, mini_mips_o_ALU_RESULT_4_port, 
      mini_mips_o_ALU_RESULT_3_port, mini_mips_o_ALU_RESULT_2_port, 
      mini_mips_o_ALU_RESULT_1_port, mini_mips_o_ALU_RESULT_0_port, 
      s_exe_result_31_port, s_exe_result_30_port, s_exe_result_29_port, 
      s_exe_result_28_port, s_exe_result_27_port, s_exe_result_26_port, 
      s_exe_result_25_port, s_exe_result_24_port, s_exe_result_23_port, 
      s_exe_result_22_port, s_exe_result_21_port, s_exe_result_20_port, 
      s_exe_result_19_port, s_exe_result_18_port, s_exe_result_17_port, 
      s_exe_result_16_port, s_exe_result_15_port, s_exe_result_14_port, 
      s_exe_result_13_port, s_exe_result_12_port, s_if_PCSrc, s_MemtoReg, 
      s_writeback_data_31_port, s_writeback_data_30_port, 
      s_writeback_data_29_port, s_writeback_data_28_port, 
      s_writeback_data_27_port, s_writeback_data_26_port, 
      s_writeback_data_25_port, s_writeback_data_24_port, 
      s_writeback_data_23_port, s_writeback_data_22_port, 
      s_writeback_data_21_port, s_writeback_data_20_port, 
      s_writeback_data_19_port, s_writeback_data_18_port, 
      s_writeback_data_17_port, s_writeback_data_16_port, 
      s_writeback_data_15_port, s_writeback_data_14_port, 
      s_writeback_data_13_port, s_writeback_data_12_port, 
      s_writeback_data_11_port, s_writeback_data_10_port, 
      s_writeback_data_9_port, s_writeback_data_8_port, s_writeback_data_7_port
      , s_writeback_data_6_port, s_writeback_data_5_port, 
      s_writeback_data_4_port, s_writeback_data_3_port, s_writeback_data_2_port
      , s_writeback_data_1_port, s_writeback_data_0_port, 
      s_exe_if_branch_pc_11_port, s_exe_if_branch_pc_10_port, 
      s_exe_if_branch_pc_9_port, s_exe_if_branch_pc_8_port, 
      s_exe_if_branch_pc_7_port, s_exe_if_branch_pc_6_port, 
      s_exe_if_branch_pc_5_port, s_exe_if_branch_pc_4_port, 
      s_exe_if_branch_pc_3_port, s_exe_if_branch_pc_2_port, 
      s_exe_if_branch_pc_1_port, s_exe_if_branch_pc_0_port, 
      s_if_exe_pc_plus1_11_port, s_if_exe_pc_plus1_10_port, 
      s_if_exe_pc_plus1_9_port, s_if_exe_pc_plus1_8_port, 
      s_if_exe_pc_plus1_7_port, s_if_exe_pc_plus1_6_port, 
      s_if_exe_pc_plus1_5_port, s_if_exe_pc_plus1_4_port, 
      s_if_exe_pc_plus1_3_port, s_if_exe_pc_plus1_2_port, 
      s_if_exe_pc_plus1_1_port, s_if_exe_pc_plus1_0_port, s_id_ctrl_regWrite, 
      s_id_ctrl_RegDst, s_id_ctrl_opcode_5_port, s_id_ctrl_opcode_4_port, 
      s_id_ctrl_opcode_3_port, s_id_ctrl_opcode_2_port, s_id_ctrl_opcode_1_port
      , s_id_ctrl_opcode_0_port, s_exe_ctrl_alu_src_b, s_exe_ctrl_op_2_port, 
      s_exe_ctrl_op_1_port, s_exe_ctrl_op_0_port, s_id_exe_shamt_4_port, 
      s_id_exe_shamt_3_port, s_id_exe_shamt_2_port, s_id_exe_shamt_1_port, 
      s_id_exe_shamt_0_port, s_id_exe_reg_a_9_port, s_id_exe_reg_a_8_port, 
      s_id_exe_reg_a_7_port, s_id_exe_reg_a_6_port, s_id_exe_reg_a_5_port, 
      s_id_exe_reg_a_4_port, s_id_exe_reg_a_3_port, s_id_exe_reg_a_31_port, 
      s_id_exe_reg_a_30_port, s_id_exe_reg_a_2_port, s_id_exe_reg_a_29_port, 
      s_id_exe_reg_a_28_port, s_id_exe_reg_a_27_port, s_id_exe_reg_a_26_port, 
      s_id_exe_reg_a_25_port, s_id_exe_reg_a_24_port, s_id_exe_reg_a_23_port, 
      s_id_exe_reg_a_22_port, s_id_exe_reg_a_21_port, s_id_exe_reg_a_20_port, 
      s_id_exe_reg_a_1_port, s_id_exe_reg_a_19_port, s_id_exe_reg_a_18_port, 
      s_id_exe_reg_a_17_port, s_id_exe_reg_a_16_port, s_id_exe_reg_a_15_port, 
      s_id_exe_reg_a_14_port, s_id_exe_reg_a_13_port, s_id_exe_reg_a_12_port, 
      s_id_exe_reg_a_11_port, s_id_exe_reg_a_10_port, s_id_exe_reg_a_0_port, 
      s_id_exe_immidiate_9_port, s_id_exe_immidiate_8_port, 
      s_id_exe_immidiate_7_port, s_id_exe_immidiate_6_port, 
      s_id_exe_immidiate_5_port, s_id_exe_immidiate_4_port, 
      s_id_exe_immidiate_3_port, s_id_exe_immidiate_31_port, 
      s_id_exe_immidiate_30_port, s_id_exe_immidiate_2_port, 
      s_id_exe_immidiate_29_port, s_id_exe_immidiate_28_port, 
      s_id_exe_immidiate_27_port, s_id_exe_immidiate_26_port, 
      s_id_exe_immidiate_25_port, s_id_exe_immidiate_24_port, 
      s_id_exe_immidiate_23_port, s_id_exe_immidiate_22_port, 
      s_id_exe_immidiate_21_port, s_id_exe_immidiate_20_port, 
      s_id_exe_immidiate_1_port, s_id_exe_immidiate_19_port, 
      s_id_exe_immidiate_18_port, s_id_exe_immidiate_17_port, 
      s_id_exe_immidiate_16_port, s_id_exe_immidiate_15_port, 
      s_id_exe_immidiate_14_port, s_id_exe_immidiate_13_port, 
      s_id_exe_immidiate_12_port, s_id_exe_immidiate_11_port, 
      s_id_exe_immidiate_10_port, s_id_exe_immidiate_0_port, 
      s_id_exe_funct_5_port, s_id_exe_funct_4_port, s_id_exe_funct_3_port, 
      s_id_exe_funct_2_port, s_id_exe_funct_1_port, s_id_exe_funct_0_port, n8, 
      n9, n10, n11, n12, n13, n14, n_1000, n_1001 : std_logic;

begin
   mini_mips_o <= ( mini_mips_o_DMEM_ADDR_11_port, 
      mini_mips_o_DMEM_ADDR_10_port, mini_mips_o_DMEM_ADDR_9_port, 
      mini_mips_o_DMEM_ADDR_8_port, mini_mips_o_DMEM_ADDR_7_port, 
      mini_mips_o_DMEM_ADDR_6_port, mini_mips_o_DMEM_ADDR_5_port, 
      mini_mips_o_DMEM_ADDR_4_port, mini_mips_o_DMEM_ADDR_3_port, 
      mini_mips_o_DMEM_ADDR_2_port, mini_mips_o_DMEM_ADDR_1_port, 
      mini_mips_o_DMEM_ADDR_0_port, mini_mips_o_DMEM_DATA_31_port, 
      mini_mips_o_DMEM_DATA_30_port, mini_mips_o_DMEM_DATA_29_port, 
      mini_mips_o_DMEM_DATA_28_port, mini_mips_o_DMEM_DATA_27_port, 
      mini_mips_o_DMEM_DATA_26_port, mini_mips_o_DMEM_DATA_25_port, 
      mini_mips_o_DMEM_DATA_24_port, mini_mips_o_DMEM_DATA_23_port, 
      mini_mips_o_DMEM_DATA_22_port, mini_mips_o_DMEM_DATA_21_port, 
      mini_mips_o_DMEM_DATA_20_port, mini_mips_o_DMEM_DATA_19_port, 
      mini_mips_o_DMEM_DATA_18_port, mini_mips_o_DMEM_DATA_17_port, 
      mini_mips_o_DMEM_DATA_16_port, mini_mips_o_DMEM_DATA_15_port, 
      mini_mips_o_DMEM_DATA_14_port, mini_mips_o_DMEM_DATA_13_port, 
      mini_mips_o_DMEM_DATA_12_port, mini_mips_o_DMEM_DATA_11_port, 
      mini_mips_o_DMEM_DATA_10_port, mini_mips_o_DMEM_DATA_9_port, 
      mini_mips_o_DMEM_DATA_8_port, mini_mips_o_DMEM_DATA_7_port, 
      mini_mips_o_DMEM_DATA_6_port, mini_mips_o_DMEM_DATA_5_port, 
      mini_mips_o_DMEM_DATA_4_port, mini_mips_o_DMEM_DATA_3_port, 
      mini_mips_o_DMEM_DATA_2_port, mini_mips_o_DMEM_DATA_1_port, 
      mini_mips_o_DMEM_DATA_0_port, mini_mips_o_IMEM_ADDR_11_port, 
      mini_mips_o_IMEM_ADDR_10_port, mini_mips_o_IMEM_ADDR_9_port, 
      mini_mips_o_IMEM_ADDR_8_port, mini_mips_o_IMEM_ADDR_7_port, 
      mini_mips_o_IMEM_ADDR_6_port, mini_mips_o_IMEM_ADDR_5_port, 
      mini_mips_o_IMEM_ADDR_4_port, mini_mips_o_IMEM_ADDR_3_port, 
      mini_mips_o_IMEM_ADDR_2_port, mini_mips_o_IMEM_ADDR_1_port, 
      mini_mips_o_IMEM_ADDR_0_port, mini_mips_o_DMEM_WEN_N_port, 
      mini_mips_o_ALU_RESULT_15_port, mini_mips_o_ALU_RESULT_14_port, 
      mini_mips_o_ALU_RESULT_13_port, mini_mips_o_ALU_RESULT_12_port, 
      mini_mips_o_ALU_RESULT_11_port, mini_mips_o_ALU_RESULT_10_port, 
      mini_mips_o_ALU_RESULT_9_port, mini_mips_o_ALU_RESULT_8_port, 
      mini_mips_o_ALU_RESULT_7_port, mini_mips_o_ALU_RESULT_6_port, 
      mini_mips_o_ALU_RESULT_5_port, mini_mips_o_ALU_RESULT_4_port, 
      mini_mips_o_ALU_RESULT_3_port, mini_mips_o_ALU_RESULT_2_port, 
      mini_mips_o_ALU_RESULT_1_port, mini_mips_o_ALU_RESULT_0_port );
   
   X_Logic0_port <= '0';
   mini_mips_o_reg_ALU_RESULT_15_inst : HS65_LH_DFPQX9 port map( D => 
                           s_exe_result_15_port, CP => clk, Q => 
                           mini_mips_o_ALU_RESULT_15_port);
   mini_mips_o_reg_ALU_RESULT_14_inst : HS65_LH_DFPQX9 port map( D => 
                           s_exe_result_14_port, CP => clk, Q => 
                           mini_mips_o_ALU_RESULT_14_port);
   mini_mips_o_reg_ALU_RESULT_13_inst : HS65_LH_DFPQX9 port map( D => 
                           s_exe_result_13_port, CP => clk, Q => 
                           mini_mips_o_ALU_RESULT_13_port);
   mini_mips_o_reg_ALU_RESULT_12_inst : HS65_LH_DFPQX9 port map( D => 
                           s_exe_result_12_port, CP => clk, Q => 
                           mini_mips_o_ALU_RESULT_12_port);
   mini_mips_o_reg_ALU_RESULT_11_inst : HS65_LH_DFPQX9 port map( D => 
                           mini_mips_o_DMEM_ADDR_11_port, CP => clk, Q => 
                           mini_mips_o_ALU_RESULT_11_port);
   mini_mips_o_reg_ALU_RESULT_10_inst : HS65_LH_DFPQX9 port map( D => 
                           mini_mips_o_DMEM_ADDR_10_port, CP => clk, Q => 
                           mini_mips_o_ALU_RESULT_10_port);
   mini_mips_o_reg_ALU_RESULT_9_inst : HS65_LH_DFPQX9 port map( D => 
                           mini_mips_o_DMEM_ADDR_9_port, CP => clk, Q => 
                           mini_mips_o_ALU_RESULT_9_port);
   mini_mips_o_reg_ALU_RESULT_8_inst : HS65_LH_DFPQX9 port map( D => 
                           mini_mips_o_DMEM_ADDR_8_port, CP => clk, Q => 
                           mini_mips_o_ALU_RESULT_8_port);
   mini_mips_o_reg_ALU_RESULT_7_inst : HS65_LH_DFPQX9 port map( D => 
                           mini_mips_o_DMEM_ADDR_7_port, CP => clk, Q => 
                           mini_mips_o_ALU_RESULT_7_port);
   mini_mips_o_reg_ALU_RESULT_6_inst : HS65_LH_DFPQX9 port map( D => 
                           mini_mips_o_DMEM_ADDR_6_port, CP => clk, Q => 
                           mini_mips_o_ALU_RESULT_6_port);
   mini_mips_o_reg_ALU_RESULT_5_inst : HS65_LH_DFPQX9 port map( D => 
                           mini_mips_o_DMEM_ADDR_5_port, CP => clk, Q => 
                           mini_mips_o_ALU_RESULT_5_port);
   mini_mips_o_reg_ALU_RESULT_4_inst : HS65_LH_DFPQX9 port map( D => 
                           mini_mips_o_DMEM_ADDR_4_port, CP => clk, Q => 
                           mini_mips_o_ALU_RESULT_4_port);
   mini_mips_o_reg_ALU_RESULT_3_inst : HS65_LH_DFPQX9 port map( D => 
                           mini_mips_o_DMEM_ADDR_3_port, CP => clk, Q => 
                           mini_mips_o_ALU_RESULT_3_port);
   mini_mips_o_reg_ALU_RESULT_2_inst : HS65_LH_DFPQX9 port map( D => 
                           mini_mips_o_DMEM_ADDR_2_port, CP => clk, Q => 
                           mini_mips_o_ALU_RESULT_2_port);
   mini_mips_o_reg_ALU_RESULT_1_inst : HS65_LH_DFPQX9 port map( D => 
                           mini_mips_o_DMEM_ADDR_1_port, CP => clk, Q => 
                           mini_mips_o_ALU_RESULT_1_port);
   mini_mips_o_reg_ALU_RESULT_0_inst : HS65_LH_DFPQX9 port map( D => 
                           mini_mips_o_DMEM_ADDR_0_port, CP => clk, Q => 
                           mini_mips_o_ALU_RESULT_0_port);
   if_top_inst : if_top port map( clk => clk, rst_n => rst_n, if_top_i(13) => 
                           X_Logic0_port, if_top_i(12) => 
                           s_exe_if_branch_pc_11_port, if_top_i(11) => 
                           s_exe_if_branch_pc_10_port, if_top_i(10) => 
                           s_exe_if_branch_pc_9_port, if_top_i(9) => 
                           s_exe_if_branch_pc_8_port, if_top_i(8) => 
                           s_exe_if_branch_pc_7_port, if_top_i(7) => 
                           s_exe_if_branch_pc_6_port, if_top_i(6) => 
                           s_exe_if_branch_pc_5_port, if_top_i(5) => 
                           s_exe_if_branch_pc_4_port, if_top_i(4) => 
                           s_exe_if_branch_pc_3_port, if_top_i(3) => 
                           s_exe_if_branch_pc_2_port, if_top_i(2) => 
                           s_exe_if_branch_pc_1_port, if_top_i(1) => 
                           s_exe_if_branch_pc_0_port, if_top_i(0) => s_if_PCSrc
                           , if_top_o(23) => mini_mips_o_IMEM_ADDR_11_port, 
                           if_top_o(22) => mini_mips_o_IMEM_ADDR_10_port, 
                           if_top_o(21) => mini_mips_o_IMEM_ADDR_9_port, 
                           if_top_o(20) => mini_mips_o_IMEM_ADDR_8_port, 
                           if_top_o(19) => mini_mips_o_IMEM_ADDR_7_port, 
                           if_top_o(18) => mini_mips_o_IMEM_ADDR_6_port, 
                           if_top_o(17) => mini_mips_o_IMEM_ADDR_5_port, 
                           if_top_o(16) => mini_mips_o_IMEM_ADDR_4_port, 
                           if_top_o(15) => mini_mips_o_IMEM_ADDR_3_port, 
                           if_top_o(14) => mini_mips_o_IMEM_ADDR_2_port, 
                           if_top_o(13) => mini_mips_o_IMEM_ADDR_1_port, 
                           if_top_o(12) => mini_mips_o_IMEM_ADDR_0_port, 
                           if_top_o(11) => s_if_exe_pc_plus1_11_port, 
                           if_top_o(10) => s_if_exe_pc_plus1_10_port, 
                           if_top_o(9) => s_if_exe_pc_plus1_9_port, if_top_o(8)
                           => s_if_exe_pc_plus1_8_port, if_top_o(7) => 
                           s_if_exe_pc_plus1_7_port, if_top_o(6) => 
                           s_if_exe_pc_plus1_6_port, if_top_o(5) => 
                           s_if_exe_pc_plus1_5_port, if_top_o(4) => 
                           s_if_exe_pc_plus1_4_port, if_top_o(3) => 
                           s_if_exe_pc_plus1_3_port, if_top_o(2) => 
                           s_if_exe_pc_plus1_2_port, if_top_o(1) => 
                           s_if_exe_pc_plus1_1_port, if_top_o(0) => 
                           s_if_exe_pc_plus1_0_port);
   id_top_inst : id_top port map( clk => clk, rst_n => rst_n, id_top_i(67) => 
                           mini_mips_i(31), id_top_i(66) => mini_mips_i(30), 
                           id_top_i(65) => mini_mips_i(29), id_top_i(64) => 
                           mini_mips_i(28), id_top_i(63) => mini_mips_i(27), 
                           id_top_i(62) => mini_mips_i(26), id_top_i(61) => 
                           mini_mips_i(25), id_top_i(60) => mini_mips_i(24), 
                           id_top_i(59) => mini_mips_i(23), id_top_i(58) => 
                           mini_mips_i(22), id_top_i(57) => mini_mips_i(21), 
                           id_top_i(56) => mini_mips_i(20), id_top_i(55) => 
                           mini_mips_i(19), id_top_i(54) => mini_mips_i(18), 
                           id_top_i(53) => mini_mips_i(17), id_top_i(52) => 
                           mini_mips_i(16), id_top_i(51) => mini_mips_i(15), 
                           id_top_i(50) => mini_mips_i(14), id_top_i(49) => 
                           mini_mips_i(13), id_top_i(48) => mini_mips_i(12), 
                           id_top_i(47) => mini_mips_i(11), id_top_i(46) => 
                           mini_mips_i(10), id_top_i(45) => mini_mips_i(9), 
                           id_top_i(44) => mini_mips_i(8), id_top_i(43) => 
                           mini_mips_i(7), id_top_i(42) => mini_mips_i(6), 
                           id_top_i(41) => mini_mips_i(5), id_top_i(40) => 
                           mini_mips_i(4), id_top_i(39) => mini_mips_i(3), 
                           id_top_i(38) => mini_mips_i(2), id_top_i(37) => 
                           mini_mips_i(1), id_top_i(36) => mini_mips_i(0), 
                           id_top_i(35) => s_writeback_data_31_port, 
                           id_top_i(34) => s_writeback_data_30_port, 
                           id_top_i(33) => s_writeback_data_29_port, 
                           id_top_i(32) => s_writeback_data_28_port, 
                           id_top_i(31) => s_writeback_data_27_port, 
                           id_top_i(30) => s_writeback_data_26_port, 
                           id_top_i(29) => s_writeback_data_25_port, 
                           id_top_i(28) => s_writeback_data_24_port, 
                           id_top_i(27) => s_writeback_data_23_port, 
                           id_top_i(26) => s_writeback_data_22_port, 
                           id_top_i(25) => s_writeback_data_21_port, 
                           id_top_i(24) => s_writeback_data_20_port, 
                           id_top_i(23) => s_writeback_data_19_port, 
                           id_top_i(22) => s_writeback_data_18_port, 
                           id_top_i(21) => s_writeback_data_17_port, 
                           id_top_i(20) => s_writeback_data_16_port, 
                           id_top_i(19) => s_writeback_data_15_port, 
                           id_top_i(18) => s_writeback_data_14_port, 
                           id_top_i(17) => s_writeback_data_13_port, 
                           id_top_i(16) => s_writeback_data_12_port, 
                           id_top_i(15) => s_writeback_data_11_port, 
                           id_top_i(14) => s_writeback_data_10_port, 
                           id_top_i(13) => s_writeback_data_9_port, 
                           id_top_i(12) => s_writeback_data_8_port, 
                           id_top_i(11) => s_writeback_data_7_port, 
                           id_top_i(10) => s_writeback_data_6_port, id_top_i(9)
                           => s_writeback_data_5_port, id_top_i(8) => 
                           s_writeback_data_4_port, id_top_i(7) => 
                           s_writeback_data_3_port, id_top_i(6) => 
                           s_writeback_data_2_port, id_top_i(5) => 
                           s_writeback_data_1_port, id_top_i(4) => 
                           s_writeback_data_0_port, id_top_i(3) => n13, 
                           id_top_i(2) => n13, id_top_i(1) => 
                           s_id_ctrl_regWrite, id_top_i(0) => s_id_ctrl_RegDst,
                           id_top_o(112) => s_id_exe_reg_a_31_port, 
                           id_top_o(111) => s_id_exe_reg_a_30_port, 
                           id_top_o(110) => s_id_exe_reg_a_29_port, 
                           id_top_o(109) => s_id_exe_reg_a_28_port, 
                           id_top_o(108) => s_id_exe_reg_a_27_port, 
                           id_top_o(107) => s_id_exe_reg_a_26_port, 
                           id_top_o(106) => s_id_exe_reg_a_25_port, 
                           id_top_o(105) => s_id_exe_reg_a_24_port, 
                           id_top_o(104) => s_id_exe_reg_a_23_port, 
                           id_top_o(103) => s_id_exe_reg_a_22_port, 
                           id_top_o(102) => s_id_exe_reg_a_21_port, 
                           id_top_o(101) => s_id_exe_reg_a_20_port, 
                           id_top_o(100) => s_id_exe_reg_a_19_port, 
                           id_top_o(99) => s_id_exe_reg_a_18_port, id_top_o(98)
                           => s_id_exe_reg_a_17_port, id_top_o(97) => 
                           s_id_exe_reg_a_16_port, id_top_o(96) => 
                           s_id_exe_reg_a_15_port, id_top_o(95) => 
                           s_id_exe_reg_a_14_port, id_top_o(94) => 
                           s_id_exe_reg_a_13_port, id_top_o(93) => 
                           s_id_exe_reg_a_12_port, id_top_o(92) => 
                           s_id_exe_reg_a_11_port, id_top_o(91) => 
                           s_id_exe_reg_a_10_port, id_top_o(90) => 
                           s_id_exe_reg_a_9_port, id_top_o(89) => 
                           s_id_exe_reg_a_8_port, id_top_o(88) => 
                           s_id_exe_reg_a_7_port, id_top_o(87) => 
                           s_id_exe_reg_a_6_port, id_top_o(86) => 
                           s_id_exe_reg_a_5_port, id_top_o(85) => 
                           s_id_exe_reg_a_4_port, id_top_o(84) => 
                           s_id_exe_reg_a_3_port, id_top_o(83) => 
                           s_id_exe_reg_a_2_port, id_top_o(82) => 
                           s_id_exe_reg_a_1_port, id_top_o(81) => 
                           s_id_exe_reg_a_0_port, id_top_o(80) => 
                           mini_mips_o_DMEM_DATA_31_port, id_top_o(79) => 
                           mini_mips_o_DMEM_DATA_30_port, id_top_o(78) => 
                           mini_mips_o_DMEM_DATA_29_port, id_top_o(77) => 
                           mini_mips_o_DMEM_DATA_28_port, id_top_o(76) => 
                           mini_mips_o_DMEM_DATA_27_port, id_top_o(75) => 
                           mini_mips_o_DMEM_DATA_26_port, id_top_o(74) => 
                           mini_mips_o_DMEM_DATA_25_port, id_top_o(73) => 
                           mini_mips_o_DMEM_DATA_24_port, id_top_o(72) => 
                           mini_mips_o_DMEM_DATA_23_port, id_top_o(71) => 
                           mini_mips_o_DMEM_DATA_22_port, id_top_o(70) => 
                           mini_mips_o_DMEM_DATA_21_port, id_top_o(69) => 
                           mini_mips_o_DMEM_DATA_20_port, id_top_o(68) => 
                           mini_mips_o_DMEM_DATA_19_port, id_top_o(67) => 
                           mini_mips_o_DMEM_DATA_18_port, id_top_o(66) => 
                           mini_mips_o_DMEM_DATA_17_port, id_top_o(65) => 
                           mini_mips_o_DMEM_DATA_16_port, id_top_o(64) => 
                           mini_mips_o_DMEM_DATA_15_port, id_top_o(63) => 
                           mini_mips_o_DMEM_DATA_14_port, id_top_o(62) => 
                           mini_mips_o_DMEM_DATA_13_port, id_top_o(61) => 
                           mini_mips_o_DMEM_DATA_12_port, id_top_o(60) => 
                           mini_mips_o_DMEM_DATA_11_port, id_top_o(59) => 
                           mini_mips_o_DMEM_DATA_10_port, id_top_o(58) => 
                           mini_mips_o_DMEM_DATA_9_port, id_top_o(57) => 
                           mini_mips_o_DMEM_DATA_8_port, id_top_o(56) => 
                           mini_mips_o_DMEM_DATA_7_port, id_top_o(55) => 
                           mini_mips_o_DMEM_DATA_6_port, id_top_o(54) => 
                           mini_mips_o_DMEM_DATA_5_port, id_top_o(53) => 
                           mini_mips_o_DMEM_DATA_4_port, id_top_o(52) => 
                           mini_mips_o_DMEM_DATA_3_port, id_top_o(51) => 
                           mini_mips_o_DMEM_DATA_2_port, id_top_o(50) => 
                           mini_mips_o_DMEM_DATA_1_port, id_top_o(49) => 
                           mini_mips_o_DMEM_DATA_0_port, id_top_o(48) => 
                           s_id_ctrl_opcode_5_port, id_top_o(47) => 
                           s_id_ctrl_opcode_4_port, id_top_o(46) => 
                           s_id_ctrl_opcode_3_port, id_top_o(45) => 
                           s_id_ctrl_opcode_2_port, id_top_o(44) => 
                           s_id_ctrl_opcode_1_port, id_top_o(43) => 
                           s_id_ctrl_opcode_0_port, id_top_o(42) => 
                           s_id_exe_shamt_4_port, id_top_o(41) => 
                           s_id_exe_shamt_3_port, id_top_o(40) => 
                           s_id_exe_shamt_2_port, id_top_o(39) => 
                           s_id_exe_shamt_1_port, id_top_o(38) => 
                           s_id_exe_shamt_0_port, id_top_o(37) => 
                           s_id_exe_funct_5_port, id_top_o(36) => 
                           s_id_exe_funct_4_port, id_top_o(35) => 
                           s_id_exe_funct_3_port, id_top_o(34) => 
                           s_id_exe_funct_2_port, id_top_o(33) => 
                           s_id_exe_funct_1_port, id_top_o(32) => 
                           s_id_exe_funct_0_port, id_top_o(31) => 
                           s_id_exe_immidiate_31_port, id_top_o(30) => 
                           s_id_exe_immidiate_30_port, id_top_o(29) => 
                           s_id_exe_immidiate_29_port, id_top_o(28) => 
                           s_id_exe_immidiate_28_port, id_top_o(27) => 
                           s_id_exe_immidiate_27_port, id_top_o(26) => 
                           s_id_exe_immidiate_26_port, id_top_o(25) => 
                           s_id_exe_immidiate_25_port, id_top_o(24) => 
                           s_id_exe_immidiate_24_port, id_top_o(23) => 
                           s_id_exe_immidiate_23_port, id_top_o(22) => 
                           s_id_exe_immidiate_22_port, id_top_o(21) => 
                           s_id_exe_immidiate_21_port, id_top_o(20) => 
                           s_id_exe_immidiate_20_port, id_top_o(19) => 
                           s_id_exe_immidiate_19_port, id_top_o(18) => 
                           s_id_exe_immidiate_18_port, id_top_o(17) => 
                           s_id_exe_immidiate_17_port, id_top_o(16) => 
                           s_id_exe_immidiate_16_port, id_top_o(15) => 
                           s_id_exe_immidiate_15_port, id_top_o(14) => 
                           s_id_exe_immidiate_14_port, id_top_o(13) => 
                           s_id_exe_immidiate_13_port, id_top_o(12) => 
                           s_id_exe_immidiate_12_port, id_top_o(11) => 
                           s_id_exe_immidiate_11_port, id_top_o(10) => 
                           s_id_exe_immidiate_10_port, id_top_o(9) => 
                           s_id_exe_immidiate_9_port, id_top_o(8) => 
                           s_id_exe_immidiate_8_port, id_top_o(7) => 
                           s_id_exe_immidiate_7_port, id_top_o(6) => 
                           s_id_exe_immidiate_6_port, id_top_o(5) => 
                           s_id_exe_immidiate_5_port, id_top_o(4) => 
                           s_id_exe_immidiate_4_port, id_top_o(3) => 
                           s_id_exe_immidiate_3_port, id_top_o(2) => 
                           s_id_exe_immidiate_2_port, id_top_o(1) => 
                           s_id_exe_immidiate_1_port, id_top_o(0) => 
                           s_id_exe_immidiate_0_port);
   exe_top_inst : exe_top port map( clk => clk, rst_n => rst_n, exe_top_i(123) 
                           => s_id_exe_shamt_4_port, exe_top_i(122) => 
                           s_id_exe_shamt_3_port, exe_top_i(121) => 
                           s_id_exe_shamt_2_port, exe_top_i(120) => 
                           s_id_exe_shamt_1_port, exe_top_i(119) => 
                           s_id_exe_shamt_0_port, exe_top_i(118) => 
                           s_id_exe_reg_a_31_port, exe_top_i(117) => 
                           s_id_exe_reg_a_30_port, exe_top_i(116) => 
                           s_id_exe_reg_a_29_port, exe_top_i(115) => 
                           s_id_exe_reg_a_28_port, exe_top_i(114) => 
                           s_id_exe_reg_a_27_port, exe_top_i(113) => 
                           s_id_exe_reg_a_26_port, exe_top_i(112) => 
                           s_id_exe_reg_a_25_port, exe_top_i(111) => 
                           s_id_exe_reg_a_24_port, exe_top_i(110) => 
                           s_id_exe_reg_a_23_port, exe_top_i(109) => 
                           s_id_exe_reg_a_22_port, exe_top_i(108) => 
                           s_id_exe_reg_a_21_port, exe_top_i(107) => 
                           s_id_exe_reg_a_20_port, exe_top_i(106) => 
                           s_id_exe_reg_a_19_port, exe_top_i(105) => 
                           s_id_exe_reg_a_18_port, exe_top_i(104) => 
                           s_id_exe_reg_a_17_port, exe_top_i(103) => 
                           s_id_exe_reg_a_16_port, exe_top_i(102) => 
                           s_id_exe_reg_a_15_port, exe_top_i(101) => 
                           s_id_exe_reg_a_14_port, exe_top_i(100) => 
                           s_id_exe_reg_a_13_port, exe_top_i(99) => 
                           s_id_exe_reg_a_12_port, exe_top_i(98) => 
                           s_id_exe_reg_a_11_port, exe_top_i(97) => 
                           s_id_exe_reg_a_10_port, exe_top_i(96) => 
                           s_id_exe_reg_a_9_port, exe_top_i(95) => 
                           s_id_exe_reg_a_8_port, exe_top_i(94) => 
                           s_id_exe_reg_a_7_port, exe_top_i(93) => 
                           s_id_exe_reg_a_6_port, exe_top_i(92) => 
                           s_id_exe_reg_a_5_port, exe_top_i(91) => 
                           s_id_exe_reg_a_4_port, exe_top_i(90) => 
                           s_id_exe_reg_a_3_port, exe_top_i(89) => 
                           s_id_exe_reg_a_2_port, exe_top_i(88) => 
                           s_id_exe_reg_a_1_port, exe_top_i(87) => 
                           s_id_exe_reg_a_0_port, exe_top_i(86) => 
                           mini_mips_o_DMEM_DATA_31_port, exe_top_i(85) => 
                           mini_mips_o_DMEM_DATA_30_port, exe_top_i(84) => 
                           mini_mips_o_DMEM_DATA_29_port, exe_top_i(83) => 
                           mini_mips_o_DMEM_DATA_28_port, exe_top_i(82) => 
                           mini_mips_o_DMEM_DATA_27_port, exe_top_i(81) => 
                           mini_mips_o_DMEM_DATA_26_port, exe_top_i(80) => 
                           mini_mips_o_DMEM_DATA_25_port, exe_top_i(79) => 
                           mini_mips_o_DMEM_DATA_24_port, exe_top_i(78) => 
                           mini_mips_o_DMEM_DATA_23_port, exe_top_i(77) => 
                           mini_mips_o_DMEM_DATA_22_port, exe_top_i(76) => 
                           mini_mips_o_DMEM_DATA_21_port, exe_top_i(75) => 
                           mini_mips_o_DMEM_DATA_20_port, exe_top_i(74) => 
                           mini_mips_o_DMEM_DATA_19_port, exe_top_i(73) => 
                           mini_mips_o_DMEM_DATA_18_port, exe_top_i(72) => 
                           mini_mips_o_DMEM_DATA_17_port, exe_top_i(71) => 
                           mini_mips_o_DMEM_DATA_16_port, exe_top_i(70) => 
                           mini_mips_o_DMEM_DATA_15_port, exe_top_i(69) => 
                           mini_mips_o_DMEM_DATA_14_port, exe_top_i(68) => 
                           mini_mips_o_DMEM_DATA_13_port, exe_top_i(67) => 
                           mini_mips_o_DMEM_DATA_12_port, exe_top_i(66) => 
                           mini_mips_o_DMEM_DATA_11_port, exe_top_i(65) => 
                           mini_mips_o_DMEM_DATA_10_port, exe_top_i(64) => 
                           mini_mips_o_DMEM_DATA_9_port, exe_top_i(63) => 
                           mini_mips_o_DMEM_DATA_8_port, exe_top_i(62) => 
                           mini_mips_o_DMEM_DATA_7_port, exe_top_i(61) => 
                           mini_mips_o_DMEM_DATA_6_port, exe_top_i(60) => 
                           mini_mips_o_DMEM_DATA_5_port, exe_top_i(59) => 
                           mini_mips_o_DMEM_DATA_4_port, exe_top_i(58) => 
                           mini_mips_o_DMEM_DATA_3_port, exe_top_i(57) => 
                           mini_mips_o_DMEM_DATA_2_port, exe_top_i(56) => 
                           mini_mips_o_DMEM_DATA_1_port, exe_top_i(55) => 
                           mini_mips_o_DMEM_DATA_0_port, exe_top_i(54) => 
                           s_exe_ctrl_alu_src_b, exe_top_i(53) => 
                           s_id_exe_immidiate_31_port, exe_top_i(52) => 
                           s_id_exe_immidiate_30_port, exe_top_i(51) => 
                           s_id_exe_immidiate_29_port, exe_top_i(50) => 
                           s_id_exe_immidiate_28_port, exe_top_i(49) => 
                           s_id_exe_immidiate_27_port, exe_top_i(48) => 
                           s_id_exe_immidiate_26_port, exe_top_i(47) => 
                           s_id_exe_immidiate_25_port, exe_top_i(46) => 
                           s_id_exe_immidiate_24_port, exe_top_i(45) => 
                           s_id_exe_immidiate_23_port, exe_top_i(44) => 
                           s_id_exe_immidiate_22_port, exe_top_i(43) => 
                           s_id_exe_immidiate_21_port, exe_top_i(42) => 
                           s_id_exe_immidiate_20_port, exe_top_i(41) => 
                           s_id_exe_immidiate_19_port, exe_top_i(40) => 
                           s_id_exe_immidiate_18_port, exe_top_i(39) => 
                           s_id_exe_immidiate_17_port, exe_top_i(38) => 
                           s_id_exe_immidiate_16_port, exe_top_i(37) => 
                           s_id_exe_immidiate_15_port, exe_top_i(36) => 
                           s_id_exe_immidiate_14_port, exe_top_i(35) => 
                           s_id_exe_immidiate_13_port, exe_top_i(34) => 
                           s_id_exe_immidiate_12_port, exe_top_i(33) => 
                           s_id_exe_immidiate_11_port, exe_top_i(32) => 
                           s_id_exe_immidiate_10_port, exe_top_i(31) => 
                           s_id_exe_immidiate_9_port, exe_top_i(30) => 
                           s_id_exe_immidiate_8_port, exe_top_i(29) => 
                           s_id_exe_immidiate_7_port, exe_top_i(28) => 
                           s_id_exe_immidiate_6_port, exe_top_i(27) => 
                           s_id_exe_immidiate_5_port, exe_top_i(26) => 
                           s_id_exe_immidiate_4_port, exe_top_i(25) => 
                           s_id_exe_immidiate_3_port, exe_top_i(24) => 
                           s_id_exe_immidiate_2_port, exe_top_i(23) => 
                           s_id_exe_immidiate_1_port, exe_top_i(22) => 
                           s_id_exe_immidiate_0_port, exe_top_i(21) => n14, 
                           exe_top_i(20) => s_exe_ctrl_op_2_port, exe_top_i(19)
                           => s_exe_ctrl_op_1_port, exe_top_i(18) => 
                           s_exe_ctrl_op_0_port, exe_top_i(17) => 
                           s_id_exe_funct_5_port, exe_top_i(16) => 
                           s_id_exe_funct_4_port, exe_top_i(15) => 
                           s_id_exe_funct_3_port, exe_top_i(14) => 
                           s_id_exe_funct_2_port, exe_top_i(13) => 
                           s_id_exe_funct_1_port, exe_top_i(12) => 
                           s_id_exe_funct_0_port, exe_top_i(11) => 
                           s_if_exe_pc_plus1_11_port, exe_top_i(10) => 
                           s_if_exe_pc_plus1_10_port, exe_top_i(9) => 
                           s_if_exe_pc_plus1_9_port, exe_top_i(8) => 
                           s_if_exe_pc_plus1_8_port, exe_top_i(7) => 
                           s_if_exe_pc_plus1_7_port, exe_top_i(6) => 
                           s_if_exe_pc_plus1_6_port, exe_top_i(5) => 
                           s_if_exe_pc_plus1_5_port, exe_top_i(4) => 
                           s_if_exe_pc_plus1_4_port, exe_top_i(3) => 
                           s_if_exe_pc_plus1_3_port, exe_top_i(2) => 
                           s_if_exe_pc_plus1_2_port, exe_top_i(1) => 
                           s_if_exe_pc_plus1_1_port, exe_top_i(0) => 
                           s_if_exe_pc_plus1_0_port, exe_top_o(44) => 
                           s_if_PCSrc, exe_top_o(43) => 
                           s_exe_if_branch_pc_11_port, exe_top_o(42) => 
                           s_exe_if_branch_pc_10_port, exe_top_o(41) => 
                           s_exe_if_branch_pc_9_port, exe_top_o(40) => 
                           s_exe_if_branch_pc_8_port, exe_top_o(39) => 
                           s_exe_if_branch_pc_7_port, exe_top_o(38) => 
                           s_exe_if_branch_pc_6_port, exe_top_o(37) => 
                           s_exe_if_branch_pc_5_port, exe_top_o(36) => 
                           s_exe_if_branch_pc_4_port, exe_top_o(35) => 
                           s_exe_if_branch_pc_3_port, exe_top_o(34) => 
                           s_exe_if_branch_pc_2_port, exe_top_o(33) => 
                           s_exe_if_branch_pc_1_port, exe_top_o(32) => 
                           s_exe_if_branch_pc_0_port, exe_top_o(31) => 
                           s_exe_result_31_port, exe_top_o(30) => 
                           s_exe_result_30_port, exe_top_o(29) => 
                           s_exe_result_29_port, exe_top_o(28) => 
                           s_exe_result_28_port, exe_top_o(27) => 
                           s_exe_result_27_port, exe_top_o(26) => 
                           s_exe_result_26_port, exe_top_o(25) => 
                           s_exe_result_25_port, exe_top_o(24) => 
                           s_exe_result_24_port, exe_top_o(23) => 
                           s_exe_result_23_port, exe_top_o(22) => 
                           s_exe_result_22_port, exe_top_o(21) => 
                           s_exe_result_21_port, exe_top_o(20) => 
                           s_exe_result_20_port, exe_top_o(19) => 
                           s_exe_result_19_port, exe_top_o(18) => 
                           s_exe_result_18_port, exe_top_o(17) => 
                           s_exe_result_17_port, exe_top_o(16) => 
                           s_exe_result_16_port, exe_top_o(15) => 
                           s_exe_result_15_port, exe_top_o(14) => 
                           s_exe_result_14_port, exe_top_o(13) => 
                           s_exe_result_13_port, exe_top_o(12) => 
                           s_exe_result_12_port, exe_top_o(11) => 
                           mini_mips_o_DMEM_ADDR_11_port, exe_top_o(10) => 
                           mini_mips_o_DMEM_ADDR_10_port, exe_top_o(9) => 
                           mini_mips_o_DMEM_ADDR_9_port, exe_top_o(8) => 
                           mini_mips_o_DMEM_ADDR_8_port, exe_top_o(7) => 
                           mini_mips_o_DMEM_ADDR_7_port, exe_top_o(6) => 
                           mini_mips_o_DMEM_ADDR_6_port, exe_top_o(5) => 
                           mini_mips_o_DMEM_ADDR_5_port, exe_top_o(4) => 
                           mini_mips_o_DMEM_ADDR_4_port, exe_top_o(3) => 
                           mini_mips_o_DMEM_ADDR_3_port, exe_top_o(2) => 
                           mini_mips_o_DMEM_ADDR_2_port, exe_top_o(1) => 
                           mini_mips_o_DMEM_ADDR_1_port, exe_top_o(0) => 
                           mini_mips_o_DMEM_ADDR_0_port);
   ctrl_inst : controller port map( ctrl_i(5) => s_id_ctrl_opcode_5_port, 
                           ctrl_i(4) => s_id_ctrl_opcode_4_port, ctrl_i(3) => 
                           s_id_ctrl_opcode_3_port, ctrl_i(2) => 
                           s_id_ctrl_opcode_2_port, ctrl_i(1) => 
                           s_id_ctrl_opcode_1_port, ctrl_i(0) => 
                           s_id_ctrl_opcode_0_port, ctrl_o(9) => 
                           s_id_ctrl_RegDst, ctrl_o(8) => s_exe_ctrl_alu_src_b,
                           ctrl_o(7) => s_MemtoReg, ctrl_o(6) => 
                           s_id_ctrl_regWrite, ctrl_o(5) => 
                           mini_mips_o_DMEM_WEN_N_port, ctrl_o(4) => n_1000, 
                           ctrl_o(3) => n_1001, ctrl_o(2) => 
                           s_exe_ctrl_op_2_port, ctrl_o(1) => 
                           s_exe_ctrl_op_1_port, ctrl_o(0) => 
                           s_exe_ctrl_op_0_port);
   U3 : HS65_LH_BFX9 port map( A => n12, Z => n10);
   U4 : HS65_LH_IVX9 port map( A => n9, Z => n8);
   U5 : HS65_LH_BFX9 port map( A => n12, Z => n11);
   U6 : HS65_LH_BFX9 port map( A => n12, Z => n9);
   U7 : HS65_LH_IVX9 port map( A => s_MemtoReg, Z => n12);
   U8 : HS65_LH_AO22X9 port map( A => mini_mips_o_DMEM_ADDR_9_port, B => n11, C
                           => n8, D => mini_mips_i(41), Z => 
                           s_writeback_data_9_port);
   U9 : HS65_LH_AO22X9 port map( A => mini_mips_o_DMEM_ADDR_0_port, B => n9, C 
                           => mini_mips_i(32), D => s_MemtoReg, Z => 
                           s_writeback_data_0_port);
   U10 : HS65_LH_AO22X9 port map( A => mini_mips_o_DMEM_ADDR_1_port, B => n10, 
                           C => mini_mips_i(33), D => n8, Z => 
                           s_writeback_data_1_port);
   U11 : HS65_LH_AO22X9 port map( A => mini_mips_o_DMEM_ADDR_2_port, B => n11, 
                           C => mini_mips_i(34), D => s_MemtoReg, Z => 
                           s_writeback_data_2_port);
   U12 : HS65_LH_AO22X9 port map( A => mini_mips_o_DMEM_ADDR_3_port, B => n11, 
                           C => mini_mips_i(35), D => s_MemtoReg, Z => 
                           s_writeback_data_3_port);
   U13 : HS65_LH_AO22X9 port map( A => mini_mips_o_DMEM_ADDR_4_port, B => n11, 
                           C => mini_mips_i(36), D => s_MemtoReg, Z => 
                           s_writeback_data_4_port);
   U14 : HS65_LH_AO22X9 port map( A => mini_mips_o_DMEM_ADDR_5_port, B => n11, 
                           C => mini_mips_i(37), D => s_MemtoReg, Z => 
                           s_writeback_data_5_port);
   U15 : HS65_LH_AO22X9 port map( A => mini_mips_o_DMEM_ADDR_6_port, B => n11, 
                           C => mini_mips_i(38), D => s_MemtoReg, Z => 
                           s_writeback_data_6_port);
   U16 : HS65_LH_AO22X9 port map( A => mini_mips_o_DMEM_ADDR_7_port, B => n11, 
                           C => mini_mips_i(39), D => s_MemtoReg, Z => 
                           s_writeback_data_7_port);
   U17 : HS65_LH_AO22X9 port map( A => mini_mips_o_DMEM_ADDR_8_port, B => n11, 
                           C => mini_mips_i(40), D => n8, Z => 
                           s_writeback_data_8_port);
   U18 : HS65_LH_AO22X9 port map( A => mini_mips_o_DMEM_ADDR_10_port, B => n10,
                           C => mini_mips_i(42), D => s_MemtoReg, Z => 
                           s_writeback_data_10_port);
   U19 : HS65_LH_AO22X9 port map( A => mini_mips_o_DMEM_ADDR_11_port, B => n10,
                           C => mini_mips_i(43), D => s_MemtoReg, Z => 
                           s_writeback_data_11_port);
   U20 : HS65_LH_AO22X9 port map( A => s_exe_result_12_port, B => n10, C => 
                           mini_mips_i(44), D => s_MemtoReg, Z => 
                           s_writeback_data_12_port);
   U21 : HS65_LH_AO22X9 port map( A => s_exe_result_13_port, B => n10, C => 
                           mini_mips_i(45), D => s_MemtoReg, Z => 
                           s_writeback_data_13_port);
   U22 : HS65_LH_AO22X9 port map( A => s_exe_result_14_port, B => n10, C => 
                           mini_mips_i(46), D => s_MemtoReg, Z => 
                           s_writeback_data_14_port);
   U23 : HS65_LH_AO22X9 port map( A => s_exe_result_15_port, B => n10, C => 
                           mini_mips_i(47), D => n8, Z => 
                           s_writeback_data_15_port);
   U24 : HS65_LH_AO22X9 port map( A => s_exe_result_16_port, B => n10, C => 
                           mini_mips_i(48), D => n8, Z => 
                           s_writeback_data_16_port);
   U25 : HS65_LH_AO22X9 port map( A => s_exe_result_17_port, B => n10, C => 
                           mini_mips_i(49), D => n8, Z => 
                           s_writeback_data_17_port);
   U26 : HS65_LH_AO22X9 port map( A => s_exe_result_18_port, B => n10, C => 
                           mini_mips_i(50), D => n8, Z => 
                           s_writeback_data_18_port);
   U27 : HS65_LH_AO22X9 port map( A => s_exe_result_19_port, B => n10, C => 
                           mini_mips_i(51), D => n8, Z => 
                           s_writeback_data_19_port);
   U28 : HS65_LH_AO22X9 port map( A => s_exe_result_20_port, B => n10, C => 
                           mini_mips_i(52), D => n8, Z => 
                           s_writeback_data_20_port);
   U29 : HS65_LH_AO22X9 port map( A => s_exe_result_21_port, B => n10, C => 
                           mini_mips_i(53), D => n8, Z => 
                           s_writeback_data_21_port);
   U30 : HS65_LH_AO22X9 port map( A => s_exe_result_22_port, B => n10, C => 
                           mini_mips_i(54), D => n8, Z => 
                           s_writeback_data_22_port);
   U31 : HS65_LH_AO22X9 port map( A => s_exe_result_23_port, B => n10, C => 
                           mini_mips_i(55), D => n8, Z => 
                           s_writeback_data_23_port);
   U32 : HS65_LH_AO22X9 port map( A => s_exe_result_24_port, B => n10, C => 
                           mini_mips_i(56), D => n8, Z => 
                           s_writeback_data_24_port);
   U33 : HS65_LH_AO22X9 port map( A => s_exe_result_25_port, B => n10, C => 
                           mini_mips_i(57), D => n8, Z => 
                           s_writeback_data_25_port);
   U34 : HS65_LH_AO22X9 port map( A => s_exe_result_26_port, B => n10, C => 
                           mini_mips_i(58), D => n8, Z => 
                           s_writeback_data_26_port);
   U35 : HS65_LH_AO22X9 port map( A => s_exe_result_27_port, B => n10, C => 
                           mini_mips_i(59), D => s_MemtoReg, Z => 
                           s_writeback_data_27_port);
   U36 : HS65_LH_AO22X9 port map( A => s_exe_result_28_port, B => n10, C => 
                           mini_mips_i(60), D => n8, Z => 
                           s_writeback_data_28_port);
   U37 : HS65_LH_AO22X9 port map( A => s_exe_result_29_port, B => n11, C => 
                           mini_mips_i(61), D => s_MemtoReg, Z => 
                           s_writeback_data_29_port);
   U38 : HS65_LH_AO22X9 port map( A => s_exe_result_30_port, B => n11, C => 
                           mini_mips_i(62), D => n8, Z => 
                           s_writeback_data_30_port);
   U39 : HS65_LH_AO22X9 port map( A => s_exe_result_31_port, B => n11, C => 
                           mini_mips_i(63), D => s_MemtoReg, Z => 
                           s_writeback_data_31_port);
   n13 <= '0';
   n14 <= '0';

end SYN_Behavioral;

library IEEE,IO65LPHVT_SF_1V8_50A_7M4X0Y2Z,CORE65LPHVT;

use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

entity mini_mips_p is

   port( clk, rst_n : inout std_logic;  alu_result : inout std_logic_vector (15
         downto 0));

end mini_mips_p;

architecture SYN_Behavioral of mini_mips_p is

   component mini_mips
      port( clk, rst_n : in std_logic;  mini_mips_i : in std_logic_vector (63 
            downto 0);  mini_mips_o : out std_logic_vector (72 downto 0));
   end component;
   
   component BD2SCARUDQP_1V8_SF_LIN
      port( A, TA, TM, EN, TEN : in std_logic;  IO : inout std_logic;  HYST, 
            PDN, PUN : in std_logic;  ZI : out std_logic);
   end component;
   
   component ST_SPHDL_4096x32m8_L
      port( A : in std_logic_vector (11 downto 0);  D : in std_logic_vector (31
            downto 0);  Q : out std_logic_vector (31 downto 0);  CK, CSN : in 
            std_logic;  RY : out std_logic;  TBYPASS, WEN : in std_logic);
   end component;
   
   signal X_Logic1_port, X_Logic0_port, s_dmem_to_top_dmem_data_31_port, 
      s_dmem_to_top_dmem_data_30_port, s_dmem_to_top_dmem_data_29_port, 
      s_dmem_to_top_dmem_data_28_port, s_dmem_to_top_dmem_data_27_port, 
      s_dmem_to_top_dmem_data_26_port, s_dmem_to_top_dmem_data_25_port, 
      s_dmem_to_top_dmem_data_24_port, s_dmem_to_top_dmem_data_23_port, 
      s_dmem_to_top_dmem_data_22_port, s_dmem_to_top_dmem_data_21_port, 
      s_dmem_to_top_dmem_data_20_port, s_dmem_to_top_dmem_data_19_port, 
      s_dmem_to_top_dmem_data_18_port, s_dmem_to_top_dmem_data_17_port, 
      s_dmem_to_top_dmem_data_16_port, s_dmem_to_top_dmem_data_15_port, 
      s_dmem_to_top_dmem_data_14_port, s_dmem_to_top_dmem_data_13_port, 
      s_dmem_to_top_dmem_data_12_port, s_dmem_to_top_dmem_data_11_port, 
      s_dmem_to_top_dmem_data_10_port, s_dmem_to_top_dmem_data_9_port, 
      s_dmem_to_top_dmem_data_8_port, s_dmem_to_top_dmem_data_7_port, 
      s_dmem_to_top_dmem_data_6_port, s_dmem_to_top_dmem_data_5_port, 
      s_dmem_to_top_dmem_data_4_port, s_dmem_to_top_dmem_data_3_port, 
      s_dmem_to_top_dmem_data_2_port, s_dmem_to_top_dmem_data_1_port, 
      s_dmem_to_top_dmem_data_0_port, s_imem_to_top_imem_data_31_port, 
      s_imem_to_top_imem_data_30_port, s_imem_to_top_imem_data_29_port, 
      s_imem_to_top_imem_data_28_port, s_imem_to_top_imem_data_27_port, 
      s_imem_to_top_imem_data_26_port, s_imem_to_top_imem_data_25_port, 
      s_imem_to_top_imem_data_24_port, s_imem_to_top_imem_data_23_port, 
      s_imem_to_top_imem_data_22_port, s_imem_to_top_imem_data_21_port, 
      s_imem_to_top_imem_data_20_port, s_imem_to_top_imem_data_19_port, 
      s_imem_to_top_imem_data_18_port, s_imem_to_top_imem_data_17_port, 
      s_imem_to_top_imem_data_16_port, s_imem_to_top_imem_data_15_port, 
      s_imem_to_top_imem_data_14_port, s_imem_to_top_imem_data_13_port, 
      s_imem_to_top_imem_data_12_port, s_imem_to_top_imem_data_11_port, 
      s_imem_to_top_imem_data_10_port, s_imem_to_top_imem_data_9_port, 
      s_imem_to_top_imem_data_8_port, s_imem_to_top_imem_data_7_port, 
      s_imem_to_top_imem_data_6_port, s_imem_to_top_imem_data_5_port, 
      s_imem_to_top_imem_data_4_port, s_imem_to_top_imem_data_3_port, 
      s_imem_to_top_imem_data_2_port, s_imem_to_top_imem_data_1_port, 
      s_imem_to_top_imem_data_0_port, s_top_to_dmem_dmem_addr_11_port, 
      s_top_to_dmem_dmem_addr_10_port, s_top_to_dmem_dmem_addr_9_port, 
      s_top_to_dmem_dmem_addr_8_port, s_top_to_dmem_dmem_addr_7_port, 
      s_top_to_dmem_dmem_addr_6_port, s_top_to_dmem_dmem_addr_5_port, 
      s_top_to_dmem_dmem_addr_4_port, s_top_to_dmem_dmem_addr_3_port, 
      s_top_to_dmem_dmem_addr_2_port, s_top_to_dmem_dmem_addr_1_port, 
      s_top_to_dmem_dmem_addr_0_port, s_top_to_dmem_dmem_data_31_port, 
      s_top_to_dmem_dmem_data_30_port, s_top_to_dmem_dmem_data_29_port, 
      s_top_to_dmem_dmem_data_28_port, s_top_to_dmem_dmem_data_27_port, 
      s_top_to_dmem_dmem_data_26_port, s_top_to_dmem_dmem_data_25_port, 
      s_top_to_dmem_dmem_data_24_port, s_top_to_dmem_dmem_data_23_port, 
      s_top_to_dmem_dmem_data_22_port, s_top_to_dmem_dmem_data_21_port, 
      s_top_to_dmem_dmem_data_20_port, s_top_to_dmem_dmem_data_19_port, 
      s_top_to_dmem_dmem_data_18_port, s_top_to_dmem_dmem_data_17_port, 
      s_top_to_dmem_dmem_data_16_port, s_top_to_dmem_dmem_data_15_port, 
      s_top_to_dmem_dmem_data_14_port, s_top_to_dmem_dmem_data_13_port, 
      s_top_to_dmem_dmem_data_12_port, s_top_to_dmem_dmem_data_11_port, 
      s_top_to_dmem_dmem_data_10_port, s_top_to_dmem_dmem_data_9_port, 
      s_top_to_dmem_dmem_data_8_port, s_top_to_dmem_dmem_data_7_port, 
      s_top_to_dmem_dmem_data_6_port, s_top_to_dmem_dmem_data_5_port, 
      s_top_to_dmem_dmem_data_4_port, s_top_to_dmem_dmem_data_3_port, 
      s_top_to_dmem_dmem_data_2_port, s_top_to_dmem_dmem_data_1_port, 
      s_top_to_dmem_dmem_data_0_port, s_top_to_imem_imem_addr_11_port, 
      s_top_to_imem_imem_addr_10_port, s_top_to_imem_imem_addr_9_port, 
      s_top_to_imem_imem_addr_8_port, s_top_to_imem_imem_addr_7_port, 
      s_top_to_imem_imem_addr_6_port, s_top_to_imem_imem_addr_5_port, 
      s_top_to_imem_imem_addr_4_port, s_top_to_imem_imem_addr_3_port, 
      s_top_to_imem_imem_addr_2_port, s_top_to_imem_imem_addr_1_port, 
      s_top_to_imem_imem_addr_0_port, s_dmem_wen_n, clk_i, rst_n_i, n_1002, 
      n_1003, n_1004, n_1005, n_1006, n_1007, n_1008, n_1009, n_1010, n_1011, 
      n_1012, n_1013, n_1014, n_1015, n_1016, n_1017, n_1018, n_1019, n_1020, 
      n_1021, n_1022, n_1023, n_1024, n_1025, n_1026, n_1027, n_1028, n_1029, 
      n_1030, n_1031, n_1032, n_1033, n_1034, n_1035 : std_logic;

begin
   
   imem_inst : ST_SPHDL_4096x32m8_L port map( A(11) => 
                           s_top_to_imem_imem_addr_11_port, A(10) => 
                           s_top_to_imem_imem_addr_10_port, A(9) => 
                           s_top_to_imem_imem_addr_9_port, A(8) => 
                           s_top_to_imem_imem_addr_8_port, A(7) => 
                           s_top_to_imem_imem_addr_7_port, A(6) => 
                           s_top_to_imem_imem_addr_6_port, A(5) => 
                           s_top_to_imem_imem_addr_5_port, A(4) => 
                           s_top_to_imem_imem_addr_4_port, A(3) => 
                           s_top_to_imem_imem_addr_3_port, A(2) => 
                           s_top_to_imem_imem_addr_2_port, A(1) => 
                           s_top_to_imem_imem_addr_1_port, A(0) => 
                           s_top_to_imem_imem_addr_0_port, D(31) => 
                           X_Logic0_port, D(30) => X_Logic0_port, D(29) => 
                           X_Logic0_port, D(28) => X_Logic0_port, D(27) => 
                           X_Logic0_port, D(26) => X_Logic0_port, D(25) => 
                           X_Logic0_port, D(24) => X_Logic0_port, D(23) => 
                           X_Logic0_port, D(22) => X_Logic0_port, D(21) => 
                           X_Logic0_port, D(20) => X_Logic0_port, D(19) => 
                           X_Logic0_port, D(18) => X_Logic0_port, D(17) => 
                           X_Logic0_port, D(16) => X_Logic0_port, D(15) => 
                           X_Logic0_port, D(14) => X_Logic0_port, D(13) => 
                           X_Logic0_port, D(12) => X_Logic0_port, D(11) => 
                           X_Logic0_port, D(10) => X_Logic0_port, D(9) => 
                           X_Logic0_port, D(8) => X_Logic0_port, D(7) => 
                           X_Logic0_port, D(6) => X_Logic0_port, D(5) => 
                           X_Logic0_port, D(4) => X_Logic0_port, D(3) => 
                           X_Logic0_port, D(2) => X_Logic0_port, D(1) => 
                           X_Logic0_port, D(0) => X_Logic0_port, Q(31) => 
                           s_imem_to_top_imem_data_31_port, Q(30) => 
                           s_imem_to_top_imem_data_30_port, Q(29) => 
                           s_imem_to_top_imem_data_29_port, Q(28) => 
                           s_imem_to_top_imem_data_28_port, Q(27) => 
                           s_imem_to_top_imem_data_27_port, Q(26) => 
                           s_imem_to_top_imem_data_26_port, Q(25) => 
                           s_imem_to_top_imem_data_25_port, Q(24) => 
                           s_imem_to_top_imem_data_24_port, Q(23) => 
                           s_imem_to_top_imem_data_23_port, Q(22) => 
                           s_imem_to_top_imem_data_22_port, Q(21) => 
                           s_imem_to_top_imem_data_21_port, Q(20) => 
                           s_imem_to_top_imem_data_20_port, Q(19) => 
                           s_imem_to_top_imem_data_19_port, Q(18) => 
                           s_imem_to_top_imem_data_18_port, Q(17) => 
                           s_imem_to_top_imem_data_17_port, Q(16) => 
                           s_imem_to_top_imem_data_16_port, Q(15) => 
                           s_imem_to_top_imem_data_15_port, Q(14) => 
                           s_imem_to_top_imem_data_14_port, Q(13) => 
                           s_imem_to_top_imem_data_13_port, Q(12) => 
                           s_imem_to_top_imem_data_12_port, Q(11) => 
                           s_imem_to_top_imem_data_11_port, Q(10) => 
                           s_imem_to_top_imem_data_10_port, Q(9) => 
                           s_imem_to_top_imem_data_9_port, Q(8) => 
                           s_imem_to_top_imem_data_8_port, Q(7) => 
                           s_imem_to_top_imem_data_7_port, Q(6) => 
                           s_imem_to_top_imem_data_6_port, Q(5) => 
                           s_imem_to_top_imem_data_5_port, Q(4) => 
                           s_imem_to_top_imem_data_4_port, Q(3) => 
                           s_imem_to_top_imem_data_3_port, Q(2) => 
                           s_imem_to_top_imem_data_2_port, Q(1) => 
                           s_imem_to_top_imem_data_1_port, Q(0) => 
                           s_imem_to_top_imem_data_0_port, CK => clk_i, CSN => 
                           X_Logic0_port, RY => n_1002, TBYPASS => 
                           X_Logic0_port, WEN => X_Logic1_port);
   dmem_inst : ST_SPHDL_4096x32m8_L port map( A(11) => 
                           s_top_to_dmem_dmem_addr_11_port, A(10) => 
                           s_top_to_dmem_dmem_addr_10_port, A(9) => 
                           s_top_to_dmem_dmem_addr_9_port, A(8) => 
                           s_top_to_dmem_dmem_addr_8_port, A(7) => 
                           s_top_to_dmem_dmem_addr_7_port, A(6) => 
                           s_top_to_dmem_dmem_addr_6_port, A(5) => 
                           s_top_to_dmem_dmem_addr_5_port, A(4) => 
                           s_top_to_dmem_dmem_addr_4_port, A(3) => 
                           s_top_to_dmem_dmem_addr_3_port, A(2) => 
                           s_top_to_dmem_dmem_addr_2_port, A(1) => 
                           s_top_to_dmem_dmem_addr_1_port, A(0) => 
                           s_top_to_dmem_dmem_addr_0_port, D(31) => 
                           s_top_to_dmem_dmem_data_31_port, D(30) => 
                           s_top_to_dmem_dmem_data_30_port, D(29) => 
                           s_top_to_dmem_dmem_data_29_port, D(28) => 
                           s_top_to_dmem_dmem_data_28_port, D(27) => 
                           s_top_to_dmem_dmem_data_27_port, D(26) => 
                           s_top_to_dmem_dmem_data_26_port, D(25) => 
                           s_top_to_dmem_dmem_data_25_port, D(24) => 
                           s_top_to_dmem_dmem_data_24_port, D(23) => 
                           s_top_to_dmem_dmem_data_23_port, D(22) => 
                           s_top_to_dmem_dmem_data_22_port, D(21) => 
                           s_top_to_dmem_dmem_data_21_port, D(20) => 
                           s_top_to_dmem_dmem_data_20_port, D(19) => 
                           s_top_to_dmem_dmem_data_19_port, D(18) => 
                           s_top_to_dmem_dmem_data_18_port, D(17) => 
                           s_top_to_dmem_dmem_data_17_port, D(16) => 
                           s_top_to_dmem_dmem_data_16_port, D(15) => 
                           s_top_to_dmem_dmem_data_15_port, D(14) => 
                           s_top_to_dmem_dmem_data_14_port, D(13) => 
                           s_top_to_dmem_dmem_data_13_port, D(12) => 
                           s_top_to_dmem_dmem_data_12_port, D(11) => 
                           s_top_to_dmem_dmem_data_11_port, D(10) => 
                           s_top_to_dmem_dmem_data_10_port, D(9) => 
                           s_top_to_dmem_dmem_data_9_port, D(8) => 
                           s_top_to_dmem_dmem_data_8_port, D(7) => 
                           s_top_to_dmem_dmem_data_7_port, D(6) => 
                           s_top_to_dmem_dmem_data_6_port, D(5) => 
                           s_top_to_dmem_dmem_data_5_port, D(4) => 
                           s_top_to_dmem_dmem_data_4_port, D(3) => 
                           s_top_to_dmem_dmem_data_3_port, D(2) => 
                           s_top_to_dmem_dmem_data_2_port, D(1) => 
                           s_top_to_dmem_dmem_data_1_port, D(0) => 
                           s_top_to_dmem_dmem_data_0_port, Q(31) => 
                           s_dmem_to_top_dmem_data_31_port, Q(30) => 
                           s_dmem_to_top_dmem_data_30_port, Q(29) => 
                           s_dmem_to_top_dmem_data_29_port, Q(28) => 
                           s_dmem_to_top_dmem_data_28_port, Q(27) => 
                           s_dmem_to_top_dmem_data_27_port, Q(26) => 
                           s_dmem_to_top_dmem_data_26_port, Q(25) => 
                           s_dmem_to_top_dmem_data_25_port, Q(24) => 
                           s_dmem_to_top_dmem_data_24_port, Q(23) => 
                           s_dmem_to_top_dmem_data_23_port, Q(22) => 
                           s_dmem_to_top_dmem_data_22_port, Q(21) => 
                           s_dmem_to_top_dmem_data_21_port, Q(20) => 
                           s_dmem_to_top_dmem_data_20_port, Q(19) => 
                           s_dmem_to_top_dmem_data_19_port, Q(18) => 
                           s_dmem_to_top_dmem_data_18_port, Q(17) => 
                           s_dmem_to_top_dmem_data_17_port, Q(16) => 
                           s_dmem_to_top_dmem_data_16_port, Q(15) => 
                           s_dmem_to_top_dmem_data_15_port, Q(14) => 
                           s_dmem_to_top_dmem_data_14_port, Q(13) => 
                           s_dmem_to_top_dmem_data_13_port, Q(12) => 
                           s_dmem_to_top_dmem_data_12_port, Q(11) => 
                           s_dmem_to_top_dmem_data_11_port, Q(10) => 
                           s_dmem_to_top_dmem_data_10_port, Q(9) => 
                           s_dmem_to_top_dmem_data_9_port, Q(8) => 
                           s_dmem_to_top_dmem_data_8_port, Q(7) => 
                           s_dmem_to_top_dmem_data_7_port, Q(6) => 
                           s_dmem_to_top_dmem_data_6_port, Q(5) => 
                           s_dmem_to_top_dmem_data_5_port, Q(4) => 
                           s_dmem_to_top_dmem_data_4_port, Q(3) => 
                           s_dmem_to_top_dmem_data_3_port, Q(2) => 
                           s_dmem_to_top_dmem_data_2_port, Q(1) => 
                           s_dmem_to_top_dmem_data_1_port, Q(0) => 
                           s_dmem_to_top_dmem_data_0_port, CK => clk_i, CSN => 
                           X_Logic0_port, RY => n_1003, TBYPASS => 
                           X_Logic0_port, WEN => s_dmem_wen_n);
   clk_pad_in : BD2SCARUDQP_1V8_SF_LIN port map( A => X_Logic0_port, TA => 
                           X_Logic0_port, TM => X_Logic0_port, EN => 
                           X_Logic1_port, TEN => X_Logic1_port, IO => clk, HYST
                           => X_Logic0_port, PDN => X_Logic0_port, PUN => 
                           X_Logic0_port, ZI => clk_i);
   rst_n_pad_in : BD2SCARUDQP_1V8_SF_LIN port map( A => X_Logic0_port, TA => 
                           X_Logic0_port, TM => X_Logic0_port, EN => 
                           X_Logic1_port, TEN => X_Logic1_port, IO => rst_n, 
                           HYST => X_Logic0_port, PDN => X_Logic0_port, PUN => 
                           X_Logic0_port, ZI => rst_n_i);
   out_pad_0 : BD2SCARUDQP_1V8_SF_LIN port map( A => X_Logic0_port, TA => 
                           X_Logic0_port, TM => X_Logic0_port, EN => 
                           X_Logic1_port, TEN => X_Logic1_port, IO => 
                           alu_result(0), HYST => X_Logic0_port, PDN => 
                           X_Logic0_port, PUN => X_Logic0_port, ZI => n_1004);
   out_pad_1 : BD2SCARUDQP_1V8_SF_LIN port map( A => X_Logic0_port, TA => 
                           X_Logic0_port, TM => X_Logic0_port, EN => 
                           X_Logic1_port, TEN => X_Logic1_port, IO => 
                           alu_result(1), HYST => X_Logic0_port, PDN => 
                           X_Logic0_port, PUN => X_Logic0_port, ZI => n_1005);
   out_pad_2 : BD2SCARUDQP_1V8_SF_LIN port map( A => X_Logic0_port, TA => 
                           X_Logic0_port, TM => X_Logic0_port, EN => 
                           X_Logic1_port, TEN => X_Logic1_port, IO => 
                           alu_result(2), HYST => X_Logic0_port, PDN => 
                           X_Logic0_port, PUN => X_Logic0_port, ZI => n_1006);
   out_pad_3 : BD2SCARUDQP_1V8_SF_LIN port map( A => X_Logic0_port, TA => 
                           X_Logic0_port, TM => X_Logic0_port, EN => 
                           X_Logic1_port, TEN => X_Logic1_port, IO => 
                           alu_result(3), HYST => X_Logic0_port, PDN => 
                           X_Logic0_port, PUN => X_Logic0_port, ZI => n_1007);
   out_pad_4 : BD2SCARUDQP_1V8_SF_LIN port map( A => X_Logic0_port, TA => 
                           X_Logic0_port, TM => X_Logic0_port, EN => 
                           X_Logic1_port, TEN => X_Logic1_port, IO => 
                           alu_result(4), HYST => X_Logic0_port, PDN => 
                           X_Logic0_port, PUN => X_Logic0_port, ZI => n_1008);
   out_pad_5 : BD2SCARUDQP_1V8_SF_LIN port map( A => X_Logic0_port, TA => 
                           X_Logic0_port, TM => X_Logic0_port, EN => 
                           X_Logic1_port, TEN => X_Logic1_port, IO => 
                           alu_result(5), HYST => X_Logic0_port, PDN => 
                           X_Logic0_port, PUN => X_Logic0_port, ZI => n_1009);
   out_pad_6 : BD2SCARUDQP_1V8_SF_LIN port map( A => X_Logic0_port, TA => 
                           X_Logic0_port, TM => X_Logic0_port, EN => 
                           X_Logic1_port, TEN => X_Logic1_port, IO => 
                           alu_result(6), HYST => X_Logic0_port, PDN => 
                           X_Logic0_port, PUN => X_Logic0_port, ZI => n_1010);
   out_pad_7 : BD2SCARUDQP_1V8_SF_LIN port map( A => X_Logic0_port, TA => 
                           X_Logic0_port, TM => X_Logic0_port, EN => 
                           X_Logic1_port, TEN => X_Logic1_port, IO => 
                           alu_result(7), HYST => X_Logic0_port, PDN => 
                           X_Logic0_port, PUN => X_Logic0_port, ZI => n_1011);
   out_pad_8 : BD2SCARUDQP_1V8_SF_LIN port map( A => X_Logic0_port, TA => 
                           X_Logic0_port, TM => X_Logic0_port, EN => 
                           X_Logic1_port, TEN => X_Logic1_port, IO => 
                           alu_result(8), HYST => X_Logic0_port, PDN => 
                           X_Logic0_port, PUN => X_Logic0_port, ZI => n_1012);
   out_pad_9 : BD2SCARUDQP_1V8_SF_LIN port map( A => X_Logic0_port, TA => 
                           X_Logic0_port, TM => X_Logic0_port, EN => 
                           X_Logic1_port, TEN => X_Logic1_port, IO => 
                           alu_result(9), HYST => X_Logic0_port, PDN => 
                           X_Logic0_port, PUN => X_Logic0_port, ZI => n_1013);
   out_pad_10 : BD2SCARUDQP_1V8_SF_LIN port map( A => X_Logic0_port, TA => 
                           X_Logic0_port, TM => X_Logic0_port, EN => 
                           X_Logic1_port, TEN => X_Logic1_port, IO => 
                           alu_result(10), HYST => X_Logic0_port, PDN => 
                           X_Logic0_port, PUN => X_Logic0_port, ZI => n_1014);
   out_pad_11 : BD2SCARUDQP_1V8_SF_LIN port map( A => X_Logic0_port, TA => 
                           X_Logic0_port, TM => X_Logic0_port, EN => 
                           X_Logic1_port, TEN => X_Logic1_port, IO => 
                           alu_result(11), HYST => X_Logic0_port, PDN => 
                           X_Logic0_port, PUN => X_Logic0_port, ZI => n_1015);
   out_pad_12 : BD2SCARUDQP_1V8_SF_LIN port map( A => X_Logic0_port, TA => 
                           X_Logic0_port, TM => X_Logic0_port, EN => 
                           X_Logic1_port, TEN => X_Logic1_port, IO => 
                           alu_result(12), HYST => X_Logic0_port, PDN => 
                           X_Logic0_port, PUN => X_Logic0_port, ZI => n_1016);
   out_pad_13 : BD2SCARUDQP_1V8_SF_LIN port map( A => X_Logic0_port, TA => 
                           X_Logic0_port, TM => X_Logic0_port, EN => 
                           X_Logic1_port, TEN => X_Logic1_port, IO => 
                           alu_result(13), HYST => X_Logic0_port, PDN => 
                           X_Logic0_port, PUN => X_Logic0_port, ZI => n_1017);
   out_pad_14 : BD2SCARUDQP_1V8_SF_LIN port map( A => X_Logic0_port, TA => 
                           X_Logic0_port, TM => X_Logic0_port, EN => 
                           X_Logic1_port, TEN => X_Logic1_port, IO => 
                           alu_result(14), HYST => X_Logic0_port, PDN => 
                           X_Logic0_port, PUN => X_Logic0_port, ZI => n_1018);
   out_pad_15 : BD2SCARUDQP_1V8_SF_LIN port map( A => X_Logic0_port, TA => 
                           X_Logic0_port, TM => X_Logic0_port, EN => 
                           X_Logic1_port, TEN => X_Logic1_port, IO => 
                           alu_result(15), HYST => X_Logic0_port, PDN => 
                           X_Logic0_port, PUN => X_Logic0_port, ZI => n_1019);
   X_Logic1_port <= '1';
   X_Logic0_port <= '0';
   mini_mips_inst : mini_mips port map( clk => clk_i, rst_n => rst_n_i, 
                           mini_mips_i(63) => s_dmem_to_top_dmem_data_31_port, 
                           mini_mips_i(62) => s_dmem_to_top_dmem_data_30_port, 
                           mini_mips_i(61) => s_dmem_to_top_dmem_data_29_port, 
                           mini_mips_i(60) => s_dmem_to_top_dmem_data_28_port, 
                           mini_mips_i(59) => s_dmem_to_top_dmem_data_27_port, 
                           mini_mips_i(58) => s_dmem_to_top_dmem_data_26_port, 
                           mini_mips_i(57) => s_dmem_to_top_dmem_data_25_port, 
                           mini_mips_i(56) => s_dmem_to_top_dmem_data_24_port, 
                           mini_mips_i(55) => s_dmem_to_top_dmem_data_23_port, 
                           mini_mips_i(54) => s_dmem_to_top_dmem_data_22_port, 
                           mini_mips_i(53) => s_dmem_to_top_dmem_data_21_port, 
                           mini_mips_i(52) => s_dmem_to_top_dmem_data_20_port, 
                           mini_mips_i(51) => s_dmem_to_top_dmem_data_19_port, 
                           mini_mips_i(50) => s_dmem_to_top_dmem_data_18_port, 
                           mini_mips_i(49) => s_dmem_to_top_dmem_data_17_port, 
                           mini_mips_i(48) => s_dmem_to_top_dmem_data_16_port, 
                           mini_mips_i(47) => s_dmem_to_top_dmem_data_15_port, 
                           mini_mips_i(46) => s_dmem_to_top_dmem_data_14_port, 
                           mini_mips_i(45) => s_dmem_to_top_dmem_data_13_port, 
                           mini_mips_i(44) => s_dmem_to_top_dmem_data_12_port, 
                           mini_mips_i(43) => s_dmem_to_top_dmem_data_11_port, 
                           mini_mips_i(42) => s_dmem_to_top_dmem_data_10_port, 
                           mini_mips_i(41) => s_dmem_to_top_dmem_data_9_port, 
                           mini_mips_i(40) => s_dmem_to_top_dmem_data_8_port, 
                           mini_mips_i(39) => s_dmem_to_top_dmem_data_7_port, 
                           mini_mips_i(38) => s_dmem_to_top_dmem_data_6_port, 
                           mini_mips_i(37) => s_dmem_to_top_dmem_data_5_port, 
                           mini_mips_i(36) => s_dmem_to_top_dmem_data_4_port, 
                           mini_mips_i(35) => s_dmem_to_top_dmem_data_3_port, 
                           mini_mips_i(34) => s_dmem_to_top_dmem_data_2_port, 
                           mini_mips_i(33) => s_dmem_to_top_dmem_data_1_port, 
                           mini_mips_i(32) => s_dmem_to_top_dmem_data_0_port, 
                           mini_mips_i(31) => s_imem_to_top_imem_data_31_port, 
                           mini_mips_i(30) => s_imem_to_top_imem_data_30_port, 
                           mini_mips_i(29) => s_imem_to_top_imem_data_29_port, 
                           mini_mips_i(28) => s_imem_to_top_imem_data_28_port, 
                           mini_mips_i(27) => s_imem_to_top_imem_data_27_port, 
                           mini_mips_i(26) => s_imem_to_top_imem_data_26_port, 
                           mini_mips_i(25) => s_imem_to_top_imem_data_25_port, 
                           mini_mips_i(24) => s_imem_to_top_imem_data_24_port, 
                           mini_mips_i(23) => s_imem_to_top_imem_data_23_port, 
                           mini_mips_i(22) => s_imem_to_top_imem_data_22_port, 
                           mini_mips_i(21) => s_imem_to_top_imem_data_21_port, 
                           mini_mips_i(20) => s_imem_to_top_imem_data_20_port, 
                           mini_mips_i(19) => s_imem_to_top_imem_data_19_port, 
                           mini_mips_i(18) => s_imem_to_top_imem_data_18_port, 
                           mini_mips_i(17) => s_imem_to_top_imem_data_17_port, 
                           mini_mips_i(16) => s_imem_to_top_imem_data_16_port, 
                           mini_mips_i(15) => s_imem_to_top_imem_data_15_port, 
                           mini_mips_i(14) => s_imem_to_top_imem_data_14_port, 
                           mini_mips_i(13) => s_imem_to_top_imem_data_13_port, 
                           mini_mips_i(12) => s_imem_to_top_imem_data_12_port, 
                           mini_mips_i(11) => s_imem_to_top_imem_data_11_port, 
                           mini_mips_i(10) => s_imem_to_top_imem_data_10_port, 
                           mini_mips_i(9) => s_imem_to_top_imem_data_9_port, 
                           mini_mips_i(8) => s_imem_to_top_imem_data_8_port, 
                           mini_mips_i(7) => s_imem_to_top_imem_data_7_port, 
                           mini_mips_i(6) => s_imem_to_top_imem_data_6_port, 
                           mini_mips_i(5) => s_imem_to_top_imem_data_5_port, 
                           mini_mips_i(4) => s_imem_to_top_imem_data_4_port, 
                           mini_mips_i(3) => s_imem_to_top_imem_data_3_port, 
                           mini_mips_i(2) => s_imem_to_top_imem_data_2_port, 
                           mini_mips_i(1) => s_imem_to_top_imem_data_1_port, 
                           mini_mips_i(0) => s_imem_to_top_imem_data_0_port, 
                           mini_mips_o(72) => s_top_to_dmem_dmem_addr_11_port, 
                           mini_mips_o(71) => s_top_to_dmem_dmem_addr_10_port, 
                           mini_mips_o(70) => s_top_to_dmem_dmem_addr_9_port, 
                           mini_mips_o(69) => s_top_to_dmem_dmem_addr_8_port, 
                           mini_mips_o(68) => s_top_to_dmem_dmem_addr_7_port, 
                           mini_mips_o(67) => s_top_to_dmem_dmem_addr_6_port, 
                           mini_mips_o(66) => s_top_to_dmem_dmem_addr_5_port, 
                           mini_mips_o(65) => s_top_to_dmem_dmem_addr_4_port, 
                           mini_mips_o(64) => s_top_to_dmem_dmem_addr_3_port, 
                           mini_mips_o(63) => s_top_to_dmem_dmem_addr_2_port, 
                           mini_mips_o(62) => s_top_to_dmem_dmem_addr_1_port, 
                           mini_mips_o(61) => s_top_to_dmem_dmem_addr_0_port, 
                           mini_mips_o(60) => s_top_to_dmem_dmem_data_31_port, 
                           mini_mips_o(59) => s_top_to_dmem_dmem_data_30_port, 
                           mini_mips_o(58) => s_top_to_dmem_dmem_data_29_port, 
                           mini_mips_o(57) => s_top_to_dmem_dmem_data_28_port, 
                           mini_mips_o(56) => s_top_to_dmem_dmem_data_27_port, 
                           mini_mips_o(55) => s_top_to_dmem_dmem_data_26_port, 
                           mini_mips_o(54) => s_top_to_dmem_dmem_data_25_port, 
                           mini_mips_o(53) => s_top_to_dmem_dmem_data_24_port, 
                           mini_mips_o(52) => s_top_to_dmem_dmem_data_23_port, 
                           mini_mips_o(51) => s_top_to_dmem_dmem_data_22_port, 
                           mini_mips_o(50) => s_top_to_dmem_dmem_data_21_port, 
                           mini_mips_o(49) => s_top_to_dmem_dmem_data_20_port, 
                           mini_mips_o(48) => s_top_to_dmem_dmem_data_19_port, 
                           mini_mips_o(47) => s_top_to_dmem_dmem_data_18_port, 
                           mini_mips_o(46) => s_top_to_dmem_dmem_data_17_port, 
                           mini_mips_o(45) => s_top_to_dmem_dmem_data_16_port, 
                           mini_mips_o(44) => s_top_to_dmem_dmem_data_15_port, 
                           mini_mips_o(43) => s_top_to_dmem_dmem_data_14_port, 
                           mini_mips_o(42) => s_top_to_dmem_dmem_data_13_port, 
                           mini_mips_o(41) => s_top_to_dmem_dmem_data_12_port, 
                           mini_mips_o(40) => s_top_to_dmem_dmem_data_11_port, 
                           mini_mips_o(39) => s_top_to_dmem_dmem_data_10_port, 
                           mini_mips_o(38) => s_top_to_dmem_dmem_data_9_port, 
                           mini_mips_o(37) => s_top_to_dmem_dmem_data_8_port, 
                           mini_mips_o(36) => s_top_to_dmem_dmem_data_7_port, 
                           mini_mips_o(35) => s_top_to_dmem_dmem_data_6_port, 
                           mini_mips_o(34) => s_top_to_dmem_dmem_data_5_port, 
                           mini_mips_o(33) => s_top_to_dmem_dmem_data_4_port, 
                           mini_mips_o(32) => s_top_to_dmem_dmem_data_3_port, 
                           mini_mips_o(31) => s_top_to_dmem_dmem_data_2_port, 
                           mini_mips_o(30) => s_top_to_dmem_dmem_data_1_port, 
                           mini_mips_o(29) => s_top_to_dmem_dmem_data_0_port, 
                           mini_mips_o(28) => s_top_to_imem_imem_addr_11_port, 
                           mini_mips_o(27) => s_top_to_imem_imem_addr_10_port, 
                           mini_mips_o(26) => s_top_to_imem_imem_addr_9_port, 
                           mini_mips_o(25) => s_top_to_imem_imem_addr_8_port, 
                           mini_mips_o(24) => s_top_to_imem_imem_addr_7_port, 
                           mini_mips_o(23) => s_top_to_imem_imem_addr_6_port, 
                           mini_mips_o(22) => s_top_to_imem_imem_addr_5_port, 
                           mini_mips_o(21) => s_top_to_imem_imem_addr_4_port, 
                           mini_mips_o(20) => s_top_to_imem_imem_addr_3_port, 
                           mini_mips_o(19) => s_top_to_imem_imem_addr_2_port, 
                           mini_mips_o(18) => s_top_to_imem_imem_addr_1_port, 
                           mini_mips_o(17) => s_top_to_imem_imem_addr_0_port, 
                           mini_mips_o(16) => s_dmem_wen_n, mini_mips_o(15) => 
                           n_1020, mini_mips_o(14) => n_1021, mini_mips_o(13) 
                           => n_1022, mini_mips_o(12) => n_1023, 
                           mini_mips_o(11) => n_1024, mini_mips_o(10) => n_1025
                           , mini_mips_o(9) => n_1026, mini_mips_o(8) => n_1027
                           , mini_mips_o(7) => n_1028, mini_mips_o(6) => n_1029
                           , mini_mips_o(5) => n_1030, mini_mips_o(4) => n_1031
                           , mini_mips_o(3) => n_1032, mini_mips_o(2) => n_1033
                           , mini_mips_o(1) => n_1034, mini_mips_o(0) => n_1035
                           );

end SYN_Behavioral;
