//Legal Notice: (C)2008 Altera Corporation. All rights reserved.  Your
//use of Altera Corporation's design tools, logic functions and other
//software and tools, and its AMPP partner logic functions, and any
//output files any of the foregoing (including device programming or
//simulation files), and any associated documentation or information are
//expressly subject to the terms and conditions of the Altera Program
//License Subscription Agreement or other applicable license agreement,
//including, without limitation, that your use is for the sole purpose
//of programming logic devices manufactured by Altera and sold by Altera
//or its authorized distributors.  Please refer to the applicable
//agreement for further details.

// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module cycloneIII_3c25_niosII_video (
                                      // inputs:
                                       top_HC_ADC_DOUT,
                                       top_HC_ADC_PENIRQ_N,
                                       top_HC_RX_CLK,
                                       top_HC_RX_COL,
                                       top_HC_RX_CRS,
                                       top_HC_RX_D,
                                       top_HC_RX_DV,
                                       top_HC_RX_ERR,
                                       top_HC_SD_DAT,
                                       top_HC_TX_CLK,
                                       top_HC_UART_RXD,
                                       top_button,
                                       top_clkin_50,
                                       top_reset_n,

                                      // outputs:
                                       top_HC_ADC_CS_N,
                                       top_HC_ADC_DCLK,
                                       top_HC_ADC_DIN,
                                       top_HC_DEN,
                                       top_HC_ETH_RESET_N,
                                       top_HC_HD,
                                       top_HC_ID_I2CDAT,
                                       top_HC_ID_I2CSCL,
                                       top_HC_LCD_DATA,
                                       top_HC_MDC,
                                       top_HC_MDIO,
                                       top_HC_SCEN,
                                       top_HC_SDA,
                                       top_HC_SD_CLK,
                                       top_HC_SD_CMD,
                                       top_HC_SD_DAT3,
                                       top_HC_TX_D,
                                       top_HC_TX_EN,
                                       top_HC_UART_TXD,
                                       top_HC_VD,
                                       top_clk_to_offchip_video,
                                       top_flash_cs_n,
                                       top_flash_oe_n,
                                       top_flash_reset_n,
                                       top_flash_ssram_a,
                                       top_flash_ssram_d,
                                       top_flash_wr_n,
                                       top_led,
                                       top_mem_addr,
                                       top_mem_ba,
                                       top_mem_cas_n,
                                       top_mem_cke,
                                       top_mem_clk,
                                       top_mem_clk_n,
                                       top_mem_cs_n,
                                       top_mem_dm,
                                       top_mem_dq,
                                       top_mem_dqs,
                                       top_mem_ras_n,
                                       top_mem_we_n,
                                       top_ssram_adsc_n,
                                       top_ssram_bw_n,
                                       top_ssram_bwe_n,
                                       top_ssram_ce_n,
                                       top_ssram_clk,
                                       top_ssram_oe_n
                                    )
;

  output           top_HC_ADC_CS_N;
  output           top_HC_ADC_DCLK;
  output           top_HC_ADC_DIN;
  output           top_HC_DEN;
  output           top_HC_ETH_RESET_N;
  output           top_HC_HD;
  inout            top_HC_ID_I2CDAT;
  output           top_HC_ID_I2CSCL;
  output  [  7: 0] top_HC_LCD_DATA;
  output           top_HC_MDC;
  inout            top_HC_MDIO;
  output           top_HC_SCEN;
  inout            top_HC_SDA;
  output           top_HC_SD_CLK;
  output           top_HC_SD_CMD;
  output           top_HC_SD_DAT3;
  output  [  3: 0] top_HC_TX_D;
  output           top_HC_TX_EN;
  output           top_HC_UART_TXD;
  output           top_HC_VD;
  output           top_clk_to_offchip_video;
  output           top_flash_cs_n;
  output           top_flash_oe_n;
  output           top_flash_reset_n;
  output  [ 23: 0] top_flash_ssram_a;
  inout   [ 31: 0] top_flash_ssram_d;
  output           top_flash_wr_n;
  output  [  1: 0] top_led;
  output  [ 12: 0] top_mem_addr;
  output  [  1: 0] top_mem_ba;
  output           top_mem_cas_n;
  output           top_mem_cke;
  inout            top_mem_clk;
  inout            top_mem_clk_n;
  output           top_mem_cs_n;
  output  [  1: 0] top_mem_dm;
  inout   [ 15: 0] top_mem_dq;
  inout   [  1: 0] top_mem_dqs;
  output           top_mem_ras_n;
  output           top_mem_we_n;
  output           top_ssram_adsc_n;
  output  [  3: 0] top_ssram_bw_n;
  output           top_ssram_bwe_n;
  output           top_ssram_ce_n;
  output           top_ssram_clk;
  output           top_ssram_oe_n;
  input            top_HC_ADC_DOUT;
  input            top_HC_ADC_PENIRQ_N;
  input            top_HC_RX_CLK;
  input            top_HC_RX_COL;
  input            top_HC_RX_CRS;
  input   [  3: 0] top_HC_RX_D;
  input            top_HC_RX_DV;
  input            top_HC_RX_ERR;
  input            top_HC_SD_DAT;
  input            top_HC_TX_CLK;
  input            top_HC_UART_RXD;
  input   [  3: 0] top_button;
  input            top_clkin_50;
  input            top_reset_n;

  wire             top_CDn_to_the_el_camino_sd_card_controller;
  wire             top_HC_ADC_CS_N;
  wire             top_HC_ADC_DCLK;
  wire             top_HC_ADC_DIN;
  wire             top_HC_DEN;
  wire             top_HC_ETH_RESET_N;
  wire             top_HC_HD;
  wire             top_HC_ID_I2CDAT;
  wire             top_HC_ID_I2CSCL;
  wire    [  7: 0] top_HC_LCD_DATA;
  wire             top_HC_MDC;
  wire             top_HC_MDIO;
  wire             top_HC_SCEN;
  wire             top_HC_SDA;
  wire             top_HC_SD_CLK;
  wire             top_HC_SD_CMD;
  wire             top_HC_SD_DAT3;
  wire    [  3: 0] top_HC_TX_D;
  wire             top_HC_TX_EN;
  wire             top_HC_UART_TXD;
  wire             top_HC_VD;
  wire             top_SCLK_from_the_touch_panel_spi;
  wire             top_SS_n_from_the_touch_panel_spi;
  wire             top_WP_to_the_el_camino_sd_card_controller;
  wire             top_clk_to_offchip_video;
  wire             top_ddr_sdram_aux_full_rate_clk_out;
  wire             top_ddr_sdram_aux_half_rate_clk_out;
  wire             top_ddr_sdram_phy_clk_out;
  wire             top_ena_10_from_the_tse_mac;
  wire             top_eth_mode_from_the_tse_mac;
  wire             top_flash_cs_n;
  wire             top_flash_oe_n;
  wire             top_flash_reset_n;
  wire    [ 23: 0] top_flash_ssram_a;
  wire    [ 31: 0] top_flash_ssram_d;
  wire             top_flash_wr_n;
  wire    [  7: 0] top_gm_rx_d_to_the_tse_mac;
  wire             top_gm_rx_dv_to_the_tse_mac;
  wire             top_gm_rx_err_to_the_tse_mac;
  wire    [  7: 0] top_gm_tx_d_from_the_tse_mac;
  wire             top_gm_tx_en_from_the_tse_mac;
  wire             top_gm_tx_err_from_the_tse_mac;
  wire    [  3: 0] top_in_port_to_the_button_pio;
  wire    [  1: 0] top_led;
  wire             top_local_init_done_from_the_ddr_sdram;
  wire             top_local_refresh_ack_from_the_ddr_sdram;
  wire             top_local_wdata_req_from_the_ddr_sdram;
  wire             top_m_rx_col_to_the_tse_mac;
  wire             top_m_rx_crs_to_the_tse_mac;
  wire    [  3: 0] top_m_rx_d_to_the_tse_mac;
  wire             top_m_rx_en_to_the_tse_mac;
  wire             top_m_rx_err_to_the_tse_mac;
  wire    [  3: 0] top_m_tx_d_from_the_tse_mac;
  wire             top_m_tx_en_from_the_tse_mac;
  wire             top_m_tx_err_from_the_tse_mac;
  wire             top_mdc_from_the_tse_mac;
  wire             top_mdio_in;
  wire             top_mdio_in_to_the_tse_mac;
  wire             top_mdio_oen;
  wire             top_mdio_oen_from_the_tse_mac;
  wire             top_mdio_out;
  wire             top_mdio_out_from_the_tse_mac;
  wire    [ 12: 0] top_mem_addr;
  wire    [  1: 0] top_mem_ba;
  wire             top_mem_cas_n;
  wire             top_mem_cke;
  wire             top_mem_clk;
  wire             top_mem_clk_n;
  wire             top_mem_cs_n;
  wire    [  1: 0] top_mem_dm;
  wire    [ 15: 0] top_mem_dq;
  wire    [  1: 0] top_mem_dqs;
  wire             top_mem_ras_n;
  wire             top_mem_we_n;
  wire             top_out_port_from_the_lcd_i2c_en;
  wire             top_out_port_from_the_lcd_i2c_scl;
  wire             top_peripheral_clk;
  wire             top_remote_update_clk;
  wire             top_reset_phy_clk_n_from_the_ddr_sdram;
  wire             top_rx_clk_to_the_tse_mac;
  wire             top_set_1000_to_the_tse_mac;
  wire             top_set_10_to_the_tse_mac;
  wire             top_ssram_adsc_n;
  wire    [  3: 0] top_ssram_bw_n;
  wire             top_ssram_bwe_n;
  wire             top_ssram_ce_n;
  wire             top_ssram_clk;
  wire             top_ssram_oe_n;
  wire             top_tx_clk_to_the_tse_mac;
  cycloneIII_3c25_niosII_video_sopc cycloneIII_3c25_niosII_video_sopc_instance
    (
      .CDn_to_the_el_camino_sd_card_controller (top_CDn_to_the_el_camino_sd_card_controller),
      .CSn_from_the_el_camino_sd_card_controller (top_HC_SD_DAT3),
      .DEN_from_the_lcd_sync_generator (top_HC_DEN),
      .DI_from_the_el_camino_sd_card_controller (top_HC_SD_CMD),
      .DO_to_the_el_camino_sd_card_controller (top_HC_SD_DAT),
      .HD_from_the_lcd_sync_generator (top_HC_HD),
      .MISO_to_the_touch_panel_spi (top_HC_ADC_DOUT),
      .MOSI_from_the_touch_panel_spi (top_HC_ADC_DIN),
      .RGB_OUT_from_the_lcd_sync_generator (top_HC_LCD_DATA),
      .SCLK_from_the_el_camino_sd_card_controller (top_HC_SD_CLK),
      .SCLK_from_the_touch_panel_spi (top_SCLK_from_the_touch_panel_spi),
      .SS_n_from_the_touch_panel_spi (top_SS_n_from_the_touch_panel_spi),
      .VD_from_the_lcd_sync_generator (top_HC_VD),
      .WP_to_the_el_camino_sd_card_controller (top_WP_to_the_el_camino_sd_card_controller),
      .adsc_n_to_the_ssram (top_ssram_adsc_n),
      .bidir_port_to_and_from_the_lcd_i2c_sdat (top_HC_SDA),
      .bidir_port_to_and_from_the_pio_id_eeprom_dat (top_HC_ID_I2CDAT),
      .bw_n_to_the_ssram (top_ssram_bw_n),
      .bwe_n_to_the_ssram (top_ssram_bwe_n),
      .chipenable1_n_to_the_ssram (top_ssram_ce_n),
      .clk (top_clkin_50),
      .ddr_sdram_aux_full_rate_clk_out (top_ddr_sdram_aux_full_rate_clk_out),
      .ddr_sdram_aux_half_rate_clk_out (top_ddr_sdram_aux_half_rate_clk_out),
      .ddr_sdram_phy_clk_out (top_ddr_sdram_phy_clk_out),
      .ena_10_from_the_tse_mac (top_ena_10_from_the_tse_mac),
      .eth_mode_from_the_tse_mac (top_eth_mode_from_the_tse_mac),
      .flash_ssram_tristate_bridge_address (top_flash_ssram_a),
      .flash_ssram_tristate_bridge_data (top_flash_ssram_d),
      .global_reset_n_to_the_ddr_sdram (top_reset_n),
      .gm_rx_d_to_the_tse_mac (top_gm_rx_d_to_the_tse_mac),
      .gm_rx_dv_to_the_tse_mac (top_gm_rx_dv_to_the_tse_mac),
      .gm_rx_err_to_the_tse_mac (top_gm_rx_err_to_the_tse_mac),
      .gm_tx_d_from_the_tse_mac (top_gm_tx_d_from_the_tse_mac),
      .gm_tx_en_from_the_tse_mac (top_gm_tx_en_from_the_tse_mac),
      .gm_tx_err_from_the_tse_mac (top_gm_tx_err_from_the_tse_mac),
      .in_port_to_the_button_pio (top_in_port_to_the_button_pio),
      .in_port_to_the_touch_panel_pen_irq_n (top_HC_ADC_PENIRQ_N),
      .local_init_done_from_the_ddr_sdram (top_local_init_done_from_the_ddr_sdram),
      .local_refresh_ack_from_the_ddr_sdram (top_local_refresh_ack_from_the_ddr_sdram),
      .local_wdata_req_from_the_ddr_sdram (top_local_wdata_req_from_the_ddr_sdram),
      .m_rx_col_to_the_tse_mac (top_m_rx_col_to_the_tse_mac),
      .m_rx_crs_to_the_tse_mac (top_m_rx_crs_to_the_tse_mac),
      .m_rx_d_to_the_tse_mac (top_m_rx_d_to_the_tse_mac),
      .m_rx_en_to_the_tse_mac (top_m_rx_en_to_the_tse_mac),
      .m_rx_err_to_the_tse_mac (top_m_rx_err_to_the_tse_mac),
      .m_tx_d_from_the_tse_mac (top_m_tx_d_from_the_tse_mac),
      .m_tx_en_from_the_tse_mac (top_m_tx_en_from_the_tse_mac),
      .m_tx_err_from_the_tse_mac (top_m_tx_err_from_the_tse_mac),
      .mdc_from_the_tse_mac (top_mdc_from_the_tse_mac),
      .mdio_in_to_the_tse_mac (top_mdio_in_to_the_tse_mac),
      .mdio_oen_from_the_tse_mac (top_mdio_oen_from_the_tse_mac),
      .mdio_out_from_the_tse_mac (top_mdio_out_from_the_tse_mac),
      .mem_addr_from_the_ddr_sdram (top_mem_addr),
      .mem_ba_from_the_ddr_sdram (top_mem_ba),
      .mem_cas_n_from_the_ddr_sdram (top_mem_cas_n),
      .mem_cke_from_the_ddr_sdram (top_mem_cke),
      .mem_clk_n_to_and_from_the_ddr_sdram (top_mem_clk_n),
      .mem_clk_to_and_from_the_ddr_sdram (top_mem_clk),
      .mem_cs_n_from_the_ddr_sdram (top_mem_cs_n),
      .mem_dm_from_the_ddr_sdram (top_mem_dm),
      .mem_dq_to_and_from_the_ddr_sdram (top_mem_dq),
      .mem_dqs_to_and_from_the_ddr_sdram (top_mem_dqs),
      .mem_ras_n_from_the_ddr_sdram (top_mem_ras_n),
      .mem_we_n_from_the_ddr_sdram (top_mem_we_n),
      .out_port_from_the_lcd_i2c_en (top_out_port_from_the_lcd_i2c_en),
      .out_port_from_the_lcd_i2c_scl (top_out_port_from_the_lcd_i2c_scl),
      .out_port_from_the_led_pio (top_led),
      .out_port_from_the_pio_id_eeprom_scl (top_HC_ID_I2CSCL),
      .outputenable_n_to_the_ssram (top_ssram_oe_n),
      .pll_c0_out (top_clk_to_offchip_video),
      .pll_c1_out (top_ssram_clk),
      .pll_c2_out (top_peripheral_clk),
      .pll_c3_out (top_remote_update_clk),
      .read_n_to_the_ext_flash (top_flash_oe_n),
      .reset_n (top_reset_n),
      .reset_phy_clk_n_from_the_ddr_sdram (top_reset_phy_clk_n_from_the_ddr_sdram),
      .rx_clk_to_the_tse_mac (top_rx_clk_to_the_tse_mac),
      .rxd_to_the_uart1 (top_HC_UART_RXD),
      .select_n_to_the_ext_flash (top_flash_cs_n),
      .set_1000_to_the_tse_mac (top_set_1000_to_the_tse_mac),
      .set_10_to_the_tse_mac (top_set_10_to_the_tse_mac),
      .tx_clk_to_the_tse_mac (top_tx_clk_to_the_tse_mac),
      .txd_from_the_uart1 (top_HC_UART_TXD),
      .write_n_to_the_ext_flash (top_flash_wr_n)
    );


  assign top_CDn_to_the_el_camino_sd_card_controller = 1'b0;
  assign top_WP_to_the_el_camino_sd_card_controller = 1'b0;
  assign top_flash_reset_n = top_reset_n;
  assign top_HC_SCEN = top_out_port_from_the_lcd_i2c_en;
  assign top_HC_ADC_CS_N = top_SS_n_from_the_touch_panel_spi;
  assign top_HC_ADC_DCLK = ~top_SS_n_from_the_touch_panel_spi ? top_SCLK_from_the_touch_panel_spi: (~top_out_port_from_the_lcd_i2c_en ? top_out_port_from_the_lcd_i2c_scl: 0);
  gmii_mii_mux gmii_mii_mux_instance
    (
      .eth_mode (1'b0),
      .mdio (top_HC_MDIO),
      .mdio_in (top_mdio_in),
      .mdio_oen (top_mdio_oen),
      .mdio_out (top_mdio_out)
    );


  assign top_m_rx_col_to_the_tse_mac = top_HC_RX_COL;
  assign top_m_rx_crs_to_the_tse_mac = top_HC_RX_CRS;
  assign top_m_rx_d_to_the_tse_mac = top_HC_RX_D;
  assign top_m_rx_en_to_the_tse_mac = top_HC_RX_DV;
  assign top_m_rx_err_to_the_tse_mac = top_HC_RX_ERR;
  assign top_mdio_in_to_the_tse_mac = top_mdio_in;
  assign top_rx_clk_to_the_tse_mac = top_HC_RX_CLK;
  assign top_set_1000_to_the_tse_mac = 1'b0;
  assign top_set_10_to_the_tse_mac = 1'b0;
  assign top_tx_clk_to_the_tse_mac = top_HC_TX_CLK;
  assign top_HC_TX_D = top_m_tx_d_from_the_tse_mac;
  assign top_HC_TX_EN = top_m_tx_en_from_the_tse_mac;
  assign top_HC_MDC = top_mdc_from_the_tse_mac;
  assign top_mdio_oen = top_mdio_oen_from_the_tse_mac;
  assign top_mdio_out = top_mdio_out_from_the_tse_mac;
  assign top_HC_ETH_RESET_N = 1'b1;
  assign top_in_port_to_the_button_pio = top_button;

endmodule

