// megafunction wizard: %Shift register (RAM-based)%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: ALTSHIFT_TAPS 

// ============================================================
// File Name: Descriptor_Buffer.v
// Megafunction Name(s):
// 			ALTSHIFT_TAPS
//
// Simulation Library Files(s):
// 			altera_mf
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 13.0.1 Build 232 06/12/2013 SP 1 SJ Full Version
// ************************************************************


//Copyright (C) 1991-2013 Altera Corporation
//Your use of Altera Corporation's design tools, logic functions 
//and other software and tools, and its AMPP partner logic 
//functions, and any output files from any of the foregoing 
//(including device programming or simulation files), and any 
//associated documentation or information are expressly subject 
//to the terms and conditions of the Altera Program License 
//Subscription Agreement, Altera MegaCore Function License 
//Agreement, or other applicable license agreement, including, 
//without limitation, that your use is for the sole purpose of 
//programming logic devices manufactured by Altera and sold by 
//Altera or its authorized distributors.  Please refer to the 
//applicable agreement for further details.


// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module Descriptor_Buffer (
	aclr,
	clken,
	clock,
	shiftin,
	shiftout,
	taps0x,
	taps10x,
	taps11x,
	taps12x,
	taps13x,
	taps14x,
	taps15x,
	taps1x,
	taps2x,
	taps3x,
	taps4x,
	taps5x,
	taps6x,
	taps7x,
	taps8x,
	taps9x);

	input	  aclr;
	input	  clken;
	input	  clock;
	input	[18:0]  shiftin;
	output	[18:0]  shiftout;
	output	[18:0]  taps0x;
	output	[18:0]  taps10x;
	output	[18:0]  taps11x;
	output	[18:0]  taps12x;
	output	[18:0]  taps13x;
	output	[18:0]  taps14x;
	output	[18:0]  taps15x;
	output	[18:0]  taps1x;
	output	[18:0]  taps2x;
	output	[18:0]  taps3x;
	output	[18:0]  taps4x;
	output	[18:0]  taps5x;
	output	[18:0]  taps6x;
	output	[18:0]  taps7x;
	output	[18:0]  taps8x;
	output	[18:0]  taps9x;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri1	  aclr;
	tri1	  clken;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire [303:0] sub_wire0;
	wire [18:0] sub_wire9;
	wire [113:95] sub_wire31 = sub_wire0[113:95];
	wire [284:266] sub_wire30 = sub_wire0[284:266];
	wire [284:266] sub_wire29 = sub_wire30[284:266];
	wire [94:76] sub_wire28 = sub_wire0[94:76];
	wire [94:76] sub_wire27 = sub_wire28[94:76];
	wire [265:247] sub_wire26 = sub_wire0[265:247];
	wire [265:247] sub_wire25 = sub_wire26[265:247];
	wire [151:133] sub_wire24 = sub_wire0[151:133];
	wire [151:133] sub_wire23 = sub_wire24[151:133];
	wire [75:57] sub_wire22 = sub_wire0[75:57];
	wire [75:57] sub_wire21 = sub_wire22[75:57];
	wire [246:228] sub_wire20 = sub_wire0[246:228];
	wire [246:228] sub_wire19 = sub_wire20[246:228];
	wire [132:114] sub_wire18 = sub_wire0[132:114];
	wire [132:114] sub_wire17 = sub_wire18[132:114];
	wire [56:38] sub_wire16 = sub_wire0[56:38];
	wire [56:38] sub_wire15 = sub_wire16[56:38];
	wire [303:285] sub_wire14 = sub_wire0[303:285];
	wire [303:285] sub_wire13 = sub_wire14[303:285];
	wire [227:209] sub_wire12 = sub_wire0[227:209];
	wire [227:209] sub_wire11 = sub_wire12[227:209];
	wire [189:171] sub_wire10 = sub_wire0[189:171];
	wire [189:171] sub_wire8 = sub_wire10[189:171];
	wire [37:19] sub_wire7 = sub_wire0[37:19];
	wire [37:19] sub_wire6 = sub_wire7[37:19];
	wire [208:190] sub_wire5 = sub_wire0[208:190];
	wire [208:190] sub_wire4 = sub_wire5[208:190];
	wire [170:152] sub_wire3 = sub_wire0[170:152];
	wire [170:152] sub_wire2 = sub_wire3[170:152];
	wire [18:0] sub_wire1 = sub_wire0[18:0];
	wire [18:0] taps0x = sub_wire1[18:0];
	wire [18:0] taps8x = sub_wire2[170:152];
	wire [18:0] taps10x = sub_wire4[208:190];
	wire [18:0] taps1x = sub_wire6[37:19];
	wire [18:0] taps9x = sub_wire8[189:171];
	wire [18:0] shiftout = sub_wire9[18:0];
	wire [18:0] taps11x = sub_wire11[227:209];
	wire [18:0] taps15x = sub_wire13[303:285];
	wire [18:0] taps2x = sub_wire15[56:38];
	wire [18:0] taps6x = sub_wire17[132:114];
	wire [18:0] taps12x = sub_wire19[246:228];
	wire [18:0] taps3x = sub_wire21[75:57];
	wire [18:0] taps7x = sub_wire23[151:133];
	wire [18:0] taps13x = sub_wire25[265:247];
	wire [18:0] taps4x = sub_wire27[94:76];
	wire [18:0] taps14x = sub_wire29[284:266];
	wire [18:0] taps5x = sub_wire31[113:95];

	altshift_taps	ALTSHIFT_TAPS_component (
				.aclr (aclr),
				.clock (clock),
				.clken (clken),
				.shiftin (shiftin),
				.taps (sub_wire0),
				.shiftout (sub_wire9));
	defparam
		ALTSHIFT_TAPS_component.intended_device_family = "Cyclone II",
		ALTSHIFT_TAPS_component.lpm_hint = "RAM_BLOCK_TYPE=M4K",
		ALTSHIFT_TAPS_component.lpm_type = "altshift_taps",
		ALTSHIFT_TAPS_component.number_of_taps = 16,
		ALTSHIFT_TAPS_component.tap_distance = 800,
		ALTSHIFT_TAPS_component.width = 19;


endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: ACLR NUMERIC "1"
// Retrieval info: PRIVATE: CLKEN NUMERIC "1"
// Retrieval info: PRIVATE: GROUP_TAPS NUMERIC "1"
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone II"
// Retrieval info: PRIVATE: NUMBER_OF_TAPS NUMERIC "16"
// Retrieval info: PRIVATE: RAM_BLOCK_TYPE NUMERIC "1"
// Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
// Retrieval info: PRIVATE: TAP_DISTANCE NUMERIC "18"
// Retrieval info: PRIVATE: WIDTH NUMERIC "19"
// Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all
// Retrieval info: CONSTANT: INTENDED_DEVICE_FAMILY STRING "Cyclone II"
// Retrieval info: CONSTANT: LPM_HINT STRING "RAM_BLOCK_TYPE=M4K"
// Retrieval info: CONSTANT: LPM_TYPE STRING "altshift_taps"
// Retrieval info: CONSTANT: NUMBER_OF_TAPS NUMERIC "16"
// Retrieval info: CONSTANT: TAP_DISTANCE NUMERIC "18"
// Retrieval info: CONSTANT: WIDTH NUMERIC "19"
// Retrieval info: USED_PORT: aclr 0 0 0 0 INPUT VCC "aclr"
// Retrieval info: USED_PORT: clken 0 0 0 0 INPUT VCC "clken"
// Retrieval info: USED_PORT: clock 0 0 0 0 INPUT NODEFVAL "clock"
// Retrieval info: USED_PORT: shiftin 0 0 19 0 INPUT NODEFVAL "shiftin[18..0]"
// Retrieval info: USED_PORT: shiftout 0 0 19 0 OUTPUT NODEFVAL "shiftout[18..0]"
// Retrieval info: USED_PORT: taps0x 0 0 19 0 OUTPUT NODEFVAL "taps0x[18..0]"
// Retrieval info: USED_PORT: taps10x 0 0 19 0 OUTPUT NODEFVAL "taps10x[18..0]"
// Retrieval info: USED_PORT: taps11x 0 0 19 0 OUTPUT NODEFVAL "taps11x[18..0]"
// Retrieval info: USED_PORT: taps12x 0 0 19 0 OUTPUT NODEFVAL "taps12x[18..0]"
// Retrieval info: USED_PORT: taps13x 0 0 19 0 OUTPUT NODEFVAL "taps13x[18..0]"
// Retrieval info: USED_PORT: taps14x 0 0 19 0 OUTPUT NODEFVAL "taps14x[18..0]"
// Retrieval info: USED_PORT: taps15x 0 0 19 0 OUTPUT NODEFVAL "taps15x[18..0]"
// Retrieval info: USED_PORT: taps1x 0 0 19 0 OUTPUT NODEFVAL "taps1x[18..0]"
// Retrieval info: USED_PORT: taps2x 0 0 19 0 OUTPUT NODEFVAL "taps2x[18..0]"
// Retrieval info: USED_PORT: taps3x 0 0 19 0 OUTPUT NODEFVAL "taps3x[18..0]"
// Retrieval info: USED_PORT: taps4x 0 0 19 0 OUTPUT NODEFVAL "taps4x[18..0]"
// Retrieval info: USED_PORT: taps5x 0 0 19 0 OUTPUT NODEFVAL "taps5x[18..0]"
// Retrieval info: USED_PORT: taps6x 0 0 19 0 OUTPUT NODEFVAL "taps6x[18..0]"
// Retrieval info: USED_PORT: taps7x 0 0 19 0 OUTPUT NODEFVAL "taps7x[18..0]"
// Retrieval info: USED_PORT: taps8x 0 0 19 0 OUTPUT NODEFVAL "taps8x[18..0]"
// Retrieval info: USED_PORT: taps9x 0 0 19 0 OUTPUT NODEFVAL "taps9x[18..0]"
// Retrieval info: CONNECT: @aclr 0 0 0 0 aclr 0 0 0 0
// Retrieval info: CONNECT: @clken 0 0 0 0 clken 0 0 0 0
// Retrieval info: CONNECT: @clock 0 0 0 0 clock 0 0 0 0
// Retrieval info: CONNECT: @shiftin 0 0 19 0 shiftin 0 0 19 0
// Retrieval info: CONNECT: shiftout 0 0 19 0 @shiftout 0 0 19 0
// Retrieval info: CONNECT: taps0x 0 0 19 0 @taps 0 0 19 0
// Retrieval info: CONNECT: taps10x 0 0 19 0 @taps 0 0 19 190
// Retrieval info: CONNECT: taps11x 0 0 19 0 @taps 0 0 19 209
// Retrieval info: CONNECT: taps12x 0 0 19 0 @taps 0 0 19 228
// Retrieval info: CONNECT: taps13x 0 0 19 0 @taps 0 0 19 247
// Retrieval info: CONNECT: taps14x 0 0 19 0 @taps 0 0 19 266
// Retrieval info: CONNECT: taps15x 0 0 19 0 @taps 0 0 19 285
// Retrieval info: CONNECT: taps1x 0 0 19 0 @taps 0 0 19 19
// Retrieval info: CONNECT: taps2x 0 0 19 0 @taps 0 0 19 38
// Retrieval info: CONNECT: taps3x 0 0 19 0 @taps 0 0 19 57
// Retrieval info: CONNECT: taps4x 0 0 19 0 @taps 0 0 19 76
// Retrieval info: CONNECT: taps5x 0 0 19 0 @taps 0 0 19 95
// Retrieval info: CONNECT: taps6x 0 0 19 0 @taps 0 0 19 114
// Retrieval info: CONNECT: taps7x 0 0 19 0 @taps 0 0 19 133
// Retrieval info: CONNECT: taps8x 0 0 19 0 @taps 0 0 19 152
// Retrieval info: CONNECT: taps9x 0 0 19 0 @taps 0 0 19 171
// Retrieval info: GEN_FILE: TYPE_NORMAL Descriptor_Buffer.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL Descriptor_Buffer.inc FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL Descriptor_Buffer.cmp FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL Descriptor_Buffer.bsf FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL Descriptor_Buffer_inst.v FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL Descriptor_Buffer_bb.v TRUE
// Retrieval info: LIB_FILE: altera_mf
