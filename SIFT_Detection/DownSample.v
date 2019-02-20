`timescale 1 ps / 1 ps

module DownSample(
  input                  iclk,
  input                  irst_n,
  input                  iDval,
  input          [7:0]   iData,
  output  reg            oData_en,
  output  reg    [7:0]   oData,
  output  reg            oMAC_3_en
);

reg [8:0] counter;
reg       mode;
reg [8:0] MAC_3_counter;
reg       MAC_3_mode;

always@(posedge iclk or negedge irst_n) begin
  if (!irst_n) begin
    MAC_3_mode <= 0;
    MAC_3_counter <= 0;
    oMAC_3_en <= 0;
  end
  else begin
    if (iDval) begin
      if (MAC_3_counter < 259 && !MAC_3_mode) begin
        oMAC_3_en <= 1;
        MAC_3_mode <= 1; 
      end
      else if(MAC_3_counter < 259 && MAC_3_mode) begin
        oMAC_3_en <= 0;
        MAC_3_mode <= 0; 
      end 
      else begin
        oMAC_3_en <= 0; 
      end
      MAC_3_counter <= MAC_3_counter + 1;
    end 
  end
end

always@(posedge iclk or negedge irst_n) begin
  if (!irst_n) begin
    mode <= 0;
    counter <= 0;
    oData_en <= 0;
    oData <= 0;  
  end
  else begin
    if (iDval) begin
      if (counter < 256 && !mode) begin
        oData_en <= 1;
        mode <= 1; 
      end
      else if(counter < 256 && mode) begin
        oData_en <= 0;
        mode <= 0; 
      end 
      else begin
        oData_en <= 0; 
      end
      oData <= iData;
      counter <= counter + 1;
    end 
  end
end

endmodule