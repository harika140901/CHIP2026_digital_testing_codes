# -----------------------------------------------------------------------------
# FMC Pin Assignments
# -----------------------------------------------------------------------------
#
# CHIP 2026 pad map reference:
# This project uses the FMC package pin assignments as the board-level view of the
# CHIP 2026 pad ring. The underlying chip pad planning shown in the design notes
# uses the following groups and naming conventions:
#
#   Power / ground:
#     VDDQ, VDD, VSS, GND
#
#   Digital / I/O pads:
#     PAD_D0, PAD_D1, PAD_DI, PAD_DO, PAD_IO_0 ... PAD_IO_N
#     PAD_CI, PAD_CO, PAD_AN, PAD_C0, PAD_C1
#
#   Scan / control pads:
#     SCN_IN, SCN_OUT, CLKA, CLKB, IN_EN, MUX_OUT, SAMPLE_E,
#     CONTROL, TEST, CLK_NE, DFF_RST, etc.
#
# The constraints below map the FMC board pins to the FPGA ports used in the test
# setup. This is the physical implementation layer for the chip pad ring plan.
# -----------------------------------------------------------------------------

set_property PACKAGE_PIN B16 [get_ports FMC_B16]
set_property PACKAGE_PIN B17 [get_ports FMC_B17]
set_property PACKAGE_PIN B19 [get_ports FMC_B19]
set_property PACKAGE_PIN B20 [get_ports FMC_B20]
set_property PACKAGE_PIN B21 [get_ports FMC_B21]
set_property PACKAGE_PIN B22 [get_ports FMC_B22]

set_property PACKAGE_PIN C17 [get_ports FMC_C17]
set_property PACKAGE_PIN C18 [get_ports FMC_C18]
set_property PACKAGE_PIN C20 [get_ports FMC_C20]
set_property PACKAGE_PIN C22 [get_ports FMC_C22]

set_property PACKAGE_PIN D15 [get_ports FMC_D15]
set_property PACKAGE_PIN D20 [get_ports FMC_D20]
set_property PACKAGE_PIN D21 [get_ports FMC_D21]
set_property PACKAGE_PIN D22 [get_ports FMC_D22]

set_property PACKAGE_PIN E15 [get_ports FMC_E15]
set_property PACKAGE_PIN E18 [get_ports FMC_E18]
set_property PACKAGE_PIN E21 [get_ports FMC_E21]

set_property PACKAGE_PIN F18 [get_ports FMC_F18]
set_property PACKAGE_PIN F19 [get_ports FMC_F19]

set_property PACKAGE_PIN G19 [get_ports FMC_G19]
set_property PACKAGE_PIN G20 [get_ports FMC_G20]
set_property PACKAGE_PIN G21 [get_ports FMC_G21]

set_property PACKAGE_PIN J18 [get_ports FMC_J18]
set_property PACKAGE_PIN J21 [get_ports FMC_J21]
set_property PACKAGE_PIN J22 [get_ports FMC_J22]

set_property PACKAGE_PIN K18 [get_ports FMC_K18]
set_property PACKAGE_PIN K19 [get_ports FMC_K19]
set_property PACKAGE_PIN K20 [get_ports FMC_K20]

set_property PACKAGE_PIN L17 [get_ports FMC_L17]
set_property PACKAGE_PIN L21 [get_ports FMC_L21]
set_property PACKAGE_PIN L22 [get_ports FMC_L22]

set_property PACKAGE_PIN M17 [get_ports FMC_M17]
set_property PACKAGE_PIN M19 [get_ports FMC_M19]
set_property PACKAGE_PIN M20 [get_ports FMC_M20]

set_property PACKAGE_PIN N19 [get_ports FMC_N19]
set_property PACKAGE_PIN N20 [get_ports FMC_N20]
set_property PACKAGE_PIN N22 [get_ports FMC_N22]

set_property PACKAGE_PIN P22 [get_ports FMC_P22]

set_property PACKAGE_PIN R19 [get_ports FMC_R19]
set_property PACKAGE_PIN R20 [get_ports FMC_R20]
set_property PACKAGE_PIN R21 [get_ports FMC_R21]

set_property PACKAGE_PIN T19 [get_ports FMC_T19]


# -----------------------------------------------------------------------------
# I/O Standard
# -----------------------------------------------------------------------------

set_property IOSTANDARD LVCMOS18 [get_ports {
    FMC_B16 FMC_B17 FMC_B19 FMC_B20 FMC_B21 FMC_B22
    FMC_C17 FMC_C18 FMC_C20 FMC_C22
    FMC_D15 FMC_D20 FMC_D21 FMC_D22
    FMC_E15 FMC_E18 FMC_E21
    FMC_F18 FMC_F19
    FMC_G19 FMC_G20 FMC_G21
    FMC_J18 FMC_J21 FMC_J22
    FMC_K18 FMC_K19 FMC_K20
    FMC_L17 FMC_L21 FMC_L22
    FMC_M17 FMC_M19 FMC_M20
    FMC_N19 FMC_N20 FMC_N22
    FMC_P22
    FMC_R19 FMC_R20 FMC_R21
    FMC_T19
}]


# -----------------------------------------------------------------------------
# Output Slew Rate
# -----------------------------------------------------------------------------

set_property SLEW FAST [get_ports {
    FMC_B16 FMC_B17 FMC_B19 FMC_B20 FMC_B21 FMC_B22
    FMC_C17 FMC_C18 FMC_C20 FMC_C22
    FMC_D15 FMC_D20 FMC_D21 FMC_D22
    FMC_E15 FMC_E18 FMC_E21
    FMC_F18 FMC_F19
    FMC_G19 FMC_G20 FMC_G21
    FMC_J18 FMC_J21 FMC_J22
    FMC_K18 FMC_K19 FMC_K20
    FMC_L17 FMC_L21 FMC_L22
    FMC_M17 FMC_M19 FMC_M20
    FMC_N19 FMC_N20 FMC_N22
    FMC_P22
    FMC_R19 FMC_R20 FMC_R21
    FMC_T19
}]
