`timescale 1 ps / 1 ps

module LowContrastValue (  
  input                               iclk,
  input                               irst_n,
  input           signed     [8:0]    ipixel_data,
  input           signed     [8:0]    iadj11,
  input           signed     [8:0]    iadj12,
  input           signed     [8:0]    iadj13,
  input           signed     [8:0]    iadj21,
  input           signed     [8:0]    iadj22,
  input           signed     [8:0]    iadj23,
  input           signed     [8:0]    iadj31,
  input           signed     [8:0]    iadj32,
  input           signed     [8:0]    iadj33,
  input           signed     [16:0]   idet,
  input           signed     [8:0]    idx,
  input           signed     [8:0]    idy,
  input           signed     [8:0]    ids,
  output    reg   signed     [31:0]   oleft_value,
  output    reg   signed     [31:0]   oright_value
);

reg    signed    [8:0]     idx_hold[1:0];
reg    signed    [8:0]     idy_hold[1:0];
reg    signed    [8:0]     ids_hold[1:0];
reg    signed    [8:0]     ipixel_data_hold[3:0];
reg    signed    [16:0]    idet_hold[4:0];

reg              [3:0]   	i;
reg    signed    [31:0]  	a;
reg    signed    [31:0]  	b;
reg    signed    [31:0]  	c;
wire   signed    [18:0]    mul_1[2:0];
wire   signed    [18:0]    mul_2;
reg    signed    [31:0]    idet_square_hold;

MultipleMatrix_3x3_3x1 lowcontrastvalue1(  
  .iclk(iclk),
  .irst_n(irst_n),
  .iData_a11(iadj11),
  .iData_a12(iadj12),
  .iData_a13(iadj13),
  .iData_a21(iadj21),
  .iData_a22(iadj22),
  .iData_a23(iadj23),
  .iData_a31(iadj31),
  .iData_a32(iadj32),
  .iData_a33(iadj33),
  .iData_b11(idx),
  .iData_b21(idy),
  .iData_b31(ids),
  .odata11(mul_1[0]),
  .odata21(mul_1[1]),
  .odata31(mul_1[2])
);

MultipleMatrix_1x3_3x1 lowcontrastvalue2(  
  .iclk(iclk),
  .irst_n(irst_n),
  .iData_a11(idx_hold[1]),
  .iData_a12(idy_hold[1]),
  .iData_a13(ids_hold[1]),
  .iData_b11(mul_1[0]),
  .iData_b21(mul_1[1]),
  .iData_b31(mul_1[2]),
  .odata(mul_2)
);

//////////////////////////////////////////////////////////////////////////////////////////////////
//pipeline data
always@(posedge iclk or negedge irst_n) begin
	if (!irst_n) begin
		idx_hold[0] <= 0;
		idy_hold[0] <= 0;
		ids_hold[0] <= 0;
		idx_hold[1] <= 0;
		idy_hold[1] <= 0;
		ids_hold[1] <= 0;
		for (i = 0; i < 4; i = i + 1) begin
			idet_hold[i] <= 0;
			ipixel_data_hold[i] <= 0;
		end
		idet_hold[4] <= 0;
	end
	else begin
	  idx_hold[0] <= idx;
		idy_hold[0] <= idy;
		ids_hold[0] <= ids;
		idx_hold[1] <= idx_hold[0];
		idy_hold[1] <= idy_hold[0];
		ids_hold[1] <= ids_hold[0];
		idet_hold[0] <= idet;
		ipixel_data_hold[0] <=  ipixel_data;
		for (i = 0; i < 3; i = i + 1) begin
			idet_hold[i+1] <= idet_hold[i];
			ipixel_data_hold[i+1] <= ipixel_data_hold[i];
		end 
		idet_hold[4] <= idet_hold[3];
	end
end
//////////////////////////////////////////////////////////////////////////////////////////////////
//operate data

reg    signed    [8:0]   ipixel_data_hold_pow;
reg    signed    [31:0]  idet_square;
reg    signed    [26:0]  data_b;
reg    signed    [18:0]  data_c;

always@(posedge iclk or negedge irst_n) begin
  if (!irst_n) begin
    a <= 0;
    b <= 0;
    c <= 0;
    idet_square <= 0;
    oleft_value <= 0;
    oright_value <= 0;
  end
  else begin
    ////////////////////////////////////////////////////////////////////////////////////////
    //clk1
    ipixel_data_hold_pow <= ipixel_data_hold[3] * ipixel_data_hold[3];
    idet_square <= idet_hold[3] * idet_hold[3];
    data_b <= ipixel_data_hold[3] * mul_2;
    data_c <= mul_2;
 	  ////////////////////////////////////////////////////////////////////////////////////////
	  //clk2
    a <= ipixel_data_hold_pow * idet_square;
    b <= data_b * idet_hold[4];
    c <= (data_c * data_c) >> 2;
    idet_square_hold <= idet_square;
	  ////////////////////////////////////////////////////////////////////////////////////////
	  //clk2
    oleft_value <= (a - b + c);
    oright_value <= idet_square_hold;
    ////////////////////////////////////////////////////////////////////////////////////////
    
  end
end
//////////////////////////////////////////////////////////////////////////////////////////////////

endmodule 