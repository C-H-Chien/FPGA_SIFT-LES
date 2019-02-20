`timescale 1 ps / 1 ps

module Hessian_3D (  
  input                         iclk,
  input                         irst_n,
  input     signed     [8:0]    iData_mid_top_left,
  input     signed     [8:0]    iData_mid_top,
  input     signed     [8:0]    iData_mid_top_right,
  input     signed     [8:0]    iData_mid_left,
  input     signed     [8:0]    iData_mid,
  input     signed     [8:0]    iData_mid_right,
  input     signed     [8:0]    iData_mid_bot_left,
  input     signed     [8:0]    iData_mid_bot,
  input     signed     [8:0]    iData_mid_bot_right,
  input     signed     [8:0]    iData_next_top,
  input     signed     [8:0]    iData_next_left,
  input     signed     [8:0]    iData_next,
  input     signed     [8:0]    iData_next_right,
  input     signed     [8:0]    iData_next_bot,
  input     signed     [8:0]    iData_pre_top,
  input     signed     [8:0]    iData_pre_left,
  input     signed     [8:0]    iData_pre,
  input     signed     [8:0]    iData_pre_right,
  input     signed     [8:0]    iData_pre_bot,
  output    signed     [8:0]    odxx,
  output    signed     [8:0]    odyy,
  output    signed     [8:0]    odss,
  output    signed     [8:0]    odxy,
  output    signed     [8:0]    odxs,
  output    signed     [8:0]    odys
);

reg   [8:0]   operate_dxx;   
reg   [8:0]   operate_dyy;
reg   [8:0]   operate_dss;
reg   [8:0]   operate_dxy;   
reg   [8:0]   operate_dxs;
reg   [8:0]   operate_dys;

assign odxx = operate_dxx;
assign odyy = operate_dyy;
assign odss = operate_dss;
assign odxy = {operate_dxy[8],operate_dxy[8],operate_dxy[8:2]};
assign odxs = {operate_dxs[8],operate_dxs[8],operate_dxs[8:2]};
assign odys = {operate_dys[8],operate_dys[8],operate_dys[8:2]};

always@(posedge iclk or negedge irst_n) begin
  if (!irst_n) begin
    operate_dxx <= 0;
    operate_dyy <= 0;
    operate_dss <= 0; 
    operate_dxy <= 0;
    operate_dxs <= 0;
    operate_dys <= 0;  
  end
  else begin
    operate_dxx <= (iData_mid_right + iData_mid_left) - (2 * iData_mid);
    operate_dyy <= (iData_mid_bot + iData_mid_top) - (2 * iData_mid);
    operate_dss <= (iData_next + iData_pre) - (2 * iData_mid); 
    operate_dxy <= (iData_mid_bot_right - iData_mid_bot_left) + (iData_mid_top_left - iData_mid_top_right);
    operate_dxs <= (iData_next_right - iData_next_left) + (iData_pre_left - iData_pre_right);
    operate_dys <= (iData_next_bot - iData_next_top) + (iData_pre_top - iData_pre_bot);  
  end  
end

endmodule 