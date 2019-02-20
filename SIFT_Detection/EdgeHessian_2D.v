`timescale 1 ps / 1 ps

module EdgeHessian_2D (  
  input                              iclk,
  input                              irst_n,
  input          signed     [8:0]    idxx,
  input          signed     [8:0]    idyy,
  input          signed     [8:0]    idxy,
  output   reg   signed     [9:0]    otr,
  output   reg   signed     [16:0]   odet
);

reg   [8:0]   r_tr;
reg   [16:0]  data1;
reg   [16:0]  data2;

always@(posedge iclk or negedge irst_n) begin
  if (!irst_n) begin
    otr <= 0;
    odet <= 0;
  end  
  else  begin
    //////////////////////////////////////////////////////////////////////////////////////////////////
    //clk1
    r_tr <= idxx + idyy;
    data1 <= idxx * idyy;
    data2 <= idxy * idxy;
    //////////////////////////////////////////////////////////////////////////////////////////////////
    //clk1    
    otr <= r_tr;
    odet <= data1 - data2;
  end    
end

endmodule 