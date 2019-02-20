module StatisticsBin(
  input                   iclk,
  input                   ireset,
  input         [17:0]    iline0,
  input         [17:0]    iline1,
  input         [17:0]    iline2,
  input         [17:0]    iline3,
  input         [17:0]    iline4,
  input         [17:0]    iline5,
  input         [17:0]    iline6,
  input         [17:0]    iline7,
  input         [17:0]    iline8,
  input         [17:0]    iline9,
  input         [17:0]    iline10,
  input         [17:0]    iline11,
  input         [17:0]    iline12,
  input         [17:0]    iline13,
  input         [17:0]    iline14,
  input         [17:0]    iline15,
  input         [8:0]     ilower_limit,
  input         [8:0]     iupper_limit,
  output  reg   [12:0]    obin_value
);

reg   [8:0]   r_mag_hold[15:0];
reg   [4:0]   i;

always@(posedge iclk or negedge ireset) begin
  if (!ireset) begin
    for (i = 0; i < 16; i = i + 1) begin  
      r_mag_hold[i] <= 0;
    end
  end
  else begin
///////////////////////////////////////////////////////////////////////////////////////////////
//region_detection
    ///////////////////////////////////////////////////////////////////////////////////////////////
    if (iline0[17:9] >= ilower_limit && iline0[17:9] < iupper_limit) begin
      r_mag_hold[0] <= iline0[8:0];
    end
    else begin
      r_mag_hold[0] <= 0;
    end
    ///////////////////////////////////////////////////////////////////////////////////////////////
    if (iline1[17:9] >= ilower_limit && iline1[17:9] < iupper_limit) begin
      r_mag_hold[1] <= iline1[8:0];
    end
    else begin
      r_mag_hold[1] <= 0;
    end
    ///////////////////////////////////////////////////////////////////////////////////////////////
    if (iline2[17:9] >= ilower_limit && iline2[17:9] < iupper_limit) begin
      r_mag_hold[2] <= iline2[8:0];
    end
    else begin
      r_mag_hold[2] <= 0;
    end    
    ///////////////////////////////////////////////////////////////////////////////////////////////
    if (iline3[17:9] >= ilower_limit && iline3[17:9] < iupper_limit) begin
      r_mag_hold[3] <= iline3[8:0];
    end
    else begin
      r_mag_hold[3] <= 0;
    end
    ///////////////////////////////////////////////////////////////////////////////////////////////
    if (iline4[17:9] >= ilower_limit && iline4[17:9] < iupper_limit) begin
      r_mag_hold[4] <= iline4[8:0];
    end
    else begin
      r_mag_hold[4] <= 0;
    end
    ///////////////////////////////////////////////////////////////////////////////////////////////
    if (iline5[17:9] >= ilower_limit && iline5[17:9] < iupper_limit) begin
      r_mag_hold[5] <= iline5[8:0];
    end
    else begin
      r_mag_hold[5] <= 0;
    end
    ///////////////////////////////////////////////////////////////////////////////////////////////   
    if (iline6[17:9] >= ilower_limit && iline6[17:9] < iupper_limit) begin
      r_mag_hold[6] <= iline6[8:0];
    end
    else begin
      r_mag_hold[6] <= 0;
    end    
    ///////////////////////////////////////////////////////////////////////////////////////////////   
    if (iline7[17:9] >= ilower_limit && iline7[17:9] < iupper_limit) begin
      r_mag_hold[7] <= iline7[8:0];
    end
    else begin
      r_mag_hold[7] <= 0;
    end  
    ///////////////////////////////////////////////////////////////////////////////////////////////
    if (iline8[17:9] >= ilower_limit && iline8[17:9] < iupper_limit) begin
      r_mag_hold[8] <= iline8[8:0];
    end
    else begin
      r_mag_hold[8] <= 0;
    end
    ///////////////////////////////////////////////////////////////////////////////////////////////
    if (iline9[17:9] >= ilower_limit && iline9[17:9] < iupper_limit) begin
      r_mag_hold[9] <= iline9[8:0];
    end
    else begin
      r_mag_hold[9] <= 0;
    end
    ///////////////////////////////////////////////////////////////////////////////////////////////
    if (iline10[17:9] >= ilower_limit && iline10[17:9] < iupper_limit) begin
      r_mag_hold[10] <= iline10[8:0];
    end
    else begin
      r_mag_hold[10] <= 0;
    end
    ///////////////////////////////////////////////////////////////////////////////////////////////
    if (iline11[17:9] >= ilower_limit && iline11[17:9] < iupper_limit) begin
      r_mag_hold[11] <= iline11[8:0];
    end
    else begin
      r_mag_hold[11] <= 0;
    end
    ///////////////////////////////////////////////////////////////////////////////////////////////
    if (iline12[17:9] >= ilower_limit && iline12[17:9] < iupper_limit) begin
      r_mag_hold[12] <= iline12[8:0];
    end
    else begin
      r_mag_hold[12] <= 0;
    end
    ///////////////////////////////////////////////////////////////////////////////////////////////
    if (iline13[17:9] >= ilower_limit && iline13[17:9] < iupper_limit) begin
      r_mag_hold[13] <= iline13[8:0];
    end
    else begin
      r_mag_hold[13] <= 0;
    end
    ///////////////////////////////////////////////////////////////////////////////////////////////
    if (iline14[17:9] >= ilower_limit && iline14[17:9] < iupper_limit) begin
      r_mag_hold[14] <= iline14[8:0];
    end
    else begin
      r_mag_hold[14] <= 0;
    end
    ///////////////////////////////////////////////////////////////////////////////////////////////
    if (iline15[17:9] >= ilower_limit && iline15[17:9] < iupper_limit) begin
      r_mag_hold[15] <= iline15[8:0];
    end
    else begin
      r_mag_hold[15] <= 0;
    end
    ///////////////////////////////////////////////////////////////////////////////////////////////
  end  
end

reg [3:0] j;

reg [9:0] r_MUX_layer1[3:0];
  
always@(posedge iclk or negedge ireset) begin
  if (!ireset) begin
    for (j = 0; j < 4; j = j + 1) begin
      r_MUX_layer1[j] <= 0;  
    end
    obin_value <= 0;
  end
  else begin
///////////////////////////////////////////////////////////////////////////////////////////////
//layer1
    ///////////////////////////////////////////////////////////////////////////////////////////////
    r_MUX_layer1[0] <= (r_mag_hold[0] + r_mag_hold[1]) + (r_mag_hold[2] + r_mag_hold[3]);
	  r_MUX_layer1[1] <= (r_mag_hold[4] + r_mag_hold[5]) + (r_mag_hold[6] + r_mag_hold[7]);
	  r_MUX_layer1[2] <= (r_mag_hold[8] + r_mag_hold[9]) + (r_mag_hold[10] + r_mag_hold[11]);
	  r_MUX_layer1[3] <= (r_mag_hold[12] + r_mag_hold[13]) + (r_mag_hold[14] + r_mag_hold[15]);
    ///////////////////////////////////////////////////////////////////////////////////////////////
    
    obin_value <= (r_MUX_layer1[0] + r_MUX_layer1[1]) + (r_MUX_layer1[2] + r_MUX_layer1[3]);
    
  end
end  

  
endmodule
