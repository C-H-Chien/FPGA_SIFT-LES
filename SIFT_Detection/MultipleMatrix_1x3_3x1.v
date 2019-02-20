`timescale 1 ps / 1 ps

module MultipleMatrix_1x3_3x1 (  
  input                                  iclk,
  input                                  irst_n,
  input             signed     [8:0]     iData_a11,
  input             signed     [8:0]     iData_a12,
  input             signed     [8:0]     iData_a13,
  input             signed     [8:0]     iData_b11,
  input             signed     [8:0]     iData_b21,
  input             signed     [8:0]     iData_b31,
  output    reg     signed     [18:0]    odata
);

reg   signed    [16:0]   add_value[2:0];

always@(posedge iclk or negedge irst_n) begin
  if (!irst_n) begin
    add_value[0] <= 0;
    add_value[1] <= 0;
    add_value[2] <= 0;  
    odata <= 0;
  end
  else begin
    add_value[0] <= iData_a11 * iData_b11;
    add_value[1] <= iData_a12 * iData_b21;
    add_value[2] <= iData_a13 * iData_b31;
    odata <= (add_value[0] + add_value[1]) + add_value[2];
  end
end

endmodule
