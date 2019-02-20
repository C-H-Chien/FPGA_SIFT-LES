/*
This module match features between a base feature and all other features in the image
*/

module Matching_main (
	input 				 iclk,
	input 				 irst,
	input				 ibasechange, 
	input				 imatch_en,
	input		[1279:0] idescriptor,
	input		[9:0]	 indx_s,
	input		[10:0] scene_fnum,
	output		[31:0] 	 o_num,
	output				 o_sig1,
	output				 finish_sig
);

wire [1279:0] SRA;
wire [16:0] Matc_FIFO;
//wire [9:0] feature_number;
wire matching_output_signal;
wire [9:0] ifeaNum;

reg [9:0] counte;
reg maten;

//wires for data valid signals
//wire o_valid;
//wire finish_match;

//wires for the DCFIFO, the module "Pre_Compare_FIFO"
/* wire rdemptyFIFOCom, wrfullFIFOCom, rdreqFIFOCom;
wire pre_compare_fifo_rd;
wire w_pre_compare_fifo_rd; */

//SRAM_1 t2(
//	.data(idescriptor),
//	.addr(0),
//	.we(ibasechange), 
//	.clk(iclk),
//	.q(SRA)
//);

SRAM_f t2(
	.address(0),
	.clock(iclk),
	.data(idescriptor),
	.wren(ibasechange),
	.q(SRA)
);

matching_128 t3(
	.iclk(iclk),						// clock signal
	.ireset(irst),						// reset signal
	.ienable(maten),					// as long as ibasechange is NOT triggered, maten is 1
	.i_base_des(SRA), 					// template feature from book.pgm
	.i_sample_des(idescriptor), 		// features from scene.pgm
	.o_num(Matc_FIFO), 					// value of difference of feature descriptors
	.o_signal(matching_output_signal) 	// data valid
);

//after all featuers of scene.pgm are matched with a template feature in book.pgm
//the Compare module compares to find the minimum of the difference of descriptors
//if no feature is matched, o_valid is 0
//Compare t5(
//	.iclk(iclk),
//	.irst(irst),
//	.ienable(matching_output_signal),
//	.ibasechange(ibasechange),
//	.Matc_FIFO(Matc_FIFO), 		//the difference of fueature descriptors
//	.indx_s(indx_s),
//	.scene_fnum(scene_fnum),
//	.o_fnum(feature_number),	//the index of matched feature
//	.o_valid_sig(o_valid),		//data valid
//	.match_finish(finish_match)
//);

//===================//
//Compare module
//===================//
reg [16:0]  comp, comp_sec;
reg [9:0]  feature_num, o_f_idx;
reg			ovalid;

//register for a counter
reg [10:0] fnum_count;

//register for complete signal
reg complete_sig;
reg complete_en; 

//test in modelsim
always @ (posedge iclk or negedge irst) begin
	if (!irst) begin
		comp <= 17'hFFFF;
		comp_sec <= 17'hFFFF;
		feature_num <= 0;
		ovalid <= 0;
		complete_sig <= 1'b0;
		complete_en <= 1'b1;
		fnum_count <= 0;
	end
	else if (matching_output_signal) begin
		if(complete_en) begin
			if((comp_sec > Matc_FIFO) && !ibasechange) begin
				if(comp > Matc_FIFO) begin
					if (((comp>>1) > Matc_FIFO) && (fnum_count == scene_fnum)) begin
						o_f_idx <= indx_s;
						ovalid <= 1;
					end
					else begin
						comp <= Matc_FIFO;
						comp_sec <= comp;
						feature_num <= indx_s;
						complete_sig <= 1'b1;
						fnum_count <= fnum_count + 1;
					end
				end
				else begin
					comp_sec <= Matc_FIFO;
					complete_sig <= 1'b1;
					fnum_count <= fnum_count + 1;
				end
			end
			else begin
				//complete_sig <= 1'b1;
				fnum_count <= fnum_count + 1;
			end
		end
		
//		if(fnum_count == scene_fnum) begin
//			if( (comp_sec>>1) > comp ) begin	//feature is matched
//				ovalid <= 1;
//				complete_sig <= 1'b1;
//				o_f_idx <= feature_num;
//				comp <= 17'hFFFF;
//				comp_sec <= 17'hFFFF;
//				fnum_count <= 0;
//			end
//			else begin		//feature is NOT matched
//				ovalid <= 0;
//				complete_sig <= 1'b1;
//				comp <= 17'hFFFF;
//				comp_sec <= 17'hFFFF;
//				fnum_count <= 0;
//			end
//		end
//		
//		//verify whether it is able to match another feature
//		if (!complete_sig && !ibasechange) begin
//			complete_en <= 1'b1;
//		end
//		else if (complete_sig) begin
//			complete_en <= 1'b0;
//			complete_sig <= 1'b0;
//		end
//		else begin
//			complete_sig <= 1'b0;
//		end
//	end
//	else if (!matching_output_signal && irst) begin
//		ovalid <= 0;
//		complete_sig <= 1'b0;
	end
end

//==================//

assign ifeaNum = counte; //index of the input feature descriptor derived by a counter
assign o_num = {22'h0,o_f_idx};

//Delay 1 clock for matching
//used in modelsim
always@(posedge iclk or negedge irst) begin
	if (!irst) begin
		counte <= 0;
		maten <= 0;
	end
	else begin
		if(imatch_en)begin
			counte <= counte + 1;
			if(ibasechange) begin
				maten <= 0;
				counte <= 0;
			end
			else begin
				maten <= 1;
			end
		end
		else begin
			counte <= 0;
			maten <= 0;
		end
	end
end

assign o_sig1 = ovalid;
assign finish_sig = complete_sig;
//assign finish_sig = finish_match;

endmodule
