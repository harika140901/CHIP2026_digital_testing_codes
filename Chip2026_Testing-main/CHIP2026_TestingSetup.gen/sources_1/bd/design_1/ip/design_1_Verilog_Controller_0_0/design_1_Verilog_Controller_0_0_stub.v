// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.1 (win64) Build 6140274 Thu May 22 00:12:29 MDT 2025
// Date        : Sat Oct 24 12:21:38 2026
// Host        : lappy running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/horro/Documents/research/CHIP2026_digital_testing_codes/Chip2026_Testing-main/CHIP2026_TestingSetup.gen/sources_1/bd/design_1/ip/design_1_Verilog_Controller_0_0/design_1_Verilog_Controller_0_0_stub.v
// Design      : design_1_Verilog_Controller_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* CHECK_LICENSE_TYPE = "design_1_Verilog_Controller_0_0,Verilog_Controller,{}" *) (* CORE_GENERATION_INFO = "design_1_Verilog_Controller_0_0,Verilog_Controller,{x_ipProduct=Vivado 2025.1,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=Verilog_Controller,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) 
(* IP_DEFINITION_SOURCE = "module_ref" *) (* X_CORE_INFO = "Verilog_Controller,Vivado 2025.1" *) 
module design_1_Verilog_Controller_0_0(WL_EN_C, SA_EN_C, BL_PCHG_C, CLK_SA_C, READ_EN_C, 
  WEN_C, CS_B_C, SCN_SEL_C, CLK_A_C, CLK_B_C, IN_EN_C, SCN_IN_C, COMPUTE_EN_C, DFF_RST_C, 
  MUX_OUT_PAD_C, CONTROL_EN_C, CLK_OUT_PAD_C, osc_EN_C, capturestart_C, div_ratio_C, 
  SAMPLE_EDGE_TIME_C, WL_EN, SA_EN, BL_PCHG, CLK_SA, WEN, READ_EN, CS_B, SCN_SEL, CLKA, CLKB, IN_EN, 
  SCN_IN, COMPUTE_EN, DFF_RST, MUX_OUT_PAD, CONTROL_EN, CLK_OUT_PAD, osc_EN, capturestart, 
  div_ratio, SAMPLE_EDGE_TIME, scan_mode_setting_in, dig_out, clk, in_tvalid, in_tlast, in_tdata, 
  in_tready, out_tready, out_tvalid, out_tlast, out_tdata, SCAN_DONE_FLAGS)
/* synthesis syn_black_box black_box_pad_pin="WL_EN_C,SA_EN_C,BL_PCHG_C,CLK_SA_C,READ_EN_C,WEN_C,CS_B_C[1:0],SCN_SEL_C[2:0],CLK_A_C,CLK_B_C,IN_EN_C,SCN_IN_C,COMPUTE_EN_C,DFF_RST_C,MUX_OUT_PAD_C,CONTROL_EN_C,CLK_OUT_PAD_C,osc_EN_C,capturestart_C[3:0],div_ratio_C[3:0],SAMPLE_EDGE_TIME_C[3:0],WL_EN,SA_EN,BL_PCHG,CLK_SA,WEN,READ_EN,CS_B[1:0],SCN_SEL[2:0],CLKA,CLKB,IN_EN,SCN_IN,COMPUTE_EN,DFF_RST,MUX_OUT_PAD,CONTROL_EN,CLK_OUT_PAD,osc_EN,capturestart[3:0],div_ratio[3:0],SAMPLE_EDGE_TIME[3:0],scan_mode_setting_in[31:0],dig_out[2:0],in_tvalid,in_tlast,in_tdata[31:0],in_tready,out_tready,out_tvalid,out_tlast,out_tdata[31:0],SCAN_DONE_FLAGS[3:0]" */
/* synthesis syn_force_seq_prim="clk" */;
  input WL_EN_C;
  input SA_EN_C;
  input BL_PCHG_C;
  input CLK_SA_C;
  input READ_EN_C;
  input WEN_C;
  input [1:0]CS_B_C;
  input [2:0]SCN_SEL_C;
  input CLK_A_C;
  input CLK_B_C;
  input IN_EN_C;
  input SCN_IN_C;
  input COMPUTE_EN_C;
  input DFF_RST_C;
  input MUX_OUT_PAD_C;
  input CONTROL_EN_C;
  input CLK_OUT_PAD_C;
  input osc_EN_C;
  input [3:0]capturestart_C;
  input [3:0]div_ratio_C;
  input [3:0]SAMPLE_EDGE_TIME_C;
  output WL_EN;
  output SA_EN;
  output BL_PCHG;
  output CLK_SA;
  output WEN;
  output READ_EN;
  output [1:0]CS_B;
  output [2:0]SCN_SEL;
  output CLKA;
  output CLKB;
  output IN_EN;
  output SCN_IN;
  output COMPUTE_EN;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 DFF_RST RST" *) (* X_INTERFACE_MODE = "master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DFF_RST, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) output DFF_RST;
  output MUX_OUT_PAD;
  output CONTROL_EN;
  output CLK_OUT_PAD;
  output osc_EN;
  output [3:0]capturestart;
  output [3:0]div_ratio;
  output [3:0]SAMPLE_EDGE_TIME;
  input [31:0]scan_mode_setting_in;
  input [2:0]dig_out;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, ASSOCIATED_BUSIF in:out, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0" *) input clk /* synthesis syn_isclock = 1 */;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in TVALID" *) (* X_INTERFACE_MODE = "slave" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME in, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, LAYERED_METADATA undef, INSERT_VIP 0" *) input in_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in TLAST" *) input in_tlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in TDATA" *) input [31:0]in_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in TREADY" *) output in_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out TREADY" *) (* X_INTERFACE_MODE = "master" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME out, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, LAYERED_METADATA undef, INSERT_VIP 0" *) input out_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out TVALID" *) output out_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out TLAST" *) output out_tlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out TDATA" *) output [31:0]out_tdata;
  output [3:0]SCAN_DONE_FLAGS;
endmodule
