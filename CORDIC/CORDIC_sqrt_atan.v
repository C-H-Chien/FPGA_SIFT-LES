//Let angle to zoom out 2 ^ 10

//`define  rot0  16'hB400    //45
//`define  rot1  16'h6A43    //26.5651
//`define  rot2  16'h3825    //14.0362
//`define  rot3  16'h1c80    //7.1250
//`define  rot4  16'h0e4e    //3.5763
//`define  rot5  16'h0729    //1.7899
//`define  rot6  16'h0395    //0.8952
//`define  rot7  16'h01ca    //0.4476
//`define  rot8  16'h00e5    //0.2238
//`define  rot9  16'h0073    //0.1119

//Let angle to zoom out 2 ^ 6

`define  rot0  12'hB40    //45
`define  rot1  12'h6A4    //26.5651
`define  rot2  12'h382    //14.0362
`define  rot3  12'h1c8    //7.1250
`define  rot4  12'h0e4    //3.5763
`define  rot5  12'h072    //1.7899
`define  rot6  12'h039   //0.8952
`define  rot7  12'h01c    //0.4476
`define  rot8  12'h00e    //0.2238
`define  rot9  12'h007    //0.1119

module CORDIC_sqrt_atan (
	input 									iclk,
	input 									ireset,
	input		signed	 	[16:0]	ix,
	input		signed	 	[16:0]	iy,
	output 	signed		[16:0]	ox,
	output 	signed		[16:0]	oz
);

parameter K = 19'h09b78;		//gian k=0.6073*2^16,9b74,n means the number pipeline
parameter BitSize = 16;
parameter iteration = 10;

reg	signed	[BitSize:0]		x[iteration:0];
reg	signed	[BitSize:0] 	y[iteration:0];
reg	signed 	[BitSize:0] 	z[iteration:0];

reg 	signed	[BitSize:0] 	abs_x;
reg 	signed	[BitSize:0] 	abs_y;

reg [2:0] quadrant [iteration+1:0];
reg [4:0] i;

reg	signed	[BitSize:0]		quadrant_sqrt;
reg	signed	[BitSize:0]		quadrant_atan;

assign ox = quadrant_sqrt;
assign oz = quadrant_atan;

always@(posedge iclk or negedge ireset) begin
	if (!ireset) begin
		for (i = 0; i < iteration+2; i = i + 1) begin
			quadrant[i] <= 0;
		end
		abs_x <= 0;
		abs_y <= 0;
	end
	else begin
		////////////////////////////////////////////////////////////////////////////////////////////////
		//detect quadrant
		if (ix > 0 && iy > 0) begin
			quadrant[0] <= 0;
			abs_x <= ix;
			abs_y <= iy;
		end
		else if (ix < 0 && iy > 0) begin
			quadrant[0] <= 1;
			abs_x <= -ix;
			abs_y <= iy;
		end
		else if (ix < 0 && iy < 0) begin
			quadrant[0] <= 2;
			abs_x <= -ix;
			abs_y <= -iy;
		end
		else if (ix > 0 && iy < 0) begin
			quadrant[0] <= 3;
			abs_x <= ix;
			abs_y <= -iy;
		end
		else if (ix >= 0 && iy == 0) begin
		  quadrant[0] <= 4;
			abs_x <= ix;
			abs_y <= iy;
		end
		else if (ix == 0 && iy > 0) begin
		  quadrant[0] <= 5;
			abs_x <= ix;
			abs_y <= iy;
		end
		else if (ix < 0 && iy == 0) begin
		  quadrant[0] <= 6;
			abs_x <= -ix;
			abs_y <= iy;
		end
		else begin
		  quadrant[0] <= 7;
			abs_x <= ix;
			abs_y <= -iy;		  
		end
		////////////////////////////////////////////////////////////////////////////////////////////////
		//hold quadrant
		for (i = 0; i < iteration+1; i = i + 1) begin
			quadrant[i+1] <= quadrant[i];
		end		
		////////////////////////////////////////////////////////////////////////////////////////////////
	end
end

always@(posedge iclk or negedge ireset) begin
	if (!ireset) begin
		quadrant_sqrt <= 0;
		quadrant_atan <= 0;
	end
	else begin
		case (quadrant[iteration+1])
			3'b000 : begin
				quadrant_atan <= z[iteration];
			end
			3'b001 : begin
				quadrant_atan <= 11520 - z[iteration];		
			end
			3'b010 : begin
				quadrant_atan <= z[iteration] + 11520;		
			end
			3'b011 : begin
				quadrant_atan <= 23040 - z[iteration];			
			end
			3'b100 : begin
				quadrant_atan <= 0;			
			end
			3'b101 : begin
				quadrant_atan <= 5760;			
			end
			3'b110 : begin
				quadrant_atan <= 11520;			
			end
			3'b111 : begin
				quadrant_atan <= 17280;			
			end		
		endcase
		quadrant_sqrt <= x[iteration];
	end
end

always@(posedge iclk or negedge ireset) begin
	if (!ireset) begin
		for (i = 0; i < iteration+1; i = i + 1) begin
			x[i] <= 0;
			y[i] <= 0;
			z[i] <= 0;
		end
	end
	else begin
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//state0
		x[0] <= abs_x;
		y[0] <= abs_y;
		z[0] <= 0;
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//state1
		if (y[0] >= 0) begin
			x[1] <= x[0] + y[0];
			y[1] <= y[0] - x[0];
			z[1] <= z[0] + `rot0;
		end
		else begin
			x[1] <= x[0] - y[0];  
			y[1] <= y[0] + x[0]; 
			z[1] <= z[0] - `rot0 ;
		end
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//state2
		if (y[1] >= 0) begin
			x[2] <= x[1] + {y[1][BitSize], y[1][BitSize:1]};
			y[2] <= y[1] - {x[1][BitSize], x[1][BitSize:1]};
			z[2] <= z[1] + `rot1;
		end
		else begin
			x[2] <= x[1] - {y[1][BitSize], y[1][BitSize:1]}; 
			y[2] <= y[1] + {x[1][BitSize], x[1][BitSize:1]};
			z[2] <= z[1] - `rot1 ; 
		end
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//state3
		if (y[2] >= 0) begin
			x[3] <= x[2] + {{2{y[2][BitSize]}}, y[2][BitSize:2]};
			y[3] <= y[2] - {{2{x[2][BitSize]}}, x[2][BitSize:2]};
			z[3] <= z[2] + `rot2;
		end
		else begin
			x[3] <= x[2] - {{2{y[2][BitSize]}}, y[2][BitSize:2]};
			y[3] <= y[2] + {{2{x[2][BitSize]}}, x[2][BitSize:2]};
			z[3] <= z[2] - `rot2 ; 
		end
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//state4
		if (y[3] >= 0) begin
			x[4] <= x[3] + {{3{y[3][BitSize]}}, y[3][BitSize:3]};
			y[4] <= y[3] - {{3{x[3][BitSize]}}, x[3][BitSize:3]};
			z[4] <= z[3] + `rot3;
		end
		else begin
			x[4] <= x[3] - {{3{y[3][BitSize]}}, y[3][BitSize:3]};
			y[4] <= y[3] + {{3{x[3][BitSize]}}, x[3][BitSize:3]};
			z[4] <= z[3] - `rot3 ; 
		end
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//state5
		if (y[4] >= 0) begin
			x[5] <= x[4] + {{4{y[4][BitSize]}}, y[4][BitSize:4]};
			y[5] <= y[4] - {{4{x[4][BitSize]}}, x[4][BitSize:4]};
			z[5] <= z[4] + `rot4;
		end
		else begin
			x[5] <= x[4] - {{4{y[4][BitSize]}}, y[4][BitSize:4]};
			y[5] <= y[4] + {{4{x[4][BitSize]}}, x[4][BitSize:4]};
			z[5] <= z[4] - `rot4 ;  
		end
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//state6
		if (y[5] >= 0) begin
			x[6] <= x[5] + {{5{y[5][BitSize]}}, y[5][BitSize:5]};
			y[6] <= y[5] - {{5{x[5][BitSize]}}, x[5][BitSize:5]};
			z[6] <= z[5] + `rot5;
		end
		else begin
			x[6] <= x[5] - {{5{y[5][BitSize]}}, y[5][BitSize:5]};
			y[6] <= y[5] + {{5{x[5][BitSize]}}, x[5][BitSize:5]};
			z[6] <= z[5] - `rot5 ; // reversal 55 
		end
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//state7
		if (y[6] >= 0) begin
			x[7] <= x[6] + {{6{y[6][BitSize]}}, y[6][BitSize:6]};
			y[7] <= y[6] - {{6{x[6][BitSize]}}, x[6][BitSize:6]};
			z[7] <= z[6] + `rot6;
		end
		else begin
			x[7] <= x[6] - {{6{y[6][BitSize]}}, y[6][BitSize:6]};
			y[7] <= y[6] + {{6{x[6][BitSize]}}, x[6][BitSize:6]};
			z[7] <= z[6] - `rot6 ; // reversal 46 
		end
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//state8
		if (y[7] >= 0) begin
			x[8] <= x[7] + {{7{y[7][BitSize]}}, y[7][BitSize:7]};
			y[8] <= y[7] - {{7{x[7][BitSize]}}, x[7][BitSize:7]};
			z[8] <= z[7] + `rot7;
		end
		else begin
			x[8] <= x[7] - {{7{y[7][BitSize]}}, y[7][BitSize:7]};
			y[8] <= y[7] + {{7{x[7][BitSize]}}, x[7][BitSize:7]};
			z[8] <= z[7] - `rot7 ; // reversal 45 
		end
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//state9
		if (y[8] >= 0) begin
			x[9] <= x[8] + {{8{y[8][BitSize]}}, y[8][BitSize:8]};
			y[9] <= y[8] - {{8{x[8][BitSize]}}, x[8][BitSize:8]};
			z[9] <= z[8] + `rot8;
		end
		else begin
			x[9] <= x[8] - {{8{y[8][BitSize]}}, y[8][BitSize:8]};
			y[9] <= y[8] + {{8{x[8][BitSize]}}, x[8][BitSize:8]};
			z[9] <= z[8] - `rot8 ; // reversal 45 
		end
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//state10
		if (y[9] >= 0) begin
			x[10] <= x[9] + {{9{y[9][BitSize]}}, y[9][BitSize:9]};
			y[10] <= y[9] - {{9{x[9][BitSize]}}, x[9][BitSize:9]};
			z[10] <= z[9] + `rot9;
		end
		else begin
			x[10] <= x[9] - {{9{y[9][BitSize]}}, y[9][BitSize:9]};
			y[10] <= y[9] + {{9{x[9][BitSize]}}, x[9][BitSize:9]};
			z[10] <= z[9] - `rot9 ; // reversal 45 
		end
	end
end

endmodule
