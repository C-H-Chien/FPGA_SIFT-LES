`timescale 1 ps / 1 ps

module MinimumDetection (  
  input                    iclk,
  input                    irst_n,
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
  output                   oSmall_en
);

wire data_en[8:0];
wire Layer_data_en[2:0];

FindSmallValue detectsmallvalue1(  
  .iclk(iclk),
  .irst_n(irst_n),
  .iData_a(iData_a),
  .iData_b0(iData_b0),
  .iData_b1(iData_b1),
  .iData_b2(iData_b2),
  .oBig_en(data_en[0])
);

FindSmallValue detectsmallvalue2(  
  .iclk(iclk),
  .irst_n(irst_n),
  .iData_a(iData_a),
  .iData_b0(iData_b3),
  .iData_b1(iData_b4),
  .iData_b2(iData_b5),
  .oBig_en(data_en[1])
);

FindSmallValue detectsmallvalue3(  
  .iclk(iclk),
  .irst_n(irst_n),
  .iData_a(iData_a),
  .iData_b0(iData_b6),
  .iData_b1(iData_b7),
  .iData_b2(iData_b8),
  .oBig_en(data_en[2])
);

FindSmallValue detectsmallvalue4(  
  .iclk(iclk),
  .irst_n(irst_n),
  .iData_a(iData_a),
  .iData_b0(iData_b9),
  .iData_b1(iData_b10),
  .iData_b2(iData_b11),
  .oBig_en(data_en[3])
);

FindSmallValue detectsmallvalue5(  
  .iclk(iclk),
  .irst_n(irst_n),
  .iData_a(iData_a),
  .iData_b0(iData_b12),
  .iData_b1(iData_b13),
  .iData_b2(iData_b14),
  .oBig_en(data_en[4])
);

FindSmallValue detectsmallvalue6(  
  .iclk(iclk),
  .irst_n(irst_n),
  .iData_a(iData_a),
  .iData_b0(iData_b15),
  .iData_b1(iData_b16),
  .iData_b2(iData_b17),
  .oBig_en(data_en[5])
);

FindSmallValue detectsmallvalue7(  
  .iclk(iclk),
  .irst_n(irst_n),
  .iData_a(iData_a),
  .iData_b0(iData_b18),
  .iData_b1(iData_b19),
  .iData_b2(iData_b20),
  .oBig_en(data_en[6])
);


FindSmallValue detectsmallvalue8(  
  .iclk(iclk),
  .irst_n(irst_n),
  .iData_a(iData_a),
  .iData_b0(iData_b21),
  .iData_b1(iData_b22),
  .iData_b2(iData_b23),
  .oBig_en(data_en[7])
);

FindSmallValue detectsmallvalue9(  
  .iclk(iclk),
  .irst_n(irst_n),
  .iData_a(iData_a),
  .iData_b0(iData_b24),
  .iData_b1(iData_b25),
  .iData_b2(iData_b26),
  .oBig_en(data_en[8])
);

TestExtremaValueEn detectsmallvalue10(  
  .iclk(iclk),
  .irst_n(irst_n),
  .iBig_en1(data_en[0]),
  .iBig_en2(data_en[1]),
  .iBig_en3(data_en[2]),
  .oBig_en(Layer_data_en[0])
);

TestExtremaValueEn detectsmallvalue11(  
  .iclk(iclk),
  .irst_n(irst_n),
  .iBig_en1(data_en[3]),
  .iBig_en2(data_en[4]),
  .iBig_en3(data_en[5]),
  .oBig_en(Layer_data_en[1])
);

TestExtremaValueEn detectsmallvalue12(  
  .iclk(iclk),
  .irst_n(irst_n),
  .iBig_en1(data_en[6]),
  .iBig_en2(data_en[7]),
  .iBig_en3(data_en[8]),
  .oBig_en(Layer_data_en[2])
);

TestExtremaValueEn detectsmallvalue13(  
  .iclk(iclk),
  .irst_n(irst_n),
  .iBig_en1(Layer_data_en[0]),
  .iBig_en2(Layer_data_en[1]),
  .iBig_en3(Layer_data_en[2]),
  .oBig_en(oSmall_en)
);

endmodule 
