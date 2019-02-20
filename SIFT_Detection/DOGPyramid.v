`timescale 1 ps / 1 ps

module DOGPyramid (
	input             iclk,
	input             irst_n,
	input  	 [8:0]    GaussianImageData1,
	input  	 [8:0]    GaussianImageData2,
	input  	 [8:0]    GaussianImageData3,
	input  	 [8:0]    GaussianImageData4,
	output  	[8:0]    DOGImageData1,
	output  	[8:0]    DOGImageData2,
	output  	[8:0]    DOGImageData3
);

DOGImage DOGPyramid1(
  .clk(iclk),
  .irst_n(irst_n),
  .idata_a(GaussianImageData2),
  .idata_b(GaussianImageData1),
  .odata(DOGImageData1)
);

DOGImage DOGPyramid2(
  .clk(iclk),
  .irst_n(irst_n),
  .idata_a(GaussianImageData3),
  .idata_b(GaussianImageData2),
  .odata(DOGImageData2)
);

DOGImage DOGPyramid3(
  .clk(iclk),
  .irst_n(irst_n),
  .idata_a(GaussianImageData4),
  .idata_b(GaussianImageData3),
  .odata(DOGImageData3)
);

endmodule
