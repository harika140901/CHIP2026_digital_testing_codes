// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.1 (win64) Build 6140274 Thu May 22 00:12:29 MDT 2025
// Date        : Sat Oct 24 10:47:17 2026
// Host        : lappy running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/horro/Documents/research/CHIP2026_digital_testing_codes/Chip2026_Testing-main/CHIP2026_TestingSetup.gen/sources_1/bd/design_1/ip/design_1_Unbundle_AXI_Bus_0_0/design_1_Unbundle_AXI_Bus_0_0_stub.v
// Design      : design_1_Unbundle_AXI_Bus_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* CHECK_LICENSE_TYPE = "design_1_Unbundle_AXI_Bus_0_0,Unbundle_AXI_Bus,{}" *) (* CORE_GENERATION_INFO = "design_1_Unbundle_AXI_Bus_0_0,Unbundle_AXI_Bus,{x_ipProduct=Vivado 2025.1,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=Unbundle_AXI_Bus,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) 
(* IP_DEFINITION_SOURCE = "module_ref" *) (* X_CORE_INFO = "Unbundle_AXI_Bus,Vivado 2025.1" *) 
module design_1_Unbundle_AXI_Bus_0_0(DIG_AXI_IN_0, DIG_AXI_IN_1, WL_EN_C, SA_EN_C, 
  BL_PCHG_C, WEN_C, READ_EN_C, CS_B_C, SCN_SEL_C, CLKA_C, CLKB_C, IN_EN_C, SCN_IN_C, COMPUTE_EN_C, 
  DFF_RST_C, MUX_OUT_PAD_C, CONTROL_EN_C, CLK_OUT_PAD_C, osc_EN_C, capturestart_C, div_ratio_C, 
  SAMPLE_EDGE_TIME_C, CLK_SA_B_C)
/* synthesis syn_black_box black_box_pad_pin="DIG_AXI_IN_0[31:0],DIG_AXI_IN_1,WL_EN_C,SA_EN_C,BL_PCHG_C,WEN_C,READ_EN_C,CS_B_C[1:0],SCN_SEL_C[2:0],CLKA_C,CLKB_C,IN_EN_C,SCN_IN_C,COMPUTE_EN_C,DFF_RST_C,MUX_OUT_PAD_C,CONTROL_EN_C,CLK_OUT_PAD_C,osc_EN_C,capturestart_C[3:0],div_ratio_C[3:0],SAMPLE_EDGE_TIME_C[3:0],CLK_SA_B_C" */;
  input [31:0]DIG_AXI_IN_0;
  input DIG_AXI_IN_1;
  output WL_EN_C;
  output SA_EN_C;
  output BL_PCHG_C;
  output WEN_C;
  output READ_EN_C;
  output [1:0]CS_B_C;
  output [2:0]SCN_SEL_C;
  output CLKA_C;
  output CLKB_C;
  output IN_EN_C;
  output SCN_IN_C;
  output COMPUTE_EN_C;
  output DFF_RST_C;
  output MUX_OUT_PAD_C;
  output CONTROL_EN_C;
  output CLK_OUT_PAD_C;
  output osc_EN_C;
  output [3:0]capturestart_C;
  output [3:0]div_ratio_C;
  output [3:0]SAMPLE_EDGE_TIME_C;
  output CLK_SA_B_C;
endmodule
