project_open -current_revision $quartus(args)

# Analysis & Synthesis Assignments
# ================================
set_global_assignment -name FAMILY "Cyclone III"
 
# Fitter Assignments
# ==================
set_global_assignment -name DEVICE EP3C25F324C8


set_location_assignment PIN_V9 -to osc_clk
set_location_assignment PIN_N2 -to reset_n
set_location_assignment PIN_U2 -to mem_clk
set_location_assignment PIN_V2 -to mem_clk_n
set_location_assignment PIN_V1 -to mem_cs_n
set_location_assignment PIN_R13 -to mem_cke
set_location_assignment PIN_U1 -to mem_addr[0]
set_location_assignment PIN_U5 -to mem_addr[1]
set_location_assignment PIN_U7 -to mem_addr[2]
set_location_assignment PIN_U8 -to mem_addr[3]
set_location_assignment PIN_P8 -to mem_addr[4]
set_location_assignment PIN_P7 -to mem_addr[5]
set_location_assignment PIN_P6 -to mem_addr[6]
set_location_assignment PIN_T14 -to mem_addr[7]
set_location_assignment PIN_T13 -to mem_addr[8]
set_location_assignment PIN_V13 -to mem_addr[9]
set_location_assignment PIN_U17 -to mem_addr[10]
set_location_assignment PIN_V17 -to mem_addr[11]
set_location_assignment PIN_U16 -to mem_addr[12]
set_location_assignment PIN_V11 -to mem_ba[0]
set_location_assignment PIN_V12 -to mem_ba[1]
set_location_assignment PIN_V16 -to mem_ras_n
set_location_assignment PIN_T4 -to mem_cas_n
set_location_assignment PIN_U15 -to mem_we_n
set_location_assignment PIN_U4 -to mem_dq[0]
set_location_assignment PIN_V4 -to mem_dq[1]
set_location_assignment PIN_R8 -to mem_dq[2]
set_location_assignment PIN_V5 -to mem_dq[3]
set_location_assignment PIN_P9 -to mem_dq[4]
set_location_assignment PIN_U6 -to mem_dq[5]
set_location_assignment PIN_V6 -to mem_dq[6]
set_location_assignment PIN_V7 -to mem_dq[7]
set_location_assignment PIN_U13 -to mem_dq[8]
set_location_assignment PIN_U12 -to mem_dq[9]
set_location_assignment PIN_U11 -to mem_dq[10]
set_location_assignment PIN_V15 -to mem_dq[11]
set_location_assignment PIN_U14 -to mem_dq[12]
set_location_assignment PIN_R11 -to mem_dq[13]
set_location_assignment PIN_P10 -to mem_dq[14]
set_location_assignment PIN_V14 -to mem_dq[15]
set_location_assignment PIN_U3 -to mem_dqs[0]
set_location_assignment PIN_T8 -to mem_dqs[1]
set_location_assignment PIN_V3 -to mem_dm[0]
set_location_assignment PIN_V8 -to mem_dm[1]
set_location_assignment PIN_D18 -to flash_wr_n
set_location_assignment PIN_E2 -to flash_cs_n
set_location_assignment PIN_D17 -to flash_oe_n
set_location_assignment PIN_C3 -to flash_reset_n
set_location_assignment PIN_A6 -to flash_ssram_a[20]
set_location_assignment PIN_B18 -to flash_ssram_a[21]
set_location_assignment PIN_C17 -to flash_ssram_a[22]
set_location_assignment PIN_C18 -to flash_ssram_a[23]
set_location_assignment PIN_G14 -to flash_ssram_a[24]
set_location_assignment PIN_B17 -to flash_ssram_a[25]
set_location_assignment PIN_E12 -to flash_ssram_a[1]
set_location_assignment PIN_A16 -to flash_ssram_a[2]
set_location_assignment PIN_B16 -to flash_ssram_a[3]
set_location_assignment PIN_A15 -to flash_ssram_a[4]
set_location_assignment PIN_B15 -to flash_ssram_a[5]
set_location_assignment PIN_A14 -to flash_ssram_a[6]
set_location_assignment PIN_B14 -to flash_ssram_a[7]
set_location_assignment PIN_A13 -to flash_ssram_a[8]
set_location_assignment PIN_B13 -to flash_ssram_a[9]
set_location_assignment PIN_A12 -to flash_ssram_a[10]
set_location_assignment PIN_B12 -to flash_ssram_a[11]
set_location_assignment PIN_A11 -to flash_ssram_a[12]
set_location_assignment PIN_B11 -to flash_ssram_a[13]
set_location_assignment PIN_C10 -to flash_ssram_a[14]
set_location_assignment PIN_D10 -to flash_ssram_a[15]
set_location_assignment PIN_E10 -to flash_ssram_a[16]
set_location_assignment PIN_C9 -to flash_ssram_a[17]
set_location_assignment PIN_D9 -to flash_ssram_a[18]
set_location_assignment PIN_A7 -to flash_ssram_a[19]
set_location_assignment PIN_H3 -to flash_ssram_d[0]
set_location_assignment PIN_D1 -to flash_ssram_d[1]
set_location_assignment PIN_D2 -to flash_ssram_d[19]
set_location_assignment PIN_A8 -to flash_ssram_d[2]
set_location_assignment PIN_B8 -to flash_ssram_d[3]
set_location_assignment PIN_B7 -to flash_ssram_d[4]
set_location_assignment PIN_C5 -to flash_ssram_d[5]
set_location_assignment PIN_E8 -to flash_ssram_d[6]
set_location_assignment PIN_A4 -to flash_ssram_d[7]
set_location_assignment PIN_B4 -to flash_ssram_d[8]
set_location_assignment PIN_E7 -to flash_ssram_d[9]
set_location_assignment PIN_A3 -to flash_ssram_d[10]
set_location_assignment PIN_B3 -to flash_ssram_d[11]
set_location_assignment PIN_D5 -to flash_ssram_d[12]
set_location_assignment PIN_B5 -to flash_ssram_d[13]
set_location_assignment PIN_A5 -to flash_ssram_d[14]
set_location_assignment PIN_B6 -to flash_ssram_d[15]
set_location_assignment PIN_C16 -to flash_ssram_d[16]
set_location_assignment PIN_D12 -to flash_ssram_d[17]
set_location_assignment PIN_E11 -to flash_ssram_d[18]
set_location_assignment PIN_E13 -to flash_ssram_d[20]
set_location_assignment PIN_E14 -to flash_ssram_d[21]
set_location_assignment PIN_A17 -to flash_ssram_d[22]
set_location_assignment PIN_D16 -to flash_ssram_d[23]
set_location_assignment PIN_C12 -to flash_ssram_d[24]
set_location_assignment PIN_A18 -to flash_ssram_d[25]
set_location_assignment PIN_F8 -to flash_ssram_d[26]
set_location_assignment PIN_D7 -to flash_ssram_d[27]
set_location_assignment PIN_F6 -to flash_ssram_d[28]
set_location_assignment PIN_E6 -to flash_ssram_d[29]
set_location_assignment PIN_G6 -to flash_ssram_d[30]
set_location_assignment PIN_C7 -to flash_ssram_d[31]
set_location_assignment PIN_E9 -to ssram_oe_n
set_location_assignment PIN_F9 -to ssram_ce_n
set_location_assignment PIN_F10 -to ssram_bw_n[0]
set_location_assignment PIN_F11 -to ssram_bw_n[1]
set_location_assignment PIN_F12 -to ssram_bw_n[2]
set_location_assignment PIN_F13 -to ssram_bw_n[3]
set_location_assignment PIN_F7 -to ssram_adsc_n
set_location_assignment PIN_G13 -to ssram_bwe_n
set_location_assignment PIN_F1 -to button[0]
set_location_assignment PIN_F2 -to button[1]
set_location_assignment PIN_A10 -to button[2]
set_location_assignment PIN_B10 -to button[3]
set_location_assignment PIN_P13 -to led[0]
#Set to a pin that routes out to the TV decoder. This is because P12 is not valid.
set_location_assignment PIN_T1 -to led[1]
set_location_assignment PIN_N12 -to led[2]
set_location_assignment PIN_N9 -to led[3]
set_location_assignment PIN_A2 -to ssram_clk
set_location_assignment PIN_A2 -to pll_c1_out
#set_location_assignment PIN_H5 -to reconfig_request_pio
set_instance_assignment -name VIRTUAL_PIN ON -to flash_ssram_a[0]

#According to HSMC connector name.
set_location_assignment PIN_A1 -to hsmc_clk
set_location_assignment PIN_D14 -to pll_c0_out
set_location_assignment PIN_D14 -to cpu_clk
set_location_assignment PIN_K17 -to HSMC_D16
set_location_assignment PIN_P11 -to HSMC_D18
set_location_assignment PIN_B2 -to HSMC_TX_p4
set_location_assignment PIN_B1 -to HSMC_TX_n4
set_location_assignment PIN_G2 -to HSMC_TX_p5
set_location_assignment PIN_G1 -to HSMC_TX_n5
set_location_assignment PIN_K2 -to HSMC_TX_p6
set_location_assignment PIN_K1 -to HSMC_TX_n6
set_location_assignment PIN_L2 -to HSMC_TX_p7
set_location_assignment PIN_L1 -to HSMC_TX_n7
set_location_assignment PIN_C14 -to HSMC_CLKOUT_n1
set_location_assignment PIN_N8 -to HSMC_D8
set_location_assignment PIN_J13 -to HSMC_D10
set_location_assignment PIN_N10 -to HSMC_D12
set_location_assignment PIN_N11 -to HSMC_D14
set_location_assignment PIN_M3 -to HSMC_D5
set_location_assignment PIN_T2 -to HSMC_D7
set_location_assignment PIN_H15 -to HSMC_D9
set_location_assignment PIN_H16 -to HSMC_D11
set_location_assignment PIN_N16 -to HSMC_D13
set_location_assignment PIN_N15 -to HSMC_D15
set_location_assignment PIN_R16 -to HSMC_D17
set_location_assignment PIN_T16 -to HSMC_D19
set_location_assignment PIN_L6 -to HSMC_D3
set_location_assignment PIN_D3 -to HSMC_D1
set_location_assignment PIN_F18 -to HSMC_CLKIN_n1
set_location_assignment PIN_N7 -to HSMC_D6
set_location_assignment PIN_T1 -to HSMC_D4
set_location_assignment PIN_A9 -to HSMC_CLKIN0
set_location_assignment PIN_M5 -to HSMC_D2
set_location_assignment PIN_H6 -to HSMC_D0
set_location_assignment PIN_P18 -to HSMC_TX_n14
set_location_assignment PIN_A1 -to HSMC_CLKOUT0
set_location_assignment PIN_E18 -to HSMC_TX_n10
set_location_assignment PIN_H1 -to HSMC_RX_n5
set_location_assignment PIN_C2 -to HSMC_RX_p4
set_location_assignment PIN_R2 -to HSMC_TX_p9
set_location_assignment PIN_M1 -to HSMC_TX_n8
set_location_assignment PIN_M2 -to HSMC_TX_p8
set_location_assignment PIN_F3 -to HSMC_SCL
set_location_assignment PIN_E1 -to HSMC_SDA
set_location_assignment PIN_R1 -to HSMC_TX_n9
set_location_assignment PIN_C1 -to HSMC_RX_n4
set_location_assignment PIN_H2 -to HSMC_RX_p5
set_location_assignment PIN_E17 -to HSMC_TX_p10
set_location_assignment PIN_L17 -to HSMC_TX_p12
set_location_assignment PIN_M18 -to HSMC_TX_n12
set_location_assignment PIN_L14 -to HSMC_TX_p13
set_location_assignment PIN_L15 -to HSMC_TX_n13
set_location_assignment PIN_P2 -to HSMC_RX_p8
set_location_assignment PIN_P1 -to HSMC_RX_n8
set_location_assignment PIN_T3 -to HSMC_RX_p9
set_location_assignment PIN_R3 -to HSMC_RX_n9
set_location_assignment PIN_N18 -to HSMC_CLKIN_n2
set_location_assignment PIN_F17 -to HSMC_CLKIN_p1
set_location_assignment PIN_H18 -to HSMC_TX_n11
set_location_assignment PIN_L5 -to HSMC_RX_n6
set_location_assignment PIN_L3 -to HSMC_RX_n7
set_location_assignment PIN_L4 -to HSMC_RX_p7
set_location_assignment PIN_K5 -to HSMC_RX_p6
set_location_assignment PIN_G18 -to HSMC_RX_n10
set_location_assignment PIN_P17 -to HSMC_TX_p14
set_location_assignment PIN_H17 -to HSMC_TX_p11
set_location_assignment PIN_R4 -to HSMC_TX_n15
set_location_assignment PIN_T17 -to HSMC_TX_p16
set_location_assignment PIN_T18 -to HSMC_TX_n16
set_location_assignment PIN_L16 -to HSMC_RX_p12
set_location_assignment PIN_M17 -to HSMC_RX_n12
set_location_assignment PIN_N6 -to HSMC_RX_n15
set_location_assignment PIN_M13 -to HSMC_RX_p16
set_location_assignment PIN_N13 -to HSMC_RX_n16
set_location_assignment PIN_D14 -to HSMC_CLKOUT_p1
set_location_assignment PIN_R17 -to HSMC_RX_p14
set_location_assignment PIN_M14 -to HSMC_RX_n13
set_location_assignment PIN_L13 -to HSMC_RX_p13
set_location_assignment PIN_R18 -to HSMC_RX_n14
set_location_assignment PIN_M6 -to HSMC_RX_p15
set_location_assignment PIN_K18 -to HSMC_RX_p11
set_location_assignment PIN_N17 -to HSMC_CLKIN_p2
set_location_assignment PIN_L18 -to HSMC_RX_n11
set_location_assignment PIN_G17 -to HSMC_RX_p10
set_location_assignment PIN_U18 -to HSMC_CLKOUT_p2
set_location_assignment PIN_V18 -to HSMC_CLKOUT_n2
set_location_assignment PIN_R5 -to HSMC_TX_p15

#According to device that it's connected to.
set_location_assignment PIN_K17 -to HC_VGA_DATA[0]
set_location_assignment PIN_P11 -to HC_VGA_DATA[1]
set_location_assignment PIN_B2 -to HC_VGA_DATA[2]
set_location_assignment PIN_B1 -to HC_VGA_DATA[3]
set_location_assignment PIN_G2 -to HC_VGA_DATA[4]
set_location_assignment PIN_G1 -to HC_VGA_DATA[5]
set_location_assignment PIN_K2 -to HC_VGA_DATA[6]
set_location_assignment PIN_K1 -to HC_VGA_DATA[7]
set_location_assignment PIN_L2 -to HC_VGA_DATA[8]
set_location_assignment PIN_L1 -to HC_VGA_DATA[9]
set_location_assignment PIN_C14 -to HC_VGA_CLOCK
set_location_assignment PIN_H15 -to HC_VGA_HS
set_location_assignment PIN_J13 -to HC_VGA_VS
set_location_assignment PIN_N10 -to HC_VGA_BLANK
set_location_assignment PIN_N11 -to HC_VGA_SYNC
set_location_assignment PIN_H16 -to HC_TD_D[0]
set_location_assignment PIN_N16 -to HC_TD_D[1]
set_location_assignment PIN_N15 -to HC_TD_D[2]
set_location_assignment PIN_R16 -to HC_TD_D[3]
set_location_assignment PIN_T16 -to HC_TD_D[4]
set_location_assignment PIN_C2 -to HC_TD_D[5]
set_location_assignment PIN_C1 -to HC_TD_D[6]
set_location_assignment PIN_H2 -to HC_TD_D[7]
set_location_assignment PIN_L5 -to HC_TD_HS
set_location_assignment PIN_K5 -to HC_TD_VS
set_location_assignment PIN_F18 -to HC_TD_27MHZ
set_location_assignment PIN_H1 -to HC_TD_RESET
set_location_assignment PIN_M1 -to HC_AUD_ADCLRCK
set_location_assignment PIN_A9 -to HC_AUD_ADCDAT
set_location_assignment PIN_R2 -to HC_AUD_DACLRCK
set_location_assignment PIN_R1 -to HC_AUD_DACDAT
set_location_assignment PIN_E17 -to HC_AUD_BCLK
set_location_assignment PIN_A1 -to HC_AUD_XCK
set_location_assignment PIN_H17 -to HC_UART_TXD
set_location_assignment PIN_E18 -to HC_UART_RXD
set_location_assignment PIN_M3 -to HC_SD_DAT
set_location_assignment PIN_N8 -to HC_SD_DAT3
set_location_assignment PIN_L6 -to HC_SD_CMD
set_location_assignment PIN_M2 -to HC_SD_CLK
set_location_assignment PIN_E1 -to HC_I2C_SDAT
set_location_assignment PIN_F3 -to HC_I2C_SCLK
set_location_assignment PIN_H6 -to HC_ID_I2CSCL
set_location_assignment PIN_D3 -to HC_ID_I2CDAT
set_location_assignment PIN_T1 -to HC_PS2_DAT
set_location_assignment PIN_M5 -to HC_PS2_CLK
set_location_assignment PIN_M18 -to HC_TX_D[0]
set_location_assignment PIN_L14 -to HC_TX_D[1]
set_location_assignment PIN_L15 -to HC_TX_D[2]
set_location_assignment PIN_P17 -to HC_TX_D[3]
set_location_assignment PIN_P2 -to HC_RX_D[0]
set_location_assignment PIN_P1 -to HC_RX_D[1]
set_location_assignment PIN_T3 -to HC_RX_D[2]
set_location_assignment PIN_R3 -to HC_RX_D[3]
set_location_assignment PIN_N18 -to HC_TX_CLK
set_location_assignment PIN_F17 -to HC_RX_CLK
set_location_assignment PIN_L17 -to HC_TX_EN
set_location_assignment PIN_G18 -to HC_RX_DV
set_location_assignment PIN_L3 -to HC_RX_CRS
set_location_assignment PIN_L4 -to HC_RX_ERR
set_location_assignment PIN_G17 -to HC_RX_COL
set_location_assignment PIN_N7 -to HC_MDIO
set_location_assignment PIN_P18 -to HC_MDC
set_location_assignment PIN_H18 -to HC_ETH_RESET_N
set_location_assignment PIN_R4 -to HC_LCD_DATA[0]
set_location_assignment PIN_T17 -to HC_LCD_DATA[1]
set_location_assignment PIN_T18 -to HC_LCD_DATA[2]
set_location_assignment PIN_L16 -to HC_LCD_DATA[3]
set_location_assignment PIN_M17 -to HC_LCD_DATA[4]
set_location_assignment PIN_N6 -to HC_LCD_DATA[5]
set_location_assignment PIN_M13 -to HC_LCD_DATA[6]
set_location_assignment PIN_N13 -to HC_LCD_DATA[7]
set_location_assignment PIN_D14 -to HC_NCLK
set_location_assignment PIN_R17 -to HC_DEN
set_location_assignment PIN_M14 -to HC_HD
set_location_assignment PIN_L13 -to HC_VD
set_location_assignment PIN_R18 -to HC_GREST
set_location_assignment PIN_M6 -to HC_SCEN
set_location_assignment PIN_T2 -to HC_SDA
set_location_assignment PIN_N17 -to HC_ADC_PENIRQ_N
set_location_assignment PIN_L18 -to HC_ADC_DOUT
set_location_assignment PIN_K18 -to HC_ADC_BUSY
set_location_assignment PIN_U18 -to HC_ADC_DIN
set_location_assignment PIN_V18 -to HC_ADC_DCLK
set_location_assignment PIN_R5 -to HC_ADC_CS_N
project_close
