`timescale 1 ps / 1 ps

module SIFTDetection (  
  input                                 iclk,
  input                                 irst_n,
  input                        [8:0]    idata0,
  input                        [8:0]    idata1,
  input                        [8:0]    idata2,
  output    	     		                okeypoint_en,
  output     reg                        odata_en
);

wire				stable_en;
wire				keypoint_en;
reg				keypoint_en_hold[7:0];

integer	i;

assign okeypoint_en = stable_en & keypoint_en_hold[7];

wire	[8:0] w_window_value [26:0]; 

Window_3x3 ImagePyramid_tb3(
	.iclk(iclk),
	.irst_n(irst_n),
	.idata(idata0),
	.odata0(w_window_value[0]),
	.odata1(w_window_value[1]),
	.odata2(w_window_value[2]),
	.odata3(w_window_value[3]),
	.odata4(w_window_value[4]),
	.odata5(w_window_value[5]),
	.odata6(w_window_value[6]),
	.odata7(w_window_value[7]),
	.odata8(w_window_value[8])
);

Window_3x3 ImagePyramid_tb4(
	.iclk(iclk),
	.irst_n(irst_n),
	.idata(idata1),
	.odata0(w_window_value[9]),
	.odata1(w_window_value[10]),
	.odata2(w_window_value[11]),
	.odata3(w_window_value[12]),
	.odata4(w_window_value[13]),
	.odata5(w_window_value[14]),
	.odata6(w_window_value[15]),
	.odata7(w_window_value[16]),
	.odata8(w_window_value[17])
);

Window_3x3 ImagePyramid_tb5(
	.iclk(iclk),
	.irst_n(irst_n),
	.idata(idata2),
	.odata0(w_window_value[18]),
	.odata1(w_window_value[19]),
	.odata2(w_window_value[20]),
	.odata3(w_window_value[21]),
	.odata4(w_window_value[22]),
	.odata5(w_window_value[23]),
	.odata6(w_window_value[24]),
	.odata7(w_window_value[25]),
	.odata8(w_window_value[26])
);

ExtremaDetection detectkeypoint1(  
  .iclk(iclk),
  .irst_n(irst_n),
  .iDval(),
  .iData_a(w_window_value[13][7:0]),
  .iData_b0(w_window_value[26][7:0]),
  .iData_b1(w_window_value[25][7:0]),
  .iData_b2(w_window_value[24][7:0]),
  .iData_b3(w_window_value[23][7:0]),
  .iData_b4(w_window_value[22][7:0]),
  .iData_b5(w_window_value[21][7:0]),
  .iData_b6(w_window_value[20][7:0]),
  .iData_b7(w_window_value[19][7:0]),
  .iData_b8(w_window_value[18][7:0]),
  .iData_b9(w_window_value[17][7:0]),
  .iData_b10(w_window_value[16][7:0]),
  .iData_b11(w_window_value[15][7:0]),
  .iData_b12(w_window_value[14][7:0]),
  .iData_b13(w_window_value[13][7:0]),
  .iData_b14(w_window_value[12][7:0]),
  .iData_b15(w_window_value[11][7:0]),
  .iData_b16(w_window_value[10][7:0]),
  .iData_b17(w_window_value[9][7:0]),
  .iData_b18(w_window_value[8][7:0]),
  .iData_b19(w_window_value[7][7:0]),
  .iData_b20(w_window_value[6][7:0]),
  .iData_b21(w_window_value[5][7:0]),
  .iData_b22(w_window_value[4][7:0]),
  .iData_b23(w_window_value[3][7:0]),
  .iData_b24(w_window_value[2][7:0]),
  .iData_b25(w_window_value[1][7:0]),
  .iData_b26(w_window_value[0][7:0]),
  .oDval(),
  .oExtrema_en(keypoint_en)
);

UnstableKeypointDetect detectkeypoint2(  
  .iclk(iclk),
  .irst_n(irst_n),
  .iData_mid_top_left({1'b0, w_window_value[17][7:0]}),
  .iData_mid_top({1'b0, w_window_value[16][7:0]}),
  .iData_mid_top_right({1'b0, w_window_value[15][7:0]}),
  .iData_mid_left({1'b0, w_window_value[14][7:0]}),
  .iData_mid({1'b0, w_window_value[13][7:0]}),
  .iData_mid_right({1'b0, w_window_value[12][7:0]}),
  .iData_mid_bot_left({1'b0, w_window_value[11][7:0]}),
  .iData_mid_bot({1'b0, w_window_value[10][7:0]}),
  .iData_mid_bot_right({1'b0, w_window_value[9][7:0]}),
  .iData_next_top({1'b0, w_window_value[25][7:0]}),
  .iData_next_left({1'b0, w_window_value[23][7:0]}),
  .iData_next({1'b0, w_window_value[22][7:0]}),
  .iData_next_right({1'b0, w_window_value[21][7:0]}),
  .iData_next_bot({1'b0, w_window_value[19][7:0]}),
  .iData_pre_top({1'b0, w_window_value[7][7:0]}),
  .iData_pre_left({1'b0, w_window_value[5][7:0]}),
  .iData_pre({1'b0, w_window_value[4][7:0]}),
  .iData_pre_right({1'b0, w_window_value[3][7:0]}),
  .iData_pre_bot({1'b0, w_window_value[1][7:0]}),
  .ostable_en(stable_en)
);

always@(posedge iclk or negedge irst_n) begin
	if (!irst_n) begin
		for (i = 0; i < 8; i = i + 1) begin
			keypoint_en_hold[i] <= 0;
		end
	end
	else begin
		keypoint_en_hold[0] <= keypoint_en;
		for (i = 0; i < 7; i = i + 1) begin
			keypoint_en_hold[i+1] <= keypoint_en_hold[i];
		end 
	end
end

reg           r_data_en  [11:0];
reg   [4:0]   j;

always@(posedge iclk or negedge irst_n) begin
  if (!irst_n) begin
    for (j = 0; j < 12; j = j + 1) begin
      r_data_en[j] <= 0;
    end
    odata_en <= 0;
  end  
  else begin
    r_data_en[0] <= w_window_value[3][8];
    for (j = 0; j < 11; j = j + 1) begin
      r_data_en[j+1] <= r_data_en[j];
    end
    odata_en <= r_data_en[11];
  end
end

endmodule 