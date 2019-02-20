`timescale 1 ps / 1 ps

module Window_hold (
	input              			 iclk,
	input            			  	irst_n,
	input	     		[8:0]   	 idata,
	output	reg	  [8:0]   	 odata0,
	output	reg	  [8:0]   	 odata1,
	output	reg	  [8:0]  	  odata2
);

always@(posedge iclk or negedge irst_n) begin
	if (!irst_n) begin
		odata0 <= 0;
		odata1 <= 0;
		odata2 <= 0;
	end
	else begin
		odata0 <= idata;
		odata1 <= odata0;
		odata2 <= odata1;
	end
end

endmodule 