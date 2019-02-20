`timescale 1 ps / 1 ps

module InverseHessian_3D (  
  input                               iclk,
  input                               irst_n,
  input           signed     [8:0]    iData_11,
  input           signed     [8:0]    iData_12,
  input           signed     [8:0]    iData_13,
  input           signed     [8:0]    iData_21,
  input           signed     [8:0]    iData_22,
  input           signed     [8:0]    iData_23,
  input           signed     [8:0]    iData_31,
  input           signed     [8:0]    iData_32,
  input           signed     [8:0]    iData_33,
  output    reg   signed     [8:0]    oadj11,
  output    reg   signed     [8:0]    oadj12,
  output    reg   signed     [8:0]    oadj13,
  output    reg   signed     [8:0]    oadj21,
  output    reg   signed     [8:0]    oadj22,
  output    reg   signed     [8:0]    oadj23,
  output    reg   signed     [8:0]    oadj31,
  output    reg   signed     [8:0]    oadj32,
  output    reg   signed     [8:0]    oadj33,
  output    reg   signed     [16:0]   odet
);

reg  signed [8:0] matrix1  [8:0];
reg  signed [8:0] matrix2  [8:0];
reg  signed [16:0] det_num  [5:0];
reg  signed [16:0] det_add  [1:0];

always@(posedge iclk or negedge irst_n) begin
  if (!irst_n) begin
    matrix1[0] <= 0;
    matrix1[1] <= 0;
    matrix1[2] <= 0;
    matrix1[3] <= 0;
    matrix1[4] <= 0;
    matrix1[5] <= 0;
    matrix1[6] <= 0;
    matrix1[7] <= 0;
    matrix1[8] <= 0;
    matrix2[0] <= 0;
    matrix2[1] <= 0;
    matrix2[2] <= 0;
    matrix2[3] <= 0;
    matrix2[4] <= 0;
    matrix2[5] <= 0;
    matrix2[6] <= 0;
    matrix2[7] <= 0;
    matrix2[8] <= 0;
    det_num[0] <= 0;
    det_num[1] <= 0;
    det_num[2] <= 0;
    det_num[3] <= 0;
    det_num[4] <= 0;
    det_num[5] <= 0;
    det_add[0] <= 0;
    det_add[1] <= 0;
    oadj11 <= 0;
    oadj12 <= 0;
    oadj13 <= 0;
    oadj21 <= 0;
    oadj22 <= 0;
    oadj23 <= 0;
    oadj31 <= 0;
    oadj32 <= 0;
    oadj33 <= 0;
    odet <= 0;
  end
  else begin
    ////////////////////////////////////////////////////////////////
    //clk 1
    matrix1[0] <= (iData_22 * iData_33) - (iData_23 * iData_32);  
    matrix1[1] <= (iData_13 * iData_32) - (iData_12 * iData_33);  
    matrix1[2] <= (iData_12 * iData_23) - (iData_13 * iData_22);  
    matrix1[3] <= (iData_23 * iData_31) - (iData_21 * iData_33);  
    matrix1[4] <= (iData_11 * iData_33) - (iData_13 * iData_31);  
    matrix1[5] <= (iData_13 * iData_21) - (iData_11 * iData_23);  
    matrix1[6] <= (iData_21 * iData_32) - (iData_22 * iData_31);  
    matrix1[7] <= (iData_12 * iData_31) - (iData_11 * iData_32);  
    matrix1[8] <= (iData_11 * iData_22) - (iData_12 * iData_21);  
    det_num[0] <= (iData_11 * iData_22) * iData_33; 
    det_num[1] <= (iData_13 * iData_21) * iData_32; 
    det_num[2] <= (iData_12 * iData_23) * iData_31;  
    det_num[3] <= (iData_13 * iData_22) * iData_31;  
    det_num[4] <= (iData_11 * iData_23) * iData_32;  
    det_num[5] <= (iData_12 * iData_21) * iData_33;  
    ////////////////////////////////////////////////////////////////
    //clk 2
    matrix2[0] <= matrix1[0];
    matrix2[1] <= matrix1[1];
    matrix2[2] <= matrix1[2];
    matrix2[3] <= matrix1[3];
    matrix2[4] <= matrix1[4];
    matrix2[5] <= matrix1[5];
    matrix2[6] <= matrix1[6];
    matrix2[7] <= matrix1[7];
    matrix2[8] <= matrix1[8];
    det_add[0] <= (det_num[0] + det_num[1]) + det_num[2];
    det_add[1] <= (det_num[3] + det_num[4]) + det_num[5];
    ////////////////////////////////////////////////////////////////
    //clk 3
    oadj11 <= matrix2[0];
    oadj12 <= matrix2[1];
    oadj13 <= matrix2[2];
    oadj21 <= matrix2[3];
    oadj22 <= matrix2[4];
    oadj23 <= matrix2[5];
    oadj31 <= matrix2[6];
    oadj32 <= matrix2[7];
    oadj33 <= matrix2[8];
    odet <= det_add[0] - det_add[1];
    ////////////////////////////////////////////////////////////////
  end
end
    
endmodule 