`timescale 1 ps / 1 ps

module EdgeDetect (  
  input                              iclk,
  input                              irst_n,
  input          signed     [8:0]    idxx,
  input          signed     [8:0]    idyy,
  input          signed     [8:0]    idxy,
  output   reg                       oedge_en
);

parameter sift_curv_thr = 10;

wire   signed   [9:0]    tr;
wire   signed   [16:0]   det;
wire   signed   [22:0]   left_value;
wire   signed   [24:0]   right_value;
wire   signed   [16:0]   det_hold;

EdgeHessian_2D EH1(  
  .iclk(iclk),
  .irst_n(irst_n),
  .idxx(idxx),
  .idyy(idyy),
  .idxy(idxy),
  .otr(tr),
  .odet(det)
);

Edgevalue EV1(  
  .iclk(iclk),
  .irst_n(irst_n),
  .itr(tr),
  .idet(det),
  .oleft_value(left_value),
  .oright_value(right_value),
  .odet(det_hold)
);

//tr * tr * SIFT_CURV_THR >= (SIFT_CURV_THR + 1) * (SIFT_CURV_THR + 1) * det
//        left            >=                     right

always@(posedge iclk or negedge irst_n) begin
  if (!irst_n) begin
    oedge_en <= 0;
  end
  else begin
    if ((det_hold <= 0) || (left_value >= right_value)) begin
      oedge_en <= 0;  //is edge    
    end
    else begin
      oedge_en <= 1;
    end  
  end
end

endmodule 