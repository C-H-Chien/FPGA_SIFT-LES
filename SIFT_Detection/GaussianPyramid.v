`timescale 1 ps / 1 ps

module GaussianPyramid (
	input             iclk,
	input             irst_n,
	input  	[8:0]		iImagePixelData,
	output  	[8:0]    GaussianImageData1,
	output  	[8:0]    GaussianImageData2,
	output  	[8:0]    GaussianImageData3,
	output  	[8:0]    GaussianImageData4
);

wire  	[8:0]		Layer1Line[6:0];

defparam GaussianFilter1.size = 800;

LineBufferLayer1 GaussianFilter1(
	.clken(iImagePixelData[8]),
	.clock(iclk),
	.aclr(!irst_n),
	.shiftin(iImagePixelData),
	.taps0x(Layer1Line[0]),
	.taps1x(Layer1Line[1]),
	.taps2x(Layer1Line[2]),
	.taps3x(Layer1Line[3]),
	.taps4x(Layer1Line[4]),
	.taps5x(Layer1Line[5]),
	.taps6x(Layer1Line[6])
);

reg Gaussian_en_hold[3];

always@(posedge iclk or negedge irst_n) begin
	if (!irst_n) begin
		Gaussian_en_hold[0] <= 0;
		Gaussian_en_hold[1] <= 0;
		Gaussian_en_hold[2] <= 0;		
	end
	else begin
		Gaussian_en_hold[0] <= Layer1Line[3][8];
		Gaussian_en_hold[1] <= Gaussian_en_hold[0];
		Gaussian_en_hold[2] <= Gaussian_en_hold[1];
	end
end

GaussianFilter GaussianFilter2(
  .iclk(iclk),
  .irst_n(irst_n),
  .iRead_en(Gaussian_en_hold[2]),
  .iGaussian_num(3'b001),
  .Line0(Layer1Line[0]),
  .Line1(Layer1Line[1]),
  .Line2(Layer1Line[2]),
  .Line3(Layer1Line[3]),
  .Line4(Layer1Line[4]),
  .Line5(Layer1Line[5]),
  .Line6(Layer1Line[6]),
  .GaussianPixelData(GaussianImageData1)
);

GaussianFilter GaussianFilter3(
  .iclk(iclk),
  .irst_n(irst_n),
  .iRead_en(Gaussian_en_hold[2]),
  .iGaussian_num(3'b010),
  .Line0(Layer1Line[0]),
  .Line1(Layer1Line[1]),
  .Line2(Layer1Line[2]),
  .Line3(Layer1Line[3]),
  .Line4(Layer1Line[4]),
  .Line5(Layer1Line[5]),
  .Line6(Layer1Line[6]),
  .GaussianPixelData(GaussianImageData2)
);

GaussianFilter GaussianFilter4(
  .iclk(iclk),
  .irst_n(irst_n),
  .iRead_en(Gaussian_en_hold[2]),
  .iGaussian_num(3'b011),
  .Line0(Layer1Line[0]),
  .Line1(Layer1Line[1]),
  .Line2(Layer1Line[2]),
  .Line3(Layer1Line[3]),
  .Line4(Layer1Line[4]),
  .Line5(Layer1Line[5]),
  .Line6(Layer1Line[6]),
  .GaussianPixelData(GaussianImageData3)
);

GaussianFilter GaussianFilter5(
  .iclk(iclk),
  .irst_n(irst_n),
  .iRead_en(Gaussian_en_hold[2]),
  .iGaussian_num(3'b100),
  .Line0(Layer1Line[0]),
  .Line1(Layer1Line[1]),
  .Line2(Layer1Line[2]),
  .Line3(Layer1Line[3]),
  .Line4(Layer1Line[4]),
  .Line5(Layer1Line[5]),
  .Line6(Layer1Line[6]),
  .GaussianPixelData(GaussianImageData4)
);

endmodule

