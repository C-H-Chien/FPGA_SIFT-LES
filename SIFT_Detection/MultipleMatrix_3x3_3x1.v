`timescale 1 ps / 1 ps

module MultipleMatrix_3x3_3x1 (  
  input                                  iclk,
  input                                  irst_n,
  input             signed     [8:0]     iData_a11,
  input             signed     [8:0]     iData_a12,
  input             signed     [8:0]     iData_a13,
  input             signed     [8:0]     iData_a21,
  input             signed     [8:0]     iData_a22,
  input             signed     [8:0]     iData_a23,
  input             signed     [8:0]     iData_a31,
  input             signed     [8:0]     iData_a32,
  input             signed     [8:0]     iData_a33,
  input             signed     [8:0]     iData_b11,
  input             signed     [8:0]     iData_b21,
  input             signed     [8:0]     iData_b31,
  output    reg     signed     [18:0]    odata11,
  output    reg     signed     [18:0]    odata21,
  output    reg     signed     [18:0]    odata31
);


reg   signed    [16:0]    c11_mul   [2:0];
reg   signed    [16:0]    c21_mul   [2:0];
reg   signed    [16:0]    c31_mul   [2:0];

always@(posedge iclk or negedge irst_n) begin
  if (!irst_n) begin
    c11_mul[0] <= 0;
    c11_mul[1] <= 0;
    c11_mul[2] <= 0;
    c21_mul[0] <= 0;
    c21_mul[1] <= 0;
    c21_mul[2] <= 0;
    c31_mul[0] <= 0;
    c31_mul[1] <= 0;
    c31_mul[2] <= 0;
    odata11 <= 0;
    odata21 <= 0;
    odata31 <= 0;
  end
  else begin
    c11_mul[0] <= iData_a11 * iData_b11;
    c11_mul[1] <= iData_a12 * iData_b21;
    c11_mul[2] <= iData_a13 * iData_b31;
    c21_mul[0] <= iData_a21 * iData_b11;
    c21_mul[1] <= iData_a22 * iData_b21;
    c21_mul[2] <= iData_a23 * iData_b31;
    c31_mul[0] <= iData_a31 * iData_b11;
    c31_mul[1] <= iData_a32 * iData_b21;
    c31_mul[2] <= iData_a33 * iData_b31;
    odata11 <= c11_mul[0] + c11_mul[1] + c11_mul[2];
    odata21 <= c21_mul[0] + c21_mul[1] + c21_mul[2];
    odata31 <= c31_mul[0] + c31_mul[1] + c31_mul[2];
  end
end

endmodule