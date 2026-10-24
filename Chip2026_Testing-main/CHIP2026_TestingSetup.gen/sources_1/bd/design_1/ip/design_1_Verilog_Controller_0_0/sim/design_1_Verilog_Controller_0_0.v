// (c) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// (c) Copyright 2022-2026 Advanced Micro Devices, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of AMD and is protected under U.S. and international copyright
// and other intellectual property laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// AMD, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND AMD HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) AMD shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or AMD had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// AMD products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of AMD products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:module_ref:Verilog_Controller:1.0
// IP Revision: 1

`timescale 1ns/1ps

(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module design_1_Verilog_Controller_0_0 (
  WL_EN_C,
  SA_EN_C,
  BL_PCHG_C,
  CLK_SA_C,
  READ_EN_C,
  WEN_C,
  CS_B_C,
  SCN_SEL_C,
  CLK_A_C,
  CLK_B_C,
  IN_EN_C,
  SCN_IN_C,
  COMPUTE_EN_C,
  DFF_RST_C,
  MUX_OUT_PAD_C,
  CONTROL_EN_C,
  CLK_OUT_PAD_C,
  osc_EN_C,
  capturestart_C,
  div_ratio_C,
  SAMPLE_EDGE_TIME_C,
  WL_EN,
  SA_EN,
  BL_PCHG,
  CLK_SA,
  WEN,
  READ_EN,
  CS_B,
  SCN_SEL,
  CLKA,
  CLKB,
  IN_EN,
  SCN_IN,
  COMPUTE_EN,
  DFF_RST,
  MUX_OUT_PAD,
  CONTROL_EN,
  CLK_OUT_PAD,
  osc_EN,
  capturestart,
  div_ratio,
  SAMPLE_EDGE_TIME,
  scan_mode_setting_in,
  dig_out,
  clk,
  in_tvalid,
  in_tlast,
  in_tdata,
  in_tready,
  out_tready,
  out_tvalid,
  out_tlast,
  out_tdata,
  SCAN_DONE_FLAGS
);

input wire WL_EN_C;
input wire SA_EN_C;
input wire BL_PCHG_C;
input wire CLK_SA_C;
input wire READ_EN_C;
input wire WEN_C;
input wire [1 : 0] CS_B_C;
input wire [2 : 0] SCN_SEL_C;
input wire CLK_A_C;
input wire CLK_B_C;
input wire IN_EN_C;
input wire SCN_IN_C;
input wire COMPUTE_EN_C;
input wire DFF_RST_C;
input wire MUX_OUT_PAD_C;
input wire CONTROL_EN_C;
input wire CLK_OUT_PAD_C;
input wire osc_EN_C;
input wire [3 : 0] capturestart_C;
input wire [3 : 0] div_ratio_C;
input wire [3 : 0] SAMPLE_EDGE_TIME_C;
output wire WL_EN;
output wire SA_EN;
output wire BL_PCHG;
output wire CLK_SA;
output wire WEN;
output wire READ_EN;
output wire [1 : 0] CS_B;
output wire [2 : 0] SCN_SEL;
output wire CLKA;
output wire CLKB;
output wire IN_EN;
output wire SCN_IN;
output wire COMPUTE_EN;
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 DFF_RST RST" *)
(* X_INTERFACE_MODE = "master" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DFF_RST, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
output wire DFF_RST;
output wire MUX_OUT_PAD;
output wire CONTROL_EN;
output wire CLK_OUT_PAD;
output wire osc_EN;
output wire [3 : 0] capturestart;
output wire [3 : 0] div_ratio;
output wire [3 : 0] SAMPLE_EDGE_TIME;
input wire [31 : 0] scan_mode_setting_in;
input wire [2 : 0] dig_out;
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *)
(* X_INTERFACE_MODE = "slave" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, ASSOCIATED_BUSIF in:out, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0" *)
input wire clk;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in TVALID" *)
(* X_INTERFACE_MODE = "slave" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME in, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, LAYERED_METADATA undef, INSERT_VIP 0" *)
input wire in_tvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in TLAST" *)
input wire in_tlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in TDATA" *)
input wire [31 : 0] in_tdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 in TREADY" *)
output wire in_tready;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out TREADY" *)
(* X_INTERFACE_MODE = "master" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME out, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, LAYERED_METADATA undef, INSERT_VIP 0" *)
input wire out_tready;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out TVALID" *)
output wire out_tvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out TLAST" *)
output wire out_tlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 out TDATA" *)
output wire [31 : 0] out_tdata;
output wire [3 : 0] SCAN_DONE_FLAGS;

  Verilog_Controller inst (
    .WL_EN_C(WL_EN_C),
    .SA_EN_C(SA_EN_C),
    .BL_PCHG_C(BL_PCHG_C),
    .CLK_SA_C(CLK_SA_C),
    .READ_EN_C(READ_EN_C),
    .WEN_C(WEN_C),
    .CS_B_C(CS_B_C),
    .SCN_SEL_C(SCN_SEL_C),
    .CLK_A_C(CLK_A_C),
    .CLK_B_C(CLK_B_C),
    .IN_EN_C(IN_EN_C),
    .SCN_IN_C(SCN_IN_C),
    .COMPUTE_EN_C(COMPUTE_EN_C),
    .DFF_RST_C(DFF_RST_C),
    .MUX_OUT_PAD_C(MUX_OUT_PAD_C),
    .CONTROL_EN_C(CONTROL_EN_C),
    .CLK_OUT_PAD_C(CLK_OUT_PAD_C),
    .osc_EN_C(osc_EN_C),
    .capturestart_C(capturestart_C),
    .div_ratio_C(div_ratio_C),
    .SAMPLE_EDGE_TIME_C(SAMPLE_EDGE_TIME_C),
    .WL_EN(WL_EN),
    .SA_EN(SA_EN),
    .BL_PCHG(BL_PCHG),
    .CLK_SA(CLK_SA),
    .WEN(WEN),
    .READ_EN(READ_EN),
    .CS_B(CS_B),
    .SCN_SEL(SCN_SEL),
    .CLKA(CLKA),
    .CLKB(CLKB),
    .IN_EN(IN_EN),
    .SCN_IN(SCN_IN),
    .COMPUTE_EN(COMPUTE_EN),
    .DFF_RST(DFF_RST),
    .MUX_OUT_PAD(MUX_OUT_PAD),
    .CONTROL_EN(CONTROL_EN),
    .CLK_OUT_PAD(CLK_OUT_PAD),
    .osc_EN(osc_EN),
    .capturestart(capturestart),
    .div_ratio(div_ratio),
    .SAMPLE_EDGE_TIME(SAMPLE_EDGE_TIME),
    .scan_mode_setting_in(scan_mode_setting_in),
    .dig_out(dig_out),
    .clk(clk),
    .in_tvalid(in_tvalid),
    .in_tlast(in_tlast),
    .in_tdata(in_tdata),
    .in_tready(in_tready),
    .out_tready(out_tready),
    .out_tvalid(out_tvalid),
    .out_tlast(out_tlast),
    .out_tdata(out_tdata),
    .SCAN_DONE_FLAGS(SCAN_DONE_FLAGS)
  );
endmodule
