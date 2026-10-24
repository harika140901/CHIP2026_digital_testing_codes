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


// IP VLNV: xilinx.com:module_ref:TO_FMC:1.0
// IP Revision: 1

(* X_CORE_INFO = "TO_FMC,Vivado 2025.1" *)
(* CHECK_LICENSE_TYPE = "design_1_TO_FMC_0_0,TO_FMC,{}" *)
(* CORE_GENERATION_INFO = "design_1_TO_FMC_0_0,TO_FMC,{x_ipProduct=Vivado 2025.1,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=TO_FMC,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}" *)
(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module design_1_TO_FMC_0_0 (
  capturestart,
  div_ratio,
  SAMPLE_EDGE_TIME,
  SCN_SEL,
  CS_B,
  CLKA,
  CLKB,
  IN_EN,
  SCN_IN,
  COMPUTE_EN,
  DFF_RST,
  MUX_OUT_PAD,
  CONTROL_EN,
  CLK_OUT_PAD,
  CLK_SA_B,
  WEN,
  READ_EN,
  SA_EN,
  BL_PCHG,
  osc_EN,
  WL_EN,
  FMC_L21,
  FMC_L22,
  FMC_R19,
  FMC_T19,
  FMC_K19,
  FMC_K20,
  FMC_D20,
  FMC_C20,
  FMC_E21,
  FMC_D21,
  FMC_N19,
  FMC_N20,
  FMC_J18,
  FMC_K18,
  FMC_R20,
  FMC_R21,
  FMC_L17,
  FMC_M17,
  FMC_B19,
  FMC_B20,
  FMC_E15,
  FMC_D15,
  FMC_F18,
  FMC_E18,
  FMC_M19,
  FMC_M20,
  FMC_N22,
  FMC_P22,
  FMC_J21,
  FMC_J22,
  FMC_G20,
  FMC_G21,
  FMC_G19,
  FMC_F19,
  FMC_D22,
  FMC_C22,
  FMC_B22,
  FMC_C17,
  FMC_C18,
  FMC_B16,
  FMC_B17,
  FMC_B21,
  DIG_AXI_OUT_0,
  DIG_DEBUG_AXI_OUT_0,
  DIG_DEBUG_AXI_OUT_1
);

input wire [3 : 0] capturestart;
input wire [3 : 0] div_ratio;
input wire [3 : 0] SAMPLE_EDGE_TIME;
input wire [2 : 0] SCN_SEL;
input wire [1 : 0] CS_B;
input wire CLKA;
input wire CLKB;
input wire IN_EN;
input wire SCN_IN;
input wire COMPUTE_EN;
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 DFF_RST RST" *)
(* X_INTERFACE_MODE = "slave" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DFF_RST, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
input wire DFF_RST;
input wire MUX_OUT_PAD;
input wire CONTROL_EN;
input wire CLK_OUT_PAD;
input wire CLK_SA_B;
input wire WEN;
input wire READ_EN;
input wire SA_EN;
input wire BL_PCHG;
input wire osc_EN;
input wire WL_EN;
output wire FMC_L21;
output wire FMC_L22;
output wire FMC_R19;
output wire FMC_T19;
output wire FMC_K19;
output wire FMC_K20;
output wire FMC_D20;
output wire FMC_C20;
output wire FMC_E21;
output wire FMC_D21;
output wire FMC_N19;
output wire FMC_N20;
output wire FMC_J18;
output wire FMC_K18;
output wire FMC_R20;
output wire FMC_R21;
output wire FMC_L17;
output wire FMC_M17;
output wire FMC_B19;
output wire FMC_B20;
output wire FMC_E15;
output wire FMC_D15;
output wire FMC_F18;
output wire FMC_E18;
output wire FMC_M19;
output wire FMC_M20;
output wire FMC_N22;
output wire FMC_P22;
output wire FMC_J21;
output wire FMC_J22;
output wire FMC_G20;
output wire FMC_G21;
output wire FMC_G19;
output wire FMC_F19;
output wire FMC_D22;
output wire FMC_C22;
output wire FMC_B22;
output wire FMC_C17;
output wire FMC_C18;
input wire FMC_B16;
input wire FMC_B17;
input wire FMC_B21;
output wire [2 : 0] DIG_AXI_OUT_0;
output wire [31 : 0] DIG_DEBUG_AXI_OUT_0;
output wire DIG_DEBUG_AXI_OUT_1;

  TO_FMC inst (
    .capturestart(capturestart),
    .div_ratio(div_ratio),
    .SAMPLE_EDGE_TIME(SAMPLE_EDGE_TIME),
    .SCN_SEL(SCN_SEL),
    .CS_B(CS_B),
    .CLKA(CLKA),
    .CLKB(CLKB),
    .IN_EN(IN_EN),
    .SCN_IN(SCN_IN),
    .COMPUTE_EN(COMPUTE_EN),
    .DFF_RST(DFF_RST),
    .MUX_OUT_PAD(MUX_OUT_PAD),
    .CONTROL_EN(CONTROL_EN),
    .CLK_OUT_PAD(CLK_OUT_PAD),
    .CLK_SA_B(CLK_SA_B),
    .WEN(WEN),
    .READ_EN(READ_EN),
    .SA_EN(SA_EN),
    .BL_PCHG(BL_PCHG),
    .osc_EN(osc_EN),
    .WL_EN(WL_EN),
    .FMC_L21(FMC_L21),
    .FMC_L22(FMC_L22),
    .FMC_R19(FMC_R19),
    .FMC_T19(FMC_T19),
    .FMC_K19(FMC_K19),
    .FMC_K20(FMC_K20),
    .FMC_D20(FMC_D20),
    .FMC_C20(FMC_C20),
    .FMC_E21(FMC_E21),
    .FMC_D21(FMC_D21),
    .FMC_N19(FMC_N19),
    .FMC_N20(FMC_N20),
    .FMC_J18(FMC_J18),
    .FMC_K18(FMC_K18),
    .FMC_R20(FMC_R20),
    .FMC_R21(FMC_R21),
    .FMC_L17(FMC_L17),
    .FMC_M17(FMC_M17),
    .FMC_B19(FMC_B19),
    .FMC_B20(FMC_B20),
    .FMC_E15(FMC_E15),
    .FMC_D15(FMC_D15),
    .FMC_F18(FMC_F18),
    .FMC_E18(FMC_E18),
    .FMC_M19(FMC_M19),
    .FMC_M20(FMC_M20),
    .FMC_N22(FMC_N22),
    .FMC_P22(FMC_P22),
    .FMC_J21(FMC_J21),
    .FMC_J22(FMC_J22),
    .FMC_G20(FMC_G20),
    .FMC_G21(FMC_G21),
    .FMC_G19(FMC_G19),
    .FMC_F19(FMC_F19),
    .FMC_D22(FMC_D22),
    .FMC_C22(FMC_C22),
    .FMC_B22(FMC_B22),
    .FMC_C17(FMC_C17),
    .FMC_C18(FMC_C18),
    .FMC_B16(FMC_B16),
    .FMC_B17(FMC_B17),
    .FMC_B21(FMC_B21),
    .DIG_AXI_OUT_0(DIG_AXI_OUT_0),
    .DIG_DEBUG_AXI_OUT_0(DIG_DEBUG_AXI_OUT_0),
    .DIG_DEBUG_AXI_OUT_1(DIG_DEBUG_AXI_OUT_1)
  );
endmodule
