// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.1 (win64) Build 6140274 Thu May 22 00:12:29 MDT 2025
// Date        : Sat Oct 24 10:48:06 2026
// Host        : lappy running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/horro/Documents/research/CHIP2026_digital_testing_codes/Chip2026_Testing-main/CHIP2026_TestingSetup.gen/sources_1/bd/design_1/ip/design_1_TO_FMC_0_0/design_1_TO_FMC_0_0_sim_netlist.v
// Design      : design_1_TO_FMC_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_1_TO_FMC_0_0,TO_FMC,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "TO_FMC,Vivado 2025.1" *) 
(* NotValidForBitStream *)
module design_1_TO_FMC_0_0
   (capturestart,
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
    DIG_DEBUG_AXI_OUT_1);
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

  wire \<const0> ;
  wire BL_PCHG;
  wire CLKA;
  wire CLKB;
  wire CLK_OUT_PAD;
  wire CLK_SA_B;
  wire COMPUTE_EN;
  wire CONTROL_EN;
  wire [1:0]CS_B;
  wire DFF_RST;
  wire FMC_B16;
  wire FMC_B17;
  wire FMC_B21;
  wire IN_EN;
  wire MUX_OUT_PAD;
  wire READ_EN;
  wire [3:0]SAMPLE_EDGE_TIME;
  wire SA_EN;
  wire SCN_IN;
  wire [2:0]SCN_SEL;
  wire WEN;
  wire WL_EN;
  wire [3:0]capturestart;
  wire [3:0]div_ratio;
  wire osc_EN;

  assign DIG_AXI_OUT_0[2] = FMC_B16;
  assign DIG_AXI_OUT_0[1] = FMC_B17;
  assign DIG_AXI_OUT_0[0] = FMC_B21;
  assign DIG_DEBUG_AXI_OUT_0[31] = osc_EN;
  assign DIG_DEBUG_AXI_OUT_0[30] = BL_PCHG;
  assign DIG_DEBUG_AXI_OUT_0[29] = SA_EN;
  assign DIG_DEBUG_AXI_OUT_0[28] = READ_EN;
  assign DIG_DEBUG_AXI_OUT_0[27] = WEN;
  assign DIG_DEBUG_AXI_OUT_0[26] = CLK_SA_B;
  assign DIG_DEBUG_AXI_OUT_0[25] = CLK_OUT_PAD;
  assign DIG_DEBUG_AXI_OUT_0[24] = CONTROL_EN;
  assign DIG_DEBUG_AXI_OUT_0[23] = MUX_OUT_PAD;
  assign DIG_DEBUG_AXI_OUT_0[22] = DFF_RST;
  assign DIG_DEBUG_AXI_OUT_0[21] = COMPUTE_EN;
  assign DIG_DEBUG_AXI_OUT_0[20] = SCN_IN;
  assign DIG_DEBUG_AXI_OUT_0[19] = IN_EN;
  assign DIG_DEBUG_AXI_OUT_0[18] = CLKB;
  assign DIG_DEBUG_AXI_OUT_0[17] = CLKA;
  assign DIG_DEBUG_AXI_OUT_0[16:15] = CS_B;
  assign DIG_DEBUG_AXI_OUT_0[14:12] = SCN_SEL;
  assign DIG_DEBUG_AXI_OUT_0[11:8] = SAMPLE_EDGE_TIME;
  assign DIG_DEBUG_AXI_OUT_0[7:4] = div_ratio;
  assign DIG_DEBUG_AXI_OUT_0[3:0] = capturestart;
  assign DIG_DEBUG_AXI_OUT_1 = WL_EN;
  assign FMC_B19 = WEN;
  assign FMC_B20 = READ_EN;
  assign FMC_B22 = \<const0> ;
  assign FMC_C17 = osc_EN;
  assign FMC_C18 = WL_EN;
  assign FMC_C20 = DFF_RST;
  assign FMC_C22 = CLKB;
  assign FMC_D15 = \<const0> ;
  assign FMC_D20 = div_ratio[1];
  assign FMC_D21 = CONTROL_EN;
  assign FMC_D22 = CLKA;
  assign FMC_E15 = \<const0> ;
  assign FMC_E18 = \<const0> ;
  assign FMC_E21 = MUX_OUT_PAD;
  assign FMC_F18 = \<const0> ;
  assign FMC_F19 = IN_EN;
  assign FMC_G19 = SCN_IN;
  assign FMC_G20 = \<const0> ;
  assign FMC_G21 = BL_PCHG;
  assign FMC_J18 = SAMPLE_EDGE_TIME[0];
  assign FMC_J21 = CS_B[0];
  assign FMC_J22 = SA_EN;
  assign FMC_K18 = SAMPLE_EDGE_TIME[1];
  assign FMC_K19 = capturestart[3];
  assign FMC_K20 = div_ratio[0];
  assign FMC_L17 = CLK_OUT_PAD;
  assign FMC_L21 = COMPUTE_EN;
  assign FMC_L22 = capturestart[0];
  assign FMC_M17 = CLK_SA_B;
  assign FMC_M19 = SCN_SEL[0];
  assign FMC_M20 = SCN_SEL[1];
  assign FMC_N19 = div_ratio[2];
  assign FMC_N20 = div_ratio[3];
  assign FMC_N22 = SCN_SEL[2];
  assign FMC_P22 = CS_B[1];
  assign FMC_R19 = capturestart[1];
  assign FMC_R20 = SAMPLE_EDGE_TIME[2];
  assign FMC_R21 = SAMPLE_EDGE_TIME[3];
  assign FMC_T19 = capturestart[2];
  GND GND
       (.G(\<const0> ));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
