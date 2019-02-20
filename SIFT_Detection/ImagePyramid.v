`timescale 1 ps / 1 ps

module ImagePyramid (
	input             iclk,
	input             irst_n,
	input  	 [8:0]		  iImagePixelData,
	output  	[8:0]    GaussianImageData1,
	output  	[8:0]    GaussianImageData2,
	output  	[8:0]    GaussianImageData3,
	output  	[8:0]    GaussianImageData4,
	output	  [8:0]	  	DOGImageDate1,
	output	  [8:0]		  DOGImageDate2,
	output	  [8:0]	  	DOGImageDate3
);

wire	[8:0]		w_GaussianImage[5:0];

assign GaussianImageData1 = w_GaussianImage[0];
assign GaussianImageData2 = w_GaussianImage[1];
assign GaussianImageData3 = w_GaussianImage[2];
assign GaussianImageData4 = w_GaussianImage[3];

GaussianPyramid ImagePyramid1(
	.iclk(iclk),
	.irst_n(irst_n),
	.iImagePixelData(iImagePixelData),
	.GaussianImageData1(w_GaussianImage[0]),
	.GaussianImageData2(w_GaussianImage[1]),
	.GaussianImageData3(w_GaussianImage[2]),
	.GaussianImageData4(w_GaussianImage[3])
);

DOGPyramid ImagePyramid2(
	.iclk(iclk),
	.irst_n(irst_n),
	.GaussianImageData1(w_GaussianImage[0]),
	.GaussianImageData2(w_GaussianImage[1]),
	.GaussianImageData3(w_GaussianImage[2]),
	.GaussianImageData4(w_GaussianImage[3]),
	.DOGImageData1(DOGImageDate1),
	.DOGImageData2(DOGImageDate2),
	.DOGImageData3(DOGImageDate3)
);

endmodule 