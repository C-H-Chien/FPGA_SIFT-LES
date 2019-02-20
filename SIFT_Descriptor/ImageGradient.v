`timescale 1 ps / 1 ps

module ImageGradient(
	input 					           iclk,
	input 					           ireset,
	input                 idata_en,
	input			       [8:0]	 itop,
	input			       [8:0]	 ileft,
	input 		       [8:0]		iright,
	input			       [8:0]	 ibot,
	output		       [15:0]	omagnitude,
	output		       [15:0]	oorientation,
	output   reg          odata_en
);

reg	signed 	[16:0]	 delta_x;
reg	signed 	[16:0]	 delta_y;
reg                 data_en_hold[12:0];

////////////////////////////////////////////////////////////////////////////
// calculating dx and dy 
always@(posedge iclk or negedge ireset) begin
	if (!ireset) begin
		delta_x <= 0;
		delta_y <= 0;
	end
	else begin
		delta_x <= (iright[7:0] - ileft[7:0]) << 6;
		delta_y <= (ibot[7:0] - itop[7:0]) << 6;
	end
end
////////////////////////////////////////////////////////////////////////////

CORDIC_sqrt_atan ImageGradient1(
	.iclk(iclk),
	.ireset(ireset),
	.ix(delta_x),
	.iy(delta_y),
	.ox(omagnitude),
	.oz(oorientation)
);

////////////////////////////////////////////////////////////////////////////
//data_enable

reg [3:0] i;

always@(posedge iclk or negedge ireset) begin
  if (!ireset) begin
    for (i = 0; i < 13; i = i+1) begin
      data_en_hold[i] <= 0;        
    end
    odata_en <= 0;
  end
  else begin
    data_en_hold[0] <= idata_en;
    for (i = 0; i < 12; i = i+1) begin
      data_en_hold[i+1] <= data_en_hold[i];    
    end
    odata_en <= data_en_hold[12];
  end
end

////////////////////////////////////////////////////////////////////////////

endmodule 