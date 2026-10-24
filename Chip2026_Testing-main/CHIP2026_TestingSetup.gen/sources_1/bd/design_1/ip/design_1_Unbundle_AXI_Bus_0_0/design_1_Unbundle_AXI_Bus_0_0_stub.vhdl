-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2025.1 (win64) Build 6140274 Thu May 22 00:12:29 MDT 2025
-- Date        : Sat Oct 24 10:47:17 2026
-- Host        : lappy running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               c:/Users/horro/Documents/research/CHIP2026_digital_testing_codes/Chip2026_Testing-main/CHIP2026_TestingSetup.gen/sources_1/bd/design_1/ip/design_1_Unbundle_AXI_Bus_0_0/design_1_Unbundle_AXI_Bus_0_0_stub.vhdl
-- Design      : design_1_Unbundle_AXI_Bus_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity design_1_Unbundle_AXI_Bus_0_0 is
  Port ( 
    DIG_AXI_IN_0 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    DIG_AXI_IN_1 : in STD_LOGIC;
    WL_EN_C : out STD_LOGIC;
    SA_EN_C : out STD_LOGIC;
    BL_PCHG_C : out STD_LOGIC;
    WEN_C : out STD_LOGIC;
    READ_EN_C : out STD_LOGIC;
    CS_B_C : out STD_LOGIC_VECTOR ( 1 downto 0 );
    SCN_SEL_C : out STD_LOGIC_VECTOR ( 2 downto 0 );
    CLKA_C : out STD_LOGIC;
    CLKB_C : out STD_LOGIC;
    IN_EN_C : out STD_LOGIC;
    SCN_IN_C : out STD_LOGIC;
    COMPUTE_EN_C : out STD_LOGIC;
    DFF_RST_C : out STD_LOGIC;
    MUX_OUT_PAD_C : out STD_LOGIC;
    CONTROL_EN_C : out STD_LOGIC;
    CLK_OUT_PAD_C : out STD_LOGIC;
    osc_EN_C : out STD_LOGIC;
    capturestart_C : out STD_LOGIC_VECTOR ( 3 downto 0 );
    div_ratio_C : out STD_LOGIC_VECTOR ( 3 downto 0 );
    SAMPLE_EDGE_TIME_C : out STD_LOGIC_VECTOR ( 3 downto 0 );
    CLK_SA_B_C : out STD_LOGIC
  );

  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_1_Unbundle_AXI_Bus_0_0 : entity is "design_1_Unbundle_AXI_Bus_0_0,Unbundle_AXI_Bus,{}";
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of design_1_Unbundle_AXI_Bus_0_0 : entity is "design_1_Unbundle_AXI_Bus_0_0,Unbundle_AXI_Bus,{x_ipProduct=Vivado 2025.1,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=Unbundle_AXI_Bus,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of design_1_Unbundle_AXI_Bus_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of design_1_Unbundle_AXI_Bus_0_0 : entity is "module_ref";
end design_1_Unbundle_AXI_Bus_0_0;

architecture stub of design_1_Unbundle_AXI_Bus_0_0 is
  attribute syn_black_box : boolean;
  attribute black_box_pad_pin : string;
  attribute syn_black_box of stub : architecture is true;
  attribute black_box_pad_pin of stub : architecture is "DIG_AXI_IN_0[31:0],DIG_AXI_IN_1,WL_EN_C,SA_EN_C,BL_PCHG_C,WEN_C,READ_EN_C,CS_B_C[1:0],SCN_SEL_C[2:0],CLKA_C,CLKB_C,IN_EN_C,SCN_IN_C,COMPUTE_EN_C,DFF_RST_C,MUX_OUT_PAD_C,CONTROL_EN_C,CLK_OUT_PAD_C,osc_EN_C,capturestart_C[3:0],div_ratio_C[3:0],SAMPLE_EDGE_TIME_C[3:0],CLK_SA_B_C";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of stub : architecture is "Unbundle_AXI_Bus,Vivado 2025.1";
begin
end;
