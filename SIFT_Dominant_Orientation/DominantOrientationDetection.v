`timescale 1 ps / 1 ps

module DominantOrientationDetection(
	input 						       iclk,
	input 						       iclk_8,
	input              idata_en,
	input 						       ireset,
	input			[8:0]	 	 	 itop,
	input			[8:0]	 		  ileft,
	input 		[8:0]			   iright,
	input			[8:0]	 		  ibot,
	output             odominant_orientation_en,
  output  [5:0]      odominant_orientation
);

wire  [15:0]    w_magnitude;
wire  [15:0]    w_orientation;
wire            w_ImageGradient_en;

ImageGradient OrientationDetection1(
	.iclk(iclk),
	.ireset(ireset),
	.itop(itop),
	.ileft(ileft),
	.iright(iright),
	.ibot(ibot),
	.omagnitude(w_magnitude),
	.oorientation(w_orientation),
	.odata_en(w_ImageGradient_en)
);

reg   [2:0]     i;
reg   [17:0]    magnitude_cal[1:0];
reg   [13:0]    orientation_cal[1:0];
reg   [8:0]     magnitude_real;
reg   [5:0]     orientation_real;
reg             r_CORDIC_en[2:0];

////////////////////////////////////////////////////////////////////////////
//CORDIC answer transfer
always@(posedge iclk or negedge ireset) begin
  if (!ireset) begin
    for (i = 0; i < 2; i = i+1) begin      
      magnitude_cal[i] <= 0;
      orientation_cal[i] <= 0;
    end      
    magnitude_real <= 0;
    orientation_real <= 0;
    ////////////////////////////////////////////////////////////////////////////
    r_CORDIC_en[0] <= 0;
    r_CORDIC_en[1] <= 0;
    r_CORDIC_en[2] <= 0;
    ////////////////////////////////////////////////////////////////////////////
  end
  else begin  // (magnitude >> 6) * K    (orientation / 10) 
    magnitude_cal[0] <= w_magnitude >> 6; 
    orientation_cal[0] <= w_orientation >> 6;  	
    magnitude_cal[1] <= magnitude_cal[0] * 311;
    orientation_cal[1] <= orientation_cal[0] * 13;
    magnitude_real <= magnitude_cal[1] >> 9;
    orientation_real <= orientation_cal[1] >> 7;
    ////////////////////////////////////////////////////////////////////////////
    r_CORDIC_en[0] <= w_ImageGradient_en;
    r_CORDIC_en[1] <= r_CORDIC_en[0];
    r_CORDIC_en[2] <= r_CORDIC_en[1];
    ////////////////////////////////////////////////////////////////////////////
  end 
end
////////////////////////////////////////////////////////////////////////////////
//Line Buffer and DCFIFO Encode

wire  [15:0]  gradient;
wire  [15:0]  buffer_gradient[6:0];

assign gradient = {r_CORDIC_en[2], orientation_real, magnitude_real};  //high angle, low magnitude

////////////////////////////////////////////////////////////////////////////////
Orientation_LibeBuffer7x7 OrientationDetection2(
	.aclr(!ireset),
	.clken(gradient[15]),
	.clock(iclk),
	.shiftin(gradient),
	.taps0x(buffer_gradient[0]),
	.taps1x(buffer_gradient[1]),
	.taps2x(buffer_gradient[2]),
	.taps3x(buffer_gradient[3]),
	.taps4x(buffer_gradient[4]),
	.taps5x(buffer_gradient[5]),
	.taps6x(buffer_gradient[6])
);


reg  [127:0]  DCFIFO_gradient;

/////////////////////////////////////////////////////////////////////////////////
//mask time
 
always@(posedge iclk or negedge ireset) begin
  if (!ireset) begin
    DCFIFO_gradient <= 0;
  end
  else begin
    if (buffer_gradient[3][15]) begin
      DCFIFO_gradient = {16'h0000, buffer_gradient[6], buffer_gradient[5], buffer_gradient[4], buffer_gradient[3], buffer_gradient[2], buffer_gradient[1], buffer_gradient[0]};
    end
    else begin
      DCFIFO_gradient <= 0;
    end
  end
end
////////////////////////////////////////////////////////////////////////////////

wire    [15:0]    w_DCFIFO_data;
wire              w_read_request;
wire    [10:0]    w_readusedw;
wire    [7:0]     w_writeusedw;

DCFIFO_Controller   OrientationDetection3(
		.iclk_input(iclk),     //50M
		.iclk_output(iclk_8),    //400M
		.ireset(ireset),
		.idata(DCFIFO_gradient),
		.oread_request(w_read_request),
		.odata(w_DCFIFO_data),
		.rdusedw(w_readusedw),
		.wrusedw(w_writeusedw)
);

////////////////////////////////////////////////////////////////////////////

wire            w_gradient_en;
wire  [14:0]    w_gradient_data;
wire            w_initial;
wire            w_satisfact_finish_signal;

InitialCounter OrientationDetection4(
	.iclk(iclk_8),
	.ireset(ireset),
	.idata_en(w_DCFIFO_data[15]),
	.idata(w_DCFIFO_data[14:0]),
	.odata_en(w_gradient_en),
	.odata(w_gradient_data),
  .oinitial_signal(w_initial),
  .osatisfact_finish_signal(w_satisfact_finish_signal)
);

/////////////////////////////////////////////////////////////////////////////////////////
reg           w_satisfact_finish_signal_hold [8:0];
reg   [4:0]   j;

always@(posedge iclk_8 or negedge ireset) begin
  if (!ireset) begin
    for (j = 0; j < 9; j = j + 1) begin
      w_satisfact_finish_signal_hold[j] <= 0;
    end        
  end
  else begin
    w_satisfact_finish_signal_hold[0] <= w_satisfact_finish_signal;
    for (j = 0; j < 8; j = j + 1) begin
      w_satisfact_finish_signal_hold[j+1] <= w_satisfact_finish_signal_hold[j];
    end 
  end
end

/////////////////////////////////////////////////////////////////////////////////////////
wire  [15:0]    w_statistics_orientation[71:0];
wire  [15:0]    w_statistics_orientation_MUX[35:0];
wire            w_initial_MUX;
wire            w_StatisticsOrientationMagnitude_en;

StatisticsOrientationMagnitude OrientationDetection5(
	.iclk(iclk_8),
	.ireset(ireset),
	.idata_en(w_gradient_en),
	.iinitial(w_initial),
	.imagnitude(w_gradient_data[8:0]),
	.iorientation(w_gradient_data[14:9]),
	.odata_en(w_StatisticsOrientationMagnitude_en),
	.oinitial(w_initial_MUX),
	.statistics_orientation0(w_statistics_orientation[0]),
	.statistics_orientation1(w_statistics_orientation[1]),
	.statistics_orientation2(w_statistics_orientation[2]),
	.statistics_orientation3(w_statistics_orientation[3]),
	.statistics_orientation4(w_statistics_orientation[4]),
	.statistics_orientation5(w_statistics_orientation[5]),
	.statistics_orientation6(w_statistics_orientation[6]),
	.statistics_orientation7(w_statistics_orientation[7]),
	.statistics_orientation8(w_statistics_orientation[8]),
	.statistics_orientation9(w_statistics_orientation[9]),
	.statistics_orientation10(w_statistics_orientation[10]),
	.statistics_orientation11(w_statistics_orientation[11]),
	.statistics_orientation12(w_statistics_orientation[12]),
	.statistics_orientation13(w_statistics_orientation[13]),
	.statistics_orientation14(w_statistics_orientation[14]),
	.statistics_orientation15(w_statistics_orientation[15]),
	.statistics_orientation16(w_statistics_orientation[16]),
	.statistics_orientation17(w_statistics_orientation[17]),
	.statistics_orientation18(w_statistics_orientation[18]),
	.statistics_orientation19(w_statistics_orientation[19]),
	.statistics_orientation20(w_statistics_orientation[20]),
	.statistics_orientation21(w_statistics_orientation[21]),
	.statistics_orientation22(w_statistics_orientation[22]),
	.statistics_orientation23(w_statistics_orientation[23]),
	.statistics_orientation24(w_statistics_orientation[24]),
	.statistics_orientation25(w_statistics_orientation[25]),
	.statistics_orientation26(w_statistics_orientation[26]),
	.statistics_orientation27(w_statistics_orientation[27]),
	.statistics_orientation28(w_statistics_orientation[28]),
	.statistics_orientation29(w_statistics_orientation[29]),
	.statistics_orientation30(w_statistics_orientation[30]),
	.statistics_orientation31(w_statistics_orientation[31]),
	.statistics_orientation32(w_statistics_orientation[32]),
	.statistics_orientation33(w_statistics_orientation[33]),
	.statistics_orientation34(w_statistics_orientation[34]),
	.statistics_orientation35(w_statistics_orientation[35])
);

StatisticsOrientationMagnitude OrientationDetection6(
	.iclk(iclk_8),
	.ireset(ireset),
	.idata_en(w_gradient_en),
	.iinitial(!w_initial),
	.imagnitude(w_gradient_data[8:0]),
	.iorientation(w_gradient_data[14:9]),
	.statistics_orientation0(w_statistics_orientation[36]),
	.statistics_orientation1(w_statistics_orientation[37]),
	.statistics_orientation2(w_statistics_orientation[38]),
	.statistics_orientation3(w_statistics_orientation[39]),
	.statistics_orientation4(w_statistics_orientation[40]),
	.statistics_orientation5(w_statistics_orientation[41]),
	.statistics_orientation6(w_statistics_orientation[42]),
	.statistics_orientation7(w_statistics_orientation[43]),
	.statistics_orientation8(w_statistics_orientation[44]),
	.statistics_orientation9(w_statistics_orientation[45]),
	.statistics_orientation10(w_statistics_orientation[46]),
	.statistics_orientation11(w_statistics_orientation[47]),
	.statistics_orientation12(w_statistics_orientation[48]),
	.statistics_orientation13(w_statistics_orientation[49]),
	.statistics_orientation14(w_statistics_orientation[50]),
	.statistics_orientation15(w_statistics_orientation[51]),
	.statistics_orientation16(w_statistics_orientation[52]),
	.statistics_orientation17(w_statistics_orientation[53]),
	.statistics_orientation18(w_statistics_orientation[54]),
	.statistics_orientation19(w_statistics_orientation[55]),
	.statistics_orientation20(w_statistics_orientation[56]),
	.statistics_orientation21(w_statistics_orientation[57]),
	.statistics_orientation22(w_statistics_orientation[58]),
	.statistics_orientation23(w_statistics_orientation[59]),
	.statistics_orientation24(w_statistics_orientation[60]),
	.statistics_orientation25(w_statistics_orientation[61]),
	.statistics_orientation26(w_statistics_orientation[62]),
	.statistics_orientation27(w_statistics_orientation[63]),
	.statistics_orientation28(w_statistics_orientation[64]),
	.statistics_orientation29(w_statistics_orientation[65]),
	.statistics_orientation30(w_statistics_orientation[66]),
	.statistics_orientation31(w_statistics_orientation[67]),
	.statistics_orientation32(w_statistics_orientation[68]),
	.statistics_orientation33(w_statistics_orientation[69]),
	.statistics_orientation34(w_statistics_orientation[70]),
	.statistics_orientation35(w_statistics_orientation[71])
);

wire  w_StatisticsOrientationMUX_en;

StatisticsOrientationMUX OrientationDetection7(
	.iclk(iclk_8),
	.ireset(ireset),
	.idata_en(w_StatisticsOrientationMagnitude_en),
	.iselect_MUX(w_initial_MUX),
	.istatistics_orientation0(w_statistics_orientation[0]),
	.istatistics_orientation1(w_statistics_orientation[1]),
	.istatistics_orientation2(w_statistics_orientation[2]),
	.istatistics_orientation3(w_statistics_orientation[3]),
	.istatistics_orientation4(w_statistics_orientation[4]),
	.istatistics_orientation5(w_statistics_orientation[5]),
	.istatistics_orientation6(w_statistics_orientation[6]),
	.istatistics_orientation7(w_statistics_orientation[7]),
	.istatistics_orientation8(w_statistics_orientation[8]),
	.istatistics_orientation9(w_statistics_orientation[9]),
	.istatistics_orientation10(w_statistics_orientation[10]),
	.istatistics_orientation11(w_statistics_orientation[11]),
	.istatistics_orientation12(w_statistics_orientation[12]),
	.istatistics_orientation13(w_statistics_orientation[13]),
	.istatistics_orientation14(w_statistics_orientation[14]),
	.istatistics_orientation15(w_statistics_orientation[15]),
	.istatistics_orientation16(w_statistics_orientation[16]),
	.istatistics_orientation17(w_statistics_orientation[17]),
	.istatistics_orientation18(w_statistics_orientation[18]),
	.istatistics_orientation19(w_statistics_orientation[19]),
	.istatistics_orientation20(w_statistics_orientation[20]),
	.istatistics_orientation21(w_statistics_orientation[21]),
	.istatistics_orientation22(w_statistics_orientation[22]),
	.istatistics_orientation23(w_statistics_orientation[23]),
	.istatistics_orientation24(w_statistics_orientation[24]),
	.istatistics_orientation25(w_statistics_orientation[25]),
	.istatistics_orientation26(w_statistics_orientation[26]),
	.istatistics_orientation27(w_statistics_orientation[27]),
	.istatistics_orientation28(w_statistics_orientation[28]),
	.istatistics_orientation29(w_statistics_orientation[29]),
	.istatistics_orientation30(w_statistics_orientation[30]),
	.istatistics_orientation31(w_statistics_orientation[31]),
	.istatistics_orientation32(w_statistics_orientation[32]),
	.istatistics_orientation33(w_statistics_orientation[33]),
	.istatistics_orientation34(w_statistics_orientation[34]),
	.istatistics_orientation35(w_statistics_orientation[35]),
	.istatistics_orientation36(w_statistics_orientation[36]),
	.istatistics_orientation37(w_statistics_orientation[37]),
	.istatistics_orientation38(w_statistics_orientation[38]),
	.istatistics_orientation39(w_statistics_orientation[39]),
	.istatistics_orientation40(w_statistics_orientation[40]),
	.istatistics_orientation41(w_statistics_orientation[41]),
	.istatistics_orientation42(w_statistics_orientation[42]),
	.istatistics_orientation43(w_statistics_orientation[43]),
	.istatistics_orientation44(w_statistics_orientation[44]),
	.istatistics_orientation45(w_statistics_orientation[45]),
	.istatistics_orientation46(w_statistics_orientation[46]),
	.istatistics_orientation47(w_statistics_orientation[47]),
	.istatistics_orientation48(w_statistics_orientation[48]),
	.istatistics_orientation49(w_statistics_orientation[49]),
	.istatistics_orientation50(w_statistics_orientation[50]),
	.istatistics_orientation51(w_statistics_orientation[51]),
	.istatistics_orientation52(w_statistics_orientation[52]),
	.istatistics_orientation53(w_statistics_orientation[53]),
	.istatistics_orientation54(w_statistics_orientation[54]),
	.istatistics_orientation55(w_statistics_orientation[55]),
	.istatistics_orientation56(w_statistics_orientation[56]),
	.istatistics_orientation57(w_statistics_orientation[57]),
	.istatistics_orientation58(w_statistics_orientation[58]),
	.istatistics_orientation59(w_statistics_orientation[59]),
	.istatistics_orientation60(w_statistics_orientation[60]),
	.istatistics_orientation61(w_statistics_orientation[61]),
	.istatistics_orientation62(w_statistics_orientation[62]),
	.istatistics_orientation63(w_statistics_orientation[63]),
	.istatistics_orientation64(w_statistics_orientation[64]),
	.istatistics_orientation65(w_statistics_orientation[65]),
	.istatistics_orientation66(w_statistics_orientation[66]),
	.istatistics_orientation67(w_statistics_orientation[67]),
	.istatistics_orientation68(w_statistics_orientation[68]),
	.istatistics_orientation69(w_statistics_orientation[69]),
	.istatistics_orientation70(w_statistics_orientation[70]),
	.istatistics_orientation71(w_statistics_orientation[71]),
	.ostatistics_orientation0(w_statistics_orientation_MUX[0]),
	.ostatistics_orientation1(w_statistics_orientation_MUX[1]),
	.ostatistics_orientation2(w_statistics_orientation_MUX[2]),
	.ostatistics_orientation3(w_statistics_orientation_MUX[3]),
	.ostatistics_orientation4(w_statistics_orientation_MUX[4]),
	.ostatistics_orientation5(w_statistics_orientation_MUX[5]),
	.ostatistics_orientation6(w_statistics_orientation_MUX[6]),
	.ostatistics_orientation7(w_statistics_orientation_MUX[7]),
	.ostatistics_orientation8(w_statistics_orientation_MUX[8]),
	.ostatistics_orientation9(w_statistics_orientation_MUX[9]),
	.ostatistics_orientation10(w_statistics_orientation_MUX[10]),
	.ostatistics_orientation11(w_statistics_orientation_MUX[11]),
	.ostatistics_orientation12(w_statistics_orientation_MUX[12]),
	.ostatistics_orientation13(w_statistics_orientation_MUX[13]),
	.ostatistics_orientation14(w_statistics_orientation_MUX[14]),
	.ostatistics_orientation15(w_statistics_orientation_MUX[15]),
	.ostatistics_orientation16(w_statistics_orientation_MUX[16]),
	.ostatistics_orientation17(w_statistics_orientation_MUX[17]),
	.ostatistics_orientation18(w_statistics_orientation_MUX[18]),
	.ostatistics_orientation19(w_statistics_orientation_MUX[19]),
	.ostatistics_orientation20(w_statistics_orientation_MUX[20]),
	.ostatistics_orientation21(w_statistics_orientation_MUX[21]),
	.ostatistics_orientation22(w_statistics_orientation_MUX[22]),
	.ostatistics_orientation23(w_statistics_orientation_MUX[23]),
	.ostatistics_orientation24(w_statistics_orientation_MUX[24]),
	.ostatistics_orientation25(w_statistics_orientation_MUX[25]),
	.ostatistics_orientation26(w_statistics_orientation_MUX[26]),
	.ostatistics_orientation27(w_statistics_orientation_MUX[27]),
	.ostatistics_orientation28(w_statistics_orientation_MUX[28]),
	.ostatistics_orientation29(w_statistics_orientation_MUX[29]),
	.ostatistics_orientation30(w_statistics_orientation_MUX[30]),
	.ostatistics_orientation31(w_statistics_orientation_MUX[31]),
	.ostatistics_orientation32(w_statistics_orientation_MUX[32]),
	.ostatistics_orientation33(w_statistics_orientation_MUX[33]),
	.ostatistics_orientation34(w_statistics_orientation_MUX[34]),
	.ostatistics_orientation35(w_statistics_orientation_MUX[35]),
	.odata_en(w_StatisticsOrientationMUX_en)
);

wire  w_MaximumOrientationDetection;

MaximumOrientationDetection OrientationDetection8(
	.iclk(iclk_8),
	.ireset(ireset),
	.idata_en(w_StatisticsOrientationMUX_en),
  .istatistics_orientation0(w_statistics_orientation_MUX[0]),
  .istatistics_orientation1(w_statistics_orientation_MUX[1]),
  .istatistics_orientation2(w_statistics_orientation_MUX[2]),
  .istatistics_orientation3(w_statistics_orientation_MUX[3]),
  .istatistics_orientation4(w_statistics_orientation_MUX[4]),
  .istatistics_orientation5(w_statistics_orientation_MUX[5]),
  .istatistics_orientation6(w_statistics_orientation_MUX[6]),
  .istatistics_orientation7(w_statistics_orientation_MUX[7]),
  .istatistics_orientation8(w_statistics_orientation_MUX[8]),
  .istatistics_orientation9(w_statistics_orientation_MUX[9]),
  .istatistics_orientation10(w_statistics_orientation_MUX[10]),
  .istatistics_orientation11(w_statistics_orientation_MUX[11]),
  .istatistics_orientation12(w_statistics_orientation_MUX[12]),
  .istatistics_orientation13(w_statistics_orientation_MUX[13]),
  .istatistics_orientation14(w_statistics_orientation_MUX[14]),
  .istatistics_orientation15(w_statistics_orientation_MUX[15]),
  .istatistics_orientation16(w_statistics_orientation_MUX[16]),
  .istatistics_orientation17(w_statistics_orientation_MUX[17]),
  .istatistics_orientation18(w_statistics_orientation_MUX[18]),
  .istatistics_orientation19(w_statistics_orientation_MUX[19]),
  .istatistics_orientation20(w_statistics_orientation_MUX[20]),
  .istatistics_orientation21(w_statistics_orientation_MUX[21]),
  .istatistics_orientation22(w_statistics_orientation_MUX[22]),
  .istatistics_orientation23(w_statistics_orientation_MUX[23]),
  .istatistics_orientation24(w_statistics_orientation_MUX[24]),
  .istatistics_orientation25(w_statistics_orientation_MUX[25]),
  .istatistics_orientation26(w_statistics_orientation_MUX[26]),
  .istatistics_orientation27(w_statistics_orientation_MUX[27]),
  .istatistics_orientation28(w_statistics_orientation_MUX[28]),
  .istatistics_orientation29(w_statistics_orientation_MUX[29]),
  .istatistics_orientation30(w_statistics_orientation_MUX[30]),
  .istatistics_orientation31(w_statistics_orientation_MUX[31]),
  .istatistics_orientation32(w_statistics_orientation_MUX[32]),
  .istatistics_orientation33(w_statistics_orientation_MUX[33]),
  .istatistics_orientation34(w_statistics_orientation_MUX[34]),
  .istatistics_orientation35(w_statistics_orientation_MUX[35]),
  .omaximum_value(odominant_orientation),
  .odata_en(w_MaximumOrientationDetection)
);

assign odominant_orientation_en = w_MaximumOrientationDetection & w_satisfact_finish_signal_hold[8];

////////////////////////////////////////////////////////////////////////////

endmodule 