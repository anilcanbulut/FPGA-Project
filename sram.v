//This implementation of Dual port RAM
//Which has the ability to write and read simultanuosly in different clocks
//This Buffer has two inside ports Buffer A(150x150x12) and B(150x150x1)
module Buffer(
	input rw_clk,					//	Write/read clock (50MHz)
	input [13:0] r_addr_RGB,		// 150*150 22500 15 bit lazÃƒÆ’Ã¢â‚¬ÂÃƒâ€šÃ‚Â±m addreslenebilmesi iÃƒÆ’Ã†â€™Ãƒâ€šÃ‚Â§in  ,259 yapacaksan ayarla
	output reg [13:0] d_out_RGB,	// Port RGB data out (3-bits)
	input [13:0] w_addr_gray,
	input [13:0] r_addr_gray,
	output reg [3:0] d_out_gray
);

reg [11:0] data_RGB [14399:0];  //Registers array (120x120)
reg [3:0] gray_data[14399:0];

initial begin
        $display("Loading Image");
        $readmemb("binary2.mem", data_RGB); 
end

always @(posedge rw_clk) begin
	d_out_RGB <= data_RGB[r_addr_RGB];		// Set the RGB out data from the registers of RGB					 
	gray_data[w_addr_gray] <= ((d_out_RGB[11:8] >> 2) + (d_out_RGB[11:8] >> 5) + (d_out_RGB[7:4] >> 4) + (d_out_RGB[7:4] >> 1) + (d_out_RGB[3:0] >> 4) + (d_out_RGB[7:4] >> 5));
end

always @(posedge rw_clk) begin
	d_out_gray <= gray_data[r_addr_gray];
end
endmodule
