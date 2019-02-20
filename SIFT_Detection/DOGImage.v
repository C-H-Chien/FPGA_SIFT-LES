`timescale 1 ps / 1 ps

module DOGImage(
  input                clk,
  input                irst_n,
  input         [8:0]  idata_a,
  input         [8:0]  idata_b,
  output  reg   [8:0]  odata
);

reg  [8:0]  r_data_a;
reg  [8:0]  r_data_b;

always@(posedge clk or negedge irst_n) begin
  if (!irst_n) begin
    r_data_a <= 0;
    r_data_b <= 0;
    odata <= 0;
  end 
  else begin
    r_data_a <= idata_a;
    r_data_b <= idata_b;
    if (r_data_a[7:0] > r_data_b[7:0]) begin
      odata[7:0] <= r_data_a[7:0] - r_data_b[7:0];
    end
    else begin
      odata[7:0] <= 0;      
    end
    odata[8] <= r_data_a[8];
  end 
end

endmodule