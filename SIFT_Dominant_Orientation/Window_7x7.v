`timescale 1 ps / 1 ps

module Window_7x7 (
	input            iclk,
	input       		  	irst_n,
	input			[8:0]   	idata,
	output	 [8:0]   	odata0,
	output		[8:0]   	odata1,
	output		[8:0]  	 odata2,
	output		[8:0]  	 odata3,
	output		[8:0]  	 odata4,
	output		[8:0]  	 odata5,
	output		[8:0]  	 odata6,
	output		[8:0]  	 odata7,
	output		[8:0]  	 odata8
);

wire	[8:0]	w_bufferline[2:0]; 

WindowBuffer window_3x3_1(
	.aclr(!irst_n),
	.clock(iclk),
	.shiftin(idata),
	.taps0x(w_bufferline[0]),
	.taps1x(w_bufferline[1]),
	.taps2x(w_bufferline[2])
);

Window_hold window_3x3_2(
	.iclk(iclk),
	.irst_n(irst_n),
	.idata(w_bufferline[0]),
	.odata0(odata0),
	.odata1(odata1),
	.odata2(odata2)
);

Window_hold window_3x3_3(
	.iclk(iclk),
	.irst_n(irst_n),
	.idata(w_bufferline[1]),
	.odata0(odata3),
	.odata1(odata4),
	.odata2(odata5)
);

Window_hold window_3x3_4(
	.iclk(iclk),
	.irst_n(irst_n),
	.idata(w_bufferline[2]),
	.odata0(odata6),
	.odata1(odata7),
	.odata2(odata8)
);

endmodule 

