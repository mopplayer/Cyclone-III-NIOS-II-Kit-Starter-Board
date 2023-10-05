module clock_mux(
  spi_clk,
  spi_ss_n,
  i2c_clk,
  i2c_cs,
  clock_out
);

  input spi_clk;
  input spi_ss_n;
  input i2c_clk;
  input i2c_cs;

  output wire clock_out;

  assign clock_out = (spi_ss_n == 0)? spi_clk :  // SPI is enabled
					((i2c_cs == 0)? i2c_clk : 0);  // I2C is enabled, otherwise ground the clock

endmodule
