module custom_led(
	address,
	chipselect,
	clk,
	read,
	reset_n,
	write,
	writedata,
	led_out,
	readdata
	);
	
	input [1:0] address;
	input chipselect;
	input clk;
	input read;
	input reset_n;
	input write;
	input [31:0] writedata;
	output [9:0] led_out;
	output reg [31:0] readdata;
	
	reg [9:0] DATA;
	reg [9:0] DATA_LED;
	
	always @(posedge clk or negedge reset_n) begin
	if(!reset_n) begin
	
		DATA <= 10'b0;
		readdata <= 32'b0;
		
	end else if(chipselect && write && (address == 2'b0)) begin // cho phép ghi dữ liệu vào IP custom
	
		DATA <= writedata[9:0];
		readdata <= 32'b0;
	
	end else if(chipselect && read && (address == 2'b0)) begin // cho phép đọc dữ liệu vào IP custom
	
		readdata <= DATA;
		DATA <= DATA;
		
	end else begin
	
		readdata <= 32'b0;
		DATA <= DATA;
	
	end	
	end
	
	assign led_out = DATA_LED;
	
	always @(DATA)begin
	case(DATA)
		10'b0000000001: DATA_LED <= 10'b0101010101;
		10'b0000000010: DATA_LED <= 10'b1010101010;
		10'b0000000100: DATA_LED <= 10'b1111111111;
		default: DATA_LED <= 10'b0;
		endcase	
	end	
		
endmodule