`timescale 1 ps / 1 ps

// Description: Parallel_Add
//
//
// Revision History :
// --------------------------------------------------------------------
//   Ver    : V1.0			|  Changes Made: Initial Revision			| 
//   Author : Pan Wei-Zheng	|  Mod. Date   : 09/30/2016 		 													
// --------------------------------------------------------------------

module Parallel_Add_descriptor(
  iclk,
  ireset,
  idval,
  idata,
  odval,
  osum
);

//=============================================================================
// PARAMETER declarations
//=============================================================================

`include  "SIFT_Parameter.v"

//=============================================================================
// PORT declarations
//=============================================================================

input                                           iclk;
input                                           ireset;
input                                           idval;
input         [SIFTDescriptor_output_bits-1:0]  idata;
output  reg                                     odval;
output  reg   [19:0]                            osum;

//=============================================================================
// REG/WIRE declarations
//=============================================================================

wire   [12:0]   w_idata_decode [127:0];
reg    [14:0]   add_Layer1 [31:0];
reg    [16:0]   add_Layer2 [7:0];
reg    [18:0]   add_Layer3 [1:0];
reg             w_data_en[2:0];
//=============================================================================
// Structural coding
//=============================================================================

genvar i;
generate
  for (i = 0; i < SIFTDescriptor_output_size; i = i + 1) begin : idata_encode
    assign w_idata_decode[i] = idata[Descriptor_bits * (i+1) - 1 : Descriptor_bits * i];  
  end
endgenerate

integer j;
integer k;

always@(posedge iclk or negedge ireset) begin
  if (!ireset) begin
    for (j = 0; j < 32; j = j + 1) begin
      add_Layer1[j] <= 0;    
    end
    for (k = 0; k < 8; k = k + 1) begin
      add_Layer2[k] <= 0; 
    end
    add_Layer3[0] <= 0;
    add_Layer3[1] <= 0;
    osum <= 0;
  end
  else begin
    for (j = 0; j < 32; j = j + 1) begin
      add_Layer1[j] <= (w_idata_decode[4*j] + w_idata_decode[(4*j)+1]) + (w_idata_decode[(4*j)+2] + w_idata_decode[(4*j)+3]);
    end
    for (k = 0; k < 8; k = k + 1) begin
      add_Layer2[k] <= (add_Layer1[4*k] + add_Layer1[(4*k)+1]) + (add_Layer1[(4*k)+2] + add_Layer1[(4*k)+3]);
    end
    add_Layer3[0] <= (add_Layer2[0] + add_Layer2[1]) + (add_Layer2[2] + add_Layer2[3]); 
    add_Layer3[1] <= (add_Layer2[4] + add_Layer2[5]) + (add_Layer2[6] + add_Layer2[7]);
    osum <= add_Layer3[0] + add_Layer3[1];
  end 
end

///////////////////////////////////////////////////////////////////////////////////////////////////////////

always@(posedge iclk or negedge ireset) begin
  if (!ireset) begin
    w_data_en[0] <= 0;
    w_data_en[1] <= 0;
    w_data_en[2] <= 0;
    odval <= 0;
  end
  else begin
    w_data_en[0] <= idval;
    w_data_en[1] <= w_data_en[0];
    w_data_en[2] <= w_data_en[1];
    odval <= w_data_en[2];
  end
end

endmodule 
