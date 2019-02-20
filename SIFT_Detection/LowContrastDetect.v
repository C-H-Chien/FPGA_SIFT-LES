`timescale 1 ps / 1 ps

module LowContrastDetect (  
  input                               iclk,
  input                               irst_n,
  input           signed     [8:0]    ipixel_data,
  input           signed     [8:0]    iadj11,
  input           signed     [8:0]    iadj12,
  input           signed     [8:0]    iadj13,
  input           signed     [8:0]    iadj21,
  input           signed     [8:0]    iadj22,
  input           signed     [8:0]    iadj23,
  input           signed     [8:0]    iadj31,
  input           signed     [8:0]    iadj32,
  input           signed     [8:0]    iadj33,
  input           signed     [16:0]   idet,
  input           signed     [8:0]    idx,
  input           signed     [8:0]    idy,
  input           signed     [8:0]    ids,
  output    reg                       olowcontrast_en
);

wire    signed     [31:0]   left_value;
wire    signed     [31:0]   right_value;

LowContrastValue lowcontrastdetect1(  
  .iclk(iclk),
  .irst_n(irst_n),
  .ipixel_data(ipixel_data),
  .iadj11(iadj11),
  .iadj12(iadj12),
  .iadj13(iadj13),
  .iadj21(iadj21),
  .iadj22(iadj22),
  .iadj23(iadj23),
  .iadj31(iadj31),
  .iadj32(iadj32),
  .iadj33(iadj33),
  .idet(idet),
  .idx(idx),
  .idy(idy),
  .ids(ids),
  .oleft_value(left_value),
  .oright_value(right_value)
);

always@(posedge iclk or negedge irst_n) begin
  if (!irst_n) begin
    olowcontrast_en <= 0;
  end
  else begin
    if (left_value <= right_value) begin
      olowcontrast_en <= 0;
    end
    else begin
      olowcontrast_en <= 1;
    end
  end
end

endmodule 