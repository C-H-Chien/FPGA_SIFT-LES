`timescale 1 ps / 1 ps

module Difference_3D (  
  input                       iclk,
  input                       irst_n,
  input     signed    [8:0]   iData_right,
  input     signed    [8:0]   iData_left,
  input     signed    [8:0]   iData_bot,
  input     signed    [8:0]   iData_top,
  input     signed    [8:0]   iData_next,
  input     signed    [8:0]   iData_pre,
  output    signed    [8:0]   odx,
  output    signed    [8:0]   ody,
  output    signed    [8:0]   ods
);

reg   signed    [8:0]   delta_x;
reg   signed    [8:0]   delta_y;
reg   signed    [8:0]   delta_s;

assign odx = {delta_x[8],delta_x[8:1]};
assign ody = {delta_y[8],delta_y[8:1]};
assign ods = {delta_s[8],delta_s[8:1]};

always@(posedge iclk or negedge irst_n) begin
  if (!irst_n)  begin
    delta_x <= 0;
    delta_y <= 0;
    delta_s <= 0;
  end
  else  begin 
    delta_x <= iData_right - iData_left;
    delta_y <= iData_bot - iData_top;
    delta_s <= iData_next - iData_pre;
  end
end

endmodule  