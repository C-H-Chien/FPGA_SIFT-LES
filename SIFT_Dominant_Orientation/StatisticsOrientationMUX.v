`timescale 1 ps / 1 ps

module StatisticsOrientationMUX(
	input 						             iclk,
	input 						             ireset,
	input 						             idata_en,
	input                    iselect_MUX,
  input         [15:0]     istatistics_orientation0,
  input         [15:0]     istatistics_orientation1,
  input         [15:0]     istatistics_orientation2,
  input         [15:0]     istatistics_orientation3,
  input         [15:0]     istatistics_orientation4,
  input         [15:0]     istatistics_orientation5,
  input         [15:0]     istatistics_orientation6,
  input         [15:0]     istatistics_orientation7,
  input         [15:0]     istatistics_orientation8,
  input         [15:0]     istatistics_orientation9,
  input         [15:0]     istatistics_orientation10,
  input         [15:0]     istatistics_orientation11,
  input         [15:0]     istatistics_orientation12,
  input         [15:0]     istatistics_orientation13,
  input         [15:0]     istatistics_orientation14,
  input         [15:0]     istatistics_orientation15,
  input         [15:0]     istatistics_orientation16,
  input         [15:0]     istatistics_orientation17,
  input         [15:0]     istatistics_orientation18,
  input         [15:0]     istatistics_orientation19,
  input         [15:0]     istatistics_orientation20,
  input         [15:0]     istatistics_orientation21,
  input         [15:0]     istatistics_orientation22,
  input         [15:0]     istatistics_orientation23,
  input         [15:0]     istatistics_orientation24,
  input         [15:0]     istatistics_orientation25,
  input         [15:0]     istatistics_orientation26,
  input         [15:0]     istatistics_orientation27,
  input         [15:0]     istatistics_orientation28,
  input         [15:0]     istatistics_orientation29,
  input         [15:0]     istatistics_orientation30,
  input         [15:0]     istatistics_orientation31,
  input         [15:0]     istatistics_orientation32,
  input         [15:0]     istatistics_orientation33,
  input         [15:0]     istatistics_orientation34,
  input         [15:0]     istatistics_orientation35,
  input         [15:0]     istatistics_orientation36,
  input         [15:0]     istatistics_orientation37,
  input         [15:0]     istatistics_orientation38,
  input         [15:0]     istatistics_orientation39,
  input         [15:0]     istatistics_orientation40,
  input         [15:0]     istatistics_orientation41,
  input         [15:0]     istatistics_orientation42,
  input         [15:0]     istatistics_orientation43,
  input         [15:0]     istatistics_orientation44,
  input         [15:0]     istatistics_orientation45,
  input         [15:0]     istatistics_orientation46,
  input         [15:0]     istatistics_orientation47,
  input         [15:0]     istatistics_orientation48,
  input         [15:0]     istatistics_orientation49,
  input         [15:0]     istatistics_orientation50,
  input         [15:0]     istatistics_orientation51,
  input         [15:0]     istatistics_orientation52,
  input         [15:0]     istatistics_orientation53,
  input         [15:0]     istatistics_orientation54,
  input         [15:0]     istatistics_orientation55,
  input         [15:0]     istatistics_orientation56,
  input         [15:0]     istatistics_orientation57,
  input         [15:0]     istatistics_orientation58,
  input         [15:0]     istatistics_orientation59,
  input         [15:0]     istatistics_orientation60,
  input         [15:0]     istatistics_orientation61,
  input         [15:0]     istatistics_orientation62,
  input         [15:0]     istatistics_orientation63,
  input         [15:0]     istatistics_orientation64,
  input         [15:0]     istatistics_orientation65,
  input         [15:0]     istatistics_orientation66,
  input         [15:0]     istatistics_orientation67,
  input         [15:0]     istatistics_orientation68,
  input         [15:0]     istatistics_orientation69,
  input         [15:0]     istatistics_orientation70,
  input         [15:0]     istatistics_orientation71,
  output  reg   [15:0]     ostatistics_orientation0,
  output  reg   [15:0]     ostatistics_orientation1,
  output  reg   [15:0]     ostatistics_orientation2,
  output  reg   [15:0]     ostatistics_orientation3,
  output  reg   [15:0]     ostatistics_orientation4,
  output  reg   [15:0]     ostatistics_orientation5,
  output  reg   [15:0]     ostatistics_orientation6,
  output  reg   [15:0]     ostatistics_orientation7,
  output  reg   [15:0]     ostatistics_orientation8,
  output  reg   [15:0]     ostatistics_orientation9,
  output  reg   [15:0]     ostatistics_orientation10,
  output  reg   [15:0]     ostatistics_orientation11,
  output  reg   [15:0]     ostatistics_orientation12,
  output  reg   [15:0]     ostatistics_orientation13,
  output  reg   [15:0]     ostatistics_orientation14,
  output  reg   [15:0]     ostatistics_orientation15,
  output  reg   [15:0]     ostatistics_orientation16,
  output  reg   [15:0]     ostatistics_orientation17,
  output  reg   [15:0]     ostatistics_orientation18,
  output  reg   [15:0]     ostatistics_orientation19,
  output  reg   [15:0]     ostatistics_orientation20,
  output  reg   [15:0]     ostatistics_orientation21,
  output  reg   [15:0]     ostatistics_orientation22,
  output  reg   [15:0]     ostatistics_orientation23,
  output  reg   [15:0]     ostatistics_orientation24,
  output  reg   [15:0]     ostatistics_orientation25,
  output  reg   [15:0]     ostatistics_orientation26,
  output  reg   [15:0]     ostatistics_orientation27,
  output  reg   [15:0]     ostatistics_orientation28,
  output  reg   [15:0]     ostatistics_orientation29,
  output  reg   [15:0]     ostatistics_orientation30,
  output  reg   [15:0]     ostatistics_orientation31,
  output  reg   [15:0]     ostatistics_orientation32,
  output  reg   [15:0]     ostatistics_orientation33,
  output  reg   [15:0]     ostatistics_orientation34,
  output  reg   [15:0]     ostatistics_orientation35,
	output  reg              odata_en
);

always@(posedge iclk or negedge ireset) begin
  if (!ireset) begin
    ostatistics_orientation0 <= 0;  
    ostatistics_orientation1 <= 0;  
    ostatistics_orientation2 <= 0;  
    ostatistics_orientation3 <= 0;  
    ostatistics_orientation4 <= 0;  
    ostatistics_orientation5 <= 0;  
    ostatistics_orientation6 <= 0;  
    ostatistics_orientation7 <= 0;  
    ostatistics_orientation8 <= 0;  
    ostatistics_orientation9 <= 0;  
    ostatistics_orientation10 <= 0;  
    ostatistics_orientation11 <= 0;  
    ostatistics_orientation12 <= 0;  
    ostatistics_orientation13 <= 0;  
    ostatistics_orientation14 <= 0;  
    ostatistics_orientation15 <= 0;  
    ostatistics_orientation16 <= 0;  
    ostatistics_orientation17 <= 0;  
    ostatistics_orientation18 <= 0;  
    ostatistics_orientation19 <= 0;  
    ostatistics_orientation20 <= 0;  
    ostatistics_orientation21 <= 0;  
    ostatistics_orientation22 <= 0;  
    ostatistics_orientation23 <= 0;  
    ostatistics_orientation24 <= 0;  
    ostatistics_orientation25 <= 0;  
    ostatistics_orientation26 <= 0;  
    ostatistics_orientation27 <= 0;  
    ostatistics_orientation28 <= 0;  
    ostatistics_orientation29 <= 0;  
    ostatistics_orientation30 <= 0;  
    ostatistics_orientation31 <= 0;  
    ostatistics_orientation32 <= 0;  
    ostatistics_orientation33 <= 0;  
    ostatistics_orientation34 <= 0;  
    ostatistics_orientation35 <= 0;
    odata_en <= 0;      
  end
  else begin
    odata_en <= idata_en;
    if (iselect_MUX) begin  
      ostatistics_orientation0 <= istatistics_orientation0;  
      ostatistics_orientation1 <= istatistics_orientation1;  
      ostatistics_orientation2 <= istatistics_orientation2;  
      ostatistics_orientation3 <= istatistics_orientation3;  
      ostatistics_orientation4 <= istatistics_orientation4;  
      ostatistics_orientation5 <= istatistics_orientation5;  
      ostatistics_orientation6 <= istatistics_orientation6;  
      ostatistics_orientation7 <= istatistics_orientation7;  
      ostatistics_orientation8 <= istatistics_orientation8;  
      ostatistics_orientation9 <= istatistics_orientation9;  
      ostatistics_orientation10 <= istatistics_orientation10;  
      ostatistics_orientation11 <= istatistics_orientation11;  
      ostatistics_orientation12 <= istatistics_orientation12;  
      ostatistics_orientation13 <= istatistics_orientation13;  
      ostatistics_orientation14 <= istatistics_orientation14;  
      ostatistics_orientation15 <= istatistics_orientation15;  
      ostatistics_orientation16 <= istatistics_orientation16;  
      ostatistics_orientation17 <= istatistics_orientation17;  
      ostatistics_orientation18 <= istatistics_orientation18;  
      ostatistics_orientation19 <= istatistics_orientation19;  
      ostatistics_orientation20 <= istatistics_orientation20;  
      ostatistics_orientation21 <= istatistics_orientation21;  
      ostatistics_orientation22 <= istatistics_orientation22;  
      ostatistics_orientation23 <= istatistics_orientation23;  
      ostatistics_orientation24 <= istatistics_orientation24;  
      ostatistics_orientation25 <= istatistics_orientation25;  
      ostatistics_orientation26 <= istatistics_orientation26;  
      ostatistics_orientation27 <= istatistics_orientation27;  
      ostatistics_orientation28 <= istatistics_orientation28;  
      ostatistics_orientation29 <= istatistics_orientation29;  
      ostatistics_orientation30 <= istatistics_orientation30;  
      ostatistics_orientation31 <= istatistics_orientation31;  
      ostatistics_orientation32 <= istatistics_orientation32;  
      ostatistics_orientation33 <= istatistics_orientation33;  
      ostatistics_orientation34 <= istatistics_orientation34;  
      ostatistics_orientation35 <= istatistics_orientation35;          
    end
    else begin
      ostatistics_orientation0 <= istatistics_orientation36;  
      ostatistics_orientation1 <= istatistics_orientation37;  
      ostatistics_orientation2 <= istatistics_orientation38;  
      ostatistics_orientation3 <= istatistics_orientation39;  
      ostatistics_orientation4 <= istatistics_orientation40;  
      ostatistics_orientation5 <= istatistics_orientation41;  
      ostatistics_orientation6 <= istatistics_orientation42;  
      ostatistics_orientation7 <= istatistics_orientation43;  
      ostatistics_orientation8 <= istatistics_orientation44;  
      ostatistics_orientation9 <= istatistics_orientation45;  
      ostatistics_orientation10 <= istatistics_orientation46;  
      ostatistics_orientation11 <= istatistics_orientation47;  
      ostatistics_orientation12 <= istatistics_orientation48;  
      ostatistics_orientation13 <= istatistics_orientation49;  
      ostatistics_orientation14 <= istatistics_orientation50;  
      ostatistics_orientation15 <= istatistics_orientation51;  
      ostatistics_orientation16 <= istatistics_orientation52;  
      ostatistics_orientation17 <= istatistics_orientation53;  
      ostatistics_orientation18 <= istatistics_orientation54;  
      ostatistics_orientation19 <= istatistics_orientation55;  
      ostatistics_orientation20 <= istatistics_orientation56;  
      ostatistics_orientation21 <= istatistics_orientation57;  
      ostatistics_orientation22 <= istatistics_orientation58;  
      ostatistics_orientation23 <= istatistics_orientation59;  
      ostatistics_orientation24 <= istatistics_orientation60;  
      ostatistics_orientation25 <= istatistics_orientation61;  
      ostatistics_orientation26 <= istatistics_orientation62;  
      ostatistics_orientation27 <= istatistics_orientation63;  
      ostatistics_orientation28 <= istatistics_orientation64;  
      ostatistics_orientation29 <= istatistics_orientation65;  
      ostatistics_orientation30 <= istatistics_orientation66;  
      ostatistics_orientation31 <= istatistics_orientation67;  
      ostatistics_orientation32 <= istatistics_orientation68;  
      ostatistics_orientation33 <= istatistics_orientation69;  
      ostatistics_orientation34 <= istatistics_orientation70;  
      ostatistics_orientation35 <= istatistics_orientation71;
    end
  end
end

endmodule
