/*
This module controls the matching modules
*/

module Matching_Controller (
	input 				 iclk,
	input 				 irst,
	input				 i_enable,
	input				 i_BC_en,	//base change enable signal
	input		[39:0] i_Des,
	input				 i_des_sw,
	input		[9:0]	 indx_s,
	input 	[10:0] scene_fnum_Bit,
	input	unsigned	[6:0]	 i_des_seq_idx,
	output		[31:0] 	 o_fmatch_idx,
	output				 o_Dval,
	output				 o_finish
);

//registers and wires for the module "Matching_main"
reg en_BaseChange, en_match;
wire [31:0] match_idx;
wire next_scene_des_en;

//registers and wires for the output data valid signal
reg o_valid;
wire Dval_MatchingMain;
reg regDval_MatchingMain;

//registers for the inputs of the module "Matching_main"
reg [1279:0] reg_des, des;
reg [2:0] des_assign_delay;

//register for the state
reg [2:0] state;

Matching_main FeaturesMatch(
	.iclk(iclk),
	.irst(irst),
	.ibasechange(en_BaseChange), 
	.imatch_en(en_match),
	.idescriptor(des),
	.indx_s(indx_s),
	.scene_fnum(scene_fnum_Bit),
	.o_num(match_idx),
	.o_sig1(Dval_MatchingMain),
	.finish_sig(next_scene_des_en)
);

always @ (posedge iclk or negedge irst) begin
	if (!irst) begin
		state <= 3'b000;
		
		//enable signals
		en_BaseChange <= 1'b0;
		en_match <= 1'b0;
		
		//output Dval signals
		regDval_MatchingMain <= 1'b0;
		o_valid <= 1'b0;
		
		//register of the des for matching
		des = 0;
		
		//register for a delay
		des_assign_delay = 0;
	end
	else if (i_enable) begin
		case (state)
			3'b000 : begin
						//trigger the matching module
						if (!i_des_sw) begin
							//des <= i_Des;
							case (i_des_seq_idx)
								1 : reg_des[39:0] <= i_Des;
								2 : reg_des[79:40] <= i_Des;
								3 : reg_des[119:80] <= i_Des;
								4 : reg_des[159:120] <= i_Des;
								5 : reg_des[199:160] <= i_Des;
								6 : reg_des[239:200] <= i_Des;
								7 : reg_des[279:240] <= i_Des;
								8 : reg_des[319:280] <= i_Des;
								9 : reg_des[359:320] <= i_Des;
								10 : reg_des[399:360] <= i_Des;
								11 : reg_des[439:400] <= i_Des;
								12 : reg_des[479:440] <= i_Des;
								13 : reg_des[519:480] <= i_Des;
								14 : reg_des[559:520] <= i_Des;
								15 : reg_des[599:560] <= i_Des;
								16 : reg_des[639:600] <= i_Des;
								17 : reg_des[679:640] <= i_Des;
								18 : reg_des[719:680] <= i_Des;
								19 : reg_des[759:720] <= i_Des;
								20 : reg_des[799:760] <= i_Des;
								21 : reg_des[839:800] <= i_Des;
								22 : reg_des[879:840] <= i_Des;
								23 : reg_des[919:880] <= i_Des;
								24 : reg_des[959:920] <= i_Des;
								25 : reg_des[999:960] <= i_Des;
								26 : reg_des[1039:1000] <= i_Des;
								27 : reg_des[1079:1040] <= i_Des;
								28 : reg_des[1119:1080] <= i_Des;
								29 : reg_des[1159:1120] <= i_Des;
								30 : reg_des[1199:1160] <= i_Des;
								31 : reg_des[1239:1200] <= i_Des;
								32 : reg_des[1279:1240] <= i_Des;	
							endcase

							if (i_des_seq_idx > 31) begin
								if (des_assign_delay < 1) begin
									des_assign_delay <= des_assign_delay + 1;
								end
								else begin
									des_assign_delay <= 0;
									state <= 3'b001;
									en_BaseChange <= 1'b1;
									en_match <= 1'b0;
									//des <= 0;
									des <= reg_des;
								end
							end
						end
					 end
			3'b001 : begin
						if(i_des_sw) begin
							case (i_des_seq_idx)
								1 : reg_des[39:0] <= i_Des;
								2 : reg_des[79:40] <= i_Des;
								3 : reg_des[119:80] <= i_Des;
								4 : reg_des[159:120] <= i_Des;
								5 : reg_des[199:160] <= i_Des;
								6 : reg_des[239:200] <= i_Des;
								7 : reg_des[279:240] <= i_Des;
								8 : reg_des[319:280] <= i_Des;
								9 : reg_des[359:320] <= i_Des;
								10 : reg_des[399:360] <= i_Des;
								11 : reg_des[439:400] <= i_Des;
								12 : reg_des[479:440] <= i_Des;
								13 : reg_des[519:480] <= i_Des;
								14 : reg_des[559:520] <= i_Des;
								15 : reg_des[599:560] <= i_Des;
								16 : reg_des[639:600] <= i_Des;
								17 : reg_des[679:640] <= i_Des;
								18 : reg_des[719:680] <= i_Des;
								19 : reg_des[759:720] <= i_Des;
								20 : reg_des[799:760] <= i_Des;
								21 : reg_des[839:800] <= i_Des;
								22 : reg_des[879:840] <= i_Des;
								23 : reg_des[919:880] <= i_Des;
								24 : reg_des[959:920] <= i_Des;
								25 : reg_des[999:960] <= i_Des;
								26 : reg_des[1039:1000] <= i_Des;
								27 : reg_des[1079:1040] <= i_Des;
								28 : reg_des[1119:1080] <= i_Des;
								29 : reg_des[1159:1120] <= i_Des;
								30 : reg_des[1199:1160] <= i_Des;
								31 : reg_des[1239:1200] <= i_Des;
								32 : reg_des[1279:1240] <= i_Des;
							endcase
								
							if (i_des_seq_idx > 31) begin
								if (des_assign_delay < 1) begin
									des_assign_delay <= des_assign_delay + 1;
								end
								else begin
									//turn off the basechange signal
									//and turn on the match signal to match features in book.pgm and scene.pgm
									en_BaseChange <= 1'b0;
									en_match <= 1'b1;
									state <= 3'b010;
									des <= reg_des;
									des_assign_delay <= 0;
								end	
							end
						end
					 end
			3'b010 : begin
						if (next_scene_des_en && !i_BC_en) begin
							en_match <= 1'b0;
							state <= 3'b011;
						end
						else begin
							en_match <= 1'b1;
						end
					 end
			3'b011 : begin
						if (i_BC_en) begin
							en_match <= 1'b0;
							state <= 3'b100;	// output the matching result
							en_BaseChange <= 1'b1;
						end
						else begin
							state <= 3'b001;
						end
					 end
			3'b100 : begin
						regDval_MatchingMain <= Dval_MatchingMain;
						//if the feature is matched
						if (regDval_MatchingMain) begin
							state <= 3'b000;
						end
						else begin
							state <= 3'b000;
						end
					 end
		endcase
	end
	else if (!i_enable && irst) begin
		state <= 3'b000;
		regDval_MatchingMain <= 1'b0;
		o_valid <= 1'b0;
	end
end

//Dval_MatchingMain is 1 if the feature is matched; otherwise it is NOT
assign o_Dval = Dval_MatchingMain;
assign o_fmatch_idx = match_idx;
assign o_finish = next_scene_des_en;

endmodule
