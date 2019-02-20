`timescale 1 ps / 1 ps

module UnstableKeypointDetect (  
  input                                 iclk,
  input                                 irst_n,
  input             signed     [8:0]    iData_mid_top_left,
  input             signed     [8:0]    iData_mid_top,
  input             signed     [8:0]    iData_mid_top_right,
  input             signed     [8:0]    iData_mid_left,
  input             signed     [8:0]    iData_mid,
  input             signed     [8:0]    iData_mid_right,
  input             signed     [8:0]    iData_mid_bot_left,
  input             signed     [8:0]    iData_mid_bot,
  input             signed     [8:0]    iData_mid_bot_right,
  input             signed     [8:0]    iData_next_top,
  input             signed     [8:0]    iData_next_left,
  input             signed     [8:0]    iData_next,
  input             signed     [8:0]    iData_next_right,
  input             signed     [8:0]    iData_next_bot,
  input             signed     [8:0]    iData_pre_top,
  input             signed     [8:0]    iData_pre_left,
  input             signed     [8:0]    iData_pre,
  input             signed     [8:0]    iData_pre_right,
  input             signed     [8:0]    iData_pre_bot,
  output    	     		                ostable_en
);

wire    signed    [8:0]   dx;
wire    signed    [8:0]   dy;
wire    signed    [8:0]   ds;
wire    signed    [8:0]   dxx;
wire    signed    [8:0]   dyy;
wire    signed    [8:0]   dss;
wire    signed    [8:0]   dxy;
wire    signed    [8:0]   dxs;
wire    signed    [8:0]   dys;
wire    signed    [8:0]   adj11;
wire    signed    [8:0]   adj12;
wire    signed    [8:0]   adj13;
wire    signed    [8:0]   adj21;
wire    signed    [8:0]   adj22;
wire    signed    [8:0]   adj23;
wire    signed    [8:0]   adj31;
wire    signed    [8:0]   adj32;
wire    signed    [8:0]   adj33;
wire    signed    [24:0]  det;
wire                      edge_en;
wire                      lowcontrast_en;
   
reg     signed    [8:0]   r_dx[2:0];
reg     signed    [8:0]   r_dy[2:0];
reg     signed    [8:0]   r_ds[2:0];
reg	  signed		[8:0]	  r_iData_mid[3:0];
reg               [2:0]   i;
reg					[2:0]	  j;	
reg                       edge_en_hold[5:0];

Difference_3D accuratekeypointlocation1(  
  .iclk(iclk),
  .irst_n(irst_n),
  .iData_right(iData_mid_right),
  .iData_left(iData_mid_left),
  .iData_bot(iData_mid_bot),
  .iData_top(iData_mid_top),
  .iData_next(iData_next),
  .iData_pre(iData_pre),
  .odx(dx),
  .ody(dy),
  .ods(ds)
);

Hessian_3D accuratekeypointlocation2(  
  .iclk(iclk),
  .irst_n(irst_n),
  .iData_mid_top_left(iData_mid_top_left),
  .iData_mid_top(iData_mid_top),
  .iData_mid_top_right(iData_mid_top_right),
  .iData_mid_left(iData_mid_left),
  .iData_mid(iData_mid),
  .iData_mid_right(iData_mid_right),
  .iData_mid_bot_left(iData_mid_bot_left),
  .iData_mid_bot(iData_mid_bot),
  .iData_mid_bot_right(iData_mid_bot_right),
  .iData_next_top(iData_next_top),
  .iData_next_left(iData_next_left),
  .iData_next(iData_next),
  .iData_next_right(iData_next_right),
  .iData_next_bot(iData_next_bot),
  .iData_pre_top(iData_pre_top),
  .iData_pre_left(iData_pre_left),
  .iData_pre(iData_pre),
  .iData_pre_right(iData_pre_right),
  .iData_pre_bot(iData_pre_bot),
  .odxx(dxx),
  .odyy(dyy),
  .odss(dss),
  .odxy(dxy),
  .odxs(dxs),
  .odys(dys)
);

InverseHessian_3D accuratekeypointlocation3(  
  .iclk(iclk),
  .irst_n(irst_n),
  .iData_11(dxx),
  .iData_12(dxy),
  .iData_13(dxs),
  .iData_21(dxy),
  .iData_22(dyy),
  .iData_23(dys),
  .iData_31(dxs),
  .iData_32(dys),
  .iData_33(dss),
  .oadj11(adj11),
  .oadj12(adj12),
  .oadj13(adj13),
  .oadj21(adj21),
  .oadj22(adj22),
  .oadj23(adj23),
  .oadj31(adj31),
  .oadj32(adj32),
  .oadj33(adj33),
  .odet(det)
);

always@(posedge iclk or negedge irst_n) begin
  if (!irst_n) begin
    r_dx[0] <= 0;
    r_dx[1] <= 0;
    r_dx[2] <= 0;      
    r_dy[0] <= 0;
    r_dy[1] <= 0;
    r_dy[2] <= 0;
    r_ds[0] <= 0;
    r_ds[1] <= 0;
    r_ds[2] <= 0;
	 for (j = 0; j < 4; j = j + 1) begin
		r_iData_mid[j] <= 0;
	 end
  end
  else begin
    r_dx[0] <= dx;
    r_dy[0] <= dy;
    r_ds[0] <= ds;
    r_dx[1] <= r_dx[0];
    r_dy[1] <= r_dy[0];
    r_ds[1] <= r_ds[0];
    r_dx[2] <= r_dx[1];
    r_dy[2] <= r_dy[1];
    r_ds[2] <= r_ds[1];
	 r_iData_mid[0] <= iData_mid;
	 for (j = 0; j < 3; j = j + 1) begin
		r_iData_mid[j+1] <= r_iData_mid[j];
	 end
  end
end

LowContrastDetect accuratekeypointlocation4(  
  .iclk(iclk),
  .irst_n(irst_n),
  .ipixel_data(r_iData_mid[3]),
  .iadj11(adj11),
  .iadj12(adj12),
  .iadj13(adj13),
  .iadj21(adj21),
  .iadj22(adj22),
  .iadj23(adj23),
  .iadj31(adj31),
  .iadj32(adj32),
  .iadj33(adj33),
  .idet(det),
  .idx(r_dx[2]),
  .idy(r_dy[2]),
  .ids(r_ds[2]),
  .olowcontrast_en(lowcontrast_en)
);

EdgeDetect accuratekeypointlocation5(  
  .iclk(iclk),
  .irst_n(irst_n),
  .idxx(dxx),
  .idyy(dyy),
  .idxy(dxy),
  .oedge_en(edge_en)
);

assign ostable_en = edge_en_hold[5] & lowcontrast_en;

always@(posedge iclk or negedge irst_n) begin
  if (!irst_n) begin
    for (i = 0; i < 6; i = i + 1) begin
      edge_en_hold[i] <= 0;
    end
  end
  else begin
    edge_en_hold[0] <= edge_en;
    for (i = 0; i < 5; i = i + 1) begin
      edge_en_hold[i+1] <= edge_en_hold[i];
    end  
  end
end

endmodule

