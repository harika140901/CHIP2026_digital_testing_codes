-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2025.1 (win64) Build 6140274 Thu May 22 00:12:29 MDT 2025
-- Date        : Sat Oct 24 10:47:17 2026
-- Host        : lappy running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               c:/Users/horro/Documents/research/CHIP2026_digital_testing_codes/Chip2026_Testing-main/CHIP2026_TestingSetup.gen/sources_1/bd/design_1/ip/design_1_Unbundle_AXI_Bus_0_0/design_1_Unbundle_AXI_Bus_0_0_sim_netlist.vhdl
-- Design      : design_1_Unbundle_AXI_Bus_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_Unbundle_AXI_Bus_0_0 is
  port (
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
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of design_1_Unbundle_AXI_Bus_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_1_Unbundle_AXI_Bus_0_0 : entity is "design_1_Unbundle_AXI_Bus_0_0,Unbundle_AXI_Bus,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of design_1_Unbundle_AXI_Bus_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of design_1_Unbundle_AXI_Bus_0_0 : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of design_1_Unbundle_AXI_Bus_0_0 : entity is "Unbundle_AXI_Bus,Vivado 2025.1";
end design_1_Unbundle_AXI_Bus_0_0;

architecture STRUCTURE of design_1_Unbundle_AXI_Bus_0_0 is
  signal \^dig_axi_in_0\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \^dig_axi_in_1\ : STD_LOGIC;
begin
  BL_PCHG_C <= \^dig_axi_in_0\(30);
  CLKA_C <= \^dig_axi_in_0\(17);
  CLKB_C <= \^dig_axi_in_0\(18);
  CLK_OUT_PAD_C <= \^dig_axi_in_0\(25);
  CLK_SA_B_C <= \^dig_axi_in_0\(26);
  COMPUTE_EN_C <= \^dig_axi_in_0\(21);
  CONTROL_EN_C <= \^dig_axi_in_0\(24);
  CS_B_C(1 downto 0) <= \^dig_axi_in_0\(16 downto 15);
  DFF_RST_C <= \^dig_axi_in_0\(22);
  IN_EN_C <= \^dig_axi_in_0\(19);
  MUX_OUT_PAD_C <= \^dig_axi_in_0\(23);
  READ_EN_C <= \^dig_axi_in_0\(28);
  SAMPLE_EDGE_TIME_C(3 downto 0) <= \^dig_axi_in_0\(11 downto 8);
  SA_EN_C <= \^dig_axi_in_0\(29);
  SCN_IN_C <= \^dig_axi_in_0\(20);
  SCN_SEL_C(2 downto 0) <= \^dig_axi_in_0\(14 downto 12);
  WEN_C <= \^dig_axi_in_0\(27);
  WL_EN_C <= \^dig_axi_in_1\;
  \^dig_axi_in_0\(31 downto 0) <= DIG_AXI_IN_0(31 downto 0);
  \^dig_axi_in_1\ <= DIG_AXI_IN_1;
  capturestart_C(3 downto 0) <= \^dig_axi_in_0\(3 downto 0);
  div_ratio_C(3 downto 0) <= \^dig_axi_in_0\(7 downto 4);
  osc_EN_C <= \^dig_axi_in_0\(31);
end STRUCTURE;
