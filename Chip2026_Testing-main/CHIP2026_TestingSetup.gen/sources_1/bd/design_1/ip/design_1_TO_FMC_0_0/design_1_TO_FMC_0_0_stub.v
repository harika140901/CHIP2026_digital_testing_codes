// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.1 (win64) Build 6140274 Thu May 22 00:12:29 MDT 2025
// Date        : Sat Oct 24 10:48:06 2026
// Host        : lappy running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/horro/Documents/research/CHIP2026_digital_testing_codes/Chip2026_Testing-main/CHIP2026_TestingSetup.gen/sources_1/bd/design_1/ip/design_1_TO_FMC_0_0/design_1_TO_FMC_0_0_stub.v
// Design      : design_1_TO_FMC_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* CHECK_LICENSE_TYPE = "design_1_TO_FMC_0_0,TO_FMC,{}" *) (* CORE_GENERATION_INFO = "design_1_TO_FMC_0_0,TO_FMC,{x_ipProduct=Vivado 2025.1,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=TO_FMC,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) 
(* IP_DEFINITION_SOURCE = "module_ref" *) (* X_CORE_INFO = "TO_FMC,Vivado 2025.1" *) 
module design_1_TO_FMC_0_0(capturestart, div_ratio, SAMPLE_EDGE_TIME, 
  SCN_SEL, CS_B, CLKA, CLKB, IN_EN, SCN_IN, COMPUTE_EN, DFF_RST, MUX_OUT_PAD, CONTROL_EN, CLK_OUT_PAD, 
  CLK_SA_B, WEN, READ_EN, SA_EN, BL_PCHG, osc_EN, WL_EN, FMC_L21, FMC_L22, FMC_R19, FMC_T19, FMC_K19, 
  FMC_K20, FMC_D20, FMC_C20, FMC_E21, FMC_D21, FMC_N19, FMC_N20, FMC_J18, FMC_K18, FMC_R20, FMC_R21, 
  FMC_L17, FMC_M17, FMC_B19, FMC_B20, FMC_E15, FMC_D15, FMC_F18, FMC_E18, FMC_M19, FMC_M20, FMC_N22, 
  FMC_P22, FMC_J21, FMC_J22, FMC_G20, FMC_G21, FMC_G19, FMC_F19, FMC_D22, FMC_C22, FMC_B22, FMC_C17, 
  FMC_C18, FMC_B16, FMC_B17, FMC_B21, DIG_AXI_OUT_0, DIG_DEBUG_AXI_OUT_0, DIG_DEBUG_AXI_OUT_1)
/* synthesis syn_black_box black_box_pad_pin="capturestart[3:0],div_ratio[3:0],SAMPLE_EDGE_TIME[3:0],SCN_SEL[2:0],CS_B[1:0],CLKA,CLKB,IN_EN,SCN_IN,COMPUTE_EN,DFF_RST,MUX_OUT_PAD,CONTROL_EN,CLK_OUT_PAD,CLK_SA_B,WEN,READ_EN,SA_EN,BL_PCHG,osc_EN,WL_EN,FMC_L21,FMC_L22,FMC_R19,FMC_T19,FMC_K19,FMC_K20,FMC_D20,FMC_C20,FMC_E21,FMC_D21,FMC_N19,FMC_N20,FMC_J18,FMC_K18,FMC_R20,FMC_R21,FMC_L17,FMC_M17,FMC_B19,FMC_B20,FMC_E15,FMC_D15,FMC_F18,FMC_E18,FMC_M19,FMC_M20,FMC_N22,FMC_P22,FMC_J21,FMC_J22,FMC_G20,FMC_G21,FMC_G19,FMC_F19,FMC_D22,FMC_C22,FMC_B22,FMC_C17,FMC_C18,FMC_B16,FMC_B17,FMC_B21,DIG_AXI_OUT_0[2:0],DIG_DEBUG_AXI_OUT_0[31:0],DIG_DEBUG_AXI_OUT_1" */;
  input [3:0]capturestart;
  input [3:0]div_ratio;
  input [3:0]SAMPLE_EDGE_TIME;
  input [2:0]SCN_SEL;
  input [1:0]CS_B;
  input CLKA;
  input CLKB;
  input IN_EN;
  input SCN_IN;
  input COMPUTE_EN;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 DFF_RST RST" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DFF_RST, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input DFF_RST;
  input MUX_OUT_PAD;
  input CONTROL_EN;
  input CLK_OUT_PAD;
  input CLK_SA_B;
  input WEN;
  input READ_EN;
  input SA_EN;
  input BL_PCHG;
  input osc_EN;
  input WL_EN;
  output FMC_L21;
  output FMC_L22;
  output FMC_R19;
  output FMC_T19;
  output FMC_K19;
  output FMC_K20;
  output FMC_D20;
  output FMC_C20;
  output FMC_E21;
  output FMC_D21;
  output FMC_N19;
  output FMC_N20;
  output FMC_J18;
  output FMC_K18;
  output FMC_R20;
  output FMC_R21;
  output FMC_L17;
  output FMC_M17;
  output FMC_B19;
  output FMC_B20;
  output FMC_E15;
  output FMC_D15;
  output FMC_F18;
  output FMC_E18;
  output FMC_M19;
  output FMC_M20;
  output FMC_N22;
  output FMC_P22;
  output FMC_J21;
  output FMC_J22;
  output FMC_G20;
  output FMC_G21;
  output FMC_G19;
  output FMC_F19;
  output FMC_D22;
  output FMC_C22;
  output FMC_B22;
  output FMC_C17;
  output FMC_C18;
  input FMC_B16;
  input FMC_B17;
  input FMC_B21;
  output [2:0]DIG_AXI_OUT_0;
  output [31:0]DIG_DEBUG_AXI_OUT_0;
  output DIG_DEBUG_AXI_OUT_1;
endmodule
