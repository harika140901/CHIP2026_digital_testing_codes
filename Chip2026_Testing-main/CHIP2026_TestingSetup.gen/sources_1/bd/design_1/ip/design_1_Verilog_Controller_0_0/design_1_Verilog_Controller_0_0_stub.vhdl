-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2025.1 (win64) Build 6140274 Thu May 22 00:12:29 MDT 2025
-- Date        : Sat Oct 24 12:21:38 2026
-- Host        : lappy running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               c:/Users/horro/Documents/research/CHIP2026_digital_testing_codes/Chip2026_Testing-main/CHIP2026_TestingSetup.gen/sources_1/bd/design_1/ip/design_1_Verilog_Controller_0_0/design_1_Verilog_Controller_0_0_stub.vhdl
-- Design      : design_1_Verilog_Controller_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity design_1_Verilog_Controller_0_0 is
  Port ( 
    WL_EN_C : in STD_LOGIC;
    SA_EN_C : in STD_LOGIC;
    BL_PCHG_C : in STD_LOGIC;
    CLK_SA_C : in STD_LOGIC;
    READ_EN_C : in STD_LOGIC;
    WEN_C : in STD_LOGIC;
    CS_B_C : in STD_LOGIC_VECTOR ( 1 downto 0 );
    SCN_SEL_C : in STD_LOGIC_VECTOR ( 2 downto 0 );
    CLK_A_C : in STD_LOGIC;
    CLK_B_C : in STD_LOGIC;
    IN_EN_C : in STD_LOGIC;
    SCN_IN_C : in STD_LOGIC;
    COMPUTE_EN_C : in STD_LOGIC;
    DFF_RST_C : in STD_LOGIC;
    MUX_OUT_PAD_C : in STD_LOGIC;
    CONTROL_EN_C : in STD_LOGIC;
    CLK_OUT_PAD_C : in STD_LOGIC;
    osc_EN_C : in STD_LOGIC;
    capturestart_C : in STD_LOGIC_VECTOR ( 3 downto 0 );
    div_ratio_C : in STD_LOGIC_VECTOR ( 3 downto 0 );
    SAMPLE_EDGE_TIME_C : in STD_LOGIC_VECTOR ( 3 downto 0 );
    WL_EN : out STD_LOGIC;
    SA_EN : out STD_LOGIC;
    BL_PCHG : out STD_LOGIC;
    CLK_SA : out STD_LOGIC;
    WEN : out STD_LOGIC;
    READ_EN : out STD_LOGIC;
    CS_B : out STD_LOGIC_VECTOR ( 1 downto 0 );
    SCN_SEL : out STD_LOGIC_VECTOR ( 2 downto 0 );
    CLKA : out STD_LOGIC;
    CLKB : out STD_LOGIC;
    IN_EN : out STD_LOGIC;
    SCN_IN : out STD_LOGIC;
    COMPUTE_EN : out STD_LOGIC;
    DFF_RST : out STD_LOGIC;
    MUX_OUT_PAD : out STD_LOGIC;
    CONTROL_EN : out STD_LOGIC;
    CLK_OUT_PAD : out STD_LOGIC;
    osc_EN : out STD_LOGIC;
    capturestart : out STD_LOGIC_VECTOR ( 3 downto 0 );
    div_ratio : out STD_LOGIC_VECTOR ( 3 downto 0 );
    SAMPLE_EDGE_TIME : out STD_LOGIC_VECTOR ( 3 downto 0 );
    scan_mode_setting_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    dig_out : in STD_LOGIC_VECTOR ( 2 downto 0 );
    clk : in STD_LOGIC;
    in_tvalid : in STD_LOGIC;
    in_tlast : in STD_LOGIC;
    in_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    in_tready : out STD_LOGIC;
    out_tready : in STD_LOGIC;
    out_tvalid : out STD_LOGIC;
    out_tlast : out STD_LOGIC;
    out_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    SCAN_DONE_FLAGS : out STD_LOGIC_VECTOR ( 3 downto 0 )
  );

  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_1_Verilog_Controller_0_0 : entity is "design_1_Verilog_Controller_0_0,Verilog_Controller,{}";
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of design_1_Verilog_Controller_0_0 : entity is "design_1_Verilog_Controller_0_0,Verilog_Controller,{x_ipProduct=Vivado 2025.1,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=Verilog_Controller,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of design_1_Verilog_Controller_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of design_1_Verilog_Controller_0_0 : entity is "module_ref";
end design_1_Verilog_Controller_0_0;

architecture stub of design_1_Verilog_Controller_0_0 is
  attribute syn_black_box : boolean;
  attribute black_box_pad_pin : string;
  attribute syn_black_box of stub : architecture is true;
  attribute black_box_pad_pin of stub : architecture is "WL_EN_C,SA_EN_C,BL_PCHG_C,CLK_SA_C,READ_EN_C,WEN_C,CS_B_C[1:0],SCN_SEL_C[2:0],CLK_A_C,CLK_B_C,IN_EN_C,SCN_IN_C,COMPUTE_EN_C,DFF_RST_C,MUX_OUT_PAD_C,CONTROL_EN_C,CLK_OUT_PAD_C,osc_EN_C,capturestart_C[3:0],div_ratio_C[3:0],SAMPLE_EDGE_TIME_C[3:0],WL_EN,SA_EN,BL_PCHG,CLK_SA,WEN,READ_EN,CS_B[1:0],SCN_SEL[2:0],CLKA,CLKB,IN_EN,SCN_IN,COMPUTE_EN,DFF_RST,MUX_OUT_PAD,CONTROL_EN,CLK_OUT_PAD,osc_EN,capturestart[3:0],div_ratio[3:0],SAMPLE_EDGE_TIME[3:0],scan_mode_setting_in[31:0],dig_out[2:0],clk,in_tvalid,in_tlast,in_tdata[31:0],in_tready,out_tready,out_tvalid,out_tlast,out_tdata[31:0],SCAN_DONE_FLAGS[3:0]";
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of DFF_RST : signal is "xilinx.com:signal:reset:1.0 DFF_RST RST";
  attribute X_INTERFACE_MODE : string;
  attribute X_INTERFACE_MODE of DFF_RST : signal is "master";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of DFF_RST : signal is "XIL_INTERFACENAME DFF_RST, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of clk : signal is "xilinx.com:signal:clock:1.0 clk CLK";
  attribute X_INTERFACE_MODE of clk : signal is "slave";
  attribute X_INTERFACE_PARAMETER of clk : signal is "XIL_INTERFACENAME clk, ASSOCIATED_BUSIF in:out, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of in_tvalid : signal is "xilinx.com:interface:axis:1.0 in TVALID";
  attribute X_INTERFACE_MODE of in_tvalid : signal is "slave";
  attribute X_INTERFACE_PARAMETER of in_tvalid : signal is "XIL_INTERFACENAME in, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, LAYERED_METADATA undef, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of in_tlast : signal is "xilinx.com:interface:axis:1.0 in TLAST";
  attribute X_INTERFACE_INFO of in_tdata : signal is "xilinx.com:interface:axis:1.0 in TDATA";
  attribute X_INTERFACE_INFO of in_tready : signal is "xilinx.com:interface:axis:1.0 in TREADY";
  attribute X_INTERFACE_INFO of out_tready : signal is "xilinx.com:interface:axis:1.0 out TREADY";
  attribute X_INTERFACE_MODE of out_tready : signal is "master";
  attribute X_INTERFACE_PARAMETER of out_tready : signal is "XIL_INTERFACENAME out, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, LAYERED_METADATA undef, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of out_tvalid : signal is "xilinx.com:interface:axis:1.0 out TVALID";
  attribute X_INTERFACE_INFO of out_tlast : signal is "xilinx.com:interface:axis:1.0 out TLAST";
  attribute X_INTERFACE_INFO of out_tdata : signal is "xilinx.com:interface:axis:1.0 out TDATA";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of stub : architecture is "Verilog_Controller,Vivado 2025.1";
begin
end;
