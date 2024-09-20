	component system is
		port (
			clk_clk        : in  std_logic                    := 'X';             -- clk
			sw_wire_export : in  std_logic_vector(9 downto 0) := (others => 'X'); -- export
			led_wire_leds  : out std_logic_vector(9 downto 0)                     -- leds
		);
	end component system;

	u0 : component system
		port map (
			clk_clk        => CONNECTED_TO_clk_clk,        --      clk.clk
			sw_wire_export => CONNECTED_TO_sw_wire_export, --  sw_wire.export
			led_wire_leds  => CONNECTED_TO_led_wire_leds   -- led_wire.leds
		);

