`timescale 1 ps / 1 ps

module TestExtremaValueEn (  
  input             iclk,
  input             irst_n,
  input             iBig_en1,
  input             iBig_en2,
  input             iBig_en3,
  output   reg      oBig_en
);

always@(posedge iclk or negedge irst_n) begin
  if (!irst_n) begin
    oBig_en <= 0;
  end 
  else begin
    if (iBig_en1 & iBig_en2 & iBig_en3) begin
      oBig_en <= 1;
    end
    else begin
      oBig_en <= 0;
    end
  end 
end

endmodule 