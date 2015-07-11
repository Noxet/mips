
module pc ( clk, rst_n, halt_i, npc_i, pc_o );
  input [11:0] npc_i;
  output [11:0] pc_o;
  input clk, rst_n, halt_i;
  wire   n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n15;

  HS65_LH_DFPSQX9 \pc_c_reg[11]  ( .D(n13), .CP(clk), .SN(rst_n), .Q(pc_o[11])
         );
  HS65_LH_DFPSQX9 \pc_c_reg[10]  ( .D(n12), .CP(clk), .SN(rst_n), .Q(pc_o[10])
         );
  HS65_LH_DFPSQX9 \pc_c_reg[9]  ( .D(n11), .CP(clk), .SN(rst_n), .Q(pc_o[9])
         );
  HS65_LH_DFPSQX9 \pc_c_reg[8]  ( .D(n10), .CP(clk), .SN(rst_n), .Q(pc_o[8])
         );
  HS65_LH_DFPSQX9 \pc_c_reg[7]  ( .D(n9), .CP(clk), .SN(rst_n), .Q(pc_o[7]) );
  HS65_LH_DFPSQX9 \pc_c_reg[6]  ( .D(n8), .CP(clk), .SN(rst_n), .Q(pc_o[6]) );
  HS65_LH_DFPSQX9 \pc_c_reg[5]  ( .D(n7), .CP(clk), .SN(rst_n), .Q(pc_o[5]) );
  HS65_LH_DFPSQX9 \pc_c_reg[4]  ( .D(n6), .CP(clk), .SN(rst_n), .Q(pc_o[4]) );
  HS65_LH_DFPSQX9 \pc_c_reg[3]  ( .D(n5), .CP(clk), .SN(rst_n), .Q(pc_o[3]) );
  HS65_LH_DFPSQX9 \pc_c_reg[2]  ( .D(n4), .CP(clk), .SN(rst_n), .Q(pc_o[2]) );
  HS65_LH_DFPSQX9 \pc_c_reg[1]  ( .D(n3), .CP(clk), .SN(rst_n), .Q(pc_o[1]) );
  HS65_LH_DFPSQX9 \pc_c_reg[0]  ( .D(n2), .CP(clk), .SN(rst_n), .Q(pc_o[0]) );
  HS65_LH_AO22X9 U2 ( .A(pc_o[11]), .B(halt_i), .C(npc_i[11]), .D(n15), .Z(n13) );
  HS65_LH_AO22X9 U3 ( .A(pc_o[5]), .B(halt_i), .C(npc_i[5]), .D(n15), .Z(n7)
         );
  HS65_LH_AO22X9 U4 ( .A(pc_o[6]), .B(halt_i), .C(npc_i[6]), .D(n15), .Z(n8)
         );
  HS65_LH_AO22X9 U5 ( .A(pc_o[7]), .B(halt_i), .C(npc_i[7]), .D(n15), .Z(n9)
         );
  HS65_LH_AO22X9 U6 ( .A(pc_o[8]), .B(halt_i), .C(npc_i[8]), .D(n15), .Z(n10)
         );
  HS65_LH_AO22X9 U7 ( .A(pc_o[9]), .B(halt_i), .C(npc_i[9]), .D(n15), .Z(n11)
         );
  HS65_LH_AO22X9 U8 ( .A(pc_o[10]), .B(halt_i), .C(npc_i[10]), .D(n15), .Z(n12) );
  HS65_LH_AO22X9 U9 ( .A(pc_o[1]), .B(halt_i), .C(npc_i[1]), .D(n15), .Z(n3)
         );
  HS65_LH_AO22X9 U10 ( .A(pc_o[2]), .B(halt_i), .C(npc_i[2]), .D(n15), .Z(n4)
         );
  HS65_LH_AO22X9 U11 ( .A(pc_o[3]), .B(halt_i), .C(npc_i[3]), .D(n15), .Z(n5)
         );
  HS65_LH_AO22X9 U12 ( .A(pc_o[4]), .B(halt_i), .C(npc_i[4]), .D(n15), .Z(n6)
         );
  HS65_LH_AO22X9 U13 ( .A(pc_o[0]), .B(halt_i), .C(npc_i[0]), .D(n15), .Z(n2)
         );
  HS65_LH_IVX9 U14 ( .A(halt_i), .Z(n15) );
endmodule


module if_top_DW01_inc_0 ( A, SUM );
  input [11:0] A;
  output [11:0] SUM;

  wire   [11:2] carry;

  HS65_LH_HA1X4 U1_1_9 ( .A0(A[9]), .B0(carry[9]), .CO(carry[10]), .S0(SUM[9])
         );
  HS65_LH_HA1X4 U1_1_8 ( .A0(A[8]), .B0(carry[8]), .CO(carry[9]), .S0(SUM[8])
         );
  HS65_LH_HA1X4 U1_1_7 ( .A0(A[7]), .B0(carry[7]), .CO(carry[8]), .S0(SUM[7])
         );
  HS65_LH_HA1X4 U1_1_6 ( .A0(A[6]), .B0(carry[6]), .CO(carry[7]), .S0(SUM[6])
         );
  HS65_LH_HA1X4 U1_1_5 ( .A0(A[5]), .B0(carry[5]), .CO(carry[6]), .S0(SUM[5])
         );
  HS65_LH_HA1X4 U1_1_4 ( .A0(A[4]), .B0(carry[4]), .CO(carry[5]), .S0(SUM[4])
         );
  HS65_LH_HA1X4 U1_1_3 ( .A0(A[3]), .B0(carry[3]), .CO(carry[4]), .S0(SUM[3])
         );
  HS65_LH_HA1X4 U1_1_2 ( .A0(A[2]), .B0(carry[2]), .CO(carry[3]), .S0(SUM[2])
         );
  HS65_LH_HA1X4 U1_1_1 ( .A0(A[1]), .B0(A[0]), .CO(carry[2]), .S0(SUM[1]) );
  HS65_LH_HA1X4 U1_1_10 ( .A0(A[10]), .B0(carry[10]), .CO(carry[11]), .S0(
        SUM[10]) );
  HS65_LHS_XOR2X6 U1 ( .A(carry[11]), .B(A[11]), .Z(SUM[11]) );
  HS65_LH_IVX9 U2 ( .A(A[0]), .Z(SUM[0]) );
endmodule


module if_top ( clk, rst_n, .if_top_i({\if_top_i[HALT_I] , 
        \if_top_i[BRANCH_PC][11] , \if_top_i[BRANCH_PC][10] , 
        \if_top_i[BRANCH_PC][9] , \if_top_i[BRANCH_PC][8] , 
        \if_top_i[BRANCH_PC][7] , \if_top_i[BRANCH_PC][6] , 
        \if_top_i[BRANCH_PC][5] , \if_top_i[BRANCH_PC][4] , 
        \if_top_i[BRANCH_PC][3] , \if_top_i[BRANCH_PC][2] , 
        \if_top_i[BRANCH_PC][1] , \if_top_i[BRANCH_PC][0] , \if_top_i[PCSRC] }
        ), .if_top_o({\if_top_o[IMEM_ADDR][11] , \if_top_o[IMEM_ADDR][10] , 
        \if_top_o[IMEM_ADDR][9] , \if_top_o[IMEM_ADDR][8] , 
        \if_top_o[IMEM_ADDR][7] , \if_top_o[IMEM_ADDR][6] , 
        \if_top_o[IMEM_ADDR][5] , \if_top_o[IMEM_ADDR][4] , 
        \if_top_o[IMEM_ADDR][3] , \if_top_o[IMEM_ADDR][2] , 
        \if_top_o[IMEM_ADDR][1] , \if_top_o[IMEM_ADDR][0] , 
        \if_top_o[PC_PLUS1][11] , \if_top_o[PC_PLUS1][10] , 
        \if_top_o[PC_PLUS1][9] , \if_top_o[PC_PLUS1][8] , 
        \if_top_o[PC_PLUS1][7] , \if_top_o[PC_PLUS1][6] , 
        \if_top_o[PC_PLUS1][5] , \if_top_o[PC_PLUS1][4] , 
        \if_top_o[PC_PLUS1][3] , \if_top_o[PC_PLUS1][2] , 
        \if_top_o[PC_PLUS1][1] , \if_top_o[PC_PLUS1][0] }) );
  input clk, rst_n, \if_top_i[HALT_I] , \if_top_i[BRANCH_PC][11] ,
         \if_top_i[BRANCH_PC][10] , \if_top_i[BRANCH_PC][9] ,
         \if_top_i[BRANCH_PC][8] , \if_top_i[BRANCH_PC][7] ,
         \if_top_i[BRANCH_PC][6] , \if_top_i[BRANCH_PC][5] ,
         \if_top_i[BRANCH_PC][4] , \if_top_i[BRANCH_PC][3] ,
         \if_top_i[BRANCH_PC][2] , \if_top_i[BRANCH_PC][1] ,
         \if_top_i[BRANCH_PC][0] , \if_top_i[PCSRC] ;
  output \if_top_o[IMEM_ADDR][11] , \if_top_o[IMEM_ADDR][10] ,
         \if_top_o[IMEM_ADDR][9] , \if_top_o[IMEM_ADDR][8] ,
         \if_top_o[IMEM_ADDR][7] , \if_top_o[IMEM_ADDR][6] ,
         \if_top_o[IMEM_ADDR][5] , \if_top_o[IMEM_ADDR][4] ,
         \if_top_o[IMEM_ADDR][3] , \if_top_o[IMEM_ADDR][2] ,
         \if_top_o[IMEM_ADDR][1] , \if_top_o[IMEM_ADDR][0] ,
         \if_top_o[PC_PLUS1][11] , \if_top_o[PC_PLUS1][10] ,
         \if_top_o[PC_PLUS1][9] , \if_top_o[PC_PLUS1][8] ,
         \if_top_o[PC_PLUS1][7] , \if_top_o[PC_PLUS1][6] ,
         \if_top_o[PC_PLUS1][5] , \if_top_o[PC_PLUS1][4] ,
         \if_top_o[PC_PLUS1][3] , \if_top_o[PC_PLUS1][2] ,
         \if_top_o[PC_PLUS1][1] , \if_top_o[PC_PLUS1][0] ;
  wire   n3;
  wire   [11:0] s_npc;

  pc pc_inst ( .clk(clk), .rst_n(rst_n), .halt_i(\if_top_i[HALT_I] ), .npc_i(
        s_npc), .pc_o({\if_top_o[IMEM_ADDR][11] , \if_top_o[IMEM_ADDR][10] , 
        \if_top_o[IMEM_ADDR][9] , \if_top_o[IMEM_ADDR][8] , 
        \if_top_o[IMEM_ADDR][7] , \if_top_o[IMEM_ADDR][6] , 
        \if_top_o[IMEM_ADDR][5] , \if_top_o[IMEM_ADDR][4] , 
        \if_top_o[IMEM_ADDR][3] , \if_top_o[IMEM_ADDR][2] , 
        \if_top_o[IMEM_ADDR][1] , \if_top_o[IMEM_ADDR][0] }) );
  if_top_DW01_inc_0 add_37 ( .A({\if_top_o[IMEM_ADDR][11] , 
        \if_top_o[IMEM_ADDR][10] , \if_top_o[IMEM_ADDR][9] , 
        \if_top_o[IMEM_ADDR][8] , \if_top_o[IMEM_ADDR][7] , 
        \if_top_o[IMEM_ADDR][6] , \if_top_o[IMEM_ADDR][5] , 
        \if_top_o[IMEM_ADDR][4] , \if_top_o[IMEM_ADDR][3] , 
        \if_top_o[IMEM_ADDR][2] , \if_top_o[IMEM_ADDR][1] , 
        \if_top_o[IMEM_ADDR][0] }), .SUM({\if_top_o[PC_PLUS1][11] , 
        \if_top_o[PC_PLUS1][10] , \if_top_o[PC_PLUS1][9] , 
        \if_top_o[PC_PLUS1][8] , \if_top_o[PC_PLUS1][7] , 
        \if_top_o[PC_PLUS1][6] , \if_top_o[PC_PLUS1][5] , 
        \if_top_o[PC_PLUS1][4] , \if_top_o[PC_PLUS1][3] , 
        \if_top_o[PC_PLUS1][2] , \if_top_o[PC_PLUS1][1] , 
        \if_top_o[PC_PLUS1][0] }) );
  HS65_LH_AO22X9 U2 ( .A(\if_top_o[PC_PLUS1][11] ), .B(n3), .C(
        \if_top_i[BRANCH_PC][11] ), .D(\if_top_i[PCSRC] ), .Z(s_npc[11]) );
  HS65_LH_AO22X9 U3 ( .A(\if_top_o[PC_PLUS1][5] ), .B(n3), .C(
        \if_top_i[BRANCH_PC][5] ), .D(\if_top_i[PCSRC] ), .Z(s_npc[5]) );
  HS65_LH_AO22X9 U4 ( .A(\if_top_o[PC_PLUS1][6] ), .B(n3), .C(
        \if_top_i[BRANCH_PC][6] ), .D(\if_top_i[PCSRC] ), .Z(s_npc[6]) );
  HS65_LH_AO22X9 U5 ( .A(\if_top_o[PC_PLUS1][7] ), .B(n3), .C(
        \if_top_i[BRANCH_PC][7] ), .D(\if_top_i[PCSRC] ), .Z(s_npc[7]) );
  HS65_LH_AO22X9 U6 ( .A(\if_top_o[PC_PLUS1][8] ), .B(n3), .C(
        \if_top_i[BRANCH_PC][8] ), .D(\if_top_i[PCSRC] ), .Z(s_npc[8]) );
  HS65_LH_AO22X9 U7 ( .A(\if_top_o[PC_PLUS1][9] ), .B(n3), .C(
        \if_top_i[PCSRC] ), .D(\if_top_i[BRANCH_PC][9] ), .Z(s_npc[9]) );
  HS65_LH_AO22X9 U8 ( .A(\if_top_o[PC_PLUS1][10] ), .B(n3), .C(
        \if_top_i[BRANCH_PC][10] ), .D(\if_top_i[PCSRC] ), .Z(s_npc[10]) );
  HS65_LH_AO22X9 U9 ( .A(\if_top_o[PC_PLUS1][1] ), .B(n3), .C(
        \if_top_i[BRANCH_PC][1] ), .D(\if_top_i[PCSRC] ), .Z(s_npc[1]) );
  HS65_LH_AO22X9 U10 ( .A(\if_top_o[PC_PLUS1][2] ), .B(n3), .C(
        \if_top_i[BRANCH_PC][2] ), .D(\if_top_i[PCSRC] ), .Z(s_npc[2]) );
  HS65_LH_AO22X9 U11 ( .A(\if_top_o[PC_PLUS1][3] ), .B(n3), .C(
        \if_top_i[BRANCH_PC][3] ), .D(\if_top_i[PCSRC] ), .Z(s_npc[3]) );
  HS65_LH_AO22X9 U12 ( .A(\if_top_o[PC_PLUS1][4] ), .B(n3), .C(
        \if_top_i[BRANCH_PC][4] ), .D(\if_top_i[PCSRC] ), .Z(s_npc[4]) );
  HS65_LH_AO22X9 U13 ( .A(\if_top_o[PC_PLUS1][0] ), .B(n3), .C(
        \if_top_i[BRANCH_PC][0] ), .D(\if_top_i[PCSRC] ), .Z(s_npc[0]) );
  HS65_LH_IVX9 U14 ( .A(\if_top_i[PCSRC] ), .Z(n3) );
endmodule


module controller ( .ctrl_i({\ctrl_i[OPCODE][5] , \ctrl_i[OPCODE][4] , 
        \ctrl_i[OPCODE][3] , \ctrl_i[OPCODE][2] , \ctrl_i[OPCODE][1] , 
        \ctrl_i[OPCODE][0] }), .ctrl_o({\ctrl_o[REGDST] , \ctrl_o[ALUSRC_B] , 
        \ctrl_o[MEMTOREG] , \ctrl_o[REGWRITE] , \ctrl_o[MEMWEN_N] , 
        \ctrl_o[BRANCH] , \ctrl_o[CALU_OP][3] , \ctrl_o[CALU_OP][2] , 
        \ctrl_o[CALU_OP][1] , \ctrl_o[CALU_OP][0] }) );
  input \ctrl_i[OPCODE][5] , \ctrl_i[OPCODE][4] , \ctrl_i[OPCODE][3] ,
         \ctrl_i[OPCODE][2] , \ctrl_i[OPCODE][1] , \ctrl_i[OPCODE][0] ;
  output \ctrl_o[REGDST] , \ctrl_o[ALUSRC_B] , \ctrl_o[MEMTOREG] ,
         \ctrl_o[REGWRITE] , \ctrl_o[MEMWEN_N] , \ctrl_o[BRANCH] ,
         \ctrl_o[CALU_OP][3] , \ctrl_o[CALU_OP][2] , \ctrl_o[CALU_OP][1] ,
         \ctrl_o[CALU_OP][0] ;
  wire   n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n28, \ctrl_o[BRANCH] ,
         n30, n31, n32;
  assign \ctrl_o[CALU_OP][3]  = 1'b0;
  assign \ctrl_o[CALU_OP][2]  = \ctrl_o[BRANCH] ;

  HS65_LH_AND2X4 U3 ( .A(n15), .B(n13), .Z(n8) );
  HS65_LH_AO212X4 U4 ( .A(n9), .B(n11), .C(n32), .D(n10), .E(\ctrl_o[BRANCH] ), 
        .Z(\ctrl_o[REGDST] ) );
  HS65_LH_IVX9 U5 ( .A(n14), .Z(\ctrl_o[BRANCH] ) );
  HS65_LH_NOR3X4 U6 ( .A(n28), .B(\ctrl_i[OPCODE][2] ), .C(n30), .Z(n9) );
  HS65_LH_NOR3X4 U7 ( .A(n28), .B(\ctrl_i[OPCODE][5] ), .C(n31), .Z(n16) );
  HS65_LH_NAND3X5 U8 ( .A(n9), .B(n32), .C(\ctrl_i[OPCODE][5] ), .Z(n12) );
  HS65_LH_NAND3X5 U9 ( .A(\ctrl_i[OPCODE][2] ), .B(n30), .C(n11), .Z(n14) );
  HS65_LH_NOR4ABX2 U10 ( .A(n28), .B(n31), .C(\ctrl_i[OPCODE][2] ), .D(
        \ctrl_i[OPCODE][5] ), .Z(n10) );
  HS65_LH_NOR3X4 U11 ( .A(\ctrl_i[OPCODE][4] ), .B(\ctrl_i[OPCODE][5] ), .C(
        \ctrl_i[OPCODE][3] ), .Z(n11) );
  HS65_LH_OAI212X5 U12 ( .A(\ctrl_i[OPCODE][4] ), .B(n15), .C(n28), .D(n14), 
        .E(n12), .Z(\ctrl_o[CALU_OP][0] ) );
  HS65_LH_NAND3AX6 U13 ( .A(\ctrl_i[OPCODE][2] ), .B(n30), .C(n16), .Z(n15) );
  HS65_LH_NAND3X5 U14 ( .A(\ctrl_i[OPCODE][1] ), .B(n16), .C(
        \ctrl_i[OPCODE][2] ), .Z(n13) );
  HS65_LH_IVX9 U15 ( .A(\ctrl_i[OPCODE][0] ), .Z(n28) );
  HS65_LH_OAI21X3 U16 ( .A(\ctrl_i[OPCODE][4] ), .B(n8), .C(n12), .Z(
        \ctrl_o[ALUSRC_B] ) );
  HS65_LH_OAI21X3 U17 ( .A(\ctrl_i[OPCODE][4] ), .B(n13), .C(n14), .Z(
        \ctrl_o[CALU_OP][1] ) );
  HS65_LH_IVX9 U18 ( .A(\ctrl_i[OPCODE][1] ), .Z(n30) );
  HS65_LH_NOR2X6 U19 ( .A(\ctrl_i[OPCODE][3] ), .B(n12), .Z(\ctrl_o[MEMTOREG] ) );
  HS65_LH_IVX9 U20 ( .A(\ctrl_i[OPCODE][3] ), .Z(n31) );
  HS65_LH_AOI12X2 U21 ( .A(n7), .B(n8), .C(\ctrl_i[OPCODE][4] ), .Z(
        \ctrl_o[REGWRITE] ) );
  HS65_LH_AOI12X2 U22 ( .A(n9), .B(n31), .C(n10), .Z(n7) );
  HS65_LH_NAND2AX7 U23 ( .A(n12), .B(\ctrl_i[OPCODE][3] ), .Z(
        \ctrl_o[MEMWEN_N] ) );
  HS65_LH_IVX9 U24 ( .A(\ctrl_i[OPCODE][4] ), .Z(n32) );
endmodule


module mini_mips ( clk, rst_n, .mini_mips_i({\mini_mips_i[DMEM_DATA][31] , 
        \mini_mips_i[DMEM_DATA][30] , \mini_mips_i[DMEM_DATA][29] , 
        \mini_mips_i[DMEM_DATA][28] , \mini_mips_i[DMEM_DATA][27] , 
        \mini_mips_i[DMEM_DATA][26] , \mini_mips_i[DMEM_DATA][25] , 
        \mini_mips_i[DMEM_DATA][24] , \mini_mips_i[DMEM_DATA][23] , 
        \mini_mips_i[DMEM_DATA][22] , \mini_mips_i[DMEM_DATA][21] , 
        \mini_mips_i[DMEM_DATA][20] , \mini_mips_i[DMEM_DATA][19] , 
        \mini_mips_i[DMEM_DATA][18] , \mini_mips_i[DMEM_DATA][17] , 
        \mini_mips_i[DMEM_DATA][16] , \mini_mips_i[DMEM_DATA][15] , 
        \mini_mips_i[DMEM_DATA][14] , \mini_mips_i[DMEM_DATA][13] , 
        \mini_mips_i[DMEM_DATA][12] , \mini_mips_i[DMEM_DATA][11] , 
        \mini_mips_i[DMEM_DATA][10] , \mini_mips_i[DMEM_DATA][9] , 
        \mini_mips_i[DMEM_DATA][8] , \mini_mips_i[DMEM_DATA][7] , 
        \mini_mips_i[DMEM_DATA][6] , \mini_mips_i[DMEM_DATA][5] , 
        \mini_mips_i[DMEM_DATA][4] , \mini_mips_i[DMEM_DATA][3] , 
        \mini_mips_i[DMEM_DATA][2] , \mini_mips_i[DMEM_DATA][1] , 
        \mini_mips_i[DMEM_DATA][0] , \mini_mips_i[IMEM_DATA][31] , 
        \mini_mips_i[IMEM_DATA][30] , \mini_mips_i[IMEM_DATA][29] , 
        \mini_mips_i[IMEM_DATA][28] , \mini_mips_i[IMEM_DATA][27] , 
        \mini_mips_i[IMEM_DATA][26] , \mini_mips_i[IMEM_DATA][25] , 
        \mini_mips_i[IMEM_DATA][24] , \mini_mips_i[IMEM_DATA][23] , 
        \mini_mips_i[IMEM_DATA][22] , \mini_mips_i[IMEM_DATA][21] , 
        \mini_mips_i[IMEM_DATA][20] , \mini_mips_i[IMEM_DATA][19] , 
        \mini_mips_i[IMEM_DATA][18] , \mini_mips_i[IMEM_DATA][17] , 
        \mini_mips_i[IMEM_DATA][16] , \mini_mips_i[IMEM_DATA][15] , 
        \mini_mips_i[IMEM_DATA][14] , \mini_mips_i[IMEM_DATA][13] , 
        \mini_mips_i[IMEM_DATA][12] , \mini_mips_i[IMEM_DATA][11] , 
        \mini_mips_i[IMEM_DATA][10] , \mini_mips_i[IMEM_DATA][9] , 
        \mini_mips_i[IMEM_DATA][8] , \mini_mips_i[IMEM_DATA][7] , 
        \mini_mips_i[IMEM_DATA][6] , \mini_mips_i[IMEM_DATA][5] , 
        \mini_mips_i[IMEM_DATA][4] , \mini_mips_i[IMEM_DATA][3] , 
        \mini_mips_i[IMEM_DATA][2] , \mini_mips_i[IMEM_DATA][1] , 
        \mini_mips_i[IMEM_DATA][0] }), .mini_mips_o({
        \mini_mips_o[DMEM_ADDR][11] , \mini_mips_o[DMEM_ADDR][10] , 
        \mini_mips_o[DMEM_ADDR][9] , \mini_mips_o[DMEM_ADDR][8] , 
        \mini_mips_o[DMEM_ADDR][7] , \mini_mips_o[DMEM_ADDR][6] , 
        \mini_mips_o[DMEM_ADDR][5] , \mini_mips_o[DMEM_ADDR][4] , 
        \mini_mips_o[DMEM_ADDR][3] , \mini_mips_o[DMEM_ADDR][2] , 
        \mini_mips_o[DMEM_ADDR][1] , \mini_mips_o[DMEM_ADDR][0] , 
        \mini_mips_o[DMEM_DATA][31] , \mini_mips_o[DMEM_DATA][30] , 
        \mini_mips_o[DMEM_DATA][29] , \mini_mips_o[DMEM_DATA][28] , 
        \mini_mips_o[DMEM_DATA][27] , \mini_mips_o[DMEM_DATA][26] , 
        \mini_mips_o[DMEM_DATA][25] , \mini_mips_o[DMEM_DATA][24] , 
        \mini_mips_o[DMEM_DATA][23] , \mini_mips_o[DMEM_DATA][22] , 
        \mini_mips_o[DMEM_DATA][21] , \mini_mips_o[DMEM_DATA][20] , 
        \mini_mips_o[DMEM_DATA][19] , \mini_mips_o[DMEM_DATA][18] , 
        \mini_mips_o[DMEM_DATA][17] , \mini_mips_o[DMEM_DATA][16] , 
        \mini_mips_o[DMEM_DATA][15] , \mini_mips_o[DMEM_DATA][14] , 
        \mini_mips_o[DMEM_DATA][13] , \mini_mips_o[DMEM_DATA][12] , 
        \mini_mips_o[DMEM_DATA][11] , \mini_mips_o[DMEM_DATA][10] , 
        \mini_mips_o[DMEM_DATA][9] , \mini_mips_o[DMEM_DATA][8] , 
        \mini_mips_o[DMEM_DATA][7] , \mini_mips_o[DMEM_DATA][6] , 
        \mini_mips_o[DMEM_DATA][5] , \mini_mips_o[DMEM_DATA][4] , 
        \mini_mips_o[DMEM_DATA][3] , \mini_mips_o[DMEM_DATA][2] , 
        \mini_mips_o[DMEM_DATA][1] , \mini_mips_o[DMEM_DATA][0] , 
        \mini_mips_o[IMEM_ADDR][11] , \mini_mips_o[IMEM_ADDR][10] , 
        \mini_mips_o[IMEM_ADDR][9] , \mini_mips_o[IMEM_ADDR][8] , 
        \mini_mips_o[IMEM_ADDR][7] , \mini_mips_o[IMEM_ADDR][6] , 
        \mini_mips_o[IMEM_ADDR][5] , \mini_mips_o[IMEM_ADDR][4] , 
        \mini_mips_o[IMEM_ADDR][3] , \mini_mips_o[IMEM_ADDR][2] , 
        \mini_mips_o[IMEM_ADDR][1] , \mini_mips_o[IMEM_ADDR][0] , 
        \mini_mips_o[DMEM_WEN_N] , \mini_mips_o[ALU_RESULT][15] , 
        \mini_mips_o[ALU_RESULT][14] , \mini_mips_o[ALU_RESULT][13] , 
        \mini_mips_o[ALU_RESULT][12] , \mini_mips_o[ALU_RESULT][11] , 
        \mini_mips_o[ALU_RESULT][10] , \mini_mips_o[ALU_RESULT][9] , 
        \mini_mips_o[ALU_RESULT][8] , \mini_mips_o[ALU_RESULT][7] , 
        \mini_mips_o[ALU_RESULT][6] , \mini_mips_o[ALU_RESULT][5] , 
        \mini_mips_o[ALU_RESULT][4] , \mini_mips_o[ALU_RESULT][3] , 
        \mini_mips_o[ALU_RESULT][2] , \mini_mips_o[ALU_RESULT][1] , 
        \mini_mips_o[ALU_RESULT][0] }) );
  input clk, rst_n, \mini_mips_i[DMEM_DATA][31] , \mini_mips_i[DMEM_DATA][30] ,
         \mini_mips_i[DMEM_DATA][29] , \mini_mips_i[DMEM_DATA][28] ,
         \mini_mips_i[DMEM_DATA][27] , \mini_mips_i[DMEM_DATA][26] ,
         \mini_mips_i[DMEM_DATA][25] , \mini_mips_i[DMEM_DATA][24] ,
         \mini_mips_i[DMEM_DATA][23] , \mini_mips_i[DMEM_DATA][22] ,
         \mini_mips_i[DMEM_DATA][21] , \mini_mips_i[DMEM_DATA][20] ,
         \mini_mips_i[DMEM_DATA][19] , \mini_mips_i[DMEM_DATA][18] ,
         \mini_mips_i[DMEM_DATA][17] , \mini_mips_i[DMEM_DATA][16] ,
         \mini_mips_i[DMEM_DATA][15] , \mini_mips_i[DMEM_DATA][14] ,
         \mini_mips_i[DMEM_DATA][13] , \mini_mips_i[DMEM_DATA][12] ,
         \mini_mips_i[DMEM_DATA][11] , \mini_mips_i[DMEM_DATA][10] ,
         \mini_mips_i[DMEM_DATA][9] , \mini_mips_i[DMEM_DATA][8] ,
         \mini_mips_i[DMEM_DATA][7] , \mini_mips_i[DMEM_DATA][6] ,
         \mini_mips_i[DMEM_DATA][5] , \mini_mips_i[DMEM_DATA][4] ,
         \mini_mips_i[DMEM_DATA][3] , \mini_mips_i[DMEM_DATA][2] ,
         \mini_mips_i[DMEM_DATA][1] , \mini_mips_i[DMEM_DATA][0] ,
         \mini_mips_i[IMEM_DATA][31] , \mini_mips_i[IMEM_DATA][30] ,
         \mini_mips_i[IMEM_DATA][29] , \mini_mips_i[IMEM_DATA][28] ,
         \mini_mips_i[IMEM_DATA][27] , \mini_mips_i[IMEM_DATA][26] ,
         \mini_mips_i[IMEM_DATA][25] , \mini_mips_i[IMEM_DATA][24] ,
         \mini_mips_i[IMEM_DATA][23] , \mini_mips_i[IMEM_DATA][22] ,
         \mini_mips_i[IMEM_DATA][21] , \mini_mips_i[IMEM_DATA][20] ,
         \mini_mips_i[IMEM_DATA][19] , \mini_mips_i[IMEM_DATA][18] ,
         \mini_mips_i[IMEM_DATA][17] , \mini_mips_i[IMEM_DATA][16] ,
         \mini_mips_i[IMEM_DATA][15] , \mini_mips_i[IMEM_DATA][14] ,
         \mini_mips_i[IMEM_DATA][13] , \mini_mips_i[IMEM_DATA][12] ,
         \mini_mips_i[IMEM_DATA][11] , \mini_mips_i[IMEM_DATA][10] ,
         \mini_mips_i[IMEM_DATA][9] , \mini_mips_i[IMEM_DATA][8] ,
         \mini_mips_i[IMEM_DATA][7] , \mini_mips_i[IMEM_DATA][6] ,
         \mini_mips_i[IMEM_DATA][5] , \mini_mips_i[IMEM_DATA][4] ,
         \mini_mips_i[IMEM_DATA][3] , \mini_mips_i[IMEM_DATA][2] ,
         \mini_mips_i[IMEM_DATA][1] , \mini_mips_i[IMEM_DATA][0] ;
  output \mini_mips_o[DMEM_ADDR][11] , \mini_mips_o[DMEM_ADDR][10] ,
         \mini_mips_o[DMEM_ADDR][9] , \mini_mips_o[DMEM_ADDR][8] ,
         \mini_mips_o[DMEM_ADDR][7] , \mini_mips_o[DMEM_ADDR][6] ,
         \mini_mips_o[DMEM_ADDR][5] , \mini_mips_o[DMEM_ADDR][4] ,
         \mini_mips_o[DMEM_ADDR][3] , \mini_mips_o[DMEM_ADDR][2] ,
         \mini_mips_o[DMEM_ADDR][1] , \mini_mips_o[DMEM_ADDR][0] ,
         \mini_mips_o[DMEM_DATA][31] , \mini_mips_o[DMEM_DATA][30] ,
         \mini_mips_o[DMEM_DATA][29] , \mini_mips_o[DMEM_DATA][28] ,
         \mini_mips_o[DMEM_DATA][27] , \mini_mips_o[DMEM_DATA][26] ,
         \mini_mips_o[DMEM_DATA][25] , \mini_mips_o[DMEM_DATA][24] ,
         \mini_mips_o[DMEM_DATA][23] , \mini_mips_o[DMEM_DATA][22] ,
         \mini_mips_o[DMEM_DATA][21] , \mini_mips_o[DMEM_DATA][20] ,
         \mini_mips_o[DMEM_DATA][19] , \mini_mips_o[DMEM_DATA][18] ,
         \mini_mips_o[DMEM_DATA][17] , \mini_mips_o[DMEM_DATA][16] ,
         \mini_mips_o[DMEM_DATA][15] , \mini_mips_o[DMEM_DATA][14] ,
         \mini_mips_o[DMEM_DATA][13] , \mini_mips_o[DMEM_DATA][12] ,
         \mini_mips_o[DMEM_DATA][11] , \mini_mips_o[DMEM_DATA][10] ,
         \mini_mips_o[DMEM_DATA][9] , \mini_mips_o[DMEM_DATA][8] ,
         \mini_mips_o[DMEM_DATA][7] , \mini_mips_o[DMEM_DATA][6] ,
         \mini_mips_o[DMEM_DATA][5] , \mini_mips_o[DMEM_DATA][4] ,
         \mini_mips_o[DMEM_DATA][3] , \mini_mips_o[DMEM_DATA][2] ,
         \mini_mips_o[DMEM_DATA][1] , \mini_mips_o[DMEM_DATA][0] ,
         \mini_mips_o[IMEM_ADDR][11] , \mini_mips_o[IMEM_ADDR][10] ,
         \mini_mips_o[IMEM_ADDR][9] , \mini_mips_o[IMEM_ADDR][8] ,
         \mini_mips_o[IMEM_ADDR][7] , \mini_mips_o[IMEM_ADDR][6] ,
         \mini_mips_o[IMEM_ADDR][5] , \mini_mips_o[IMEM_ADDR][4] ,
         \mini_mips_o[IMEM_ADDR][3] , \mini_mips_o[IMEM_ADDR][2] ,
         \mini_mips_o[IMEM_ADDR][1] , \mini_mips_o[IMEM_ADDR][0] ,
         \mini_mips_o[DMEM_WEN_N] , \mini_mips_o[ALU_RESULT][15] ,
         \mini_mips_o[ALU_RESULT][14] , \mini_mips_o[ALU_RESULT][13] ,
         \mini_mips_o[ALU_RESULT][12] , \mini_mips_o[ALU_RESULT][11] ,
         \mini_mips_o[ALU_RESULT][10] , \mini_mips_o[ALU_RESULT][9] ,
         \mini_mips_o[ALU_RESULT][8] , \mini_mips_o[ALU_RESULT][7] ,
         \mini_mips_o[ALU_RESULT][6] , \mini_mips_o[ALU_RESULT][5] ,
         \mini_mips_o[ALU_RESULT][4] , \mini_mips_o[ALU_RESULT][3] ,
         \mini_mips_o[ALU_RESULT][2] , \mini_mips_o[ALU_RESULT][1] ,
         \mini_mips_o[ALU_RESULT][0] ;
  wire   s_if_PCSrc, s_MemtoReg, s_id_ctrl_regWrite, s_id_ctrl_RegDst,
         s_exe_ctrl_alu_src_b, \s_id_exe_shamt[4] , \s_id_exe_shamt[3] ,
         \s_id_exe_shamt[2] , \s_id_exe_shamt[1] , \s_id_exe_shamt[0] ,
         \s_id_exe_reg_a[9] , \s_id_exe_reg_a[8] , \s_id_exe_reg_a[7] ,
         \s_id_exe_reg_a[6] , \s_id_exe_reg_a[5] , \s_id_exe_reg_a[4] ,
         \s_id_exe_reg_a[3] , \s_id_exe_reg_a[31] , \s_id_exe_reg_a[30] ,
         \s_id_exe_reg_a[2] , \s_id_exe_reg_a[29] , \s_id_exe_reg_a[28] ,
         \s_id_exe_reg_a[27] , \s_id_exe_reg_a[26] , \s_id_exe_reg_a[25] ,
         \s_id_exe_reg_a[24] , \s_id_exe_reg_a[23] , \s_id_exe_reg_a[22] ,
         \s_id_exe_reg_a[21] , \s_id_exe_reg_a[20] , \s_id_exe_reg_a[1] ,
         \s_id_exe_reg_a[19] , \s_id_exe_reg_a[18] , \s_id_exe_reg_a[17] ,
         \s_id_exe_reg_a[16] , \s_id_exe_reg_a[15] , \s_id_exe_reg_a[14] ,
         \s_id_exe_reg_a[13] , \s_id_exe_reg_a[12] , \s_id_exe_reg_a[11] ,
         \s_id_exe_reg_a[10] , \s_id_exe_reg_a[0] , \s_id_exe_immidiate[9] ,
         \s_id_exe_immidiate[8] , \s_id_exe_immidiate[7] ,
         \s_id_exe_immidiate[6] , \s_id_exe_immidiate[5] ,
         \s_id_exe_immidiate[4] , \s_id_exe_immidiate[3] ,
         \s_id_exe_immidiate[31] , \s_id_exe_immidiate[30] ,
         \s_id_exe_immidiate[2] , \s_id_exe_immidiate[29] ,
         \s_id_exe_immidiate[28] , \s_id_exe_immidiate[27] ,
         \s_id_exe_immidiate[26] , \s_id_exe_immidiate[25] ,
         \s_id_exe_immidiate[24] , \s_id_exe_immidiate[23] ,
         \s_id_exe_immidiate[22] , \s_id_exe_immidiate[21] ,
         \s_id_exe_immidiate[20] , \s_id_exe_immidiate[1] ,
         \s_id_exe_immidiate[19] , \s_id_exe_immidiate[18] ,
         \s_id_exe_immidiate[17] , \s_id_exe_immidiate[16] ,
         \s_id_exe_immidiate[15] , \s_id_exe_immidiate[14] ,
         \s_id_exe_immidiate[13] , \s_id_exe_immidiate[12] ,
         \s_id_exe_immidiate[11] , \s_id_exe_immidiate[10] ,
         \s_id_exe_immidiate[0] , \s_id_exe_funct[5] , \s_id_exe_funct[4] ,
         \s_id_exe_funct[3] , \s_id_exe_funct[2] , \s_id_exe_funct[1] ,
         \s_id_exe_funct[0] , n8, n9, n10, n11, n12;
  wire   [31:12] s_exe_result;
  wire   [31:0] s_writeback_data;
  wire   [11:0] s_exe_if_branch_pc;
  wire   [11:0] s_if_exe_pc_plus1;
  wire   [5:0] s_id_ctrl_opcode;
  wire   [3:0] s_exe_ctrl_op;
  wire   SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1;

  HS65_LH_DFPQX9 \mini_mips_o_reg[ALU_RESULT][15]  ( .D(s_exe_result[15]), 
        .CP(clk), .Q(\mini_mips_o[ALU_RESULT][15] ) );
  HS65_LH_DFPQX9 \mini_mips_o_reg[ALU_RESULT][14]  ( .D(s_exe_result[14]), 
        .CP(clk), .Q(\mini_mips_o[ALU_RESULT][14] ) );
  HS65_LH_DFPQX9 \mini_mips_o_reg[ALU_RESULT][13]  ( .D(s_exe_result[13]), 
        .CP(clk), .Q(\mini_mips_o[ALU_RESULT][13] ) );
  HS65_LH_DFPQX9 \mini_mips_o_reg[ALU_RESULT][12]  ( .D(s_exe_result[12]), 
        .CP(clk), .Q(\mini_mips_o[ALU_RESULT][12] ) );
  HS65_LH_DFPQX9 \mini_mips_o_reg[ALU_RESULT][11]  ( .D(
        \mini_mips_o[DMEM_ADDR][11] ), .CP(clk), .Q(
        \mini_mips_o[ALU_RESULT][11] ) );
  HS65_LH_DFPQX9 \mini_mips_o_reg[ALU_RESULT][10]  ( .D(
        \mini_mips_o[DMEM_ADDR][10] ), .CP(clk), .Q(
        \mini_mips_o[ALU_RESULT][10] ) );
  HS65_LH_DFPQX9 \mini_mips_o_reg[ALU_RESULT][9]  ( .D(
        \mini_mips_o[DMEM_ADDR][9] ), .CP(clk), .Q(
        \mini_mips_o[ALU_RESULT][9] ) );
  HS65_LH_DFPQX9 \mini_mips_o_reg[ALU_RESULT][8]  ( .D(
        \mini_mips_o[DMEM_ADDR][8] ), .CP(clk), .Q(
        \mini_mips_o[ALU_RESULT][8] ) );
  HS65_LH_DFPQX9 \mini_mips_o_reg[ALU_RESULT][7]  ( .D(
        \mini_mips_o[DMEM_ADDR][7] ), .CP(clk), .Q(
        \mini_mips_o[ALU_RESULT][7] ) );
  HS65_LH_DFPQX9 \mini_mips_o_reg[ALU_RESULT][6]  ( .D(
        \mini_mips_o[DMEM_ADDR][6] ), .CP(clk), .Q(
        \mini_mips_o[ALU_RESULT][6] ) );
  HS65_LH_DFPQX9 \mini_mips_o_reg[ALU_RESULT][5]  ( .D(
        \mini_mips_o[DMEM_ADDR][5] ), .CP(clk), .Q(
        \mini_mips_o[ALU_RESULT][5] ) );
  HS65_LH_DFPQX9 \mini_mips_o_reg[ALU_RESULT][4]  ( .D(
        \mini_mips_o[DMEM_ADDR][4] ), .CP(clk), .Q(
        \mini_mips_o[ALU_RESULT][4] ) );
  HS65_LH_DFPQX9 \mini_mips_o_reg[ALU_RESULT][3]  ( .D(
        \mini_mips_o[DMEM_ADDR][3] ), .CP(clk), .Q(
        \mini_mips_o[ALU_RESULT][3] ) );
  HS65_LH_DFPQX9 \mini_mips_o_reg[ALU_RESULT][2]  ( .D(
        \mini_mips_o[DMEM_ADDR][2] ), .CP(clk), .Q(
        \mini_mips_o[ALU_RESULT][2] ) );
  HS65_LH_DFPQX9 \mini_mips_o_reg[ALU_RESULT][1]  ( .D(
        \mini_mips_o[DMEM_ADDR][1] ), .CP(clk), .Q(
        \mini_mips_o[ALU_RESULT][1] ) );
  HS65_LH_DFPQX9 \mini_mips_o_reg[ALU_RESULT][0]  ( .D(
        \mini_mips_o[DMEM_ADDR][0] ), .CP(clk), .Q(
        \mini_mips_o[ALU_RESULT][0] ) );
  if_top if_top_inst ( .clk(clk), .rst_n(rst_n), .if_top_i({1'b0, 
        s_exe_if_branch_pc, s_if_PCSrc}), .if_top_o({
        \mini_mips_o[IMEM_ADDR][11] , \mini_mips_o[IMEM_ADDR][10] , 
        \mini_mips_o[IMEM_ADDR][9] , \mini_mips_o[IMEM_ADDR][8] , 
        \mini_mips_o[IMEM_ADDR][7] , \mini_mips_o[IMEM_ADDR][6] , 
        \mini_mips_o[IMEM_ADDR][5] , \mini_mips_o[IMEM_ADDR][4] , 
        \mini_mips_o[IMEM_ADDR][3] , \mini_mips_o[IMEM_ADDR][2] , 
        \mini_mips_o[IMEM_ADDR][1] , \mini_mips_o[IMEM_ADDR][0] , 
        s_if_exe_pc_plus1}) );
  id_top id_top_inst ( .clk(clk), .rst_n(rst_n), .id_top_i({
        \mini_mips_i[IMEM_DATA][31] , \mini_mips_i[IMEM_DATA][30] , 
        \mini_mips_i[IMEM_DATA][29] , \mini_mips_i[IMEM_DATA][28] , 
        \mini_mips_i[IMEM_DATA][27] , \mini_mips_i[IMEM_DATA][26] , 
        \mini_mips_i[IMEM_DATA][25] , \mini_mips_i[IMEM_DATA][24] , 
        \mini_mips_i[IMEM_DATA][23] , \mini_mips_i[IMEM_DATA][22] , 
        \mini_mips_i[IMEM_DATA][21] , \mini_mips_i[IMEM_DATA][20] , 
        \mini_mips_i[IMEM_DATA][19] , \mini_mips_i[IMEM_DATA][18] , 
        \mini_mips_i[IMEM_DATA][17] , \mini_mips_i[IMEM_DATA][16] , 
        \mini_mips_i[IMEM_DATA][15] , \mini_mips_i[IMEM_DATA][14] , 
        \mini_mips_i[IMEM_DATA][13] , \mini_mips_i[IMEM_DATA][12] , 
        \mini_mips_i[IMEM_DATA][11] , \mini_mips_i[IMEM_DATA][10] , 
        \mini_mips_i[IMEM_DATA][9] , \mini_mips_i[IMEM_DATA][8] , 
        \mini_mips_i[IMEM_DATA][7] , \mini_mips_i[IMEM_DATA][6] , 
        \mini_mips_i[IMEM_DATA][5] , \mini_mips_i[IMEM_DATA][4] , 
        \mini_mips_i[IMEM_DATA][3] , \mini_mips_i[IMEM_DATA][2] , 
        \mini_mips_i[IMEM_DATA][1] , \mini_mips_i[IMEM_DATA][0] , 
        s_writeback_data, 1'b0, 1'b0, s_id_ctrl_regWrite, s_id_ctrl_RegDst}), 
        .id_top_o({\s_id_exe_reg_a[31] , \s_id_exe_reg_a[30] , 
        \s_id_exe_reg_a[29] , \s_id_exe_reg_a[28] , \s_id_exe_reg_a[27] , 
        \s_id_exe_reg_a[26] , \s_id_exe_reg_a[25] , \s_id_exe_reg_a[24] , 
        \s_id_exe_reg_a[23] , \s_id_exe_reg_a[22] , \s_id_exe_reg_a[21] , 
        \s_id_exe_reg_a[20] , \s_id_exe_reg_a[19] , \s_id_exe_reg_a[18] , 
        \s_id_exe_reg_a[17] , \s_id_exe_reg_a[16] , \s_id_exe_reg_a[15] , 
        \s_id_exe_reg_a[14] , \s_id_exe_reg_a[13] , \s_id_exe_reg_a[12] , 
        \s_id_exe_reg_a[11] , \s_id_exe_reg_a[10] , \s_id_exe_reg_a[9] , 
        \s_id_exe_reg_a[8] , \s_id_exe_reg_a[7] , \s_id_exe_reg_a[6] , 
        \s_id_exe_reg_a[5] , \s_id_exe_reg_a[4] , \s_id_exe_reg_a[3] , 
        \s_id_exe_reg_a[2] , \s_id_exe_reg_a[1] , \s_id_exe_reg_a[0] , 
        \mini_mips_o[DMEM_DATA][31] , \mini_mips_o[DMEM_DATA][30] , 
        \mini_mips_o[DMEM_DATA][29] , \mini_mips_o[DMEM_DATA][28] , 
        \mini_mips_o[DMEM_DATA][27] , \mini_mips_o[DMEM_DATA][26] , 
        \mini_mips_o[DMEM_DATA][25] , \mini_mips_o[DMEM_DATA][24] , 
        \mini_mips_o[DMEM_DATA][23] , \mini_mips_o[DMEM_DATA][22] , 
        \mini_mips_o[DMEM_DATA][21] , \mini_mips_o[DMEM_DATA][20] , 
        \mini_mips_o[DMEM_DATA][19] , \mini_mips_o[DMEM_DATA][18] , 
        \mini_mips_o[DMEM_DATA][17] , \mini_mips_o[DMEM_DATA][16] , 
        \mini_mips_o[DMEM_DATA][15] , \mini_mips_o[DMEM_DATA][14] , 
        \mini_mips_o[DMEM_DATA][13] , \mini_mips_o[DMEM_DATA][12] , 
        \mini_mips_o[DMEM_DATA][11] , \mini_mips_o[DMEM_DATA][10] , 
        \mini_mips_o[DMEM_DATA][9] , \mini_mips_o[DMEM_DATA][8] , 
        \mini_mips_o[DMEM_DATA][7] , \mini_mips_o[DMEM_DATA][6] , 
        \mini_mips_o[DMEM_DATA][5] , \mini_mips_o[DMEM_DATA][4] , 
        \mini_mips_o[DMEM_DATA][3] , \mini_mips_o[DMEM_DATA][2] , 
        \mini_mips_o[DMEM_DATA][1] , \mini_mips_o[DMEM_DATA][0] , 
        s_id_ctrl_opcode, \s_id_exe_shamt[4] , \s_id_exe_shamt[3] , 
        \s_id_exe_shamt[2] , \s_id_exe_shamt[1] , \s_id_exe_shamt[0] , 
        \s_id_exe_funct[5] , \s_id_exe_funct[4] , \s_id_exe_funct[3] , 
        \s_id_exe_funct[2] , \s_id_exe_funct[1] , \s_id_exe_funct[0] , 
        \s_id_exe_immidiate[31] , \s_id_exe_immidiate[30] , 
        \s_id_exe_immidiate[29] , \s_id_exe_immidiate[28] , 
        \s_id_exe_immidiate[27] , \s_id_exe_immidiate[26] , 
        \s_id_exe_immidiate[25] , \s_id_exe_immidiate[24] , 
        \s_id_exe_immidiate[23] , \s_id_exe_immidiate[22] , 
        \s_id_exe_immidiate[21] , \s_id_exe_immidiate[20] , 
        \s_id_exe_immidiate[19] , \s_id_exe_immidiate[18] , 
        \s_id_exe_immidiate[17] , \s_id_exe_immidiate[16] , 
        \s_id_exe_immidiate[15] , \s_id_exe_immidiate[14] , 
        \s_id_exe_immidiate[13] , \s_id_exe_immidiate[12] , 
        \s_id_exe_immidiate[11] , \s_id_exe_immidiate[10] , 
        \s_id_exe_immidiate[9] , \s_id_exe_immidiate[8] , 
        \s_id_exe_immidiate[7] , \s_id_exe_immidiate[6] , 
        \s_id_exe_immidiate[5] , \s_id_exe_immidiate[4] , 
        \s_id_exe_immidiate[3] , \s_id_exe_immidiate[2] , 
        \s_id_exe_immidiate[1] , \s_id_exe_immidiate[0] }) );
  exe_top exe_top_inst ( .clk(clk), .rst_n(rst_n), .exe_top_i({
        \s_id_exe_shamt[4] , \s_id_exe_shamt[3] , \s_id_exe_shamt[2] , 
        \s_id_exe_shamt[1] , \s_id_exe_shamt[0] , \s_id_exe_reg_a[31] , 
        \s_id_exe_reg_a[30] , \s_id_exe_reg_a[29] , \s_id_exe_reg_a[28] , 
        \s_id_exe_reg_a[27] , \s_id_exe_reg_a[26] , \s_id_exe_reg_a[25] , 
        \s_id_exe_reg_a[24] , \s_id_exe_reg_a[23] , \s_id_exe_reg_a[22] , 
        \s_id_exe_reg_a[21] , \s_id_exe_reg_a[20] , \s_id_exe_reg_a[19] , 
        \s_id_exe_reg_a[18] , \s_id_exe_reg_a[17] , \s_id_exe_reg_a[16] , 
        \s_id_exe_reg_a[15] , \s_id_exe_reg_a[14] , \s_id_exe_reg_a[13] , 
        \s_id_exe_reg_a[12] , \s_id_exe_reg_a[11] , \s_id_exe_reg_a[10] , 
        \s_id_exe_reg_a[9] , \s_id_exe_reg_a[8] , \s_id_exe_reg_a[7] , 
        \s_id_exe_reg_a[6] , \s_id_exe_reg_a[5] , \s_id_exe_reg_a[4] , 
        \s_id_exe_reg_a[3] , \s_id_exe_reg_a[2] , \s_id_exe_reg_a[1] , 
        \s_id_exe_reg_a[0] , \mini_mips_o[DMEM_DATA][31] , 
        \mini_mips_o[DMEM_DATA][30] , \mini_mips_o[DMEM_DATA][29] , 
        \mini_mips_o[DMEM_DATA][28] , \mini_mips_o[DMEM_DATA][27] , 
        \mini_mips_o[DMEM_DATA][26] , \mini_mips_o[DMEM_DATA][25] , 
        \mini_mips_o[DMEM_DATA][24] , \mini_mips_o[DMEM_DATA][23] , 
        \mini_mips_o[DMEM_DATA][22] , \mini_mips_o[DMEM_DATA][21] , 
        \mini_mips_o[DMEM_DATA][20] , \mini_mips_o[DMEM_DATA][19] , 
        \mini_mips_o[DMEM_DATA][18] , \mini_mips_o[DMEM_DATA][17] , 
        \mini_mips_o[DMEM_DATA][16] , \mini_mips_o[DMEM_DATA][15] , 
        \mini_mips_o[DMEM_DATA][14] , \mini_mips_o[DMEM_DATA][13] , 
        \mini_mips_o[DMEM_DATA][12] , \mini_mips_o[DMEM_DATA][11] , 
        \mini_mips_o[DMEM_DATA][10] , \mini_mips_o[DMEM_DATA][9] , 
        \mini_mips_o[DMEM_DATA][8] , \mini_mips_o[DMEM_DATA][7] , 
        \mini_mips_o[DMEM_DATA][6] , \mini_mips_o[DMEM_DATA][5] , 
        \mini_mips_o[DMEM_DATA][4] , \mini_mips_o[DMEM_DATA][3] , 
        \mini_mips_o[DMEM_DATA][2] , \mini_mips_o[DMEM_DATA][1] , 
        \mini_mips_o[DMEM_DATA][0] , s_exe_ctrl_alu_src_b, 
        \s_id_exe_immidiate[31] , \s_id_exe_immidiate[30] , 
        \s_id_exe_immidiate[29] , \s_id_exe_immidiate[28] , 
        \s_id_exe_immidiate[27] , \s_id_exe_immidiate[26] , 
        \s_id_exe_immidiate[25] , \s_id_exe_immidiate[24] , 
        \s_id_exe_immidiate[23] , \s_id_exe_immidiate[22] , 
        \s_id_exe_immidiate[21] , \s_id_exe_immidiate[20] , 
        \s_id_exe_immidiate[19] , \s_id_exe_immidiate[18] , 
        \s_id_exe_immidiate[17] , \s_id_exe_immidiate[16] , 
        \s_id_exe_immidiate[15] , \s_id_exe_immidiate[14] , 
        \s_id_exe_immidiate[13] , \s_id_exe_immidiate[12] , 
        \s_id_exe_immidiate[11] , \s_id_exe_immidiate[10] , 
        \s_id_exe_immidiate[9] , \s_id_exe_immidiate[8] , 
        \s_id_exe_immidiate[7] , \s_id_exe_immidiate[6] , 
        \s_id_exe_immidiate[5] , \s_id_exe_immidiate[4] , 
        \s_id_exe_immidiate[3] , \s_id_exe_immidiate[2] , 
        \s_id_exe_immidiate[1] , \s_id_exe_immidiate[0] , 1'b0, 
        s_exe_ctrl_op[2:0], \s_id_exe_funct[5] , \s_id_exe_funct[4] , 
        \s_id_exe_funct[3] , \s_id_exe_funct[2] , \s_id_exe_funct[1] , 
        \s_id_exe_funct[0] , s_if_exe_pc_plus1}), .exe_top_o({s_if_PCSrc, 
        s_exe_if_branch_pc, s_exe_result, \mini_mips_o[DMEM_ADDR][11] , 
        \mini_mips_o[DMEM_ADDR][10] , \mini_mips_o[DMEM_ADDR][9] , 
        \mini_mips_o[DMEM_ADDR][8] , \mini_mips_o[DMEM_ADDR][7] , 
        \mini_mips_o[DMEM_ADDR][6] , \mini_mips_o[DMEM_ADDR][5] , 
        \mini_mips_o[DMEM_ADDR][4] , \mini_mips_o[DMEM_ADDR][3] , 
        \mini_mips_o[DMEM_ADDR][2] , \mini_mips_o[DMEM_ADDR][1] , 
        \mini_mips_o[DMEM_ADDR][0] }) );
  controller ctrl_inst ( .ctrl_i(s_id_ctrl_opcode), .ctrl_o({s_id_ctrl_RegDst, 
        s_exe_ctrl_alu_src_b, s_MemtoReg, s_id_ctrl_regWrite, 
        \mini_mips_o[DMEM_WEN_N] , SYNOPSYS_UNCONNECTED__0, 
        SYNOPSYS_UNCONNECTED__1, s_exe_ctrl_op[2:0]}) );
  HS65_LH_BFX9 U3 ( .A(n12), .Z(n10) );
  HS65_LH_IVX9 U4 ( .A(n9), .Z(n8) );
  HS65_LH_BFX9 U5 ( .A(n12), .Z(n11) );
  HS65_LH_BFX9 U6 ( .A(n12), .Z(n9) );
  HS65_LH_IVX9 U7 ( .A(s_MemtoReg), .Z(n12) );
  HS65_LH_AO22X9 U8 ( .A(\mini_mips_o[DMEM_ADDR][9] ), .B(n11), .C(n8), .D(
        \mini_mips_i[DMEM_DATA][9] ), .Z(s_writeback_data[9]) );
  HS65_LH_AO22X9 U9 ( .A(\mini_mips_o[DMEM_ADDR][0] ), .B(n9), .C(
        \mini_mips_i[DMEM_DATA][0] ), .D(s_MemtoReg), .Z(s_writeback_data[0])
         );
  HS65_LH_AO22X9 U10 ( .A(\mini_mips_o[DMEM_ADDR][1] ), .B(n10), .C(
        \mini_mips_i[DMEM_DATA][1] ), .D(n8), .Z(s_writeback_data[1]) );
  HS65_LH_AO22X9 U11 ( .A(\mini_mips_o[DMEM_ADDR][2] ), .B(n11), .C(
        \mini_mips_i[DMEM_DATA][2] ), .D(s_MemtoReg), .Z(s_writeback_data[2])
         );
  HS65_LH_AO22X9 U12 ( .A(\mini_mips_o[DMEM_ADDR][3] ), .B(n11), .C(
        \mini_mips_i[DMEM_DATA][3] ), .D(s_MemtoReg), .Z(s_writeback_data[3])
         );
  HS65_LH_AO22X9 U13 ( .A(\mini_mips_o[DMEM_ADDR][4] ), .B(n11), .C(
        \mini_mips_i[DMEM_DATA][4] ), .D(s_MemtoReg), .Z(s_writeback_data[4])
         );
  HS65_LH_AO22X9 U14 ( .A(\mini_mips_o[DMEM_ADDR][5] ), .B(n11), .C(
        \mini_mips_i[DMEM_DATA][5] ), .D(s_MemtoReg), .Z(s_writeback_data[5])
         );
  HS65_LH_AO22X9 U15 ( .A(\mini_mips_o[DMEM_ADDR][6] ), .B(n11), .C(
        \mini_mips_i[DMEM_DATA][6] ), .D(s_MemtoReg), .Z(s_writeback_data[6])
         );
  HS65_LH_AO22X9 U16 ( .A(\mini_mips_o[DMEM_ADDR][7] ), .B(n11), .C(
        \mini_mips_i[DMEM_DATA][7] ), .D(s_MemtoReg), .Z(s_writeback_data[7])
         );
  HS65_LH_AO22X9 U17 ( .A(\mini_mips_o[DMEM_ADDR][8] ), .B(n11), .C(
        \mini_mips_i[DMEM_DATA][8] ), .D(n8), .Z(s_writeback_data[8]) );
  HS65_LH_AO22X9 U18 ( .A(\mini_mips_o[DMEM_ADDR][10] ), .B(n10), .C(
        \mini_mips_i[DMEM_DATA][10] ), .D(s_MemtoReg), .Z(s_writeback_data[10]) );
  HS65_LH_AO22X9 U19 ( .A(\mini_mips_o[DMEM_ADDR][11] ), .B(n10), .C(
        \mini_mips_i[DMEM_DATA][11] ), .D(s_MemtoReg), .Z(s_writeback_data[11]) );
  HS65_LH_AO22X9 U20 ( .A(s_exe_result[12]), .B(n10), .C(
        \mini_mips_i[DMEM_DATA][12] ), .D(s_MemtoReg), .Z(s_writeback_data[12]) );
  HS65_LH_AO22X9 U21 ( .A(s_exe_result[13]), .B(n10), .C(
        \mini_mips_i[DMEM_DATA][13] ), .D(s_MemtoReg), .Z(s_writeback_data[13]) );
  HS65_LH_AO22X9 U22 ( .A(s_exe_result[14]), .B(n10), .C(
        \mini_mips_i[DMEM_DATA][14] ), .D(s_MemtoReg), .Z(s_writeback_data[14]) );
  HS65_LH_AO22X9 U23 ( .A(s_exe_result[15]), .B(n10), .C(
        \mini_mips_i[DMEM_DATA][15] ), .D(n8), .Z(s_writeback_data[15]) );
  HS65_LH_AO22X9 U24 ( .A(s_exe_result[16]), .B(n10), .C(
        \mini_mips_i[DMEM_DATA][16] ), .D(n8), .Z(s_writeback_data[16]) );
  HS65_LH_AO22X9 U25 ( .A(s_exe_result[17]), .B(n10), .C(
        \mini_mips_i[DMEM_DATA][17] ), .D(n8), .Z(s_writeback_data[17]) );
  HS65_LH_AO22X9 U26 ( .A(s_exe_result[18]), .B(n10), .C(
        \mini_mips_i[DMEM_DATA][18] ), .D(n8), .Z(s_writeback_data[18]) );
  HS65_LH_AO22X9 U27 ( .A(s_exe_result[19]), .B(n10), .C(
        \mini_mips_i[DMEM_DATA][19] ), .D(n8), .Z(s_writeback_data[19]) );
  HS65_LH_AO22X9 U28 ( .A(s_exe_result[20]), .B(n10), .C(
        \mini_mips_i[DMEM_DATA][20] ), .D(n8), .Z(s_writeback_data[20]) );
  HS65_LH_AO22X9 U29 ( .A(s_exe_result[21]), .B(n10), .C(
        \mini_mips_i[DMEM_DATA][21] ), .D(n8), .Z(s_writeback_data[21]) );
  HS65_LH_AO22X9 U30 ( .A(s_exe_result[22]), .B(n10), .C(
        \mini_mips_i[DMEM_DATA][22] ), .D(n8), .Z(s_writeback_data[22]) );
  HS65_LH_AO22X9 U31 ( .A(s_exe_result[23]), .B(n10), .C(
        \mini_mips_i[DMEM_DATA][23] ), .D(n8), .Z(s_writeback_data[23]) );
  HS65_LH_AO22X9 U32 ( .A(s_exe_result[24]), .B(n10), .C(
        \mini_mips_i[DMEM_DATA][24] ), .D(n8), .Z(s_writeback_data[24]) );
  HS65_LH_AO22X9 U33 ( .A(s_exe_result[25]), .B(n10), .C(
        \mini_mips_i[DMEM_DATA][25] ), .D(n8), .Z(s_writeback_data[25]) );
  HS65_LH_AO22X9 U34 ( .A(s_exe_result[26]), .B(n10), .C(
        \mini_mips_i[DMEM_DATA][26] ), .D(n8), .Z(s_writeback_data[26]) );
  HS65_LH_AO22X9 U35 ( .A(s_exe_result[27]), .B(n10), .C(
        \mini_mips_i[DMEM_DATA][27] ), .D(s_MemtoReg), .Z(s_writeback_data[27]) );
  HS65_LH_AO22X9 U36 ( .A(s_exe_result[28]), .B(n10), .C(
        \mini_mips_i[DMEM_DATA][28] ), .D(n8), .Z(s_writeback_data[28]) );
  HS65_LH_AO22X9 U37 ( .A(s_exe_result[29]), .B(n11), .C(
        \mini_mips_i[DMEM_DATA][29] ), .D(s_MemtoReg), .Z(s_writeback_data[29]) );
  HS65_LH_AO22X9 U38 ( .A(s_exe_result[30]), .B(n11), .C(
        \mini_mips_i[DMEM_DATA][30] ), .D(n8), .Z(s_writeback_data[30]) );
  HS65_LH_AO22X9 U39 ( .A(s_exe_result[31]), .B(n11), .C(
        \mini_mips_i[DMEM_DATA][31] ), .D(s_MemtoReg), .Z(s_writeback_data[31]) );
endmodule


module mini_mips_p ( clk, rst_n, alu_result );
  inout [15:0] alu_result;
  inout clk,  rst_n;
  wire   s_dmem_wen_n, clk_i, rst_n_i;
  wire   [31:0] s_dmem_to_top_dmem_data;
  wire   [31:0] s_imem_to_top_imem_data;
  wire   [11:0] s_top_to_dmem_dmem_addr;
  wire   [31:0] s_top_to_dmem_dmem_data;
  wire   [11:0] s_top_to_imem_imem_addr;
  tri   clk;
  tri   rst_n;
  tri   [15:0] alu_result;
  wire   SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1, 
        SYNOPSYS_UNCONNECTED__2, SYNOPSYS_UNCONNECTED__3, 
        SYNOPSYS_UNCONNECTED__4, SYNOPSYS_UNCONNECTED__5, 
        SYNOPSYS_UNCONNECTED__6, SYNOPSYS_UNCONNECTED__7, 
        SYNOPSYS_UNCONNECTED__8, SYNOPSYS_UNCONNECTED__9, 
        SYNOPSYS_UNCONNECTED__10, SYNOPSYS_UNCONNECTED__11, 
        SYNOPSYS_UNCONNECTED__12, SYNOPSYS_UNCONNECTED__13, 
        SYNOPSYS_UNCONNECTED__14, SYNOPSYS_UNCONNECTED__15;

  ST_SPHDL_4096x32m8_L imem_inst ( .A(s_top_to_imem_imem_addr), .D({1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0}), .Q(s_imem_to_top_imem_data), 
        .CK(clk_i), .CSN(1'b0), .TBYPASS(1'b0), .WEN(1'b1) );
  ST_SPHDL_4096x32m8_L dmem_inst ( .A(s_top_to_dmem_dmem_addr), .D(
        s_top_to_dmem_dmem_data), .Q(s_dmem_to_top_dmem_data), .CK(clk_i), 
        .CSN(1'b0), .TBYPASS(1'b0), .WEN(s_dmem_wen_n) );
  BD2SCARUDQP_1V8_SF_LIN clk_pad_in ( .A(1'b0), .TA(1'b0), .TM(1'b0), .EN(1'b1), .TEN(1'b1), .IO(clk), .HYST(1'b0), .PDN(1'b0), .PUN(1'b0), .ZI(clk_i) );
  BD2SCARUDQP_1V8_SF_LIN rst_n_pad_in ( .A(1'b0), .TA(1'b0), .TM(1'b0), .EN(
        1'b1), .TEN(1'b1), .IO(rst_n), .HYST(1'b0), .PDN(1'b0), .PUN(1'b0), 
        .ZI(rst_n_i) );
  BD2SCARUDQP_1V8_SF_LIN out_pad_0 ( .A(1'b0), .TA(1'b0), .TM(1'b0), .EN(1'b1), 
        .TEN(1'b1), .IO(alu_result[0]), .HYST(1'b0), .PDN(1'b0), .PUN(1'b0) );
  BD2SCARUDQP_1V8_SF_LIN out_pad_1 ( .A(1'b0), .TA(1'b0), .TM(1'b0), .EN(1'b1), 
        .TEN(1'b1), .IO(alu_result[1]), .HYST(1'b0), .PDN(1'b0), .PUN(1'b0) );
  BD2SCARUDQP_1V8_SF_LIN out_pad_2 ( .A(1'b0), .TA(1'b0), .TM(1'b0), .EN(1'b1), 
        .TEN(1'b1), .IO(alu_result[2]), .HYST(1'b0), .PDN(1'b0), .PUN(1'b0) );
  BD2SCARUDQP_1V8_SF_LIN out_pad_3 ( .A(1'b0), .TA(1'b0), .TM(1'b0), .EN(1'b1), 
        .TEN(1'b1), .IO(alu_result[3]), .HYST(1'b0), .PDN(1'b0), .PUN(1'b0) );
  BD2SCARUDQP_1V8_SF_LIN out_pad_4 ( .A(1'b0), .TA(1'b0), .TM(1'b0), .EN(1'b1), 
        .TEN(1'b1), .IO(alu_result[4]), .HYST(1'b0), .PDN(1'b0), .PUN(1'b0) );
  BD2SCARUDQP_1V8_SF_LIN out_pad_5 ( .A(1'b0), .TA(1'b0), .TM(1'b0), .EN(1'b1), 
        .TEN(1'b1), .IO(alu_result[5]), .HYST(1'b0), .PDN(1'b0), .PUN(1'b0) );
  BD2SCARUDQP_1V8_SF_LIN out_pad_6 ( .A(1'b0), .TA(1'b0), .TM(1'b0), .EN(1'b1), 
        .TEN(1'b1), .IO(alu_result[6]), .HYST(1'b0), .PDN(1'b0), .PUN(1'b0) );
  BD2SCARUDQP_1V8_SF_LIN out_pad_7 ( .A(1'b0), .TA(1'b0), .TM(1'b0), .EN(1'b1), 
        .TEN(1'b1), .IO(alu_result[7]), .HYST(1'b0), .PDN(1'b0), .PUN(1'b0) );
  BD2SCARUDQP_1V8_SF_LIN out_pad_8 ( .A(1'b0), .TA(1'b0), .TM(1'b0), .EN(1'b1), 
        .TEN(1'b1), .IO(alu_result[8]), .HYST(1'b0), .PDN(1'b0), .PUN(1'b0) );
  BD2SCARUDQP_1V8_SF_LIN out_pad_9 ( .A(1'b0), .TA(1'b0), .TM(1'b0), .EN(1'b1), 
        .TEN(1'b1), .IO(alu_result[9]), .HYST(1'b0), .PDN(1'b0), .PUN(1'b0) );
  BD2SCARUDQP_1V8_SF_LIN out_pad_10 ( .A(1'b0), .TA(1'b0), .TM(1'b0), .EN(1'b1), .TEN(1'b1), .IO(alu_result[10]), .HYST(1'b0), .PDN(1'b0), .PUN(1'b0) );
  BD2SCARUDQP_1V8_SF_LIN out_pad_11 ( .A(1'b0), .TA(1'b0), .TM(1'b0), .EN(1'b1), .TEN(1'b1), .IO(alu_result[11]), .HYST(1'b0), .PDN(1'b0), .PUN(1'b0) );
  BD2SCARUDQP_1V8_SF_LIN out_pad_12 ( .A(1'b0), .TA(1'b0), .TM(1'b0), .EN(1'b1), .TEN(1'b1), .IO(alu_result[12]), .HYST(1'b0), .PDN(1'b0), .PUN(1'b0) );
  BD2SCARUDQP_1V8_SF_LIN out_pad_13 ( .A(1'b0), .TA(1'b0), .TM(1'b0), .EN(1'b1), .TEN(1'b1), .IO(alu_result[13]), .HYST(1'b0), .PDN(1'b0), .PUN(1'b0) );
  BD2SCARUDQP_1V8_SF_LIN out_pad_14 ( .A(1'b0), .TA(1'b0), .TM(1'b0), .EN(1'b1), .TEN(1'b1), .IO(alu_result[14]), .HYST(1'b0), .PDN(1'b0), .PUN(1'b0) );
  BD2SCARUDQP_1V8_SF_LIN out_pad_15 ( .A(1'b0), .TA(1'b0), .TM(1'b0), .EN(1'b1), .TEN(1'b1), .IO(alu_result[15]), .HYST(1'b0), .PDN(1'b0), .PUN(1'b0) );
  mini_mips mini_mips_inst ( .clk(clk_i), .rst_n(rst_n_i), .mini_mips_i({
        s_dmem_to_top_dmem_data, s_imem_to_top_imem_data}), .mini_mips_o({
        s_top_to_dmem_dmem_addr, s_top_to_dmem_dmem_data, 
        s_top_to_imem_imem_addr, s_dmem_wen_n, SYNOPSYS_UNCONNECTED__0, 
        SYNOPSYS_UNCONNECTED__1, SYNOPSYS_UNCONNECTED__2, 
        SYNOPSYS_UNCONNECTED__3, SYNOPSYS_UNCONNECTED__4, 
        SYNOPSYS_UNCONNECTED__5, SYNOPSYS_UNCONNECTED__6, 
        SYNOPSYS_UNCONNECTED__7, SYNOPSYS_UNCONNECTED__8, 
        SYNOPSYS_UNCONNECTED__9, SYNOPSYS_UNCONNECTED__10, 
        SYNOPSYS_UNCONNECTED__11, SYNOPSYS_UNCONNECTED__12, 
        SYNOPSYS_UNCONNECTED__13, SYNOPSYS_UNCONNECTED__14, 
        SYNOPSYS_UNCONNECTED__15}) );
endmodule

