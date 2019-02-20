`timescale 1 ps / 1 ps

module Edgevalue (  
  input                                iclk,
  input                                irst_n,
  input           signed     [9:0]     itr,
  input           signed     [16:0]    idet,
  output    reg   signed     [22:0]    oleft_value,
  output    reg   signed     [24:0]    oright_value,
  output    reg   signed     [16:0]    odet
);

reg   signed    [9:0]    tr2;
reg   signed    [16:0]   det;

parameter sift_curv_thr = 10;
parameter sift_curv_thr_add1 = 121;

always@(posedge iclk or negedge irst_n) begin
  if (!irst_n) begin
    tr2 <= 0;
    det <= 0;
    oleft_value <= 0;
    oright_value <= 0;
    odet <= 0;
  end  
  else  begin
    //////////////////////////////////////////////////////////////////////
    //clk 1
    tr2 <= itr * itr;
    det <= idet;
    //////////////////////////////////////////////////////////////////////
    //clk 2
    //tr * tr * SIFT_CURV_THR >= (SIFT_CURV_THR + 1) * (SIFT_CURV_THR + 1) * det
    oleft_value <= tr2 * sift_curv_thr;
    oright_value <= sift_curv_thr_add1 * det;
    odet <= det;
    //////////////////////////////////////////////////////////////////////
  end
end

endmodule 