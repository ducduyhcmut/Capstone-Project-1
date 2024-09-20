`timescale 1ns/1ps

module testbench();
	reg [1:0] address;
	reg chipselect;
	reg clk;
	reg read;
	reg reset_n;
	reg write;
	reg [31:0] writedata;
	wire [9:0] led_out;
	wire [31:0] readdata;
	
	custom_led dut(
	.address(address),
	.chipselect(chipselect),
	.clk(clk),
	.read(read),
	.reset_n(reset_n),
	.write(write),
	.writedata(writedata),
	.led_out(led_out),
	.readdata(readdata)
	);

	always begin
	#10 clk = ~clk;
	end
	
	initial begin
		clk = 1'b0;
		writedata = 32'h00000000;
		address = 2'b00;
		chipselect = 0;
		read = 0;
		write = 1'b0;
		reset_n = 1'b0;
		#15 reset_n = 1;
		#5 writedata = 32'h00000001;
		#5 chipselect = 1'b1;
		#7 write = 1'b1;
		#20 writedata = 32'h00000000;
			 chipselect = 1'b0;
			 write = 1'b0;
		#40 writedata = 32'h00000002;
		#5  chipselect = 1'b1;
		#7  write = 1'b1;
		
		#20 writedata = 32'h00000000;
			 chipselect = 1'b0;
			 write = 1'b0;
			 
		#40 writedata = 32'h00000004;
		#5  chipselect = 1'b1;
		#7  write = 1'b1;
		
		#20 writedata = 32'h00000000;
			 chipselect = 1'b0;
			 write = 1'b0;
			 
		#40 chipselect = 1'b1;
		#7  read = 1'b1;
		#20 chipselect = 1'b0;
			 read = 1'b0;
		$finish;
	end

endmodule