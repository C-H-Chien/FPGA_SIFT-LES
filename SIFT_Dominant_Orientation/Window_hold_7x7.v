`timescale 1 ps / 1 ps

module Window_hold_7x7 (
	input              			 iclk,
	input            			  	irst_n,
	input	     		[8:0]   	 idata,
	output	reg	  [8:0]   	 odata0,
	output	reg	  [8:0]   	 odata1,
	output	reg	  [8:0]  	  odata2,
	output	reg	  [8:0]  	  odata3,
	output	reg	  [8:0]  	  odata4,
	output	reg	  [8:0]  	  odata5,
	output	reg	  [8:0]  	  odata6
);

always@(posedge iclk or negedge irst_n) begin
	if (!irst_n) begin
		odata0 <= 0;
		odata1 <= 0;
		odata2 <= 0;
		odata3 <= 0;
		odata4 <= 0;
		odata5 <= 0;
		odata6 <= 0;
	end
	else begin
		odata0 <= idata;
		odata1 <= odata0;
		odata2 <= odata1;
	  odata3 <= odata2;
		odata4 <= odata3;
		odata5 <= odata4;
		odata6 <= odata5;
	end
end

endmodule 

