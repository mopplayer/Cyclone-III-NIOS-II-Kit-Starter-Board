  //Example instantiation for system 'system'
  system system_inst
    (
      .DEN_from_the_lcd_video_sequencer             (DEN_from_the_lcd_video_sequencer),
      .HD_from_the_lcd_video_sequencer              (HD_from_the_lcd_video_sequencer),
      .MISO_to_the_touchPanel_spi                   (MISO_to_the_touchPanel_spi),
      .MOSI_from_the_touchPanel_spi                 (MOSI_from_the_touchPanel_spi),
      .RGB_OUT_from_the_lcd_video_sequencer         (RGB_OUT_from_the_lcd_video_sequencer),
      .SCLK_from_the_touchPanel_spi                 (SCLK_from_the_touchPanel_spi),
      .SS_n_from_the_touchPanel_spi                 (SS_n_from_the_touchPanel_spi),
      .VD_from_the_lcd_video_sequencer              (VD_from_the_lcd_video_sequencer),
      .adsc_n_to_the_ssram                          (adsc_n_to_the_ssram),
      .bidir_port_to_and_from_the_lcd_i2c_dat       (bidir_port_to_and_from_the_lcd_i2c_dat),
      .bidir_port_to_and_from_the_pio_id_eeprom_dat (bidir_port_to_and_from_the_pio_id_eeprom_dat),
      .bw_n_to_the_ssram                            (bw_n_to_the_ssram),
      .bwe_n_to_the_ssram                           (bwe_n_to_the_ssram),
      .chipenable1_n_to_the_ssram                   (chipenable1_n_to_the_ssram),
      .ext_clk_one                                  (ext_clk_one),
      .frame_buffer_aux_full_rate_clk_out           (frame_buffer_aux_full_rate_clk_out),
      .frame_buffer_aux_half_rate_clk_out           (frame_buffer_aux_half_rate_clk_out),
      .frame_buffer_phy_clk_out                     (frame_buffer_phy_clk_out),
      .global_reset_n_to_the_frame_buffer           (global_reset_n_to_the_frame_buffer),
      .in_port_to_the_push_buttons                  (in_port_to_the_push_buttons),
      .in_port_to_the_touchPanel_irq_n              (in_port_to_the_touchPanel_irq_n),
      .local_init_done_from_the_frame_buffer        (local_init_done_from_the_frame_buffer),
      .local_refresh_ack_from_the_frame_buffer      (local_refresh_ack_from_the_frame_buffer),
      .local_wdata_req_from_the_frame_buffer        (local_wdata_req_from_the_frame_buffer),
      .mem_addr_from_the_frame_buffer               (mem_addr_from_the_frame_buffer),
      .mem_ba_from_the_frame_buffer                 (mem_ba_from_the_frame_buffer),
      .mem_cas_n_from_the_frame_buffer              (mem_cas_n_from_the_frame_buffer),
      .mem_cke_from_the_frame_buffer                (mem_cke_from_the_frame_buffer),
      .mem_clk_n_to_and_from_the_frame_buffer       (mem_clk_n_to_and_from_the_frame_buffer),
      .mem_clk_to_and_from_the_frame_buffer         (mem_clk_to_and_from_the_frame_buffer),
      .mem_cs_n_from_the_frame_buffer               (mem_cs_n_from_the_frame_buffer),
      .mem_dm_from_the_frame_buffer                 (mem_dm_from_the_frame_buffer),
      .mem_dq_to_and_from_the_frame_buffer          (mem_dq_to_and_from_the_frame_buffer),
      .mem_dqs_to_and_from_the_frame_buffer         (mem_dqs_to_and_from_the_frame_buffer),
      .mem_ras_n_from_the_frame_buffer              (mem_ras_n_from_the_frame_buffer),
      .mem_we_n_from_the_frame_buffer               (mem_we_n_from_the_frame_buffer),
      .out_port_from_the_lcd_i2c_cs                 (out_port_from_the_lcd_i2c_cs),
      .out_port_from_the_lcd_i2c_scl                (out_port_from_the_lcd_i2c_scl),
      .out_port_from_the_pio_id_eeprom_scl          (out_port_from_the_pio_id_eeprom_scl),
      .outputenable_n_to_the_ssram                  (outputenable_n_to_the_ssram),
      .read_n_to_the_flash                          (read_n_to_the_flash),
      .reset_n                                      (reset_n),
      .reset_n_to_the_ssram                         (reset_n_to_the_ssram),
      .reset_phy_clk_n_from_the_frame_buffer        (reset_phy_clk_n_from_the_frame_buffer),
      .select_n_to_the_flash                        (select_n_to_the_flash),
      .slow_clk                                     (slow_clk),
      .system_clk                                   (system_clk),
      .tristate_bridge_address                      (tristate_bridge_address),
      .tristate_bridge_data                         (tristate_bridge_data),
      .video_clk                                    (video_clk),
      .write_n_to_the_flash                         (write_n_to_the_flash)
    );
