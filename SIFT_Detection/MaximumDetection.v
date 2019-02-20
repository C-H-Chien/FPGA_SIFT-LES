`timescale 1 ps / 1 ps

module MaximumDetection (  
  input                    iclk,
  input                    irst_n,
  input 							iDval,
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
  output 						            oDval,
  output                   oMax_en
);

wire	data_en[8:0];
wire	Layer_data_en[2:0];
reg	r_dval[2:0];

assign oDval = r_dval[2];

always@(posedge iclk or negedge irst_n) begin
	if (!irst_n) begin
		r_dval[0] <= 0;
		r_dval[1] <= 0;
		r_dval[2] <= 0;
	end
	else begin
		r_dval[0] <= iDval;
		r_dval[1] <= r_dval[0];
		r_dval[2] <= r_dval[1];
	end
end

FindBigValue detectmaxvalue1(  
  .iclk(iclk),
  .irst_n(irst_n),
  .iData_a(iData_a),
  .iData_b0(iData_b0),
  .iData_b1(iData_b1),
  .iData_b2(iData_b2),
  .oBig_en(data_en[0])
);

FindBigValue detectmaxvalue2(  
  .iclk(iclk),
  .irst_n(irst_n),
  .iData_a(iData_a),
  .iData_b0(iData_b3),
  .iData_b1(iData_b4),
  .iData_b2(iData_b5),
  .oBig_en(data_en[1])
);

FindBigValue detectmaxvalue3(  
  .iclk(iclk),
  .irst_n(irst_n),
  .iData_a(iData_a),
  .iData_b0(iData_b6),
  .iData_b1(iData_b7),
  .iData_b2(iData_b8),
  .oBig_en(data_en[2])
);

FindBigValue detectmaxvalue4(  
  .iclk(iclk),
  .irst_n(irst_n),
  .iData_a(iData_a),
  .iData_b0(iData_b9),
  .iData_b1(iData_b10),
  .iData_b2(iData_b11),
  .oBig_en(data_en[3])
);

FindBigValue detectmaxvalue5(  
  .iclk(iclk),
  .irst_n(irst_n),
  .iData_a(iData_a),
  .iData_b0(iData_b12),
  .iData_b1(iData_b13),
  .iData_b2(iData_b14),
  .oBig_en(data_en[4])
);

FindBigValue detectmaxvalue6(  
  .iclk(iclk),
  .irst_n(irst_n),
  .iData_a(iData_a),
  .iData_b0(iData_b15),
  .iData_b1(iData_b16),
  .iData_b2(iData_b17),
  .oBig_en(data_en[5])
);

FindBigValue detectmaxvalue7(  
  .iclk(iclk),
  .irst_n(irst_n),
  .iData_a(iData_a),
  .iData_b0(iData_b18),
  .iData_b1(iData_b19),
  .iData_b2(iData_b20),
  .oBig_en(data_en[6])
);


FindBigValue detectmaxvalue8(  
  .iclk(iclk),
  .irst_n(irst_n),
  .iData_a(iData_a),
  .iData_b0(iData_b21),
  .iData_b1(iData_b22),
  .iData_b2(iData_b23),
  .oBig_en(data_en[7])
);

FindBigValue detectmaxvalue9(  
  .iclk(iclk),
  .irst_n(irst_n),
  .iData_a(iData_a),
  .iData_b0(iData_b24),
  .iData_b1(iData_b25),
  .iData_b2(iData_b26),
  .oBig_en(data_en[8])
);

TestExtremaValueEn detectmaxvalue10(  
  .iclk(iclk),
  .irst_n(irst_n),
  .iBig_en1(data_en[0]),
  .iBig_en2(data_en[1]),
  .iBig_en3(data_en[2]),
  .oBig_en(Layer_data_en[0])
);

TestExtremaValueEn detectmaxvalue11(  
  .iclk(iclk),
  .irst_n(irst_n),
  .iBig_en1(data_en[3]),
  .iBig_en2(data_en[4]),
  .iBig_en3(data_en[5]),
  .oBig_en(Layer_data_en[1])
);

TestExtremaValueEn detectmaxvalue12(  
  .iclk(iclk),
  .irst_n(irst_n),
  .iBig_en1(data_en[6]),
  .iBig_en2(data_en[7]),
  .iBig_en3(data_en[8]),
  .oBig_en(Layer_data_en[2])
);

TestExtremaValueEn detectmaxvalue13(  
  .iclk(iclk),
  .irst_n(irst_n),
  .iBig_en1(Layer_data_en[0]),
  .iBig_en2(Layer_data_en[1]),
  .iBig_en3(Layer_data_en[2]),
  .oBig_en(oMax_en)
);

endmodule 