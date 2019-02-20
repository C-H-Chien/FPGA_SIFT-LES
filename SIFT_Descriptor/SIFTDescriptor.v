`timescale 1 ps / 1 ps

// Description: SIFT feature descriptor 
//
//
// Revision History :
// --------------------------------------------------------------------
//   Ver    : V1.0			|  Changes Made: Initial Revision			| 
//   Author : Pan Wei-Zheng	|  Mod. Date   : 08/09/2016 		 													
// --------------------------------------------------------------------
module SIFTDescriptor(
  iclk,
  ireset,
  iImagedata,
  odval,
  odescriptor
);

//=============================================================================
// PARAMETER declarations
//=============================================================================

`include  "SIFT_Parameter.v"

//=============================================================================
// PORT declarations
//=============================================================================
input                                             iclk;
input                                             ireset;
input         [8:0]                               iImagedata;
output                                            odval;
output        [1280-1:0]                          odescriptor;

//=============================================================================
// REG/WIRE declarations
//=============================================================================
wire   [Gradient_bits-1:0]                        w_input_gradient;
wire   [Gradient_bits-1:0]                        w_gradient[Descriptor_Buffer_Hold_input_size-1:0];
wire   [Descriptor_Buffer_Hold_input_bits-1:0]    w_all_gradient;
wire   [Descriptor_Buffer_Hold_output_bits-1:0]   w_all_gradient_hold;
wire   [Gradient_bits-1:0]                        w_gradient_hold[Descriptor_Buffer_Hold_output_size-1:0];
wire   [Descriptor_bits-1:0]                      w_descriptor[SIFTDescriptor_output_size-1:0];

//=============================================================================
// Structural coding
//=============================================================================

////////////////////////////////////////////////////////////////////////////////////////////////////
//calculating image gradient

wire	[8:0] w_Gaussian_window [8:0]; 

Window_3x3 OrientationDetection_tb2(
	.iclk(iclk),
	.irst_n(ireset),
	.idata(iImagedata),
	.odata0(w_Gaussian_window[0]),
	.odata1(w_Gaussian_window[1]),
	.odata2(w_Gaussian_window[2]),
	.odata3(w_Gaussian_window[3]),
	.odata4(w_Gaussian_window[4]),
	.odata5(w_Gaussian_window[5]),
	.odata6(w_Gaussian_window[6]),
	.odata7(w_Gaussian_window[7]),
	.odata8(w_Gaussian_window[8])
);  

wire  [15:0]    w_magnitude;
wire  [15:0]    w_orientation;
wire            w_ImageGradient_en;

ImageGradient OrientationDetection_tb3(
	.iclk(iclk),
	.ireset(ireset),
	.idata_en(w_Gaussian_window[4][8]),
	.itop(w_Gaussian_window[7]),
	.ileft(w_Gaussian_window[5]),
	.iright(w_Gaussian_window[3]),
	.ibot(w_Gaussian_window[1]),
	.omagnitude(w_magnitude),
	.oorientation(w_orientation),
	.odata_en(w_ImageGradient_en)
);

integer         cordic_i;
reg   [17:0]    magnitude_cal[1:0];
reg   [8:0]     orientation_cal[1:0];
reg   [8:0]     magnitude_real;
reg   [8:0]     orientation_real;
reg             r_CORDIC_en[2:0];

////////////////////////////////////////////////////////////////////////////
//CORDIC answer transfer
always@(posedge iclk or negedge ireset) begin
  if (!ireset) begin
    for (cordic_i = 0; cordic_i < 2; cordic_i = cordic_i+1) begin      
      magnitude_cal[cordic_i] <= 0;
      orientation_cal[cordic_i] <= 0;
    end      
    magnitude_real <= 0;
    orientation_real <= 0;
    ////////////////////////////////////////////////////////////////////////////
    r_CORDIC_en[0] <= 0;
    r_CORDIC_en[1] <= 0;
    r_CORDIC_en[2] <= 0;
    ////////////////////////////////////////////////////////////////////////////
  end
  else begin  // (magnitude >> 6) * K    (orientation / 10) 
    magnitude_cal[0] <= w_magnitude >> 6; 
    orientation_cal[0] <= w_orientation >> 6;  	
    magnitude_cal[1] <= magnitude_cal[0] * 311;
    orientation_cal[1] <= orientation_cal[0];
    magnitude_real <= magnitude_cal[1] >> 9;
    orientation_real <= orientation_cal[1];
    ////////////////////////////////////////////////////////////////////////////
    r_CORDIC_en[0] <= w_ImageGradient_en;
    r_CORDIC_en[1] <= r_CORDIC_en[0];
    r_CORDIC_en[2] <= r_CORDIC_en[1];
    ////////////////////////////////////////////////////////////////////////////
  end 
end
////////////////////////////////////////////////////////////////////////////////////////////////////

assign w_input_gradient = {r_CORDIC_en[2], orientation_real, magnitude_real};

Descriptor_Buffer SIFTDescriptor0(
	.aclr(!ireset),
	.clken(1'b1),
	.clock(iclk),
	.shiftin(w_input_gradient),
	.taps0x(w_gradient[0]),
	.taps1x(w_gradient[1]),
	.taps2x(w_gradient[2]),
	.taps3x(w_gradient[3]),
	.taps4x(w_gradient[4]),
	.taps5x(w_gradient[5]),
	.taps6x(w_gradient[6]),
	.taps7x(w_gradient[7]),
	.taps8x(w_gradient[8]),
	.taps9x(w_gradient[9]),
	.taps10x(w_gradient[10]),
	.taps11x(w_gradient[11]),
	.taps12x(w_gradient[12]),
	.taps13x(w_gradient[13]),
	.taps14x(w_gradient[14]),
	.taps15x(w_gradient[15])
);

////////////////////////////////////////////////////////////////////////////////////////
//wire  [9:0]   debug_signal[15:0];
//reg   [31:0]  debug_counter;
//
//genvar debug_i;
//
//generate
//  for (debug_i = 0; debug_i < 16; debug_i = debug_i + 1) begin :debug
//    assign debug_signal[debug_i] = {w_gradient[debug_i][18],w_gradient[debug_i][8:0]};
//  end
//endgenerate
//
//always@(posedge iclk or negedge ireset) begin
//  if (!ireset) begin
//    debug_counter <= 0;
//  end
//  else begin
//    if (w_gradient[15][18]) begin
//      debug_counter <= debug_counter + 1; 
//    end
//    else begin
//      debug_counter <= debug_counter;
//    end
//  end
//end

////////////////////////////////////////////////////////////////////////////////////////

genvar i;
generate
  for (i = 0; i < Descriptor_Buffer_Hold_input_size; i = i + 1) begin :encode_gradient
    assign w_all_gradient[Gradient_bits * (i+1) - 1 : Gradient_bits * i] = w_gradient[i];
  end
endgenerate

Descriptor_Buffer_Hold SIFTDescriptor21(
    .iclk(iclk),
    .ireset(ireset),
    .igradient(w_all_gradient),
    .ogradient(w_all_gradient_hold)
);

genvar j;
generate
  for (j = 0; j < Descriptor_Buffer_Hold_output_size; j = j + 1) begin :decode_buffer_hold
    assign w_gradient_hold[j] = w_all_gradient_hold[Gradient_bits * (j+1) - 1 : Gradient_bits * j];  
  end
endgenerate
  
Statistics_8Bin SIFTDescriptor1(
  .iclk(iclk),
  .ireset(ireset),
  .igradient0(w_gradient_hold[255][17:0]),
  .igradient1(w_gradient_hold[254][17:0]),
  .igradient2(w_gradient_hold[253][17:0]),
  .igradient3(w_gradient_hold[252][17:0]),
  .igradient4(w_gradient_hold[239][17:0]),
  .igradient5(w_gradient_hold[238][17:0]),
  .igradient6(w_gradient_hold[237][17:0]),
  .igradient7(w_gradient_hold[236][17:0]),
  .igradient8(w_gradient_hold[223][17:0]),
  .igradient9(w_gradient_hold[222][17:0]),
  .igradient10(w_gradient_hold[221][17:0]),
  .igradient11(w_gradient_hold[220][17:0]),
  .igradient12(w_gradient_hold[207][17:0]),
  .igradient13(w_gradient_hold[206][17:0]),
  .igradient14(w_gradient_hold[205][17:0]),
  .igradient15(w_gradient_hold[204][17:0]),
  .obin_value0(w_descriptor[0]),
  .obin_value1(w_descriptor[1]),
  .obin_value2(w_descriptor[2]),
  .obin_value3(w_descriptor[3]),
  .obin_value4(w_descriptor[4]),
  .obin_value5(w_descriptor[5]),
  .obin_value6(w_descriptor[6]),
  .obin_value7(w_descriptor[7])
);  

/////////////////////////////////////////////////////////////////////////////////
//wire  [8:0] debug_orientation[256:0];
//wire  [8:0] debug_magnitude[256:0];
//
//genvar debug_k;
//generate
//  for (debug_k = 0; debug_k < 256; debug_k = debug_k + 1) begin :encode_descriptor_output1
//    assign debug_orientation[debug_k] = w_gradient_hold[debug_k][17:9];
//    assign debug_magnitude[debug_k] = w_gradient_hold[debug_k][8:0]; 
//  end
//endgenerate

/////////////////////////////////////////////////////////////////////////////////

Statistics_8Bin SIFTDescriptor2(
  .iclk(iclk),
  .ireset(ireset),
  .igradient0(w_gradient_hold[251][17:0]),
  .igradient1(w_gradient_hold[250][17:0]),
  .igradient2(w_gradient_hold[249][17:0]),
  .igradient3(w_gradient_hold[248][17:0]),
  .igradient4(w_gradient_hold[235][17:0]),
  .igradient5(w_gradient_hold[234][17:0]),
  .igradient6(w_gradient_hold[233][17:0]),
  .igradient7(w_gradient_hold[232][17:0]),
  .igradient8(w_gradient_hold[219][17:0]),
  .igradient9(w_gradient_hold[218][17:0]),
  .igradient10(w_gradient_hold[217][17:0]),
  .igradient11(w_gradient_hold[216][17:0]),
  .igradient12(w_gradient_hold[203][17:0]),
  .igradient13(w_gradient_hold[202][17:0]),
  .igradient14(w_gradient_hold[201][17:0]),
  .igradient15(w_gradient_hold[200][17:0]),
  .obin_value0(w_descriptor[8]),
  .obin_value1(w_descriptor[9]),
  .obin_value2(w_descriptor[10]),
  .obin_value3(w_descriptor[11]),
  .obin_value4(w_descriptor[12]),
  .obin_value5(w_descriptor[13]),
  .obin_value6(w_descriptor[14]),
  .obin_value7(w_descriptor[15])
);  

Statistics_8Bin SIFTDescriptor3(
  .iclk(iclk),
  .ireset(ireset),
  .igradient0(w_gradient_hold[247][17:0]),
  .igradient1(w_gradient_hold[246][17:0]),
  .igradient2(w_gradient_hold[245][17:0]),
  .igradient3(w_gradient_hold[244][17:0]),
  .igradient4(w_gradient_hold[231][17:0]),
  .igradient5(w_gradient_hold[230][17:0]),
  .igradient6(w_gradient_hold[229][17:0]),
  .igradient7(w_gradient_hold[228][17:0]),
  .igradient8(w_gradient_hold[215][17:0]),
  .igradient9(w_gradient_hold[214][17:0]),
  .igradient10(w_gradient_hold[213][17:0]),
  .igradient11(w_gradient_hold[212][17:0]),
  .igradient12(w_gradient_hold[199][17:0]),
  .igradient13(w_gradient_hold[198][17:0]),
  .igradient14(w_gradient_hold[197][17:0]),
  .igradient15(w_gradient_hold[196][17:0]),
  .obin_value0(w_descriptor[16]),
  .obin_value1(w_descriptor[17]),
  .obin_value2(w_descriptor[18]),
  .obin_value3(w_descriptor[19]),
  .obin_value4(w_descriptor[20]),
  .obin_value5(w_descriptor[21]),
  .obin_value6(w_descriptor[22]),
  .obin_value7(w_descriptor[23])
);  

Statistics_8Bin SIFTDescriptor4(
  .iclk(iclk),
  .ireset(ireset),
  .igradient0(w_gradient_hold[243][17:0]),
  .igradient1(w_gradient_hold[242][17:0]),
  .igradient2(w_gradient_hold[241][17:0]),
  .igradient3(w_gradient_hold[240][17:0]),
  .igradient4(w_gradient_hold[227][17:0]),
  .igradient5(w_gradient_hold[226][17:0]),
  .igradient6(w_gradient_hold[225][17:0]),
  .igradient7(w_gradient_hold[224][17:0]),
  .igradient8(w_gradient_hold[211][17:0]),
  .igradient9(w_gradient_hold[210][17:0]),
  .igradient10(w_gradient_hold[209][17:0]),
  .igradient11(w_gradient_hold[208][17:0]),
  .igradient12(w_gradient_hold[195][17:0]),
  .igradient13(w_gradient_hold[194][17:0]),
  .igradient14(w_gradient_hold[193][17:0]),
  .igradient15(w_gradient_hold[192][17:0]),
  .obin_value0(w_descriptor[24]),
  .obin_value1(w_descriptor[25]),
  .obin_value2(w_descriptor[26]),
  .obin_value3(w_descriptor[27]),
  .obin_value4(w_descriptor[28]),
  .obin_value5(w_descriptor[29]),
  .obin_value6(w_descriptor[30]),
  .obin_value7(w_descriptor[31])
);  

Statistics_8Bin SIFTDescriptor5(
  .iclk(iclk),
  .ireset(ireset),
  .igradient0(w_gradient_hold[191][17:0]),
  .igradient1(w_gradient_hold[190][17:0]),
  .igradient2(w_gradient_hold[189][17:0]),
  .igradient3(w_gradient_hold[188][17:0]),
  .igradient4(w_gradient_hold[175][17:0]),
  .igradient5(w_gradient_hold[174][17:0]),
  .igradient6(w_gradient_hold[173][17:0]),
  .igradient7(w_gradient_hold[172][17:0]),
  .igradient8(w_gradient_hold[159][17:0]),
  .igradient9(w_gradient_hold[158][17:0]),
  .igradient10(w_gradient_hold[157][17:0]),
  .igradient11(w_gradient_hold[156][17:0]),
  .igradient12(w_gradient_hold[143][17:0]),
  .igradient13(w_gradient_hold[142][17:0]),
  .igradient14(w_gradient_hold[141][17:0]),
  .igradient15(w_gradient_hold[140][17:0]),
  .obin_value0(w_descriptor[32]),
  .obin_value1(w_descriptor[33]),
  .obin_value2(w_descriptor[34]),
  .obin_value3(w_descriptor[35]),
  .obin_value4(w_descriptor[36]),
  .obin_value5(w_descriptor[37]),
  .obin_value6(w_descriptor[38]),
  .obin_value7(w_descriptor[39])
);  

Statistics_8Bin SIFTDescriptor6(
  .iclk(iclk),
  .ireset(ireset),
  .igradient0(w_gradient_hold[187][17:0]),
  .igradient1(w_gradient_hold[186][17:0]),
  .igradient2(w_gradient_hold[185][17:0]),
  .igradient3(w_gradient_hold[184][17:0]),
  .igradient4(w_gradient_hold[171][17:0]),
  .igradient5(w_gradient_hold[170][17:0]),
  .igradient6(w_gradient_hold[169][17:0]),
  .igradient7(w_gradient_hold[168][17:0]),
  .igradient8(w_gradient_hold[155][17:0]),
  .igradient9(w_gradient_hold[154][17:0]),
  .igradient10(w_gradient_hold[153][17:0]),
  .igradient11(w_gradient_hold[152][17:0]),
  .igradient12(w_gradient_hold[139][17:0]),
  .igradient13(w_gradient_hold[138][17:0]),
  .igradient14(w_gradient_hold[137][17:0]),
  .igradient15(w_gradient_hold[136][17:0]),
  .obin_value0(w_descriptor[40]),
  .obin_value1(w_descriptor[41]),
  .obin_value2(w_descriptor[42]),
  .obin_value3(w_descriptor[43]),
  .obin_value4(w_descriptor[44]),
  .obin_value5(w_descriptor[45]),
  .obin_value6(w_descriptor[46]),
  .obin_value7(w_descriptor[47])
);  

Statistics_8Bin SIFTDescriptor7(
  .iclk(iclk),
  .ireset(ireset),
  .igradient0(w_gradient_hold[183][17:0]),
  .igradient1(w_gradient_hold[182][17:0]),
  .igradient2(w_gradient_hold[181][17:0]),
  .igradient3(w_gradient_hold[180][17:0]),
  .igradient4(w_gradient_hold[167][17:0]),
  .igradient5(w_gradient_hold[166][17:0]),
  .igradient6(w_gradient_hold[165][17:0]),
  .igradient7(w_gradient_hold[164][17:0]),
  .igradient8(w_gradient_hold[151][17:0]),
  .igradient9(w_gradient_hold[150][17:0]),
  .igradient10(w_gradient_hold[149][17:0]),
  .igradient11(w_gradient_hold[148][17:0]),
  .igradient12(w_gradient_hold[135][17:0]),
  .igradient13(w_gradient_hold[134][17:0]),
  .igradient14(w_gradient_hold[133][17:0]),
  .igradient15(w_gradient_hold[132][17:0]),
  .obin_value0(w_descriptor[48]),
  .obin_value1(w_descriptor[49]),
  .obin_value2(w_descriptor[50]),
  .obin_value3(w_descriptor[51]),
  .obin_value4(w_descriptor[52]),
  .obin_value5(w_descriptor[53]),
  .obin_value6(w_descriptor[54]),
  .obin_value7(w_descriptor[55])
);  

Statistics_8Bin SIFTDescriptor8(
  .iclk(iclk),
  .ireset(ireset),
  .igradient0(w_gradient_hold[179][17:0]),
  .igradient1(w_gradient_hold[178][17:0]),
  .igradient2(w_gradient_hold[177][17:0]),
  .igradient3(w_gradient_hold[176][17:0]),
  .igradient4(w_gradient_hold[163][17:0]),
  .igradient5(w_gradient_hold[162][17:0]),
  .igradient6(w_gradient_hold[161][17:0]),
  .igradient7(w_gradient_hold[160][17:0]),
  .igradient8(w_gradient_hold[147][17:0]),
  .igradient9(w_gradient_hold[146][17:0]),
  .igradient10(w_gradient_hold[145][17:0]),
  .igradient11(w_gradient_hold[144][17:0]),
  .igradient12(w_gradient_hold[131][17:0]),
  .igradient13(w_gradient_hold[130][17:0]),
  .igradient14(w_gradient_hold[129][17:0]),
  .igradient15(w_gradient_hold[128][17:0]),
  .obin_value0(w_descriptor[56]),
  .obin_value1(w_descriptor[57]),
  .obin_value2(w_descriptor[58]),
  .obin_value3(w_descriptor[59]),
  .obin_value4(w_descriptor[60]),
  .obin_value5(w_descriptor[61]),
  .obin_value6(w_descriptor[62]),
  .obin_value7(w_descriptor[63])
);  

Statistics_8Bin SIFTDescriptor9(
  .iclk(iclk),
  .ireset(ireset),
  .igradient0(w_gradient_hold[127][17:0]),
  .igradient1(w_gradient_hold[126][17:0]),
  .igradient2(w_gradient_hold[125][17:0]),
  .igradient3(w_gradient_hold[124][17:0]),
  .igradient4(w_gradient_hold[111][17:0]),
  .igradient5(w_gradient_hold[110][17:0]),
  .igradient6(w_gradient_hold[109][17:0]),
  .igradient7(w_gradient_hold[108][17:0]),
  .igradient8(w_gradient_hold[95][17:0]),
  .igradient9(w_gradient_hold[94][17:0]),
  .igradient10(w_gradient_hold[93][17:0]),
  .igradient11(w_gradient_hold[92][17:0]),
  .igradient12(w_gradient_hold[79][17:0]),
  .igradient13(w_gradient_hold[78][17:0]),
  .igradient14(w_gradient_hold[77][17:0]),
  .igradient15(w_gradient_hold[76][17:0]),
  .obin_value0(w_descriptor[64]),
  .obin_value1(w_descriptor[65]),
  .obin_value2(w_descriptor[66]),
  .obin_value3(w_descriptor[67]),
  .obin_value4(w_descriptor[68]),
  .obin_value5(w_descriptor[69]),
  .obin_value6(w_descriptor[70]),
  .obin_value7(w_descriptor[71])
);  

Statistics_8Bin SIFTDescriptor10(
  .iclk(iclk),
  .ireset(ireset),
  .igradient0(w_gradient_hold[123][17:0]),
  .igradient1(w_gradient_hold[122][17:0]),
  .igradient2(w_gradient_hold[121][17:0]),
  .igradient3(w_gradient_hold[120][17:0]),
  .igradient4(w_gradient_hold[107][17:0]),
  .igradient5(w_gradient_hold[106][17:0]),
  .igradient6(w_gradient_hold[105][17:0]),
  .igradient7(w_gradient_hold[104][17:0]),
  .igradient8(w_gradient_hold[91][17:0]),
  .igradient9(w_gradient_hold[90][17:0]),
  .igradient10(w_gradient_hold[89][17:0]),
  .igradient11(w_gradient_hold[88][17:0]),
  .igradient12(w_gradient_hold[75][17:0]),
  .igradient13(w_gradient_hold[74][17:0]),
  .igradient14(w_gradient_hold[73][17:0]),
  .igradient15(w_gradient_hold[72][17:0]),
  .obin_value0(w_descriptor[72]),
  .obin_value1(w_descriptor[73]),
  .obin_value2(w_descriptor[74]),
  .obin_value3(w_descriptor[75]),
  .obin_value4(w_descriptor[76]),
  .obin_value5(w_descriptor[77]),
  .obin_value6(w_descriptor[78]),
  .obin_value7(w_descriptor[79])
);  

Statistics_8Bin SIFTDescriptor11(
  .iclk(iclk),
  .ireset(ireset),
  .igradient0(w_gradient_hold[119][17:0]),
  .igradient1(w_gradient_hold[118][17:0]),
  .igradient2(w_gradient_hold[117][17:0]),
  .igradient3(w_gradient_hold[116][17:0]),
  .igradient4(w_gradient_hold[103][17:0]),
  .igradient5(w_gradient_hold[102][17:0]),
  .igradient6(w_gradient_hold[101][17:0]),
  .igradient7(w_gradient_hold[100][17:0]),
  .igradient8(w_gradient_hold[87][17:0]),
  .igradient9(w_gradient_hold[86][17:0]),
  .igradient10(w_gradient_hold[85][17:0]),
  .igradient11(w_gradient_hold[84][17:0]),
  .igradient12(w_gradient_hold[71][17:0]),
  .igradient13(w_gradient_hold[70][17:0]),
  .igradient14(w_gradient_hold[69][17:0]),
  .igradient15(w_gradient_hold[68][17:0]),
  .obin_value0(w_descriptor[80]),
  .obin_value1(w_descriptor[81]),
  .obin_value2(w_descriptor[82]),
  .obin_value3(w_descriptor[83]),
  .obin_value4(w_descriptor[84]),
  .obin_value5(w_descriptor[85]),
  .obin_value6(w_descriptor[86]),
  .obin_value7(w_descriptor[87])
);  

Statistics_8Bin SIFTDescriptor12(
  .iclk(iclk),
  .ireset(ireset),
  .igradient0(w_gradient_hold[115][17:0]),
  .igradient1(w_gradient_hold[114][17:0]),
  .igradient2(w_gradient_hold[113][17:0]),
  .igradient3(w_gradient_hold[112][17:0]),
  .igradient4(w_gradient_hold[99][17:0]),
  .igradient5(w_gradient_hold[98][17:0]),
  .igradient6(w_gradient_hold[97][17:0]),
  .igradient7(w_gradient_hold[96][17:0]),
  .igradient8(w_gradient_hold[83][17:0]),
  .igradient9(w_gradient_hold[82][17:0]),
  .igradient10(w_gradient_hold[81][17:0]),
  .igradient11(w_gradient_hold[80][17:0]),
  .igradient12(w_gradient_hold[67][17:0]),
  .igradient13(w_gradient_hold[66][17:0]),
  .igradient14(w_gradient_hold[65][17:0]),
  .igradient15(w_gradient_hold[64][17:0]),
  .obin_value0(w_descriptor[88]),
  .obin_value1(w_descriptor[89]),
  .obin_value2(w_descriptor[90]),
  .obin_value3(w_descriptor[91]),
  .obin_value4(w_descriptor[92]),
  .obin_value5(w_descriptor[93]),
  .obin_value6(w_descriptor[94]),
  .obin_value7(w_descriptor[95])
);  

Statistics_8Bin SIFTDescriptor13(
  .iclk(iclk),
  .ireset(ireset),
  .igradient0(w_gradient_hold[63][17:0]),
  .igradient1(w_gradient_hold[62][17:0]),
  .igradient2(w_gradient_hold[61][17:0]),
  .igradient3(w_gradient_hold[60][17:0]),
  .igradient4(w_gradient_hold[47][17:0]),
  .igradient5(w_gradient_hold[46][17:0]),
  .igradient6(w_gradient_hold[45][17:0]),
  .igradient7(w_gradient_hold[44][17:0]),
  .igradient8(w_gradient_hold[31][17:0]),
  .igradient9(w_gradient_hold[30][17:0]),
  .igradient10(w_gradient_hold[29][17:0]),
  .igradient11(w_gradient_hold[28][17:0]),
  .igradient12(w_gradient_hold[15][17:0]),
  .igradient13(w_gradient_hold[14][17:0]),
  .igradient14(w_gradient_hold[13][17:0]),
  .igradient15(w_gradient_hold[12][17:0]),
  .obin_value0(w_descriptor[96]),
  .obin_value1(w_descriptor[97]),
  .obin_value2(w_descriptor[98]),
  .obin_value3(w_descriptor[99]),
  .obin_value4(w_descriptor[100]),
  .obin_value5(w_descriptor[101]),
  .obin_value6(w_descriptor[102]),
  .obin_value7(w_descriptor[103])
);  

Statistics_8Bin SIFTDescriptor14(
  .iclk(iclk),
  .ireset(ireset),
  .igradient0(w_gradient_hold[59][17:0]),
  .igradient1(w_gradient_hold[58][17:0]),
  .igradient2(w_gradient_hold[57][17:0]),
  .igradient3(w_gradient_hold[56][17:0]),
  .igradient4(w_gradient_hold[43][17:0]),
  .igradient5(w_gradient_hold[42][17:0]),
  .igradient6(w_gradient_hold[41][17:0]),
  .igradient7(w_gradient_hold[40][17:0]),
  .igradient8(w_gradient_hold[27][17:0]),
  .igradient9(w_gradient_hold[26][17:0]),
  .igradient10(w_gradient_hold[25][17:0]),
  .igradient11(w_gradient_hold[24][17:0]),
  .igradient12(w_gradient_hold[11][17:0]),
  .igradient13(w_gradient_hold[10][17:0]),
  .igradient14(w_gradient_hold[9][17:0]),
  .igradient15(w_gradient_hold[8][17:0]),
  .obin_value0(w_descriptor[104]),
  .obin_value1(w_descriptor[105]),
  .obin_value2(w_descriptor[106]),
  .obin_value3(w_descriptor[107]),
  .obin_value4(w_descriptor[108]),
  .obin_value5(w_descriptor[109]),
  .obin_value6(w_descriptor[110]),
  .obin_value7(w_descriptor[111])
);  

Statistics_8Bin SIFTDescriptor15(
  .iclk(iclk),
  .ireset(ireset),
  .igradient0(w_gradient_hold[55][17:0]),
  .igradient1(w_gradient_hold[54][17:0]),
  .igradient2(w_gradient_hold[53][17:0]),
  .igradient3(w_gradient_hold[52][17:0]),
  .igradient4(w_gradient_hold[39][17:0]),
  .igradient5(w_gradient_hold[38][17:0]),
  .igradient6(w_gradient_hold[37][17:0]),
  .igradient7(w_gradient_hold[36][17:0]),
  .igradient8(w_gradient_hold[23][17:0]),
  .igradient9(w_gradient_hold[22][17:0]),
  .igradient10(w_gradient_hold[21][17:0]),
  .igradient11(w_gradient_hold[20][17:0]),
  .igradient12(w_gradient_hold[7][17:0]),
  .igradient13(w_gradient_hold[6][17:0]),
  .igradient14(w_gradient_hold[5][17:0]),
  .igradient15(w_gradient_hold[4][17:0]),
  .obin_value0(w_descriptor[112]),
  .obin_value1(w_descriptor[113]),
  .obin_value2(w_descriptor[114]),
  .obin_value3(w_descriptor[115]),
  .obin_value4(w_descriptor[116]),
  .obin_value5(w_descriptor[117]),
  .obin_value6(w_descriptor[118]),
  .obin_value7(w_descriptor[119])
);  

Statistics_8Bin SIFTDescriptor16(
  .iclk(iclk),
  .ireset(ireset),
  .igradient0(w_gradient_hold[51][17:0]),
  .igradient1(w_gradient_hold[50][17:0]),
  .igradient2(w_gradient_hold[49][17:0]),
  .igradient3(w_gradient_hold[48][17:0]),
  .igradient4(w_gradient_hold[35][17:0]),
  .igradient5(w_gradient_hold[34][17:0]),
  .igradient6(w_gradient_hold[33][17:0]),
  .igradient7(w_gradient_hold[32][17:0]),
  .igradient8(w_gradient_hold[19][17:0]),
  .igradient9(w_gradient_hold[18][17:0]),
  .igradient10(w_gradient_hold[17][17:0]),
  .igradient11(w_gradient_hold[16][17:0]),
  .igradient12(w_gradient_hold[3][17:0]),
  .igradient13(w_gradient_hold[2][17:0]),
  .igradient14(w_gradient_hold[1][17:0]),
  .igradient15(w_gradient_hold[0][17:0]),
  .obin_value0(w_descriptor[120]),
  .obin_value1(w_descriptor[121]),
  .obin_value2(w_descriptor[122]),
  .obin_value3(w_descriptor[123]),
  .obin_value4(w_descriptor[124]),
  .obin_value5(w_descriptor[125]),
  .obin_value6(w_descriptor[126]),
  .obin_value7(w_descriptor[127])
);  

/////////////////////////////////////////////////////////////////////////////////
//I will detect the real clock of this moment in the future

reg descriptor_hold[2:0];

always@(posedge iclk or negedge ireset) begin
  if (!ireset) begin
    descriptor_hold[0] <= 0;
    descriptor_hold[1] <= 0;
    descriptor_hold[2] <= 0;
  end
  else begin  
    descriptor_hold[0] <= w_gradient_hold[119][18];
    descriptor_hold[1] <= descriptor_hold[0];
    descriptor_hold[2] <= descriptor_hold[1];
  end
end  
/////////////////////////////////////////////////////////////////////////////////

wire   [SIFTDescriptor_output_bits-1:0]    w_all_descriptor;

genvar k;
generate
  for (k = 0; k < SIFTDescriptor_output_size; k = k + 1) begin :encode_descriptor_output
    assign w_all_descriptor[Descriptor_bits * (k+1) - 1 : Descriptor_bits * k] = w_descriptor[k] ; 
  end
endgenerate

/////////////////////////////////////////////////////////////////////////////////
//normalize

wire  [19:0]      w_descroptor_sum;
wire  [1279:0]    w_normalize_all_descriptor;
wire  [9:0]       w_normalize_descriptor [127:0];

Normalization SIFTDescriptor17(
  .iclk(iclk),
  .ireset(ireset),
  .idval(descriptor_hold[2]),
  .idescriptor(w_all_descriptor),
  .odval(odval),
  .odescriptor(w_normalize_all_descriptor),
  .osum(w_descroptor_sum)  
);

assign odescriptor = w_normalize_all_descriptor;

//SIFTDescriptor_test t1(
//  .iclk(iclk),
//  .ireset(ireset),
//  .idata(w_normalize_all_descriptor),
//  .odata(odescriptor)
//);


genvar h;
generate
  for (h = 0; h < SIFTDescriptor_output_size; h = h + 1) begin : idata_encode
    assign w_normalize_descriptor[h] = w_normalize_all_descriptor[10 * (h+1) - 1 : 10 * h];  
  end
endgenerate

reg [31:0] r_odval_counter;

always@(posedge iclk or negedge ireset) begin
  if (!ireset) begin
    r_odval_counter <= 0;
  end
  else begin
    if (odval) begin
      r_odval_counter <= r_odval_counter + 1;
    end
    else begin
      r_odval_counter <= r_odval_counter;
    end
  end
end

/////////////////////////////////////////////////////////////////////////////////

endmodule 

