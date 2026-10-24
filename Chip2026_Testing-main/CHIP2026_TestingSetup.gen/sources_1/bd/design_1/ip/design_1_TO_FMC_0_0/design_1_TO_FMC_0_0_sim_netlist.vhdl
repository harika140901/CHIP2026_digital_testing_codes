-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2025.1 (win64) Build 6140274 Thu May 22 00:12:29 MDT 2025
-- Date        : Sat Oct 24 10:48:06 2026
-- Host        : lappy running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               c:/Users/horro/Documents/research/CHIP2026_digital_testing_codes/Chip2026_Testing-main/CHIP2026_TestingSetup.gen/sources_1/bd/design_1/ip/design_1_TO_FMC_0_0/design_1_TO_FMC_0_0_sim_netlist.vhdl
-- Design      : design_1_TO_FMC_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_TO_FMC_0_0 is
  port (
    capturestart : in STD_LOGIC_VECTOR ( 3 downto 0 );
    div_ratio : in STD_LOGIC_VECTOR ( 3 downto 0 );
    SAMPLE_EDGE_TIME : in STD_LOGIC_VECTOR ( 3 downto 0 );
    SCN_SEL : in STD_LOGIC_VECTOR ( 2 downto 0 );
    CS_B : in STD_LOGIC_VECTOR ( 1 downto 0 );
    CLKA : in STD_LOGIC;
    CLKB : in STD_LOGIC;
    IN_EN : in STD_LOGIC;
    SCN_IN : in STD_LOGIC;
    COMPUTE_EN : in STD_LOGIC;
    DFF_RST : in STD_LOGIC;
    MUX_OUT_PAD : in STD_LOGIC;
    CONTROL_EN : in STD_LOGIC;
    CLK_OUT_PAD : in STD_LOGIC;
    CLK_SA_B : in STD_LOGIC;
    WEN : in STD_LOGIC;
    READ_EN : in STD_LOGIC;
    SA_EN : in STD_LOGIC;
    BL_PCHG : in STD_LOGIC;
    osc_EN : in STD_LOGIC;
    WL_EN : in STD_LOGIC;
    FMC_L21 : out STD_LOGIC;
    FMC_L22 : out STD_LOGIC;
    FMC_R19 : out STD_LOGIC;
    FMC_T19 : out STD_LOGIC;
    FMC_K19 : out STD_LOGIC;
    FMC_K20 : out STD_LOGIC;
    FMC_D20 : out STD_LOGIC;
    FMC_C20 : out STD_LOGIC;
    FMC_E21 : out STD_LOGIC;
    FMC_D21 : out STD_LOGIC;
    FMC_N19 : out STD_LOGIC;
    FMC_N20 : out STD_LOGIC;
    FMC_J18 : out STD_LOGIC;
    FMC_K18 : out STD_LOGIC;
    FMC_R20 : out STD_LOGIC;
    FMC_R21 : out STD_LOGIC;
    FMC_L17 : out STD_LOGIC;
    FMC_M17 : out STD_LOGIC;
    FMC_B19 : out STD_LOGIC;
    FMC_B20 : out STD_LOGIC;
    FMC_E15 : out STD_LOGIC;
    FMC_D15 : out STD_LOGIC;
    FMC_F18 : out STD_LOGIC;
    FMC_E18 : out STD_LOGIC;
    FMC_M19 : out STD_LOGIC;
    FMC_M20 : out STD_LOGIC;
    FMC_N22 : out STD_LOGIC;
    FMC_P22 : out STD_LOGIC;
    FMC_J21 : out STD_LOGIC;
    FMC_J22 : out STD_LOGIC;
    FMC_G20 : out STD_LOGIC;
    FMC_G21 : out STD_LOGIC;
    FMC_G19 : out STD_LOGIC;
    FMC_F19 : out STD_LOGIC;
    FMC_D22 : out STD_LOGIC;
    FMC_C22 : out STD_LOGIC;
    FMC_B22 : out STD_LOGIC;
    FMC_C17 : out STD_LOGIC;
    FMC_C18 : out STD_LOGIC;
    FMC_B16 : in STD_LOGIC;
    FMC_B17 : in STD_LOGIC;
    FMC_B21 : in STD_LOGIC;
    DIG_AXI_OUT_0 : out STD_LOGIC_VECTOR ( 2 downto 0 );
    DIG_DEBUG_AXI_OUT_0 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    DIG_DEBUG_AXI_OUT_1 : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of design_1_TO_FMC_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_1_TO_FMC_0_0 : entity is "design_1_TO_FMC_0_0,TO_FMC,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of design_1_TO_FMC_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of design_1_TO_FMC_0_0 : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of design_1_TO_FMC_0_0 : entity is "TO_FMC,Vivado 2025.1";
end design_1_TO_FMC_0_0;

architecture STRUCTURE of design_1_TO_FMC_0_0 is
  signal \<const0>\ : STD_LOGIC;
  signal \^bl_pchg\ : STD_LOGIC;
  signal \^clka\ : STD_LOGIC;
  signal \^clkb\ : STD_LOGIC;
  signal \^clk_out_pad\ : STD_LOGIC;
  signal \^clk_sa_b\ : STD_LOGIC;
  signal \^compute_en\ : STD_LOGIC;
  signal \^control_en\ : STD_LOGIC;
  signal \^cs_b\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \^dff_rst\ : STD_LOGIC;
  signal \^fmc_b16\ : STD_LOGIC;
  signal \^fmc_b17\ : STD_LOGIC;
  signal \^fmc_b21\ : STD_LOGIC;
  signal \^in_en\ : STD_LOGIC;
  signal \^mux_out_pad\ : STD_LOGIC;
  signal \^read_en\ : STD_LOGIC;
  signal \^sample_edge_time\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \^sa_en\ : STD_LOGIC;
  signal \^scn_in\ : STD_LOGIC;
  signal \^scn_sel\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \^wen\ : STD_LOGIC;
  signal \^wl_en\ : STD_LOGIC;
  signal \^capturestart\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \^div_ratio\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \^osc_en\ : STD_LOGIC;
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of DFF_RST : signal is "xilinx.com:signal:reset:1.0 DFF_RST RST";
  attribute X_INTERFACE_MODE : string;
  attribute X_INTERFACE_MODE of DFF_RST : signal is "slave";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of DFF_RST : signal is "XIL_INTERFACENAME DFF_RST, POLARITY ACTIVE_LOW, INSERT_VIP 0";
begin
  DIG_AXI_OUT_0(2) <= \^fmc_b16\;
  DIG_AXI_OUT_0(1) <= \^fmc_b17\;
  DIG_AXI_OUT_0(0) <= \^fmc_b21\;
  DIG_DEBUG_AXI_OUT_0(31) <= \^osc_en\;
  DIG_DEBUG_AXI_OUT_0(30) <= \^bl_pchg\;
  DIG_DEBUG_AXI_OUT_0(29) <= \^sa_en\;
  DIG_DEBUG_AXI_OUT_0(28) <= \^read_en\;
  DIG_DEBUG_AXI_OUT_0(27) <= \^wen\;
  DIG_DEBUG_AXI_OUT_0(26) <= \^clk_sa_b\;
  DIG_DEBUG_AXI_OUT_0(25) <= \^clk_out_pad\;
  DIG_DEBUG_AXI_OUT_0(24) <= \^control_en\;
  DIG_DEBUG_AXI_OUT_0(23) <= \^mux_out_pad\;
  DIG_DEBUG_AXI_OUT_0(22) <= \^dff_rst\;
  DIG_DEBUG_AXI_OUT_0(21) <= \^compute_en\;
  DIG_DEBUG_AXI_OUT_0(20) <= \^scn_in\;
  DIG_DEBUG_AXI_OUT_0(19) <= \^in_en\;
  DIG_DEBUG_AXI_OUT_0(18) <= \^clkb\;
  DIG_DEBUG_AXI_OUT_0(17) <= \^clka\;
  DIG_DEBUG_AXI_OUT_0(16 downto 15) <= \^cs_b\(1 downto 0);
  DIG_DEBUG_AXI_OUT_0(14 downto 12) <= \^scn_sel\(2 downto 0);
  DIG_DEBUG_AXI_OUT_0(11 downto 8) <= \^sample_edge_time\(3 downto 0);
  DIG_DEBUG_AXI_OUT_0(7 downto 4) <= \^div_ratio\(3 downto 0);
  DIG_DEBUG_AXI_OUT_0(3 downto 0) <= \^capturestart\(3 downto 0);
  DIG_DEBUG_AXI_OUT_1 <= \^wl_en\;
  FMC_B19 <= \^wen\;
  FMC_B20 <= \^read_en\;
  FMC_B22 <= \<const0>\;
  FMC_C17 <= \^osc_en\;
  FMC_C18 <= \^wl_en\;
  FMC_C20 <= \^dff_rst\;
  FMC_C22 <= \^clkb\;
  FMC_D15 <= \<const0>\;
  FMC_D20 <= \^div_ratio\(1);
  FMC_D21 <= \^control_en\;
  FMC_D22 <= \^clka\;
  FMC_E15 <= \<const0>\;
  FMC_E18 <= \<const0>\;
  FMC_E21 <= \^mux_out_pad\;
  FMC_F18 <= \<const0>\;
  FMC_F19 <= \^in_en\;
  FMC_G19 <= \^scn_in\;
  FMC_G20 <= \<const0>\;
  FMC_G21 <= \^bl_pchg\;
  FMC_J18 <= \^sample_edge_time\(0);
  FMC_J21 <= \^cs_b\(0);
  FMC_J22 <= \^sa_en\;
  FMC_K18 <= \^sample_edge_time\(1);
  FMC_K19 <= \^capturestart\(3);
  FMC_K20 <= \^div_ratio\(0);
  FMC_L17 <= \^clk_out_pad\;
  FMC_L21 <= \^compute_en\;
  FMC_L22 <= \^capturestart\(0);
  FMC_M17 <= \^clk_sa_b\;
  FMC_M19 <= \^scn_sel\(0);
  FMC_M20 <= \^scn_sel\(1);
  FMC_N19 <= \^div_ratio\(2);
  FMC_N20 <= \^div_ratio\(3);
  FMC_N22 <= \^scn_sel\(2);
  FMC_P22 <= \^cs_b\(1);
  FMC_R19 <= \^capturestart\(1);
  FMC_R20 <= \^sample_edge_time\(2);
  FMC_R21 <= \^sample_edge_time\(3);
  FMC_T19 <= \^capturestart\(2);
  \^bl_pchg\ <= BL_PCHG;
  \^capturestart\(3 downto 0) <= capturestart(3 downto 0);
  \^clk_out_pad\ <= CLK_OUT_PAD;
  \^clk_sa_b\ <= CLK_SA_B;
  \^clka\ <= CLKA;
  \^clkb\ <= CLKB;
  \^compute_en\ <= COMPUTE_EN;
  \^control_en\ <= CONTROL_EN;
  \^cs_b\(1 downto 0) <= CS_B(1 downto 0);
  \^dff_rst\ <= DFF_RST;
  \^div_ratio\(3 downto 0) <= div_ratio(3 downto 0);
  \^fmc_b16\ <= FMC_B16;
  \^fmc_b17\ <= FMC_B17;
  \^fmc_b21\ <= FMC_B21;
  \^in_en\ <= IN_EN;
  \^mux_out_pad\ <= MUX_OUT_PAD;
  \^osc_en\ <= osc_EN;
  \^read_en\ <= READ_EN;
  \^sa_en\ <= SA_EN;
  \^sample_edge_time\(3 downto 0) <= SAMPLE_EDGE_TIME(3 downto 0);
  \^scn_in\ <= SCN_IN;
  \^scn_sel\(2 downto 0) <= SCN_SEL(2 downto 0);
  \^wen\ <= WEN;
  \^wl_en\ <= WL_EN;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
end STRUCTURE;
