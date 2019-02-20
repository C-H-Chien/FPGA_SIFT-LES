`timescale 1 ps / 1 ps

module FindSmallValue (  
  input                    iclk,
  input                    irst_n,
  input           [7:0]    iData_a,
  input           [7:0]    iData_b0,
  input           [7:0]    iData_b1,
  input           [7:0]    iData_b2,
  output   reg             oBig_en
);

always@(posedge iclk or negedge irst_n) begin
  if (!irst_n) begin
    oBig_en <= 0;
  end
  else begin
    if ((iData_a <= iData_b0) && (iData_a <= iData_b1) && (iData_a <= iData_b2)) begin
      oBig_en <= 1;  
    end
    else begin
      oBig_en <= 0;      
    end 
  end
end

endmodule 
