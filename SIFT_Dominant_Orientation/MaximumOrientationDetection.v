`timescale 1 ps / 1 ps

module MaximumOrientationDetection(
	input 						       iclk,
	input 						       ireset,
	input              idata_en,
  input   [15:0]     istatistics_orientation0,
  input   [15:0]     istatistics_orientation1,
  input   [15:0]     istatistics_orientation2,
  input   [15:0]     istatistics_orientation3,
  input   [15:0]     istatistics_orientation4,
  input   [15:0]     istatistics_orientation5,
  input   [15:0]     istatistics_orientation6,
  input   [15:0]     istatistics_orientation7,
  input   [15:0]     istatistics_orientation8,
  input   [15:0]     istatistics_orientation9,
  input   [15:0]     istatistics_orientation10,
  input   [15:0]     istatistics_orientation11,
  input   [15:0]     istatistics_orientation12,
  input   [15:0]     istatistics_orientation13,
  input   [15:0]     istatistics_orientation14,
  input   [15:0]     istatistics_orientation15,
  input   [15:0]     istatistics_orientation16,
  input   [15:0]     istatistics_orientation17,
  input   [15:0]     istatistics_orientation18,
  input   [15:0]     istatistics_orientation19,
  input   [15:0]     istatistics_orientation20,
  input   [15:0]     istatistics_orientation21,
  input   [15:0]     istatistics_orientation22,
  input   [15:0]     istatistics_orientation23,
  input   [15:0]     istatistics_orientation24,
  input   [15:0]     istatistics_orientation25,
  input   [15:0]     istatistics_orientation26,
  input   [15:0]     istatistics_orientation27,
  input   [15:0]     istatistics_orientation28,
  input   [15:0]     istatistics_orientation29,
  input   [15:0]     istatistics_orientation30,
  input   [15:0]     istatistics_orientation31,
  input   [15:0]     istatistics_orientation32,
  input   [15:0]     istatistics_orientation33,
  input   [15:0]     istatistics_orientation34,
  input   [15:0]     istatistics_orientation35,
  output  [5:0]      omaximum_value,
  output    reg      odata_en
);

////////////////////////////////////////////////////////////////////////////
//Encode Orientation
reg  [5:0]     encode_i;
reg  [21:0]    encode_statistics_orientation[35:0];

always@(posedge iclk or negedge ireset) begin
  if (!ireset) begin
    for (encode_i = 0; encode_i < 36; encode_i = encode_i + 1) begin
        encode_statistics_orientation[encode_i] <= 0;
    end
  end
  else begin
    encode_statistics_orientation[0] <= {6'd0, istatistics_orientation0};
    encode_statistics_orientation[1] <= {6'd1, istatistics_orientation1};
    encode_statistics_orientation[2] <= {6'd2, istatistics_orientation2};
    encode_statistics_orientation[3] <= {6'd3, istatistics_orientation3};
    encode_statistics_orientation[4] <= {6'd4, istatistics_orientation4};
    encode_statistics_orientation[5] <= {6'd5, istatistics_orientation5};
    encode_statistics_orientation[6] <= {6'd6, istatistics_orientation6};
    encode_statistics_orientation[7] <= {6'd7, istatistics_orientation7};
    encode_statistics_orientation[8] <= {6'd8, istatistics_orientation8};
    encode_statistics_orientation[9] <= {6'd9, istatistics_orientation9};
    encode_statistics_orientation[10] <= {6'd10, istatistics_orientation10};
    encode_statistics_orientation[11] <= {6'd11, istatistics_orientation11};
    encode_statistics_orientation[12] <= {6'd12, istatistics_orientation12};
    encode_statistics_orientation[13] <= {6'd13, istatistics_orientation13};
    encode_statistics_orientation[14] <= {6'd14, istatistics_orientation14};
    encode_statistics_orientation[15] <= {6'd15, istatistics_orientation15};
    encode_statistics_orientation[16] <= {6'd16, istatistics_orientation16};
    encode_statistics_orientation[17] <= {6'd17, istatistics_orientation17};
    encode_statistics_orientation[18] <= {6'd18, istatistics_orientation18};
    encode_statistics_orientation[19] <= {6'd19, istatistics_orientation19};
    encode_statistics_orientation[20] <= {6'd20, istatistics_orientation20};
    encode_statistics_orientation[21] <= {6'd21, istatistics_orientation21};
    encode_statistics_orientation[22] <= {6'd22, istatistics_orientation22};
    encode_statistics_orientation[23] <= {6'd23, istatistics_orientation23};
    encode_statistics_orientation[24] <= {6'd24, istatistics_orientation24};
    encode_statistics_orientation[25] <= {6'd25, istatistics_orientation25};
    encode_statistics_orientation[26] <= {6'd26, istatistics_orientation26};
    encode_statistics_orientation[27] <= {6'd27, istatistics_orientation27};
    encode_statistics_orientation[28] <= {6'd28, istatistics_orientation28};
    encode_statistics_orientation[29] <= {6'd29, istatistics_orientation29};
    encode_statistics_orientation[30] <= {6'd30, istatistics_orientation30};
    encode_statistics_orientation[31] <= {6'd31, istatistics_orientation31};
    encode_statistics_orientation[32] <= {6'd32, istatistics_orientation32};
    encode_statistics_orientation[33] <= {6'd33, istatistics_orientation33};
    encode_statistics_orientation[34] <= {6'd34, istatistics_orientation34};
    encode_statistics_orientation[35] <= {6'd35, istatistics_orientation35};
  end
end

////////////////////////////////////////////////////////////////////////////
//biggest value of all

reg   [4:0]     j;
reg   [3:0]     k;
reg   [2:0]     h;
reg   [21:0]    big_layer1[17:0];
reg   [21:0]    big_layer2[8:0];
reg   [21:0]    big_layer3[3:0];
reg   [21:0]    big_hold3;
reg   [21:0]    big_layer4[1:0];
reg   [21:0]    big_hold4;
reg   [21:0]    big_layer5;
reg   [21:0]    big_hold5;
reg   [21:0]    big_layer6;

assign omaximum_value = big_layer6[21:16];

always@(posedge iclk or negedge ireset) begin
  if (!ireset) begin
    for (j = 0; j < 18; j = j + 1) begin
      big_layer1[j] <= 0;
    end
    for (k = 0; k < 9; k = k + 1) begin
      big_layer2[k] <= 0;
    end
    for (h = 0; h < 4; h = h + 1) begin
      big_layer3[h] <= 0;
    end
    big_hold3 <= 0;
    big_layer4[0] <= 0;
    big_layer4[1] <= 0;
    big_hold4 <= 0;
    big_layer5 <= 0;
    big_hold5 <= 0;
    big_layer6 <= 0;
  end
  else begin
    big_layer1[0] <= (encode_statistics_orientation[0][15:0] > encode_statistics_orientation[1][15:0]) ? encode_statistics_orientation[0] : encode_statistics_orientation[1];
    big_layer1[1] <= (encode_statistics_orientation[2][15:0] > encode_statistics_orientation[3][15:0]) ? encode_statistics_orientation[2] : encode_statistics_orientation[3];
    big_layer1[2] <= (encode_statistics_orientation[4][15:0] > encode_statistics_orientation[5][15:0]) ? encode_statistics_orientation[4] : encode_statistics_orientation[5];
    big_layer1[3] <= (encode_statistics_orientation[6][15:0] > encode_statistics_orientation[7][15:0]) ? encode_statistics_orientation[6] : encode_statistics_orientation[7];
    big_layer1[4] <= (encode_statistics_orientation[8][15:0] > encode_statistics_orientation[9][15:0]) ? encode_statistics_orientation[8] : encode_statistics_orientation[9];
    big_layer1[5] <= (encode_statistics_orientation[10][15:0] > encode_statistics_orientation[11][15:0]) ? encode_statistics_orientation[10] : encode_statistics_orientation[11];
    big_layer1[6] <= (encode_statistics_orientation[12][15:0] > encode_statistics_orientation[13][15:0]) ? encode_statistics_orientation[12] : encode_statistics_orientation[13];
    big_layer1[7] <= (encode_statistics_orientation[14][15:0] > encode_statistics_orientation[15][15:0]) ? encode_statistics_orientation[14] : encode_statistics_orientation[15];
    big_layer1[8] <= (encode_statistics_orientation[16][15:0] > encode_statistics_orientation[17][15:0]) ? encode_statistics_orientation[16] : encode_statistics_orientation[17];
    big_layer1[9] <= (encode_statistics_orientation[18][15:0] > encode_statistics_orientation[19][15:0]) ? encode_statistics_orientation[18] : encode_statistics_orientation[19];
    big_layer1[10] <= (encode_statistics_orientation[20][15:0] > encode_statistics_orientation[21][15:0]) ? encode_statistics_orientation[20] : encode_statistics_orientation[21];
    big_layer1[11] <= (encode_statistics_orientation[22][15:0] > encode_statistics_orientation[23][15:0]) ? encode_statistics_orientation[22] : encode_statistics_orientation[23];
    big_layer1[12] <= (encode_statistics_orientation[24][15:0] > encode_statistics_orientation[25][15:0]) ? encode_statistics_orientation[24] : encode_statistics_orientation[25];
    big_layer1[13] <= (encode_statistics_orientation[26][15:0] > encode_statistics_orientation[27][15:0]) ? encode_statistics_orientation[26] : encode_statistics_orientation[27];
    big_layer1[14] <= (encode_statistics_orientation[28][15:0] > encode_statistics_orientation[29][15:0]) ? encode_statistics_orientation[28] : encode_statistics_orientation[29];
    big_layer1[15] <= (encode_statistics_orientation[30][15:0] > encode_statistics_orientation[31][15:0]) ? encode_statistics_orientation[30] : encode_statistics_orientation[31];
    big_layer1[16] <= (encode_statistics_orientation[32][15:0] > encode_statistics_orientation[33][15:0]) ? encode_statistics_orientation[32] : encode_statistics_orientation[33];
    big_layer1[17] <= (encode_statistics_orientation[34][15:0] > encode_statistics_orientation[35][15:0]) ? encode_statistics_orientation[34] : encode_statistics_orientation[35];
    
    big_layer2[0] <= (big_layer1[0][15:0] > big_layer1[1][15:0]) ?  big_layer1[0] : big_layer1[1];
    big_layer2[1] <= (big_layer1[2][15:0] > big_layer1[3][15:0]) ?  big_layer1[2] : big_layer1[3];
    big_layer2[2] <= (big_layer1[4][15:0] > big_layer1[5][15:0]) ?  big_layer1[4] : big_layer1[5];
    big_layer2[3] <= (big_layer1[6][15:0] > big_layer1[7][15:0]) ?  big_layer1[6] : big_layer1[7];
    big_layer2[4] <= (big_layer1[8][15:0] > big_layer1[9][15:0]) ?  big_layer1[8] : big_layer1[9];
    big_layer2[5] <= (big_layer1[10][15:0] > big_layer1[11][15:0]) ?  big_layer1[10] : big_layer1[11];
    big_layer2[6] <= (big_layer1[12][15:0] > big_layer1[13][15:0]) ?  big_layer1[12] : big_layer1[13];
    big_layer2[7] <= (big_layer1[14][15:0] > big_layer1[15][15:0]) ?  big_layer1[14] : big_layer1[15];
    big_layer2[8] <= (big_layer1[16][15:0] > big_layer1[17][15:0]) ?  big_layer1[16] : big_layer1[17];
    
    big_layer3[0] <= (big_layer2[0][15:0] > big_layer2[1][15:0]) ? big_layer2[0] : big_layer2[1];
    big_layer3[1] <= (big_layer2[2][15:0] > big_layer2[3][15:0]) ? big_layer2[2] : big_layer2[3];
    big_layer3[2] <= (big_layer2[4][15:0] > big_layer2[5][15:0]) ? big_layer2[4] : big_layer2[5];
    big_layer3[3] <= (big_layer2[6][15:0] > big_layer2[7][15:0]) ? big_layer2[6] : big_layer2[7];
    big_hold3 <= big_layer2[8];
    
    big_layer4[0] <= (big_layer3[0][15:0] > big_layer3[1][15:0]) ? big_layer3[0] : big_layer3[1];
    big_layer4[1] <= (big_layer3[2][15:0] > big_layer3[3][15:0]) ? big_layer3[2] : big_layer3[3];
    big_hold4 <= big_hold3;
    
    big_layer5 <= (big_layer4[0][15:0] > big_layer4[1][15:0]) ? big_layer4[0] : big_layer4[1];
    big_hold5 <= big_hold4;
    
    big_layer6 <= (big_layer5[15:0] > big_hold5[15:0]) ? big_layer5 : big_hold5;
  end
end

reg r_data_en[5:0];

////////////////////////////////////////////////////////////////////////////
//enable signal data holding
always@(posedge iclk or negedge ireset) begin
  if (!ireset) begin
    r_data_en[0] <= 0;
    r_data_en[1] <= 0;
    r_data_en[2] <= 0;
    r_data_en[3] <= 0;
    r_data_en[4] <= 0;
    r_data_en[5] <= 0;
    odata_en <= 0;
  end
  else begin
    r_data_en[0] <= idata_en;
    r_data_en[1] <= r_data_en[0];
    r_data_en[2] <= r_data_en[1];
    r_data_en[3] <= r_data_en[2];
    r_data_en[4] <= r_data_en[3];
    r_data_en[5] <= r_data_en[4];
    odata_en <= r_data_en[5];
  end
end
////////////////////////////////////////////////////////////////////////////

endmodule 
