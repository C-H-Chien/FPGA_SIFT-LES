`timescale 1 ps / 1 ps

module MultipleMatrix_3x3_3x3 (  
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
  input             signed     [8:0]     iData_b12,
  input             signed     [8:0]     iData_b13,
  input             signed     [8:0]     iData_b21,
  input             signed     [8:0]     iData_b22,
  input             signed     [8:0]     iData_b23,
  input             signed     [8:0]     iData_b31,
  input             signed     [8:0]     iData_b32,
  input             signed     [8:0]     iData_b33,
  output    reg     signed     [18:0]    odata11,
  output    reg     signed     [18:0]    odata12,
  output    reg     signed     [18:0]    odata13,
  output    reg     signed     [18:0]    odata21,
  output    reg     signed     [18:0]    odata22,
  output    reg     signed     [18:0]    odata23,
  output    reg     signed     [18:0]    odata31,
  output    reg     signed     [18:0]    odata32,
  output    reg     signed     [18:0]    odata33
);

reg   signed    [16:0]    c11_mul   [2:0];
reg   signed    [16:0]    c12_mul   [2:0];
reg   signed    [16:0]    c13_mul   [2:0];
reg   signed    [16:0]    c21_mul   [2:0];
reg   signed    [16:0]    c22_mul   [2:0];
reg   signed    [16:0]    c23_mul   [2:0];
reg   signed    [16:0]    c31_mul   [2:0];
reg   signed    [16:0]    c32_mul   [2:0];
reg   signed    [16:0]    c33_mul   [2:0];

always@(posedge iclk or negedge irst_n) begin
  if (!irst_n) begin
    c11_mul[0] <= 0;
    c11_mul[1] <= 0;
    c11_mul[2] <= 0;
    c12_mul[0] <= 0;
    c12_mul[1] <= 0;
    c12_mul[2] <= 0;
    c13_mul[0] <= 0;
    c13_mul[1] <= 0;
    c13_mul[2] <= 0;
    c21_mul[0] <= 0;
    c21_mul[1] <= 0;
    c21_mul[2] <= 0;
    c22_mul[0] <= 0;
    c22_mul[1] <= 0;
    c22_mul[2] <= 0;
    c23_mul[0] <= 0;
    c23_mul[1] <= 0;
    c23_mul[2] <= 0;
    c31_mul[0] <= 0;
    c31_mul[1] <= 0;
    c31_mul[2] <= 0;
    c32_mul[0] <= 0;
    c32_mul[1] <= 0;
    c32_mul[2] <= 0;
    c33_mul[0] <= 0;
    c33_mul[1] <= 0;
    c33_mul[2] <= 0;
    odata11 <= 0;
    odata12 <= 0;
    odata13 <= 0;
    odata21 <= 0;
    odata22 <= 0;
    odata23 <= 0;
    odata31 <= 0;
    odata32 <= 0;
    odata33 <= 0;
  end
  else begin
    c11_mul[0] <= iData_a11 * iData_b11;
    c11_mul[1] <= iData_a12 * iData_b21;
    c11_mul[2] <= iData_a13 * iData_b31;
    c12_mul[0] <= iData_a11 * iData_b12;
    c12_mul[1] <= iData_a12 * iData_b22;
    c12_mul[2] <= iData_a13 * iData_b32;
    c13_mul[0] <= iData_a11 * iData_b13;
    c13_mul[1] <= iData_a12 * iData_b23;
    c13_mul[2] <= iData_a13 * iData_b33;
    c21_mul[0] <= iData_a21 * iData_b11;
    c21_mul[1] <= iData_a22 * iData_b21;
    c21_mul[2] <= iData_a23 * iData_b31;
    c22_mul[0] <= iData_a21 * iData_b12;
    c22_mul[1] <= iData_a22 * iData_b22;
    c22_mul[2] <= iData_a23 * iData_b32;
    c23_mul[0] <= iData_a21 * iData_b13;
    c23_mul[1] <= iData_a22 * iData_b23;
    c23_mul[2] <= iData_a23 * iData_b33;
    c31_mul[0] <= iData_a31 * iData_b11;
    c31_mul[1] <= iData_a32 * iData_b21;
    c31_mul[2] <= iData_a33 * iData_b31;
    c32_mul[0] <= iData_a31 * iData_b12;
    c32_mul[1] <= iData_a32 * iData_b22;
    c32_mul[2] <= iData_a33 * iData_b32;
    c33_mul[0] <= iData_a31 * iData_b13;
    c33_mul[1] <= iData_a32 * iData_b23;
    c33_mul[2] <= iData_a33 * iData_b33;
    odata11 <= c11_mul[0] + c11_mul[1] + c11_mul[2];
    odata12 <= c12_mul[0] + c12_mul[1] + c12_mul[2];
    odata13 <= c13_mul[0] + c13_mul[1] + c13_mul[2];
    odata21 <= c21_mul[0] + c21_mul[1] + c21_mul[2];
    odata22 <= c22_mul[0] + c22_mul[1] + c22_mul[2];
    odata23 <= c23_mul[0] + c23_mul[1] + c23_mul[2];
    odata31 <= c31_mul[0] + c31_mul[1] + c31_mul[2];
    odata32 <= c32_mul[0] + c32_mul[1] + c32_mul[2];
    odata33 <= c33_mul[0] + c33_mul[1] + c33_mul[2];
  end
end

endmodule