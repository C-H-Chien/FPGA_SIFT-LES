`timescale 1 ps / 1 ps

module GaussianFilter (
  input                   iclk,
  input                   irst_n,
  input                   iRead_en,
  input         [2:0]     iGaussian_num,
  input         [8:0]     Line0,
  input         [8:0]     Line1,
  input         [8:0]     Line2,
  input         [8:0]     Line3,
  input         [8:0]     Line4,
  input         [8:0]     Line5,
  input         [8:0]     Line6,
  output  reg   [8:0]     GaussianPixelData
);

reg   [7:0]     X[48:0];
wire  [19:0]    Mac_x[6:0];
reg   [19:0]    Mac_x_add[1:0];
reg   [19:0]    Mac_x_add_value;

integer         i;

always@(posedge iclk or negedge irst_n) begin
  if (!irst_n) begin
    for (i = 0; i < 49; i = i + 1) begin
      X[i] = 0;
    end  
  end
  else begin
    case (iGaussian_num)
      3'b001: begin
X[0] <= 8'h0;
X[1] <= 8'h1;
X[2] <= 8'h4;
X[3] <= 8'h5;
X[4] <= 8'h4;
X[5] <= 8'h1;
X[6] <= 8'h0;
X[7] <= 8'h1;
X[8] <= 8'h7;
X[9] <= 8'h14;
X[10] <= 8'h1c;
X[11] <= 8'h14;
X[12] <= 8'h7;
X[13] <= 8'h1;
X[14] <= 8'h4;
X[15] <= 8'h14;
X[16] <= 8'h39;
X[17] <= 8'h50;
X[18] <= 8'h39;
X[19] <= 8'h14;
X[20] <= 8'h4;
X[21] <= 8'h5;
X[22] <= 8'h1c;
X[23] <= 8'h50;
X[24] <= 8'h72;
X[25] <= 8'h50;
X[26] <= 8'h1c;
X[27] <= 8'h5;
X[28] <= 8'h4;
X[29] <= 8'h14;
X[30] <= 8'h39;
X[31] <= 8'h50;
X[32] <= 8'h39;
X[33] <= 8'h14;
X[34] <= 8'h4;
X[35] <= 8'h1;
X[36] <= 8'h7;
X[37] <= 8'h14;
X[38] <= 8'h1c;
X[39] <= 8'h14;
X[40] <= 8'h7;
X[41] <= 8'h1;
X[42] <= 8'h0;
X[43] <= 8'h1;
X[44] <= 8'h4;
X[45] <= 8'h5;
X[46] <= 8'h4;
X[47] <= 8'h1;
X[48] <= 8'h0;
      end
      3'b010: begin
X[0] <= 8'h0;
X[1] <= 8'h1;
X[2] <= 8'h3;
X[3] <= 8'h4;
X[4] <= 8'h3;
X[5] <= 8'h1;
X[6] <= 8'h0;
X[7] <= 8'h1;
X[8] <= 8'h6;
X[9] <= 8'h13;
X[10] <= 8'h1b;
X[11] <= 8'h13;
X[12] <= 8'h6;
X[13] <= 8'h1;
X[14] <= 8'h3;
X[15] <= 8'h13;
X[16] <= 8'h3a;
X[17] <= 8'h55;
X[18] <= 8'h3a;
X[19] <= 8'h13;
X[20] <= 8'h3;
X[21] <= 8'h4;
X[22] <= 8'h1b;
X[23] <= 8'h55;
X[24] <= 8'h7c;
X[25] <= 8'h55;
X[26] <= 8'h1b;
X[27] <= 8'h4;
X[28] <= 8'h3;
X[29] <= 8'h13;
X[30] <= 8'h3a;
X[31] <= 8'h55;
X[32] <= 8'h3a;
X[33] <= 8'h13;
X[34] <= 8'h3;
X[35] <= 8'h1;
X[36] <= 8'h6;
X[37] <= 8'h13;
X[38] <= 8'h1b;
X[39] <= 8'h13;
X[40] <= 8'h6;
X[41] <= 8'h1;
X[42] <= 8'h0;
X[43] <= 8'h1;
X[44] <= 8'h3;
X[45] <= 8'h4;
X[46] <= 8'h3;
X[47] <= 8'h1;
X[48] <= 8'h0;
      end
      3'b011: begin
X[0] <= 8'h0;
X[1] <= 8'h2;
X[2] <= 8'h5;
X[3] <= 8'h7;
X[4] <= 8'h5;
X[5] <= 8'h2;
X[6] <= 8'h0;
X[7] <= 8'h2;
X[8] <= 8'h9;
X[9] <= 8'h16;
X[10] <= 8'h1e;
X[11] <= 8'h16;
X[12] <= 8'h9;
X[13] <= 8'h2;
X[14] <= 8'h5;
X[15] <= 8'h16;
X[16] <= 8'h36;
X[17] <= 8'h49;
X[18] <= 8'h36;
X[19] <= 8'h16;
X[20] <= 8'h5;
X[21] <= 8'h7;
X[22] <= 8'h1e;
X[23] <= 8'h49;
X[24] <= 8'h62;
X[25] <= 8'h49;
X[26] <= 8'h1e;
X[27] <= 8'h7;
X[28] <= 8'h5;
X[29] <= 8'h16;
X[30] <= 8'h36;
X[31] <= 8'h49;
X[32] <= 8'h36;
X[33] <= 8'h16;
X[34] <= 8'h5;
X[35] <= 8'h2;
X[36] <= 8'h9;
X[37] <= 8'h16;
X[38] <= 8'h1e;
X[39] <= 8'h16;
X[40] <= 8'h9;
X[41] <= 8'h2;
X[42] <= 8'h0;
X[43] <= 8'h2;
X[44] <= 8'h5;
X[45] <= 8'h7;
X[46] <= 8'h5;
X[47] <= 8'h2;
X[48] <= 8'h0;
      end
      3'b100: begin
X[0] <= 8'h2;
X[1] <= 8'h6;
X[2] <= 8'ha;
X[3] <= 8'hc;
X[4] <= 8'ha;
X[5] <= 8'h6;
X[6] <= 8'h2;
X[7] <= 8'h6;
X[8] <= 8'he;
X[9] <= 8'h19;
X[10] <= 8'h1f;
X[11] <= 8'h19;
X[12] <= 8'he;
X[13] <= 8'h6;
X[14] <= 8'ha;
X[15] <= 8'h19;
X[16] <= 8'h2d;
X[17] <= 8'h36;
X[18] <= 8'h2d;
X[19] <= 8'h19;
X[20] <= 8'ha;
X[21] <= 8'hc;
X[22] <= 8'h1f;
X[23] <= 8'h36;
X[24] <= 8'h42;
X[25] <= 8'h36;
X[26] <= 8'h1f;
X[27] <= 8'hc;
X[28] <= 8'ha;
X[29] <= 8'h19;
X[30] <= 8'h2d;
X[31] <= 8'h36;
X[32] <= 8'h2d;
X[33] <= 8'h19;
X[34] <= 8'ha;
X[35] <= 8'h6;
X[36] <= 8'he;
X[37] <= 8'h19;
X[38] <= 8'h1f;
X[39] <= 8'h19;
X[40] <= 8'he;
X[41] <= 8'h6;
X[42] <= 8'h2;
X[43] <= 8'h6;
X[44] <= 8'ha;
X[45] <= 8'hc;
X[46] <= 8'ha;
X[47] <= 8'h6;
X[48] <= 8'h2;
      end
      3'b101: begin
        X[0] <= 8'h4;
        X[1] <= 8'h8;
        X[2] <= 8'hc;
        X[3] <= 8'he;
        X[4] <= 8'hc;
        X[5] <= 8'h8;
        X[6] <= 8'h4;
        X[7] <= 8'h8;
        X[8] <= 8'h10;
        X[9] <= 8'h1a;
        X[10] <= 8'h1e;
        X[11] <= 8'h1a;
        X[12] <= 8'h10;
        X[13] <= 8'h8;
        X[14] <= 8'hc;
        X[15] <= 8'h1a;
        X[16] <= 8'h28;
        X[17] <= 8'h2f;
        X[18] <= 8'h28;
        X[19] <= 8'h1a;
        X[20] <= 8'hc;
        X[21] <= 8'he;
        X[22] <= 8'h1e;
        X[23] <= 8'h2f;
        X[24] <= 8'h36;
        X[25] <= 8'h2f;
        X[26] <= 8'h1e;
        X[27] <= 8'he;
        X[28] <= 8'hc;
        X[29] <= 8'h1a;
        X[30] <= 8'h28;
        X[31] <= 8'h2f;
        X[32] <= 8'h28;
        X[33] <= 8'h1a;
        X[34] <= 8'hc;
        X[35] <= 8'h8;
        X[36] <= 8'h10;
        X[37] <= 8'h1a;
        X[38] <= 8'h1e;
        X[39] <= 8'h1a;
        X[40] <= 8'h10;
        X[41] <= 8'h8;
        X[42] <= 8'h4;
        X[43] <= 8'h8;
        X[44] <= 8'hc;
        X[45] <= 8'he;
        X[46] <= 8'hc;
        X[47] <= 8'h8;
        X[48] <= 8'h4;
      end
      3'b110: begin
        X[0] <= 8'h7;
        X[1] <= 8'hb;
        X[2] <= 8'hf;
        X[3] <= 8'h11;
        X[4] <= 8'hf;
        X[5] <= 8'hb;
        X[6] <= 8'h7;
        X[7] <= 8'hb;
        X[8] <= 8'h13;
        X[9] <= 8'h19;
        X[10] <= 8'h1c;
        X[11] <= 8'h19;
        X[12] <= 8'h13;
        X[13] <= 8'hb;
        X[14] <= 8'hf;
        X[15] <= 8'h19;
        X[16] <= 8'h22;
        X[17] <= 8'h26;
        X[18] <= 8'h22;
        X[19] <= 8'h19;
        X[20] <= 8'hf;
        X[21] <= 8'h11;
        X[22] <= 8'h1c;
        X[23] <= 8'h26;
        X[24] <= 8'h2a;
        X[25] <= 8'h26;
        X[26] <= 8'h1c;
        X[27] <= 8'h11;
        X[28] <= 8'hf;
        X[29] <= 8'h19;
        X[30] <= 8'h22;
        X[31] <= 8'h26;
        X[32] <= 8'h22;
        X[33] <= 8'h19;
        X[34] <= 8'hf;
        X[35] <= 8'hb;
        X[36] <= 8'h13;
        X[37] <= 8'h19;
        X[38] <= 8'h1c;
        X[39] <= 8'h19;
        X[40] <= 8'h13;
        X[41] <= 8'hb;
        X[42] <= 8'h7;
        X[43] <= 8'hb;
        X[44] <= 8'hf;
        X[45] <= 8'h11;
        X[46] <= 8'hf;
        X[47] <= 8'hb;
        X[48] <= 8'h7;
      end
    endcase 
  end
end

MAC_3 x0(
  .iclk(iclk),
	.irst_n(irst_n),
	.iDval(iRead_en),
	.idata_s(Line0),
	.idata_0(X[48]),
	.idata_1(X[47]),
	.idata_2(X[46]),
	.idata_3(X[45]),
	.idata_4(X[44]),
	.idata_5(X[43]),
	.idata_6(X[42]),
	.odata(Mac_x[0])
);

MAC_3 x1(
  .iclk(iclk),
	.irst_n(irst_n),
	.iDval(iRead_en),
	.idata_s(Line1),
	.idata_0(X[41]),
	.idata_1(X[40]),
	.idata_2(X[39]),
	.idata_3(X[38]),
	.idata_4(X[37]),
	.idata_5(X[36]),
	.idata_6(X[35]),
	.odata(Mac_x[1])
);

MAC_3 x2(
  .iclk(iclk),
	.irst_n(irst_n),
	.iDval(iRead_en),
	.idata_s(Line2),
	.idata_0(X[34]),
	.idata_1(X[33]),
	.idata_2(X[32]),
	.idata_3(X[31]),
	.idata_4(X[30]),
	.idata_5(X[29]),
	.idata_6(X[28]),
	.odata(Mac_x[2])
);

MAC_3 x3(
  .iclk(iclk),
	.irst_n(irst_n),
	.iDval(iRead_en),
	.idata_s(Line3),
	.idata_0(X[27]),
	.idata_1(X[26]),
	.idata_2(X[25]),
	.idata_3(X[24]),
	.idata_4(X[23]),
	.idata_5(X[22]),
	.idata_6(X[21]),
	.odata(Mac_x[3])
);

MAC_3 x4(
  .iclk(iclk),
	.irst_n(irst_n),
	.iDval(iRead_en),
	.idata_s(Line4),
	.idata_0(X[20]),
	.idata_1(X[19]),
	.idata_2(X[18]),
	.idata_3(X[17]),
	.idata_4(X[16]),
	.idata_5(X[15]),
	.idata_6(X[14]),
	.odata(Mac_x[4])
);

MAC_3 x5(
  .iclk(iclk),
	.irst_n(irst_n),
	.iDval(iRead_en),
	.idata_s(Line5),
	.idata_0(X[13]),
	.idata_1(X[12]),
	.idata_2(X[11]),
	.idata_3(X[10]),
	.idata_4(X[9]),
	.idata_5(X[8]),
	.idata_6(X[7]),
	.odata(Mac_x[5])
);

MAC_3 x6(
  .iclk(iclk),
	.irst_n(irst_n),
	.iDval(iRead_en),
	.idata_s(Line6),
	.idata_0(X[6]),
	.idata_1(X[5]),
	.idata_2(X[4]),
	.idata_3(X[3]),
	.idata_4(X[2]),
	.idata_5(X[1]),
	.idata_6(X[0]),
	.odata(Mac_x[6])
);

always@(posedge iclk or negedge irst_n) begin
  if (!irst_n) begin
    Mac_x_add[0] <= 0;
    Mac_x_add[1] <= 0;
    Mac_x_add_value <= 0;
    GaussianPixelData <= 0;
  end
  else begin
    Mac_x_add[0][18:0] <= Mac_x[0][18:0] + Mac_x[1][18:0] + Mac_x[2][18:0];
    Mac_x_add[1][18:0] <= Mac_x[3][18:0] + Mac_x[4][18:0] + Mac_x[5][18:0] + Mac_x[6][18:0];
    Mac_x_add_value[18:0] <= Mac_x_add[0][18:0] + Mac_x_add[1][18:0];
    Mac_x_add[0][19] <= Mac_x[3][19];
    Mac_x_add[1][19] <= Mac_x[3][19];
    Mac_x_add_value[19] <= Mac_x_add[0][19];
    if (iRead_en) begin
      GaussianPixelData[8] <= Mac_x_add_value[19];
      GaussianPixelData[7:0] <= Mac_x_add_value[17:10]; //Mac_x_add_value[17:0] >> 10
    end
    else begin
      GaussianPixelData <= 0;
    end 
  end
end

endmodule 
