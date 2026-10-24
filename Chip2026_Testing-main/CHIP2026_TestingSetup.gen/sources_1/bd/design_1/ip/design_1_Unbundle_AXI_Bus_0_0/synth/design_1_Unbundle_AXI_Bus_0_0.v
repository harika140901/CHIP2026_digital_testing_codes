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


// IP VLNV: xilinx.com:module_ref:Unbundle_AXI_Bus:1.0
// IP Revision: 1

(* X_CORE_INFO = "Unbundle_AXI_Bus,Vivado 2025.1" *)
(* CHECK_LICENSE_TYPE = "design_1_Unbundle_AXI_Bus_0_0,Unbundle_AXI_Bus,{}" *)
(* CORE_GENERATION_INFO = "design_1_Unbundle_AXI_Bus_0_0,Unbundle_AXI_Bus,{x_ipProduct=Vivado 2025.1,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=Unbundle_AXI_Bus,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}" *)
(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module design_1_Unbundle_AXI_Bus_0_0 (
  DIG_AXI_IN_0,
  DIG_AXI_IN_1,
  WL_EN_C,
  SA_EN_C,
  BL_PCHG_C,
  WEN_C,
  READ_EN_C,
  CS_B_C,
  SCN_SEL_C,
  CLKA_C,
  CLKB_C,
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
  CLK_SA_B_C
);

input wire [31 : 0] DIG_AXI_IN_0;
input wire DIG_AXI_IN_1;
output wire WL_EN_C;
output wire SA_EN_C;
output wire BL_PCHG_C;
output wire WEN_C;
output wire READ_EN_C;
output wire [1 : 0] CS_B_C;
output wire [2 : 0] SCN_SEL_C;
output wire CLKA_C;
output wire CLKB_C;
output wire IN_EN_C;
output wire SCN_IN_C;
output wire COMPUTE_EN_C;
output wire DFF_RST_C;
output wire MUX_OUT_PAD_C;
output wire CONTROL_EN_C;
output wire CLK_OUT_PAD_C;
output wire osc_EN_C;
output wire [3 : 0] capturestart_C;
output wire [3 : 0] div_ratio_C;
output wire [3 : 0] SAMPLE_EDGE_TIME_C;
output wire CLK_SA_B_C;

  Unbundle_AXI_Bus inst (
    .DIG_AXI_IN_0(DIG_AXI_IN_0),
    .DIG_AXI_IN_1(DIG_AXI_IN_1),
    .WL_EN_C(WL_EN_C),
    .SA_EN_C(SA_EN_C),
    .BL_PCHG_C(BL_PCHG_C),
    .WEN_C(WEN_C),
    .READ_EN_C(READ_EN_C),
    .CS_B_C(CS_B_C),
    .SCN_SEL_C(SCN_SEL_C),
    .CLKA_C(CLKA_C),
    .CLKB_C(CLKB_C),
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
    .CLK_SA_B_C(CLK_SA_B_C)
  );
endmodule
