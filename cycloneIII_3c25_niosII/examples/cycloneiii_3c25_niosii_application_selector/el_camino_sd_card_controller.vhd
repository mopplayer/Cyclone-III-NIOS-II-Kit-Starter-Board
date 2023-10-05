-- el_camino_sd_card_controller.vhd

-- This file was auto-generated as part of a generation operation.
-- If you edit it your changes will probably be lost.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity el_camino_sd_card_controller is
	port (
		clk           : in  std_logic                     := '0';             --       avalon_slave_clock.clk
		reset_n       : in  std_logic                     := '0';             -- avalon_slave_clock_reset.reset_n
		data_from_cpu : in  std_logic_vector(15 downto 0) := (others => '0'); --             avalon_slave.writedata
		mem_addr      : in  std_logic_vector(2 downto 0)  := (others => '0'); --                         .address
		read_n        : in  std_logic                     := '0';             --                         .read_n
		spi_select    : in  std_logic                     := '0';             --                         .chipselect
		write_n       : in  std_logic                     := '0';             --                         .write_n
		data_to_cpu   : out std_logic_vector(15 downto 0);                    --                         .readdata
		dataavailable : out std_logic;                                        --                         .dataavailable
		endofpacket   : out std_logic;                                        --                         .endofpacket
		readyfordata  : out std_logic;                                        --                         .readyfordata
		irq           : out std_logic;                                        --         avalon_slave_irq.irq
		DO            : in  std_logic                     := '0';             --      avalon_slave_export.export
		WP            : in  std_logic                     := '0';             --                         .export
		CDn           : in  std_logic                     := '0';             --                         .export
		DI            : out std_logic;                                        --                         .export
		SCLK          : out std_logic;                                        --                         .export
		CSn           : out std_logic                                         --                         .export
	);
end entity el_camino_sd_card_controller;

architecture rtl of el_camino_sd_card_controller is
	component ip_sd_mmc_spi_wrapper is
		generic (
			ms_clock_divider       : integer := 10000;
			target_clock_divider   : integer := 188;
			system_clock_frequency : integer := 80;
			spi_clock_frequency    : integer := 25
		);
		port (
			clk           : in  std_logic                     := 'X';             -- clk
			reset_n       : in  std_logic                     := 'X';             -- reset_n
			data_from_cpu : in  std_logic_vector(15 downto 0) := (others => 'X'); -- writedata
			mem_addr      : in  std_logic_vector(2 downto 0)  := (others => 'X'); -- address
			read_n        : in  std_logic                     := 'X';             -- read_n
			spi_select    : in  std_logic                     := 'X';             -- chipselect
			write_n       : in  std_logic                     := 'X';             -- write_n
			data_to_cpu   : out std_logic_vector(15 downto 0);                    -- readdata
			dataavailable : out std_logic;                                        -- dataavailable
			endofpacket   : out std_logic;                                        -- endofpacket
			readyfordata  : out std_logic;                                        -- readyfordata
			irq           : out std_logic;                                        -- irq
			DO            : in  std_logic                     := 'X';             -- export
			WP            : in  std_logic                     := 'X';             -- export
			CDn           : in  std_logic                     := 'X';             -- export
			DI            : out std_logic;                                        -- export
			SCLK          : out std_logic;                                        -- export
			CSn           : out std_logic                                         -- export
		);
	end component ip_sd_mmc_spi_wrapper;

begin

	el_camino_sd_card_controller : component ip_sd_mmc_spi_wrapper
		generic map (
			ms_clock_divider       => 60000,
			target_clock_divider   => 3,
			system_clock_frequency => 60,
			spi_clock_frequency    => 20
		)
		port map (
			clk           => clk,           --       avalon_slave_clock.clk
			reset_n       => reset_n,       -- avalon_slave_clock_reset.reset_n
			data_from_cpu => data_from_cpu, --             avalon_slave.writedata
			mem_addr      => mem_addr,      --                         .address
			read_n        => read_n,        --                         .read_n
			spi_select    => spi_select,    --                         .chipselect
			write_n       => write_n,       --                         .write_n
			data_to_cpu   => data_to_cpu,   --                         .readdata
			dataavailable => dataavailable, --                         .dataavailable
			endofpacket   => endofpacket,   --                         .endofpacket
			readyfordata  => readyfordata,  --                         .readyfordata
			irq           => irq,           --         avalon_slave_irq.irq
			DO            => DO,            --      avalon_slave_export.export
			WP            => WP,            --                         .export
			CDn           => CDn,           --                         .export
			DI            => DI,            --                         .export
			SCLK          => SCLK,          --                         .export
			CSn           => CSn            --                         .export
		);

end architecture rtl; -- of el_camino_sd_card_controller
