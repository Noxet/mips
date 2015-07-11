
module pc ( clk, rst_n, halt_i, npc_i, pc_o );
  input [11:0] npc_i;
  output [11:0] pc_o;
  input clk, rst_n, halt_i;


  HS65_LH_DFPSQX9 \pc_o_reg[11]  ( .D(npc_i[11]), .CP(clk), .SN(rst_n), .Q(
        pc_o[11]) );
  HS65_LH_DFPSQX9 \pc_o_reg[10]  ( .D(npc_i[10]), .CP(clk), .SN(rst_n), .Q(
        pc_o[10]) );
  HS65_LH_DFPSQX9 \pc_o_reg[9]  ( .D(npc_i[9]), .CP(clk), .SN(rst_n), .Q(
        pc_o[9]) );
  HS65_LH_DFPSQX9 \pc_o_reg[8]  ( .D(npc_i[8]), .CP(clk), .SN(rst_n), .Q(
        pc_o[8]) );
  HS65_LH_DFPSQX9 \pc_o_reg[7]  ( .D(npc_i[7]), .CP(clk), .SN(rst_n), .Q(
        pc_o[7]) );
  HS65_LH_DFPSQX9 \pc_o_reg[6]  ( .D(npc_i[6]), .CP(clk), .SN(rst_n), .Q(
        pc_o[6]) );
  HS65_LH_DFPSQX9 \pc_o_reg[5]  ( .D(npc_i[5]), .CP(clk), .SN(rst_n), .Q(
        pc_o[5]) );
  HS65_LH_DFPSQX9 \pc_o_reg[4]  ( .D(npc_i[4]), .CP(clk), .SN(rst_n), .Q(
        pc_o[4]) );
  HS65_LH_DFPSQX9 \pc_o_reg[3]  ( .D(npc_i[3]), .CP(clk), .SN(rst_n), .Q(
        pc_o[3]) );
  HS65_LH_DFPSQX9 \pc_o_reg[2]  ( .D(npc_i[2]), .CP(clk), .SN(rst_n), .Q(
        pc_o[2]) );
  HS65_LH_DFPSQX9 \pc_o_reg[1]  ( .D(npc_i[1]), .CP(clk), .SN(rst_n), .Q(
        pc_o[1]) );
  HS65_LH_DFPSQX9 \pc_o_reg[0]  ( .D(npc_i[0]), .CP(clk), .SN(rst_n), .Q(
        pc_o[0]) );
endmodule


module if_top_DW01_inc_0 ( A, SUM );
  input [11:0] A;
  output [11:0] SUM;

  wire   [11:2] carry;

  HS65_LH_HA1X4 U1_1_10 ( .A0(A[10]), .B0(carry[10]), .CO(carry[11]), .S0(
        SUM[10]) );
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
  HS65_LH_IVX9 U1 ( .A(A[0]), .Z(SUM[0]) );
  HS65_LHS_XOR2X3 U2 ( .A(carry[11]), .B(A[11]), .Z(SUM[11]) );
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
  wire   n2;
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
  HS65_LH_AO22X9 U15 ( .A(\if_top_o[PC_PLUS1][11] ), .B(n2), .C(
        \if_top_i[BRANCH_PC][11] ), .D(\if_top_i[PCSRC] ), .Z(s_npc[11]) );
  HS65_LH_AO22X9 U16 ( .A(\if_top_o[PC_PLUS1][7] ), .B(n2), .C(
        \if_top_i[BRANCH_PC][7] ), .D(\if_top_i[PCSRC] ), .Z(s_npc[7]) );
  HS65_LH_AO22X9 U17 ( .A(\if_top_o[PC_PLUS1][8] ), .B(n2), .C(
        \if_top_i[BRANCH_PC][8] ), .D(\if_top_i[PCSRC] ), .Z(s_npc[8]) );
  HS65_LH_AO22X9 U18 ( .A(\if_top_o[PC_PLUS1][9] ), .B(n2), .C(
        \if_top_i[PCSRC] ), .D(\if_top_i[BRANCH_PC][9] ), .Z(s_npc[9]) );
  HS65_LH_AO22X9 U19 ( .A(\if_top_o[PC_PLUS1][10] ), .B(n2), .C(
        \if_top_i[BRANCH_PC][10] ), .D(\if_top_i[PCSRC] ), .Z(s_npc[10]) );
  HS65_LH_AO22X9 U20 ( .A(\if_top_o[PC_PLUS1][1] ), .B(n2), .C(
        \if_top_i[BRANCH_PC][1] ), .D(\if_top_i[PCSRC] ), .Z(s_npc[1]) );
  HS65_LH_AO22X9 U21 ( .A(\if_top_o[PC_PLUS1][2] ), .B(n2), .C(
        \if_top_i[BRANCH_PC][2] ), .D(\if_top_i[PCSRC] ), .Z(s_npc[2]) );
  HS65_LH_AO22X9 U22 ( .A(\if_top_o[PC_PLUS1][3] ), .B(n2), .C(
        \if_top_i[BRANCH_PC][3] ), .D(\if_top_i[PCSRC] ), .Z(s_npc[3]) );
  HS65_LH_AO22X9 U23 ( .A(\if_top_o[PC_PLUS1][4] ), .B(n2), .C(
        \if_top_i[BRANCH_PC][4] ), .D(\if_top_i[PCSRC] ), .Z(s_npc[4]) );
  HS65_LH_AO22X9 U24 ( .A(\if_top_o[PC_PLUS1][5] ), .B(n2), .C(
        \if_top_i[BRANCH_PC][5] ), .D(\if_top_i[PCSRC] ), .Z(s_npc[5]) );
  HS65_LH_AO22X9 U25 ( .A(\if_top_o[PC_PLUS1][6] ), .B(n2), .C(
        \if_top_i[BRANCH_PC][6] ), .D(\if_top_i[PCSRC] ), .Z(s_npc[6]) );
  HS65_LH_AO22X9 U26 ( .A(\if_top_o[PC_PLUS1][0] ), .B(n2), .C(
        \if_top_i[BRANCH_PC][0] ), .D(\if_top_i[PCSRC] ), .Z(s_npc[0]) );
  HS65_LH_IVX9 U27 ( .A(\if_top_i[PCSRC] ), .Z(n2) );
endmodule

