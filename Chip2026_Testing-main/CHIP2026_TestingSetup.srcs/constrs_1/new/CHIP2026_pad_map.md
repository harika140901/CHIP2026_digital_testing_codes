# CHIP 2026 Pad Mapping Reference

This document captures the pad ring information from the CHIP 2026 pad placement sheet and aligns it with the existing FPGA-level pin assignment file in this project.

## Core pad groups

- Power / ground
  - VDDQ
  - VDD
  - VSS
  - GND

- Digital pads
  - PAD_D0, PAD_D1
  - PAD_DI
  - PAD_DO
  - PAD_IO_0 ... PAD_IO_N
  - PAD_CI, PAD_CO
  - PAD_AN

- Scan / control pads
  - SCN_IN
  - SCN_OUT
  - CLKA
  - CLKB
  - IN_EN
  - MUX_OUT
  - SAMPLE_E
  - DFF_RST
  - CONTROL_EN
  - MUX_OUT_PAD

## Intended mapping interpretation

The pad map shows a chip-level pad ring used for the digital testing design. The Vivado constraint file in this repo is the board implementation layer for those chip pads, and the FPGA FMC pins are the external physical representation of the same pad ring plan.

In other words:

- the chip pad plan defines the logical grouping and signal names at the die level
- the FMC constraints define how these signals are routed to board package pins for testing
- the HDL modules continue to use the board-oriented signal names (`FMC_*`, `SCN_*`, control nets) while the underlying chip pad plan follows the CHIP 2026 naming shown in the pad image

## Representative pad list from the reference image

| Group | Example pad names |
| --- | --- |
| Power | VDDQ, VDD, VSS, GND |
| Data | PAD_D0, PAD_D1, PAD_DI, PAD_DO |
| IO | PAD_IO_0, PAD_IO_1, PAD_IO_2, PAD_IO_N |
| Control | PAD_CI, PAD_CO, PAD_AN |
| Scan | SCN_IN, SCN_OUT, CLKA, CLKB, IN_EN |
| Test | SAMPLE_E, DFF_RST, MUX_OUT, CONTROL_EN |

## Status in this repo

The board-level constraints file `CHIP2026_TestingSetup.srcs/constrs_1/new/constraints_v1.xdc` has been annotated to note this pad-ring interpretation so future designers can correlate the chip-level pad map with the FPGA package pin mapping.
