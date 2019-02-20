// Description: To hold line buffer output of gradient
//
//
// Revision History :
// --------------------------------------------------------------------
//   Ver    : V1.0			|  Changes Made: Initial Revision			| 
//   Author : Pan Wei-Zheng	|  Mod. Date   : 08/09/2016 		 													
// --------------------------------------------------------------------
module Descriptor_Buffer_Hold(
    iclk,
    ireset,
    igradient,
    ogradient
);

//=============================================================================
// PARAMETER declarations
//=============================================================================

`include  "SIFT_Parameter.v"

//=============================================================================
// PORT declarations
//=============================================================================
input                                                   iclk;
input                                                   ireset;
input         [Descriptor_Buffer_Hold_input_bits:0]     igradient;
output        [Descriptor_Buffer_Hold_output_bits:0]    ogradient;

//=============================================================================
// REG/WIRE declarations
//=============================================================================
wire   [Gradient_bits:0]    w_gradient[Descriptor_Buffer_Hold_input_size-1:0];
reg    [Gradient_bits:0]    w_gradient_hold[Descriptor_Buffer_Hold_output_size-1:0];


//=============================================================================
// Structural coding
//=============================================================================

///////////////////////////////////////////////////////////////////////////////
genvar g;
generate 
  for( g = 0 ; g < Descriptor_Buffer_Hold_input_size; g = g + 1) begin :decode_input
     assign w_gradient[g] = igradient[Gradient_bits * (g+1) - 1:Gradient_bits *g];
  end	
endgenerate
///////////////////////////////////////////////////////////////////////////////

integer i, j, h, e;
always@(posedge iclk or negedge ireset) begin
  if (!ireset) begin
    for (i = 0; i < Descriptor_Buffer_Hold_output_size; i = i + 1) begin
      w_gradient_hold[i] <= 0; 
    end
  end
  else begin
    ///////////////////////////////////////////////////////////////////////////
    for (e = 0; e < Descriptor_Buffer_Hold_input_size; e = e + 1) begin
      w_gradient_hold[e * Descriptor_Buffer_Hold_input_size] <= w_gradient[e];  
    end
    ///////////////////////////////////////////////////////////////////////////
    for (j = 0; j < Descriptor_Buffer_Hold_input_size; j = j + 1) begin
      for (h = 0; h < Descriptor_Buffer_Hold_input_size-1; h = h + 1) begin
        w_gradient_hold[j * Descriptor_Buffer_Hold_input_size + (h+1)] <= w_gradient_hold[j * Descriptor_Buffer_Hold_input_size + h];
      end        
    end
    ///////////////////////////////////////////////////////////////////////////
  end
end

///////////////////////////////////////////////////////////////////////////////
genvar k;
generate 
  for( k = 0 ; k < Descriptor_Buffer_Hold_output_size; k = k + 1) begin :encode_output
     assign ogradient[(Gradient_bits * (k+1)) - 1 : Gradient_bits * k] = w_gradient_hold[k];
  end	
endgenerate
///////////////////////////////////////////////////////////////////////////////

endmodule 