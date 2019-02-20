`timescale 1 ps / 1 ps

module ExtremaDetection (  
  input                    iclk,
  input                    irst_n,
  input							iDval,
  input           [7:0]    iData_a,
  input           [7:0]    iData_b0,
  input           [7:0]    iData_b1,
  input           [7:0]    iData_b2,
  input           [7:0]    iData_b3,
  input           [7:0]    iData_b4,
  input           [7:0]    iData_b5,
  input           [7:0]    iData_b6,
  input           [7:0]    iData_b7,
  input           [7:0]    iData_b8,
  input           [7:0]    iData_b9,
  input           [7:0]    iData_b10,
  input           [7:0]    iData_b11,
  input           [7:0]    iData_b12,
  input           [7:0]    iData_b13,
  input           [7:0]    iData_b14,
  input           [7:0]    iData_b15,
  input           [7:0]    iData_b16,
  input           [7:0]    iData_b17,
  input           [7:0]    iData_b18,
  input           [7:0]    iData_b19,
  input           [7:0]    iData_b20,
  input           [7:0]    iData_b21,
  input           [7:0]    iData_b22,
  input           [7:0]    iData_b23,
  input           [7:0]    iData_b24,
  input           [7:0]    iData_b25,
  input           [7:0]    iData_b26,
  output	 reg					         oDval,
  output  reg              oExtrema_en
);

wire Max_en;
wire Small_en;
wire r_Dval;

MaximumDetection ExtremaDetection1(  
  .iclk(iclk),
  .irst_n(irst_n),
  .iDval(iDval),
  .iData_a(iData_a),
  .iData_b0(iData_b0),
  .iData_b1(iData_b1),
  .iData_b2(iData_b2),
  .iData_b3(iData_b3),
  .iData_b4(iData_b4),
  .iData_b5(iData_b5),
  .iData_b6(iData_b6),
  .iData_b7(iData_b7),
  .iData_b8(iData_b8),
  .iData_b9(iData_b9),
  .iData_b10(iData_b10),
  .iData_b11(iData_b11),
  .iData_b12(iData_b12),
  .iData_b13(iData_b13),
  .iData_b14(iData_b14),
  .iData_b15(iData_b15),
  .iData_b16(iData_b16),
  .iData_b17(iData_b17),
  .iData_b18(iData_b18),
  .iData_b19(iData_b19),
  .iData_b20(iData_b20),
  .iData_b21(iData_b21),
  .iData_b22(iData_b22),
  .iData_b23(iData_b23),
  .iData_b24(iData_b24),
  .iData_b25(iData_b25),
  .iData_b26(iData_b26),
  .oDval(r_Dval),
  .oMax_en(Max_en)
);

MinimumDetection ExtremaDetection2(  
  .iclk(iclk),
  .irst_n(irst_n),
  .iData_a(iData_a),
  .iData_b0(iData_b0),
  .iData_b1(iData_b1),
  .iData_b2(iData_b2),
  .iData_b3(iData_b3),
  .iData_b4(iData_b4),
  .iData_b5(iData_b5),
  .iData_b6(iData_b6),
  .iData_b7(iData_b7),
  .iData_b8(iData_b8),
  .iData_b9(iData_b9),
  .iData_b10(iData_b10),
  .iData_b11(iData_b11),
  .iData_b12(iData_b12),
  .iData_b13(iData_b13),
  .iData_b14(iData_b14),
  .iData_b15(iData_b15),
  .iData_b16(iData_b16),
  .iData_b17(iData_b17),
  .iData_b18(iData_b18),
  .iData_b19(iData_b19),
  .iData_b20(iData_b20),
  .iData_b21(iData_b21),
  .iData_b22(iData_b22),
  .iData_b23(iData_b23),
  .iData_b24(iData_b24),
  .iData_b25(iData_b25),
  .iData_b26(iData_b26),
  .oSmall_en(Small_en)
);

always@(posedge iclk or negedge irst_n) begin
  if (!irst_n) begin
    oDval <= 0;
    oExtrema_en <= 0;
  end
  else begin
    oExtrema_en <= Max_en | Small_en;
    oDval <= r_Dval;
  end   
end


endmodule 
