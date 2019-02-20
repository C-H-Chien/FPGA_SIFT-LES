`timescale 1 ps / 1 ps

module CORDIC_tb;
  
reg                         clk;
reg                         rst_n;
reg   signed  [16:0]        data_x;
reg   signed  [16:0]        data_y;
wire          [15:0]        sqrt;
wire          [15:0]        atan;


CORDIC_sqrt_atan ImagePyramid_tb1(
	.iclk(clk),
	.ireset(rst_n),
	.ix(data_x),
	.iy(data_y),
	.ox(sqrt),
	.oz(atan)
);

initial begin
  #0 clk   = 1'b1;
     rst_n = 1'b0;
  #1 rst_n = 1'b1;
  #2 data_x = 16'd100;
     data_y = 16'd100;
end

// 50MHz
always #1 clk = ~clk;

endmodule



