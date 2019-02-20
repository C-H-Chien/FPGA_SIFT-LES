module Compare (
	input 				iclk,
	input 				irst,
	input					ienable,
	input					iouputsignal,
	input   	[16:0] i_diff,
	input				[9:0] indx_s,
	input 			[10:0] fnum_scene,
	output 				[9:0] o_fnum,
	output				o_valid_sig,
	output				match_finish
);

reg [16:0]  comp, comp_sec; 
reg [9:0]  feature_num, o_f_idx;
reg			ovalid;

//register for a counter
reg [9:0] fnum_count;

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
  
	else if (ienable) begin
		if(complete_en) begin
			if((comp_sec > i_diff) && !iouputsignal) begin
				if(comp > i_diff) begin
					if (((comp>>1) > i_diff) && (fnum_count == fnum_scene)) begin
						o_f_idx <= indx_s;
						ovalid <= 1;
					end
					else begin
						comp <= i_diff;
						comp_sec <= comp;
						feature_num <= indx_s;
						complete_sig <= 1'b1;
						fnum_count <= fnum_count + 1;
					end
				end
				else begin
					comp_sec <= i_diff;
					complete_sig <= 1'b1;
					fnum_count <= fnum_count + 1;
				end
			end
			else begin
				complete_sig <= 1'b1;
				fnum_count <= fnum_count + 1;
			end
		end
		
		if(fnum_count == fnum_scene) begin
			if( (comp_sec>>1) > comp ) begin	//feature is matched
				ovalid <= 1;
				complete_sig <= 1'b1;
				o_f_idx <= feature_num;
				comp <= 17'hFFFF;
				comp_sec <= 17'hFFFF;
				fnum_count <= 0;
			end
			else begin		//feature is NOT matched
				ovalid <= 0;
				complete_sig <= 1'b1;
				comp <= 17'hFFFF;
				comp_sec <= 17'hFFFF;
				fnum_count <= 0;
			end
		end
		
		//verify whether it is able to match another feature
		if (!complete_sig && !iouputsignal) begin
			complete_en <= 1'b1;
		end
		else if (complete_sig) begin
			complete_en <= 1'b0;
			complete_sig <= 1'b0;
		end
		else begin
			complete_sig <= 1'b0;
		end
	end
	else if (!ienable && irst) begin
		ovalid <= 0;
		complete_sig <= 1'b0;
	end
end

assign o_valid_sig = ovalid;
//assign o_fnum = (ovalid)?(o_f_idx):0;
assign o_fnum = o_f_idx;
assign match_finish = complete_sig;

endmodule
