`timescale 1 ps / 1 ps

// Description: Normalize Descriptor
//
//
// Revision History :
// --------------------------------------------------------------------
//   Ver    : V1.0			|  Changes Made: Initial Revision			| 
//   Author : Pan Wei-Zheng	|  Mod. Date   : 10/04/2016 		 													
// --------------------------------------------------------------------

module Normalization(
  iclk,
  ireset,
  idval,
  idescriptor,
  odval,
  odescriptor,
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
input         [SIFTDescriptor_output_bits-1:0]  idescriptor;
output  reg                                     odval;
output        [1279:0]                          odescriptor;
output        [19:0]                            osum;

//=============================================================================
// REG/WIRE declarations
//=============================================================================

wire  [19:0]  w_sum;
wire          w_parallel_add_en;

//=============================================================================
// Structural coding
//=============================================================================

Parallel_Add_descriptor Normalize1(
  .iclk(iclk),
  .ireset(ireset),
  .idval(idval),
  .idata(idescriptor),
  .odval(w_parallel_add_en),
  .osum(w_sum)
);

assign osum = w_sum;

/////////////////////////////////////////////////////////////////////////////////
//input descriptor data hold

integer g;
reg   [SIFTDescriptor_output_bits-1:0]    w_all_descriptor_hold[19:0];


always@(posedge iclk or negedge ireset) begin
  if (!ireset) begin
    for (g = 0; g < 20; g = g + 1) begin
		 w_all_descriptor_hold[g] <= 0;
	 end
  end
  else begin
     for (g = 0; g < 19; g = g + 1) begin
		 w_all_descriptor_hold[0] <= idescriptor;
		 w_all_descriptor_hold[g+1] <= w_all_descriptor_hold[g];
	 end
  end
end

genvar j;
wire  [Descriptor_bits-1:0]  w_descriptor_hold [SIFTDescriptor_output_size-1:0];

generate
  for (j = 0; j < SIFTDescriptor_output_size; j = j + 1) begin : idata_encode
    assign w_descriptor_hold[j] = w_all_descriptor_hold[19][Descriptor_bits * (j+1) - 1 : Descriptor_bits * j];  
  end
endgenerate

/////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
//calculate the multiple times.
 
reg   [26:0]  multiple_numer;
reg   [4:0]   shift_bits;
reg 	[19:0]  w_sum_hold;
wire  [19:0]  region_flag;
wire   [26:0]  multiple_value; 

assign region_flag[3:0] = 9'h000;
assign region_flag[4] = (w_sum >= 16 && w_sum < 32) ? 1 : 0;
assign region_flag[5] = (w_sum >= 32 && w_sum < 64) ? 1 : 0;
assign region_flag[6] = (w_sum >= 64 && w_sum < 128) ? 1 : 0;
assign region_flag[7] = (w_sum >= 128 && w_sum < 256) ? 1 : 0;
assign region_flag[8] = (w_sum >= 256 && w_sum < 512) ? 1 : 0;
assign region_flag[9] = (w_sum >= 512 && w_sum < 1024) ? 1 : 0;
assign region_flag[10] = (w_sum >= 1024 && w_sum < 2048) ? 1 : 0;
assign region_flag[11] = (w_sum >= 2048 && w_sum < 4096) ? 1 : 0;
assign region_flag[12] = (w_sum >= 4096 && w_sum < 8192) ? 1 : 0;
assign region_flag[13] = (w_sum >= 8192 && w_sum < 16384) ? 1 : 0;
assign region_flag[14] = (w_sum >= 16384 && w_sum < 32768) ? 1 : 0;
assign region_flag[15] = (w_sum >= 32768 && w_sum < 65536) ? 1 : 0;
assign region_flag[16] = (w_sum >= 65536 && w_sum < 131072) ? 1 : 0;
assign region_flag[17] = (w_sum >= 131072 && w_sum < 262144) ? 1 : 0;
assign region_flag[19:18] = 2'b00;

always@(posedge iclk or negedge ireset) begin
  if (!ireset) begin
    multiple_numer <= 0;
    shift_bits <= 0;
	  w_sum_hold <= 0;
  end
  else begin
	 w_sum_hold <= w_sum;
    case (region_flag) 
		20'h00010 : begin
        multiple_numer = (1023 << 4);
        shift_bits <= 4;        
      end
	   20'h00020 : begin
        multiple_numer = (1023 << 5);
        shift_bits <= 5;        
      end
		20'h00040 : begin
        multiple_numer = (1023 << 6);
        shift_bits <= 6;        
      end
      20'h00080 : begin
        multiple_numer = (1023 << 7);
        shift_bits <= 7;        
      end
      20'h00100 : begin
        multiple_numer = (1023 << 8);
        shift_bits <= 8;        
      end
      20'h00200 : begin
        multiple_numer = (1023 << 9);
        shift_bits <= 9;        
      end
      20'h00400 : begin
        multiple_numer = (1023 << 10);
        shift_bits <= 10;  
      end
      20'h00800 : begin
        multiple_numer = (1023 << 11);
        shift_bits <= 11;  
      end
      20'h01000 : begin
        multiple_numer = (1023 << 12);
        shift_bits <= 12;  
      end
      20'h02000 : begin
        multiple_numer = (1023 << 13);
        shift_bits <= 13;  
      end
      20'h04000 : begin
        multiple_numer = (1023 << 14);
        shift_bits <= 14;  
      end
      20'h08000 : begin
        multiple_numer = (1023 << 15);
        shift_bits <= 15;  
      end
      20'h10000 : begin
        multiple_numer = (1023 << 16);
        shift_bits <= 16;  
      end
      20'h20000 : begin
        multiple_numer = (1023 << 17);
        shift_bits <= 17;  
      end       
      default begin
        multiple_numer = 0;
        shift_bits <= 0;        
      end     
    endcase
  end
end

integer h;
reg   [4:0]   shift_bits_hold [15:0];

always@(posedge iclk or negedge ireset) begin
	if (!ireset) begin
		for (h = 0; h < 16; h = h + 1) begin
			shift_bits_hold[h] <= 0;
		end
	end
	else begin
		for (h = 0; h < 15; h = h + 1) begin
			shift_bits_hold[0] <= shift_bits;
			shift_bits_hold[h+1] <= shift_bits_hold[h];
		end
	end
end

///////////////////////////////////////////////////////////////////////////////

Normalization_Div u1(
	.clock(iclk),
	.denom(w_sum_hold),
	.numer(multiple_numer),
	.quotient(multiple_value),
	.remain()
);

integer i;

reg [31:0] r_normalize_descriptor1 [127:0];

reg [9:0] r_normalize_descriptor2 [127:0];

always@(posedge iclk or negedge ireset) begin
  if (!ireset) begin
    for (i = 0; i < 128; i = i + 1) begin
      r_normalize_descriptor1[i] <= 0;
      r_normalize_descriptor2[i] <= 0;
    end    
  end
  else begin
    for (i = 0; i < 128; i = i + 1) begin
      r_normalize_descriptor1[i] <= (w_descriptor_hold[i] * multiple_value);
      r_normalize_descriptor2[i] <= r_normalize_descriptor1[i] >> shift_bits_hold[15];  
    end
  end
end

///////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////
//output data encoding

genvar k;
generate
  for (k = 0; k < SIFTDescriptor_output_size; k = k + 1) begin :output_encode
    assign odescriptor[10 * (k+1) - 1 : 10 * k] = r_normalize_descriptor2[k] ; 
  end
endgenerate

/////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////
//normalize calculation signals

reg r_normalize_hold [15:0];
integer f;

always@(posedge iclk or negedge ireset) begin
  if (!ireset) begin
	 for (f = 0; f < 16; f = f+1) begin
		r_normalize_hold[f] <= 0;
	 end
    odval <= 0;
  end
  else begin
    r_normalize_hold[0] <= w_parallel_add_en;
    for (f = 0; f < 15; f = f+1) begin
		r_normalize_hold[f+1] <= r_normalize_hold[f];
	 end
    odval <= r_normalize_hold[15];
  end  
end

/////////////////////////////////////////////////////////////////////////////////

endmodule 
