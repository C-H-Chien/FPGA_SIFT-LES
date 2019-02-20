`timescale 1 ps / 1 ps

module MAC_3 (
  input              iclk,
	input              irst_n,
	input              iDval,
	input	     [8:0]   idata_s,
	input	     [7:0]   idata_0,
	input	     [7:0]   idata_1,
	input	     [7:0]   idata_2,
	input	     [7:0]   idata_3,
	input	     [7:0]   idata_4,
	input	     [7:0]   idata_5,
	input	     [7:0]   idata_6,
	output	reg [19:0]  odata
);

reg [8:0]   r_idata_s[6:0];
reg [16:0]  mult[6:0];
reg [18:0]  mult_add[1:0];

integer i;
integer j;

/////////////////////////////////////////////////////////////////////////
//line buffer datahold
always@(posedge iclk or negedge irst_n) begin
  if (!irst_n) begin
    for (i = 0; i < 7; i = i + 1) begin
      r_idata_s[i] <= 0;  
    end
  end
  else begin
    if (iDval) begin  //pipeline hold
      r_idata_s[0] <= idata_s;
      r_idata_s[1] <= r_idata_s[0];
      r_idata_s[2] <= r_idata_s[1];
      r_idata_s[3] <= r_idata_s[2];
      r_idata_s[4] <= r_idata_s[3];
      r_idata_s[5] <= r_idata_s[4];
      r_idata_s[6] <= r_idata_s[5];
    end
    else begin  //hold circuit
      r_idata_s[0] <= r_idata_s[0];
      r_idata_s[1] <= r_idata_s[1];
      r_idata_s[2] <= r_idata_s[2];
      r_idata_s[3] <= r_idata_s[3];
      r_idata_s[4] <= r_idata_s[4];
      r_idata_s[5] <= r_idata_s[5];
      r_idata_s[6] <= r_idata_s[6];
    end
  end  
end
/////////////////////////////////////////////////////////////////////////

always@(posedge iclk or negedge irst_n) begin
  if (!irst_n) begin
    for (j = 0; j < 7; j = j + 1) begin
      mult[j] <= 0;
    end
    mult_add[0] <= 0;
    mult_add[1] <= 0;
    odata <= 0;
  end
  else begin
    mult[0][15:0] <=  r_idata_s[0][7:0] * idata_0;
    mult[1][15:0] <=  r_idata_s[1][7:0] * idata_1;
    mult[2][15:0] <=  r_idata_s[2][7:0] * idata_2;
    mult[3][15:0] <=  r_idata_s[3][7:0] * idata_3;
    mult[4][15:0] <=  r_idata_s[4][7:0] * idata_4;
    mult[5][15:0] <=  r_idata_s[5][7:0] * idata_5;
    mult[6][15:0] <=  r_idata_s[6][7:0] * idata_6;
    mult_add[0][17:0] <= mult[0][15:0] + mult[1][15:0] + mult[2][15:0];
    mult_add[1][17:0] <= mult[3][15:0] + mult[4][15:0] + mult[5][15:0] + mult[6][15:0];
    mult[0][16] <=  r_idata_s[0][8];
    mult[1][16] <=  r_idata_s[1][8];
    mult[2][16] <=  r_idata_s[2][8];
    mult[3][16] <=  r_idata_s[3][8];
    mult[4][16] <=  r_idata_s[4][8];
    mult[5][16] <=  r_idata_s[5][8];
    mult[6][16] <=  r_idata_s[6][8];
    mult_add[0][18] <= mult[0][16];
    mult_add[1][18] <= mult[1][16];
    if (iDval) begin
      odata[18:0] <= mult_add[0][17:0] + mult_add[1][17:0];
      odata[19] <= mult_add[0][18];
    end
    else begin
      odata <= 0;
    end
  end
end

endmodule