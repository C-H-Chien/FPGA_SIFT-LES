`timescale 1 ps / 1 ps

module StatisticsOrientationMagnitude(
	input 						             iclk,
	input 						             ireset,
	input                    idata_en,
	input                    iinitial,
	input			      [8:0]	   		imagnitude,
	input			      [5:0]	   		iorientation,
	output  reg              oinitial,
	output  reg              odata_en,
  output  reg   [15:0]     statistics_orientation0,
  output  reg   [15:0]     statistics_orientation1,
  output  reg   [15:0]     statistics_orientation2,
  output  reg   [15:0]     statistics_orientation3,
  output  reg   [15:0]     statistics_orientation4,
  output  reg   [15:0]     statistics_orientation5,
  output  reg   [15:0]     statistics_orientation6,
  output  reg   [15:0]     statistics_orientation7,
  output  reg   [15:0]     statistics_orientation8,
  output  reg   [15:0]     statistics_orientation9,
  output  reg   [15:0]     statistics_orientation10,
  output  reg   [15:0]     statistics_orientation11,
  output  reg   [15:0]     statistics_orientation12,
  output  reg   [15:0]     statistics_orientation13,
  output  reg   [15:0]     statistics_orientation14,
  output  reg   [15:0]     statistics_orientation15,
  output  reg   [15:0]     statistics_orientation16,
  output  reg   [15:0]     statistics_orientation17,
  output  reg   [15:0]     statistics_orientation18,
  output  reg   [15:0]     statistics_orientation19,
  output  reg   [15:0]     statistics_orientation20,
  output  reg   [15:0]     statistics_orientation21,
  output  reg   [15:0]     statistics_orientation22,
  output  reg   [15:0]     statistics_orientation23,
  output  reg   [15:0]     statistics_orientation24,
  output  reg   [15:0]     statistics_orientation25,
  output  reg   [15:0]     statistics_orientation26,
  output  reg   [15:0]     statistics_orientation27,
  output  reg   [15:0]     statistics_orientation28,
  output  reg   [15:0]     statistics_orientation29,
  output  reg   [15:0]     statistics_orientation30,
  output  reg   [15:0]     statistics_orientation31,
  output  reg   [15:0]     statistics_orientation32,
  output  reg   [15:0]     statistics_orientation33,
  output  reg   [15:0]     statistics_orientation34,
  output  reg   [15:0]     statistics_orientation35
);

reg   [5:0]   i;

always@(posedge iclk or negedge ireset) begin
  if (!ireset) begin
      oinitial <= 0;
      odata_en <= 0;
      statistics_orientation0 <= 0;
      statistics_orientation1 <= 0;
      statistics_orientation2 <= 0;
      statistics_orientation3 <= 0;
      statistics_orientation4 <= 0;
      statistics_orientation5 <= 0;
      statistics_orientation6 <= 0;
      statistics_orientation7 <= 0;
      statistics_orientation8 <= 0;
      statistics_orientation9 <= 0;
      statistics_orientation10 <= 0;
      statistics_orientation11 <= 0;
      statistics_orientation12 <= 0;
      statistics_orientation13 <= 0;
      statistics_orientation14 <= 0;
      statistics_orientation15 <= 0;
      statistics_orientation16 <= 0;
      statistics_orientation17 <= 0;
      statistics_orientation18 <= 0;
      statistics_orientation19 <= 0;
      statistics_orientation20 <= 0;
      statistics_orientation21 <= 0;
      statistics_orientation22 <= 0;
      statistics_orientation23 <= 0;
      statistics_orientation24 <= 0;
      statistics_orientation25 <= 0;
      statistics_orientation26 <= 0;
      statistics_orientation27 <= 0;
      statistics_orientation28 <= 0;
      statistics_orientation29 <= 0;
      statistics_orientation30 <= 0;
      statistics_orientation31 <= 0;
      statistics_orientation32 <= 0;
      statistics_orientation33 <= 0;
      statistics_orientation34 <= 0;
      statistics_orientation35 <= 0;    
  end
  else begin
    oinitial <= iinitial;
    odata_en <= idata_en;
    if (idata_en) begin
      if (iinitial) begin
        case (iorientation) 
          6'd0 :  statistics_orientation0 = statistics_orientation0 + imagnitude; 
          6'd1 :  statistics_orientation1 = statistics_orientation1 + imagnitude;
          6'd2 :  statistics_orientation2 = statistics_orientation2 + imagnitude;
          6'd3 :  statistics_orientation3 = statistics_orientation3 + imagnitude;
          6'd4 :  statistics_orientation4 = statistics_orientation4 + imagnitude;
          6'd5 :  statistics_orientation5 = statistics_orientation5 + imagnitude;
          6'd6 :  statistics_orientation6 = statistics_orientation6 + imagnitude;
          6'd7 :  statistics_orientation7 = statistics_orientation7 + imagnitude;
          6'd8 :  statistics_orientation8 = statistics_orientation8 + imagnitude;
          6'd9 :  statistics_orientation9 = statistics_orientation9 + imagnitude;
          6'd10 :  statistics_orientation10 = statistics_orientation10 + imagnitude;
          6'd11 :  statistics_orientation11 = statistics_orientation11 + imagnitude;
          6'd12 :  statistics_orientation12 = statistics_orientation12 + imagnitude;
          6'd13 :  statistics_orientation13 = statistics_orientation13 + imagnitude;
          6'd14 :  statistics_orientation14 = statistics_orientation14 + imagnitude;
          6'd15 :  statistics_orientation15 = statistics_orientation15 + imagnitude;
          6'd16 :  statistics_orientation16 = statistics_orientation16 + imagnitude;
          6'd17 :  statistics_orientation17 = statistics_orientation17 + imagnitude;
          6'd18 :  statistics_orientation18 = statistics_orientation18 + imagnitude;
          6'd19 :  statistics_orientation19 = statistics_orientation19 + imagnitude;
          6'd20 :  statistics_orientation20 = statistics_orientation20 + imagnitude;
          6'd21 :  statistics_orientation21 = statistics_orientation21 + imagnitude;
          6'd22 :  statistics_orientation22 = statistics_orientation22 + imagnitude;
          6'd23 :  statistics_orientation23 = statistics_orientation23 + imagnitude;
          6'd24 :  statistics_orientation24 = statistics_orientation24 + imagnitude;
          6'd25 :  statistics_orientation25 = statistics_orientation25 + imagnitude;
          6'd26 :  statistics_orientation26 = statistics_orientation26 + imagnitude;
          6'd27 :  statistics_orientation27 = statistics_orientation27 + imagnitude;
          6'd28 :  statistics_orientation28 = statistics_orientation28 + imagnitude;
          6'd29 :  statistics_orientation29 = statistics_orientation29 + imagnitude;
          6'd30 :  statistics_orientation30 = statistics_orientation30 + imagnitude;
          6'd31 :  statistics_orientation31 = statistics_orientation31 + imagnitude;
          6'd32 :  statistics_orientation32 = statistics_orientation32 + imagnitude;
          6'd33 :  statistics_orientation33 = statistics_orientation33 + imagnitude;
          6'd34 :  statistics_orientation34 = statistics_orientation34 + imagnitude;
          default :  statistics_orientation35 = statistics_orientation35 + imagnitude;          
        endcase
      end
      else begin
        statistics_orientation0 <= 0;
        statistics_orientation1 <= 0;
        statistics_orientation2 <= 0;
        statistics_orientation3 <= 0;
        statistics_orientation4 <= 0;
        statistics_orientation5 <= 0;
        statistics_orientation6 <= 0;
        statistics_orientation7 <= 0;
        statistics_orientation8 <= 0;
        statistics_orientation9 <= 0;
        statistics_orientation10 <= 0;
        statistics_orientation11 <= 0;
        statistics_orientation12 <= 0;
        statistics_orientation13 <= 0;
        statistics_orientation14 <= 0;
        statistics_orientation15 <= 0;
        statistics_orientation16 <= 0;
        statistics_orientation17 <= 0;
        statistics_orientation18 <= 0;
        statistics_orientation19 <= 0;
        statistics_orientation20 <= 0;
        statistics_orientation21 <= 0;
        statistics_orientation22 <= 0;
        statistics_orientation23 <= 0;
        statistics_orientation24 <= 0;
        statistics_orientation25 <= 0;
        statistics_orientation26 <= 0;
        statistics_orientation27 <= 0;
        statistics_orientation28 <= 0;
        statistics_orientation29 <= 0;
        statistics_orientation30 <= 0;
        statistics_orientation31 <= 0;
        statistics_orientation32 <= 0;
        statistics_orientation33 <= 0;
        statistics_orientation34 <= 0;
        statistics_orientation35 <= 0; 
      end
    end
  end 
end

endmodule 