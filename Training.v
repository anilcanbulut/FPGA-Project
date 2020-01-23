module Training(
	//VGA I/O
	output VGA_red, VGA_green, VGA_blue,	//VGA colors' channel		
	output VGA_hsync, VGA_vsync,				//VGA vertical and horziontal synchronization signals
	//Clock
	input clk_50,									//Clock 50 MHz input from the board itself
	input button
);

	//-------------------------Grayscale converter-----------------------------------
	reg[7:0] gray_value;					//Register 8-bits to store the grayscale value
	reg[4:0] red_channel_gray; 		//Temporary register to store red bits of the camera to be used in the grayscale converter
	reg[5:0] green_channel_gray; 		//Temporary register to store green bits of the camera to be used in the grayscale converter
	reg[4:0] blue_channel_gray;		//Temporary register to store blue bits of the camera to be used in the grayscale converter
	//-----------------------------------------------------------------------------------------------------

// Buffer port RGB 150x150x3: Used to store the rgb valu of pixel
// The data in port RGB is the final data to be displayed on the monitor
	reg [13:0] read_addr_RGB = 0;			// Address of port RGB for reading
	wire [11:0]outp_RGB;								// Output data from the port RGB (3-bit)
	
	reg [13:0] read_addr_gray = 0;
	reg [13:0] write_addr_gray = 0;
	//reg write_en_gray = 0;
	wire [3:0] outp_gray;


	//---------------------------VGA---------------------------
	// Interface for VGA module
	wire	[9:0]	VGA_hpos, VGA_vpos;				// Current pixel position
	wire 			VGA_active;					// Active flag to indicate when the screen area is active
	wire			VGA_pixel_tick;				// Signal coming from the VGA generator when the pixel position is ready to be displayed
	reg	[3:0]	pixel_VGA_RGB;			// Current pixel's RGB value
	//-----------------------------------------------------------------------------------------------------


	Buffer(						// Instance of Buffer module
	.rw_clk(clk_50),
	.r_addr_RGB(read_addr_RGB),
	.d_out_RGB(outp_RGB),
	.w_addr_gray(write_addr_gray),
	.r_addr_gray(read_addr_gray),
	.d_out_gray(outp_gray),
	);


	
	VGA(							// Instance of VGA module
		.clk(clk_50),
		.pixel_rgb(pixel_VGA_RGB),
		.hsync(VGA_hsync),
		.vsync(VGA_vsync),
		.red(VGA_red),
		.green(VGA_green),
		.blue(VGA_blue),
		.active(VGA_active),
		.ptick(VGA_pixel_tick),
		.xpos(VGA_hpos),
		.ypos(VGA_vpos)
	);

// This block is activated at the positive edge of pixel_tick signal from VGA module which means that a pixel is ready to be displayed
// This block is responsible to output the pixel on the monitor
	always @(posedge clk_50) begin
		// Check if the monitor is active and ready to display the pixel or not
		if (! VGA_active)
			pixel_VGA_RGB <= 3'b0;
		
	   else begin
			// Check if the pixel that is displayed in the available portion of the storage or not
			if(VGA_vpos < 'd120 && VGA_hpos < 'd120)
			begin	
				read_addr_RGB = (VGA_vpos[7:0])* 'd120 +(VGA_hpos[7:0]);	// Set the reading address from Buffer port B
            if(button) begin
					pixel_VGA_RGB[0]=outp_RGB[3];
               pixel_VGA_RGB[1]=outp_RGB[7];
               pixel_VGA_RGB[2]=outp_RGB[11];
				end

				write_addr_gray = (VGA_vpos[7:0])* 'd120 +(VGA_hpos[7:0]);
			end

			if(VGA_vpos < 'd120 && VGA_hpos < 'd120) begin	
				read_addr_gray = (VGA_vpos[7:0])* 'd120 +(VGA_hpos[7:0]);
				if(!button) begin
					pixel_VGA_RGB[0]=outp_gray[2];
					pixel_VGA_RGB[1]=outp_gray[2];
					pixel_VGA_RGB[2]=outp_gray[2];
				end
			end
		else
			pixel_VGA_RGB <= 3'b000;				//if it is not in our portion of memory it will be black
		end
	end
endmodule
