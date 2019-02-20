module matching_128 (
	input 				iclk,
	input 				ireset,
	input					ienable,
	input   [1279:0] 	i_base_des, 
	input   [1279:0] 	i_sample_des,
	output  [16:0] 	o_num,
	output				o_signal
);

reg [9:0] diff_0 [0:127];
reg [10:0] diff_1 [0:63];
reg [11:0] diff_2 [0:31];
reg [12:0] diff_3 [0:15];
reg [13:0] diff_4 [0:7];
reg [14:0] diff_5 [0:3];
reg [15:0] diff_6 [0:1];
reg [16:0] o_value;
reg [7:0] counter;
reg	o_sig;
integer i;

//register for clock counter
reg [3:0] clk_count;

//test in modelsim
always@(posedge iclk or negedge ireset) begin
	if (!ireset) begin
		clk_count <= 4'b0000;
		
		for(i=0;i<128;i=i+1)
			diff_0[i] <= 0;
	  
		for(i=0;i<64;i=i+1)
			diff_1[i] <= 0;
			
		for(i=0;i<32;i=i+1)
			diff_2[i] <= 0;

		for(i=0;i<16;i=i+1)
			diff_3[i] <= 0;

		for(i=0;i<8;i=i+1)
			diff_4[i] <= 0;

		for(i=0;i<4;i=i+1)
			diff_5[i] <= 0;

		for(i=0;i<2;i=i+1)
			diff_6[i] <= 0;

		o_value <= 17'hFFFF;
		o_sig <= 0;
	end
	else if (ienable) begin
		
	  //Descriptors subtraction
		for(i=0;i<128;i=i+1) begin
			// [i*10+:10] means [9:0], [19:10], ..., [1279:1270]
			diff_0[i] <= (i_base_des[i*10+:10] > i_sample_des[i*10+:10]) ? (i_base_des[i*10+:10] - i_sample_des[i*10+:10]) : (i_sample_des[i*10+:10] - i_base_des[i*10+:10]);
		end
	  
	  //Reduction Sum
		for(i=0;i<64;i=i+1) begin
			diff_1[i] <= (diff_0[i*2+1] + diff_0[i*2]);
		end
		for(i=0;i<32;i=i+1) begin
			diff_2[i] <= (diff_1[i*2+1] + diff_1[i*2]);
		end
		for(i=0;i<16;i=i+1) begin
			diff_3[i] <= (diff_2[i*2+1] + diff_2[i*2]);
		end
		for(i=0;i<8;i=i+1) begin
			diff_4[i] <= (diff_3[i*2+1] + diff_3[i*2]);
		end
		for(i=0;i<4;i=i+1) begin
			diff_5[i] <= (diff_4[i*2+1] + diff_4[i*2]);
		end
		for(i=0;i<2;i=i+1) begin
			diff_6[i] <= (diff_5[i*2+1] + diff_5[i*2]);
		end
		
		//After computational delay, output the result (delay 8 clocks)
		//wait for 10 clock
		if (clk_count < 10) begin
			clk_count <= clk_count + 1;
			o_sig = 0;
			//o_value <= 0;
		end
		else begin
			clk_count <= 4'b0000;
			o_sig <= 1;
			o_value <= (diff_6[0] + diff_6[1]); //diff_7
			//o_value <= diff_1[0]; //diff_7
		end
		
		/* if(counter[0]==1'b1) begin
			o_value <= diff_7;
			o_sig <= 1;	
		end
		else begin
			o_sig = 0;
		end */
  end
end

//clock delay (delay 8 clocks)
always@(posedge iclk or negedge ireset) begin
	if (!ireset) begin
		counter <= 8'h80;
	end
	else if (ienable && !o_sig) begin
	  counter = (counter >> 1);
	  /* if(ienable == 1'b1)
	    counter <= 8'h80; */
	end
	else if (!ienable && ireset) begin
		counter <= 8'h80;
	end
end

assign o_num = o_value;
assign o_signal = o_sig;

endmodule
