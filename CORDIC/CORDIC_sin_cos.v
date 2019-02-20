`timescale 1 ps / 1 ps

//Let angle to zoom out 2 ^ 10

`define  rot0  16'hB400    //45
`define  rot1  16'h6A43    //26.5651
`define  rot2  16'h3825    //14.0362
`define  rot3  16'h1c80    //7.1250
`define  rot4  16'h0e4e    //3.5763
`define  rot5  16'h0729    //1.7899
`define  rot6  16'h0395    //0.8952
`define  rot7  16'h01ca    //0.4476
`define  rot8  16'h00e5    //0.2238
`define  rot9  16'h0073    //0.1119
`define  rot10 16'h0039    //0.0560
`define  rot11 16'h001d    //0.0280
`define  rot12 16'h000e    //0.0140
`define  rot13 16'h0007    //0.0070
`define  rot14 16'h0004    //0.0035
`define  rot15 16'h0002    //0.0035

module CORDIC_sin_cos (
	input 									iclk,
	input 									ireset,
	input		signed	 	[20:0]	iz,
	output 	signed		[20:0]	ox,
	output 	signed		[20:0]	oy
);

parameter K = 19'h09b78;		//gian k=0.6073*2^16,9b74,n means the number pipeline
parameter BitSize = 20;

reg	signed	[BitSize:0]		x[15:0];
reg	signed	[BitSize:0] 	y[15:0];
reg	signed 	[BitSize:0] 	z[15:0];
reg 	signed	[BitSize:0] 	angle;

reg	signed	[BitSize:0]		quadrant_x;
reg	signed	[BitSize:0]		quadrant_y;

reg [4:0] i;
reg [1:0] quadrant [16:0];

assign ox = quadrant_x;
assign oy = quadrant_y;

always@(posedge iclk or negedge ireset) begin
	if (!ireset) begin
		for (i = 0; i < 17; i = i + 1) begin
			quadrant[i] <= 0;
		end
		angle <= 0;
	end
	else begin
		////////////////////////////////////////////////////////////////////////////////////////////////
		//detect quadrant
		if (iz <= 92160) begin
			quadrant[0] <= 0;
			angle <= iz;
		end
		else if (iz <= 184320) begin
			quadrant[0] <= 1;
			angle <= 184320 - iz;
		end
		else if (iz <= 276480) begin
			quadrant[0] <= 2;
			angle <= iz - 184320;
		end
		else begin
			quadrant[0] <= 3;
			angle <= 368640 - iz;
		end
		////////////////////////////////////////////////////////////////////////////////////////////////
		//hold quadrant
		for (i = 0; i < 16; i = i + 1) begin
			quadrant[i+1] <= quadrant[i];
		end		
		////////////////////////////////////////////////////////////////////////////////////////////////
	end
end

always@(posedge iclk or negedge ireset) begin
	if (!ireset) begin
		quadrant_x <= 0;
		quadrant_y <= 0;
	end
	else begin
		case (quadrant[16])
			2'b00 : begin
				quadrant_x <= x[15];
				quadrant_y <= y[15];
			end
			2'b01 : begin
				quadrant_x <= -x[15];
				quadrant_y <= y[15];		
			end
			2'b10 : begin
				quadrant_x <= -x[15];
				quadrant_y <= -y[15];		
			end
			default begin
				quadrant_x <= x[15];
				quadrant_y <= -y[15];			
			end		
		endcase
	end
end	

always@(posedge iclk or negedge ireset) begin
	if (!ireset) begin
		for (i = 0; i < 16; i = i + 1) begin
			x[i] <= 0;
			y[i] <= 0;
			z[i] <= 0;
		end
	end
	else begin
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//state0
		x[0] <= K;
		y[0] <= 0;
		z[0] <= angle;
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//state1
		if (z[0] < 0) begin
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
		if (z[1] < 0) begin
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
		if (z[2] < 0) begin
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
		if (z[3] < 0) begin
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
		if (z[4] < 0) begin
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
		if (z[5] < 0) begin
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
		if (z[6] < 0) begin
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
		if (z[7] < 0) begin
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
		if (z[8] < 0) begin
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
		if (z[9] < 0) begin
			x[10] <= x[9] + {{9{y[9][BitSize]}}, y[9][BitSize:9]};
			y[10] <= y[9] - {{9{x[9][BitSize]}}, x[9][BitSize:9]};
			z[10] <= z[9] + `rot9;
		end
		else begin
			x[10] <= x[9] - {{9{y[9][BitSize]}}, y[9][BitSize:9]};
			y[10] <= y[9] + {{9{x[9][BitSize]}}, x[9][BitSize:9]};
			z[10] <= z[9] - `rot9 ; // reversal 45 
		end
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//state11
		if (z[10] < 0) begin
			x[11] <= x[10] + {{10{y[10][BitSize]}}, y[10][BitSize:10]};
			y[11] <= y[10] - {{10{x[10][BitSize]}}, x[10][BitSize:10]};
			z[11] <= z[10] + `rot10;
		end
		else begin
			x[11] <= x[10] - {{10{y[10][BitSize]}}, y[10][BitSize:10]};
			y[11] <= y[10] + {{10{x[10][BitSize]}}, x[10][BitSize:10]};
			z[11] <= z[10] - `rot10 ; // reversal 45 
		end
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//state12
		if (z[11] < 0) begin
			x[12] <= x[11] + {{11{y[11][BitSize]}}, y[11][BitSize:11]};
			y[12] <= y[11] - {{11{x[11][BitSize]}}, x[11][BitSize:11]};
			z[12] <= z[11] + `rot11;
		end
		else begin
			x[12] <= x[11] - {{11{y[11][BitSize]}}, y[11][BitSize:11]};
			y[12] <= y[11] + {{11{x[11][BitSize]}}, x[11][BitSize:11]};
			z[12] <= z[11] - `rot11 ; // reversal 45 
		end
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//state13
		if (z[12] < 0) begin
			x[13] <= x[12] + {{12{y[12][BitSize]}}, y[12][BitSize:12]};
			y[13] <= y[12] - {{12{x[12][BitSize]}}, x[12][BitSize:12]};
			z[13] <= z[12] + `rot12;
		end
		else begin
			x[13] <= x[12] - {{12{y[12][BitSize]}}, y[12][BitSize:12]};
			y[13] <= y[12] + {{12{x[12][BitSize]}}, x[12][BitSize:12]};
			z[13] <= z[12] - `rot12 ; // reversal 45 
		end
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//state14
		if (z[13] < 0) begin
			x[14] <= x[13] + {{13{y[13][BitSize]}}, y[13][BitSize:13]};
			y[14] <= y[13] - {{13{x[13][BitSize]}}, x[13][BitSize:13]};
			z[14] <= z[13] + `rot13;
		end
		else begin
			x[14] <= x[13] - {{13{y[13][BitSize]}}, y[13][BitSize:13]};
			y[14] <= y[13] + {{13{x[13][BitSize]}}, x[13][BitSize:13]};
			z[14] <= z[13] - `rot13 ; // reversal 45 
		end
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//state15
		if (z[14] < 0) begin
			x[15] <= x[14] + {{14{y[14][BitSize]}}, y[14][BitSize:14]};
			y[15] <= y[14] - {{14{x[14][BitSize]}}, x[14][BitSize:14]};
			z[15] <= z[14] + `rot14;
		end
		else begin
			x[15] <= x[14] - {{14{y[14][BitSize]}}, y[14][BitSize:14]};
			y[15] <= y[14] + {{14{x[14][BitSize]}}, x[14][BitSize:14]};
			z[15] <= z[14] - `rot14 ; // reversal 45 
		end
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	end
end

endmodule
