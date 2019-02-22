//`define ENABLE_PCIE

`default_nettype none


module de2i_150_golden_top(

							///////////CLOCK2/////////////
							CLOCK2_50,

							/////////CLOCK3/////////
							CLOCK3_50,

							/////////CLOCK/////////
							CLOCK_50,

							/////////DRAM/////////
							DRAM_ADDR,
							DRAM_BA,
							DRAM_CAS_N,
							DRAM_CKE,
							DRAM_CLK,
							DRAM_CS_N,
							DRAM_DQ,
							DRAM_DQM,
							DRAM_RAS_N,
							DRAM_WE_N,

							/////////EEP/////////
							EEP_I2C_SCLK,
							EEP_I2C_SDAT,

							/////////ENET/////////
							ENET_GTX_CLK,
							ENET_INT_N,
							ENET_LINK100,
							ENET_MDC,
							ENET_MDIO,
							ENET_RST_N,
							ENET_RX_CLK,
							ENET_RX_COL,
							ENET_RX_CRS,
							ENET_RX_DATA,
							ENET_RX_DV,
							ENET_RX_ER,
							ENET_TX_CLK,
							ENET_TX_DATA,
							ENET_TX_EN,
							ENET_TX_ER,

							/////////FAN/////////
							FAN_CTRL,

							/////////FL/////////
							FL_CE_N,
							FL_OE_N,
							FL_RY,
							FL_WE_N,
							FL_WP_N,
							FL_RESET_N,
							/////////FS/////////
							FS_DQ,
							FS_ADDR,
							/////////GPIO/////////
							GPIO,

							/////////G/////////
							G_SENSOR_INT1,
							G_SENSOR_SCLK,
							G_SENSOR_SDAT,

							/////////HEX/////////
							HEX0,
							HEX1,
							HEX2,
							HEX3,
							HEX4,
							HEX5,
							HEX6,
							HEX7,

							/////////HSMC/////////
							HSMC_CLKIN0,
							HSMC_CLKIN_N1,
							HSMC_CLKIN_N2,
							HSMC_CLKIN_P1,
							HSMC_CLKIN_P2,
							HSMC_CLKOUT0,
							HSMC_CLKOUT_N1,
							HSMC_CLKOUT_N2,
							HSMC_CLKOUT_P1,
							HSMC_CLKOUT_P2,
							HSMC_D,
							HSMC_I2C_SCLK,
							HSMC_I2C_SDAT,
							HSMC_RX_D_N,
							HSMC_RX_D_P,
							HSMC_TX_D_N,
							HSMC_TX_D_P,

							/////////I2C/////////
							I2C_SCLK,
							I2C_SDAT,

							/////////IRDA/////////
							IRDA_RXD,

							/////////KEY/////////
							KEY,

							/////////LCD/////////
							LCD_DATA,
							LCD_EN,
							LCD_ON,
							LCD_RS,
							LCD_RW,

							/////////LEDG/////////
							LEDG,

							/////////LEDR/////////
							LEDR,

							/////////PCIE/////////
`ifdef ENABLE_PCIE

							PCIE_PERST_N,
							PCIE_REFCLK_P,
							PCIE_RX_P,
							PCIE_TX_P,
							PCIE_WAKE_N,
`endif 
							/////////SD/////////
							SD_CLK,
							SD_CMD,
							SD_DAT,
							SD_WP_N,

							/////////SMA/////////
							SMA_CLKIN,
							SMA_CLKOUT,

							/////////SSRAM/////////
							SSRAM_ADSC_N,
							SSRAM_ADSP_N,
							SSRAM_ADV_N,
							SSRAM_BE,
							SSRAM_CLK,
							SSRAM_GW_N,
							SSRAM_OE_N,
							SSRAM_WE_N,
							SSRAM0_CE_N,
							SSRAM1_CE_N,							
							/////////SW/////////
							SW,

							/////////TD/////////
							TD_CLK27,
							TD_DATA,
							TD_HS,
							TD_RESET_N,
							TD_VS,

							/////////UART/////////
							UART_CTS,
							UART_RTS,
							UART_RXD,
							UART_TXD,

							/////////VGA/////////
							VGA_B,
							VGA_BLANK_N,
							VGA_CLK,
							VGA_G,
							VGA_HS,
							VGA_R,
							VGA_SYNC_N,
							VGA_VS,
);

//=======================================================
//  PORT declarations
//=======================================================

							///////////CLOCK2/////////////

input                                              CLOCK2_50;

///////// CLOCK3 /////////
input                                              CLOCK3_50;

///////// CLOCK /////////
input                                              CLOCK_50;

///////// DRAM /////////
output                        [12:0]               DRAM_ADDR;
output                        [1:0]                DRAM_BA;
output                                             DRAM_CAS_N;
output                                             DRAM_CKE;
output                                             DRAM_CLK;
output                                             DRAM_CS_N;
inout                         [31:0]               DRAM_DQ;
output                        [3:0]                DRAM_DQM;
output                                             DRAM_RAS_N;
output                                             DRAM_WE_N;

///////// EEP /////////
output                                             EEP_I2C_SCLK;
inout                                              EEP_I2C_SDAT;

///////// ENET /////////
output                                             ENET_GTX_CLK;
input                                              ENET_INT_N;
input                                              ENET_LINK100;
output                                             ENET_MDC;
inout                                              ENET_MDIO;
output                                             ENET_RST_N;
input                                              ENET_RX_CLK;
input                                              ENET_RX_COL;
input                                              ENET_RX_CRS;
input                         [3:0]                ENET_RX_DATA;
input                                              ENET_RX_DV;
input                                              ENET_RX_ER;
input                                              ENET_TX_CLK;
output                        [3:0]                ENET_TX_DATA;
output                                             ENET_TX_EN;
output                                             ENET_TX_ER;

///////// FAN /////////
inout                                              FAN_CTRL;

///////// FL /////////
output                                             FL_CE_N;
output                                             FL_OE_N;
input                                              FL_RY;
output                                             FL_WE_N;
output                                             FL_WP_N;
output                                             FL_RESET_N;
///////// FS /////////
inout                         [31:0]               FS_DQ;
output                        [26:0]               FS_ADDR;
///////// GPIO /////////
inout                         [35:0]               GPIO;

///////// G /////////
input                                              G_SENSOR_INT1;
output                                             G_SENSOR_SCLK;
inout                                              G_SENSOR_SDAT;

///////// HEX /////////
output                        [6:0]                HEX0;
output                        [6:0]                HEX1;
output                        [6:0]                HEX2;
output                        [6:0]                HEX3;
output                        [6:0]                HEX4;
output                        [6:0]                HEX5;
output                        [6:0]                HEX6;
output                        [6:0]                HEX7;

///////// HSMC /////////
input                                              HSMC_CLKIN0;
input                                              HSMC_CLKIN_N1;
input                                              HSMC_CLKIN_N2;
input                                              HSMC_CLKIN_P1;
input                                              HSMC_CLKIN_P2;
output                                             HSMC_CLKOUT0;
inout                                              HSMC_CLKOUT_N1;
inout                                              HSMC_CLKOUT_N2;
inout                                              HSMC_CLKOUT_P1;
inout                                              HSMC_CLKOUT_P2;
inout                         [3:0]                HSMC_D;
output                                             HSMC_I2C_SCLK;
inout                                              HSMC_I2C_SDAT;
inout                         [16:0]               HSMC_RX_D_N;
inout                         [16:0]               HSMC_RX_D_P;
inout                         [16:0]               HSMC_TX_D_N;
inout                         [16:0]               HSMC_TX_D_P;

///////// I2C /////////
output                                             I2C_SCLK;
inout                                              I2C_SDAT;

///////// IRDA /////////
input                                              IRDA_RXD;

///////// KEY /////////
input                         [3:0]                KEY;

///////// LCD /////////
inout                         [7:0]                LCD_DATA;
output                                             LCD_EN;
output                                             LCD_ON;
output                                             LCD_RS;
output                                             LCD_RW;

///////// LEDG /////////
output                        [8:0]                LEDG;

///////// LEDR /////////
output                        [17:0]               LEDR;

///////// PCIE /////////
`ifdef ENABLE_PCIE
input                                              PCIE_PERST_N;
input                                              PCIE_REFCLK_P;
input                         [1:0]                PCIE_RX_P;
output                        [1:0]                PCIE_TX_P;
output                                             PCIE_WAKE_N;
`endif 
///////// SD /////////
output                                             SD_CLK;
inout                                              SD_CMD;
inout                         [3:0]                SD_DAT;
input                                              SD_WP_N;

///////// SMA /////////
input                                              SMA_CLKIN;
output                                             SMA_CLKOUT;

///////// SSRAM /////////
output                                             SSRAM_ADSC_N;
output                                             SSRAM_ADSP_N;
output                                             SSRAM_ADV_N;
output                         [3:0]               SSRAM_BE;
output                                             SSRAM_CLK;
output                                             SSRAM_GW_N;
output                                             SSRAM_OE_N;
output                                             SSRAM_WE_N;
output                                             SSRAM0_CE_N;
output                                             SSRAM1_CE_N;

///////// SW /////////
input                         [17:0]               SW;

///////// TD /////////
input                                              TD_CLK27;
input                         [7:0]                TD_DATA;
input                                              TD_HS;
output                                             TD_RESET_N;
input                                              TD_VS;

///////// UART /////////
input                                             UART_CTS;
output                                              UART_RTS;
input                                              UART_RXD;
output                                             UART_TXD;

///////// VGA /////////
output                        [7:0]                VGA_B;
output                                             VGA_BLANK_N;
output                                             VGA_CLK;
output                        [7:0]                VGA_G;
output                                             VGA_HS;
output                        [7:0]                VGA_R;
output                                             VGA_SYNC_N;
output                                             VGA_VS;

//=======================================================
//  REG/WIRE declarations
//=======================================================

wire            read;
wire            counter_max;
wire				 clk_27m;


wire	[8:0]		w_input_image;
wire  [8:0]		GaussianImageData[5:0];
wire  [8:0]		DOGImageData[5:0];

wire	  			w_iskeypoint_en;

//enable signal of writing key points to SDRAM
wire    			w_savekeypoint_en;


assign w_input_image = {Dva, SDGRAY};

ImagePyramid ImagePyramid_tb2(
	.iclk(CCD_PIXCLK),
	.irst_n(DLY_RST_2),
	.iImagePixelData(w_input_image),
	
	.GaussianImageData1(GaussianImageData[0]),
	.GaussianImageData2(GaussianImageData[1]),
	.GaussianImageData3(GaussianImageData[2]),
	.GaussianImageData4(GaussianImageData[3]),
	.DOGImageDate1(DOGImageData[0]),
	.DOGImageDate2(DOGImageData[1]),
	.DOGImageDate3(DOGImageData[2])
);

SIFTDetection test(  
  .iclk(CCD_PIXCLK),
  .irst_n(DLY_RST_2),
  .idata0(DOGImageData[0]),
  .idata1(DOGImageData[1]),
  .idata2(DOGImageData[2]),
  .okeypoint_en(w_iskeypoint_en),
  .odata_en(w_savekeypoint_en)
);

// Coordinate of SIFT image
// the position of the SIFT features
// CoorXY[0] is x, CoorXY[1] is y
reg [9:0] CoorXY[1:0];
reg [10:0] sift_des_num, reg_sift_des_num;
reg [10:0] Obj_des_num, reg_Obj_des_num;
reg Obj_des_count_terminal;

//define the coordinates of SIFT features on the whole image including the ones on the tracked object
always@(posedge CCD_PIXCLK or negedge DLY_RST_2) begin
	if (!DLY_RST_2) begin
		//The coordinate of the SIFT feature
		CoorXY[0] <= 0;
		CoorXY[1] <= 0;
		
		//number of SIFT features on the whole image
		sift_des_num <= 0;
		reg_sift_des_num <= 0;
		
		//number of SIFT features on the tracked object
		reg_Obj_des_num <= 0;
		Obj_des_num <= 0;
		
		//the stop signal of counting the number of Object features
		Obj_des_count_terminal <= 0;
	end
	else begin
		if(w_savekeypoint_en) begin
		
			//the COORDINATE and the IMAGE
			case(CoorXY[0])
				10'h31F: begin				//10'h31F is 799 in decimal
					case(CoorXY[1])
						10'h257: begin		//10'h257 is 599 in decimal
							CoorXY[0] <= 0;
							CoorXY[1] <= 0;
							sift_des_num <= reg_sift_des_num;
							reg_sift_des_num <= 0;
						end
						default: begin
							CoorXY[0] <= 0;
							CoorXY[1] <= CoorXY[1] + 1'b1;
							reg_sift_des_num <= reg_sift_des_num + 1;
						end
					endcase
				end
				default: begin
					CoorXY[0] <= CoorXY[0] + 1;
					reg_sift_des_num <= reg_sift_des_num + 1;
				end
			endcase
			
			//the OBJECT
			if(SW[2] && !Obj_des_count_terminal) begin
				//the region of the square of the tracked object
				if( CoorXY[0]>10'h150 && CoorXY[0]<10'h1D0 
					 && CoorXY[1]>10'hFC && CoorXY[1]<10'h17C) begin
					 reg_Obj_des_num <= reg_Obj_des_num + 1;
				end
				else if (CoorXY[0]>10'h1D0 && CoorXY[1]>10'h17C) begin
					Obj_des_num <= reg_Obj_des_num;
					
					//stop counting the number of object features
					Obj_des_count_terminal <= 1;
					
					//start the matching module
					match_start <= 1;
				end
			end
			
		end
	end
end

//wires of write signals for SIFT modules
wire  [14:0] w_ousedw;
wire         w_FIFO_en;
wire         w_FIFO_keypoint_en;
wire  				w_descriptor_en;
wire	[1279:0]		w_descriptor_output;

//In the SIFT_Detection_FIFO_Controller module, "w_FIFO_keypoint_en" seems to be
//the enable signal that imply whether that CCD Coor is a feature or not
//"SIFT_Detection_FIFO_Controller" module is responsible for waiting SIFTDescriptor module to complete
SIFT_Detection_FIFO_Controller top6(
		.iclk(CCD_PIXCLK),
		.ireset(DLY_RST_2),
		.iwrite_en(w_savekeypoint_en),
		.iread_en(w_descriptor_en),
		.idata(w_iskeypoint_en),
		.odata_en(w_FIFO_en),
		.odata(w_FIFO_keypoint_en),
		.ousedw(w_ousedw)
);

//the "SIFTDescriptor" module outputs the descriptions of features
SIFTDescriptor top7(
  .iclk(CCD_PIXCLK),
  .ireset(DLY_RST_2),
  .iImagedata(GaussianImageData[1]),
  .odval(w_descriptor_en),
  .odescriptor(w_descriptor_output)
);
	
//register for the delay of one-clock
reg [1279:0] r_descriptor_hold;

//delaying one-clock after key points are detected
//and before "ObjectRam" is enabled
always@(posedge CCD_PIXCLK or negedge DLY_RST_2) begin
	if (!DLY_RST_2) begin
		r_descriptor_hold <= 0;
	end
	else begin
		r_descriptor_hold <= w_descriptor_output;
	end
end

//Note that write enables of the two SRAMs are controlled by a switch and valid detected features
//registers of write and read address for the ObjRam
reg [10:0] wrRamAddr;
reg sramObj_rd_en;
wire [1279:0] o_sramObj_data;

//registers and wires of the SRAM for RAM_des
wire [1279:0] o_sramDes_data;
reg sramDes_rd_en;
reg [10:0] book_fcount;

//registers and wires for the matching
reg en_matchingControl;	//matching enable signal
reg BaseChange_trig;		//base change signal
reg [10:0] b;				//index of features of book
reg [10:0] s;				//index of features of scene
reg [10:0] f_counter;	//transfer index s between matching modules
reg [39:0] i_des;		//store descriptors for matching modules
reg [3:0] clk_counter;	//counter of clocks for delays
reg trig_t;
reg des_sw;					//switch of descriptors
reg i_des_sw;				//switch of descriptors as input to the module
wire [31:0] match_indx; //the matched index of the feature
wire match_valid;			//whether the feature is matched or not
wire en_next_des;			//matching done signal
reg [4:0] delay;			//delay for enabling the matching controller module
reg [2:0] o_des_delay_counter;	//delay for inputing correct Book des to the controller module
reg [2:0] o_des_delayS_counter;	//delay for inputing correct Scene des to the controller module
reg [2:0] idxB_delay, idxS_delay; //delay for inputing correct index of sequential des data
reg unsigned [6:0] des_seq_idx; //indx for controlling the "Matching_Controller" module
reg [39:0] i_des_book_seq [31:0];	//the sequential input of the Book des data
reg [39:0] i_des_scene_seq [31:0];	//the sequential input of the Scene des data
reg seqB_transfer_finish, seqS_transfer_finish;

reg match_start;
reg [10:0] f_num_scene_Bit, f_num_book_Bit;
reg [10:0] DesOfObj, DesOfImg;

//ObjectRam is only in charge of storing feature data inside the green square
//"r_descriptor_hold" is the input with 1280 bits
//"wrRamAddr" is the wirte address from the above
//if SW[2] is turned on and the CCD Coor is a feature, then that feautre is stored in a SRAM
//if read is enabled, q is the output of the readable data

Matching_Controller u(
	.iclk(CCD_PIXCLK),
	.irst(DLY_RST_2),
	.i_enable(en_matchingControl),
	.i_BC_en(BaseChange_trig),
	.i_Des(i_des),
	.i_des_sw(i_des_sw),
	.indx_s(f_counter),
	.scene_fnum_Bit(f_num_scene_Bit),
	.i_des_seq_idx(des_seq_idx),
	.o_fmatch_idx(match_indx),
	.o_Dval(match_valid),
	.o_finish(en_next_des)
);

RAM_obj ORam(
	.clock(CCD_PIXCLK),
	.data(r_descriptor_hold),
	.rdaddress(b),
	.rden(sramObj_rd_en),
	.wraddress(reg_Obj_des_num),
	.wren( SW[2]?(w_FIFO_keypoint_en):0 ),
	.q(o_sramObj_data)
);

RAM_des sram_book(
	.clock(CCD_PIXCLK),
	.data(r_descriptor_hold),
	.rdaddress(s),
	.rden(sramDes_rd_en),
	.wraddress(reg_sift_des_num),
	.wren( SW[17]?(w_FIFO_keypoint_en):0 ),
	.q(o_sramDes_data)
);	
	
//the following always statement is responsible for matching
always @ (posedge CCD_PIXCLK or negedge DLY_RST_2) begin
	if (!DLY_RST_2) begin
		en_matchingControl <= 0;
		BaseChange_trig <= 0;
		b <= 0;
		s <= 0;
		clk_counter = 0;
		trig_t <= 0;
		delay <= 0;
		o_des_delay_counter <= 0;
		o_des_delayS_counter <= 0;
		sramDes_rd_en <= 0;
		sramObj_rd_en <= 0;
		des_sw <= 0;
		i_des_sw <= 0;
		
		seqB_transfer_finish <= 0;
		seqS_transfer_finish <= 0;
		des_seq_idx <= 0;
		idxB_delay <= 0;
		idxS_delay <= 0;
	end
	else if (match_start) begin
		
		f_num_scene_Bit <= sift_des_num;
		f_num_book_Bit <= Obj_des_num;
		
		//initially enable the en_matchingControl signal
		if (!SW[2]) begin
		
			//read scene data from a SRAM
			sramObj_rd_en <= 1;
			
			//read book data from a SRAM
			sramDes_rd_en <= 1;
			
			if (delay < 14) begin
				delay <= delay + 1;
			end
			else if (delay > 14 && seqB_transfer_finish) begin
				en_matchingControl <= 1;
				trig_t <= 1;
				delay <= delay + 1;
			end
			else if (delay > 16 && seqS_transfer_finish && delay < 18) begin
				delay <= delay + 1;
				des_sw <= 1;
				i_des_sw <= 1;
				trig_t <= 0;
			end
			else if (delay == 14 || delay == 16)
				delay <= delay + 1;
		end
		
		//read data from the two SRAMs and transfer to "Matching_Controller" module sequatially
		if(!des_sw && !SW[2]) begin
			if (o_des_delay_counter < 2) begin
				o_des_delay_counter <= o_des_delay_counter + 1;
				o_des_delayS_counter <= 0;
				idxS_delay <= 0;
				des_seq_idx <= 0;
			end
			else begin
				en_matchingControl <= 1;
				i_des <= i_des_book_seq[des_seq_idx];
				i_des_sw <= 0;
				//o_des_delay_counter <= 0;
				
				i_des_book_seq[0] <= o_sramObj_data[39:0];
				i_des_book_seq[1] <= o_sramObj_data[79:40];
				i_des_book_seq[2] <= o_sramObj_data[119:80];
				i_des_book_seq[3] <= o_sramObj_data[159:120];
				i_des_book_seq[4] <= o_sramObj_data[199:160];
				i_des_book_seq[5] <= o_sramObj_data[239:200];
				i_des_book_seq[6] <= o_sramObj_data[279:240];
				i_des_book_seq[7] <= o_sramObj_data[319:280];
				i_des_book_seq[8] <= o_sramObj_data[359:320];
				i_des_book_seq[9] <= o_sramObj_data[399:360];
				i_des_book_seq[10] <= o_sramObj_data[439:400];
				i_des_book_seq[11] <= o_sramObj_data[479:440];
				i_des_book_seq[12] <= o_sramObj_data[519:480];
				i_des_book_seq[13] <= o_sramObj_data[559:520];
				i_des_book_seq[14] <= o_sramObj_data[599:560];
				i_des_book_seq[15] <= o_sramObj_data[639:600];
				i_des_book_seq[16] <= o_sramObj_data[679:640];
				i_des_book_seq[17] <= o_sramObj_data[719:680];
				i_des_book_seq[18] <= o_sramObj_data[759:720];
				i_des_book_seq[19] <= o_sramObj_data[799:760];
				i_des_book_seq[20] <= o_sramObj_data[839:800];
				i_des_book_seq[21] <= o_sramObj_data[879:840];
				i_des_book_seq[22] <= o_sramObj_data[919:880];
				i_des_book_seq[23] <= o_sramObj_data[959:920];
				i_des_book_seq[24] <= o_sramObj_data[999:960];
				i_des_book_seq[25] <= o_sramObj_data[1039:1000];
				i_des_book_seq[26] <= o_sramObj_data[1079:1040];
				i_des_book_seq[27] <= o_sramObj_data[1119:1080];
				i_des_book_seq[28] <= o_sramObj_data[1159:1120];
				i_des_book_seq[29] <= o_sramObj_data[1199:1160];
				i_des_book_seq[30] <= o_sramObj_data[1239:1200];
				i_des_book_seq[31] <= o_sramObj_data[1279:1240];
				
				if (idxB_delay < 2) begin
					idxB_delay <= idxB_delay + 1;
				end
				else begin
					if (des_seq_idx < 32) begin
						seqB_transfer_finish <= 0;
						des_seq_idx <= des_seq_idx + 1;
					end
					else begin
						seqB_transfer_finish <= 1;
						trig_t <= 1;
					end
				end
				
			end
		end
		else if(des_sw && !SW[2]) begin
			if (o_des_delayS_counter < 1) begin
				o_des_delayS_counter <= o_des_delayS_counter + 1;
				seqB_transfer_finish <= 0;
				idxB_delay <= 0;
				des_seq_idx <= 0;
			end
			else begin
				//i_des <= o_sram_data;
				i_des <= i_des_scene_seq[des_seq_idx];
				i_des_sw <= 1;
				o_des_delay_counter <= 0;
				
				i_des_scene_seq[0] <= o_sramDes_data[39:0];
				i_des_scene_seq[1] <= o_sramDes_data[79:40];
				i_des_scene_seq[2] <= o_sramDes_data[119:80];
				i_des_scene_seq[3] <= o_sramDes_data[159:120];
				i_des_scene_seq[4] <= o_sramDes_data[199:160];
				i_des_scene_seq[5] <= o_sramDes_data[239:200];
				i_des_scene_seq[6] <= o_sramDes_data[279:240];
				i_des_scene_seq[7] <= o_sramDes_data[319:280];
				i_des_scene_seq[8] <= o_sramDes_data[359:320];
				i_des_scene_seq[9] <= o_sramDes_data[399:360];
				i_des_scene_seq[10] <= o_sramDes_data[439:400];
				i_des_scene_seq[11] <= o_sramDes_data[479:440];
				i_des_scene_seq[12] <= o_sramDes_data[519:480];
				i_des_scene_seq[13] <= o_sramDes_data[559:520];
				i_des_scene_seq[14] <= o_sramDes_data[599:560];
				i_des_scene_seq[15] <= o_sramDes_data[639:600];
				i_des_scene_seq[16] <= o_sramDes_data[679:640];
				i_des_scene_seq[17] <= o_sramDes_data[719:680];
				i_des_scene_seq[18] <= o_sramDes_data[759:720];
				i_des_scene_seq[19] <= o_sramDes_data[799:760];
				i_des_scene_seq[20] <= o_sramDes_data[839:800];
				i_des_scene_seq[21] <= o_sramDes_data[879:840];
				i_des_scene_seq[22] <= o_sramDes_data[919:880];
				i_des_scene_seq[23] <= o_sramDes_data[959:920];
				i_des_scene_seq[24] <= o_sramDes_data[999:960];
				i_des_scene_seq[25] <= o_sramDes_data[1039:1000];
				i_des_scene_seq[26] <= o_sramDes_data[1079:1040];
				i_des_scene_seq[27] <= o_sramDes_data[1119:1080];
				i_des_scene_seq[28] <= o_sramDes_data[1159:1120];
				i_des_scene_seq[29] <= o_sramDes_data[1199:1160];
				i_des_scene_seq[30] <= o_sramDes_data[1239:1200];
				i_des_scene_seq[31] <= o_sramDes_data[1279:1240];
				
				if (idxS_delay < 2) begin
					idxS_delay <= idxS_delay + 1;
				end
				else begin
					if (des_seq_idx < 32) begin
						seqS_transfer_finish <= 0;
						des_seq_idx <= des_seq_idx + 1;
					end
					else begin
						seqS_transfer_finish <= 1;
					end
				end
			end
			
		end

		if (en_next_des) begin
			if (s < f_num_scene_Bit) begin
				des_sw <= 1;
				s <= s + 1;
				seqS_transfer_finish <= 0;
				o_des_delayS_counter <= 0;
				BaseChange_trig <= 1'b0;
				f_counter <= f_counter + 1;
			end
			else begin
				f_counter <= 0;
				s <= 0;
				if (b < f_num_book_Bit) begin
					b <= b + 1;
					BaseChange_trig <= 1'b1;
					des_sw <= 0;
				end
				else begin
					//matching is over, end the matching module
					en_matchingControl <= 1'b0;
					BaseChange_trig <= 1'b0;
					b <= 0;
					des_sw <= 1;
					f_counter <= 0;
				end
			end
		end
		else if (trig_t) begin		
			//if (clk_counter < 5) begin
				//clk_counter <= clk_counter + 1;
			//end
			//else begin
				clk_counter <= 0;
				trig_t <= 0;
				des_sw <= 1;
			//end
		end
		else begin		
			BaseChange_trig <= 1'b0;
			//read_req = 1'b0;
		end
		
//		if(match_valid) begin
//			reg_match_idx <= match_indx[26:0];
//		end
//			
//		if(en_transfer_trig) begin
//			reg_en_matchingControl <= en_matchingControl;
//		end	
	end
		
end

// CCD
wire  [11:0]  CCD_DATA;
wire          CCD_SDAT;
wire          CCD_SCLK;
wire          CCD_FLASH;
wire          CCD_FVAL;
wire          CCD_LVAL;
wire          CCD_PIXCLK;
wire          CCD_MCLK;    // CCD Master Clock

wire  [23:0]  Read_DATA1;
wire  [15:0]  Read_DATA2;
wire          VGA_CTRL_CLK;
wire			  VGA_CLK_40;
wire			  VGA_CLK_60;
wire  [11:0]  mCCD_DATA;
wire          mCCD_DVAL;
wire          mCCD_DVAL_d;
wire  [15:0]  X_Cont;
wire  [15:0]  Y_Cont;
wire  [9:0]   X_ADDR;
wire  [31:0]  Frame_Cont;
wire          DLY_RST_0;
wire          DLY_RST_1;
wire          DLY_RST_2;
wire          Read;
reg   [11:0]  rCCD_DATA;
reg           rCCD_LVAL;
reg           rCCD_FVAL;
wire  [11:0]  sCCD_R;
wire  [11:0]  sCCD_G;
wire  [11:0]  sCCD_B;
wire          sCCD_DVAL;
reg   [1:0]   rClk;
wire          sdram_ctrl_clk;

assign CCD_DATA[0]  = GPIO[13];
assign CCD_DATA[1]  = GPIO[12];
assign CCD_DATA[2]  = GPIO[11];
assign CCD_DATA[3]  = GPIO[10];
assign CCD_DATA[4]  = GPIO[9];
assign CCD_DATA[5]  = GPIO[8];
assign CCD_DATA[6]  = GPIO[7];
assign CCD_DATA[7]  = GPIO[6];
assign CCD_DATA[8]  = GPIO[5];
assign CCD_DATA[9]  = GPIO[4];
assign CCD_DATA[10] = GPIO[3];
assign CCD_DATA[11] = GPIO[1];
assign GPIO[16]     = CCD_MCLK;
assign CCD_FVAL     = GPIO[22];
assign CCD_LVAL     = GPIO[21];
assign CCD_PIXCLK   = GPIO[0];
assign GPIO[19]     = 1'b1;  // tRIGGER
assign GPIO[17]     = DLY_RST_1;

assign LEDR          = SW;

assign TD_RESET_N  = 1'b1;
//assign VGA_CLK    = ~VGA_CTRL_CLK;
assign VGA_CLK    = ~CLOCK_50;
assign CCD_MCLK      = rClk[0];

VGA_Controller vga0 (
  // Host Side
  .oRequest(Read),
  .iRed(Read_DATA1[23:16]),
  .iGreen(Read_DATA1[15:8]),
  .iBlue(Read_DATA1[7:0]),
  // VGA Side
  .oVGA_R(VGA_R),
  .oVGA_G(VGA_G),
  .oVGA_B(VGA_B),
  .oVGA_H_SYNC(VGA_HS),
  .oVGA_V_SYNC(VGA_VS),
  .oVGA_SYNC(VGA_SYNC_N),
  .oVGA_BLANK(VGA_BLANK_N),
  // Control Signal
  .iCLK(CLOCK_50),
  .iRST_N(DLY_RST_2),
  .iZOOM_MODE_SW(SW[16])
);

Reset_Delay reset0 (
  .iCLK(CLOCK_50),
  .iRST(KEY[0]),
  .oRST_0(DLY_RST_0),
  .oRST_1(DLY_RST_1),
  .oRST_2(DLY_RST_2)
);

CCD_Capture capture0 (
  .oDATA(mCCD_DATA),
  .oDVAL(mCCD_DVAL),
  .oX_Cont(X_Cont),
  .oY_Cont(Y_Cont),
  .oFrame_Cont(Frame_Cont),
  .iDATA(rCCD_DATA),
  .iFVAL(rCCD_FVAL),
  .iLVAL(rCCD_LVAL),
  .iSTART(!KEY[3]),
  .iEND(!KEY[2]),
  .iCLK(CCD_PIXCLK),
  .iRST(DLY_RST_2)
);

RAW2RGB rgb0 (
  .iCLK(CCD_PIXCLK),
  .iRST_n(DLY_RST_1),
  .iData(mCCD_DATA),
  .iDval(mCCD_DVAL),
  .oRed(sCCD_R),
  .oGreen(sCCD_G),
  .oBlue(sCCD_B),
  .oDval(sCCD_DVAL),
  .iZoom(SW[17:16]),
  .iX_Cont(X_Cont),
  .iY_Cont(Y_Cont)
);

// Coordinate of CCD
reg [9:0] RAWCoorXY[1:0];

always@(posedge CCD_PIXCLK or negedge DLY_RST_1) begin
	if (!DLY_RST_1) begin
		RAWCoorXY[0] <= 0;
		RAWCoorXY[1] <= 0;
	end
	else begin
		if(sCCD_DVAL) begin
			case(RAWCoorXY[0])
				10'h31F: begin
					case(RAWCoorXY[1])
						10'h257: begin
							RAWCoorXY[0] <= 0;
							RAWCoorXY[1] <= 0;
						end
						default: begin
							RAWCoorXY[0] <= 0;
							RAWCoorXY[1] <= RAWCoorXY[1] + 1;
						end
					endcase
				end
				default: begin
						RAWCoorXY[0] <= RAWCoorXY[0] + 1;
				end
			endcase
		end
	end
end

sdram_pll sdram_pll0 (
  .inclk0(CLOCK_50),
  .c0(sdram_ctrl_clk),
  .c1(DRAM_CLK)
);

//ImageDraw is in charge of drawing (changing) the RGB values of the image
ImageDraw DrawM(
	.iclk(CCD_PIXCLK),
	.irst(DLY_RST_2),
	.sCCDR(sCCD_R[11:4]),
	.sCCDG(sCCD_G[11:4]),
	.sCCDB(sCCD_B[11:4]),
	.iDval(sCCD_DVAL),
	.iSW({SW[5:4],SW[1]}),
	.ikeypoint(w_iskeypoint_en),
	.iCoorX(RAWCoorXY[0]),
	.iCoorY(RAWCoorXY[1]),
	.oSDR(SDRAMR),
	.oSDG(SDRAMG),
	.oSDB(SDRAMB),
	.oSDGRAY(SDGRAY),
	.oDval(Dva)
);

wire [7:0] SDRAMR, SDRAMG, SDRAMB, SDGRAY;
wire		  Dva;
reg delayDval;

// Delay 1 clk for sCCD_DVAL
always@(posedge CLOCK_50)
  delayDval <= sCCD_DVAL;

 //Sdram_Control_4Port is responsible for storing data in SDRAM
 //In this top file, ".WR1_DATA({SDRAMR, SDRAMG, SDRAMB})" writes RGB values to the module (SDRAM)
 //which are the outputs of "ImageDraw"
 //because features are drawn by red and are required to be stored back to SDRAM so that the display
 //can correctly show the features on the screen
Sdram_Control_4Port sdram (
  // HOST Side
  .REF_CLK(CLOCK_50),
  .RESET_N(1'b1),
  .CLK(sdram_ctrl_clk),
  // FIFO Write Side 1
  .WR1_DATA({SDRAMR, SDRAMG, SDRAMB}),
  .WR1(sCCD_DVAL),
  .WR1_ADDR(0),
  .WR1_MAX_ADDR(800*600),
  .WR1_LENGTH(9'h100),
  .WR1_LOAD(!DLY_RST_0),
  .WR1_CLK(CCD_PIXCLK),
  // FIFO Read Side 1
  .RD1_DATA(Read_DATA1),
  .RD1(Read),
  .RD1_ADDR(0),
  .RD1_MAX_ADDR(800*600),
  .RD1_LENGTH(9'h100),
  .RD1_LOAD(!DLY_RST_0),
  .RD1_CLK(CLOCK_50),
  // SDRAM Side
  .SA(DRAM_ADDR[11:0]),
  .BA(DRAM_BA),
  .CS_N(DRAM_CS_N),
  .CKE(DRAM_CKE),
  .RAS_N(DRAM_RAS_N),
  .CAS_N(DRAM_CAS_N),
  .WE_N(DRAM_WE_N),
  .DQ(DRAM_DQ[23:0]),
  .DQM(DRAM_DQM[2:0])
);

I2C_CCD_Config i2c0 (
  // Host Side
  .iCLK(CLOCK_50),
  .iRST_N(DLY_RST_2),
  .iZOOM_MODE_SW(SW[16]),
  .iEXPOSURE_ADJ(KEY[1]),
  .iEXPOSURE_DEC_p(SW[0]),
  // I2C Side
  .I2C_SCLK(GPIO[24]),
  .I2C_SDAT(GPIO[23])
);

always@(posedge CLOCK_50)
  rClk <= rClk+1;

always@(posedge CCD_PIXCLK) begin
  rCCD_DATA	<=	CCD_DATA;
  rCCD_LVAL	<=	CCD_LVAL;
  rCCD_FVAL	<=	CCD_FVAL;
end

////send data to Nios II
//DE2i_150_QSYS u0 (
//        .clk_clk                (CLOCK_50),                //              clk.clk
//        .led_export             (),             //              led.export
//		  
//		  //SDRAM
//        .sdram_controller_addr  (DRAM_ADDR[11:0]),  // sdram_controller.addr
//        .sdram_controller_ba    (DRAM_BA),    //                 .ba
//        .sdram_controller_cas_n (DRAM_CAS_N), //                 .cas_n
//        .sdram_controller_cke   (DRAM_CKE),   //                 .cke
//        .sdram_controller_cs_n  (DRAM_CS_N),  //                 .cs_n
//        .sdram_controller_dq    (DRAM_DQ[23:0]),    //                 .dq
//        .sdram_controller_dqm   (DRAM_DQM[2:0]),   //                 .dqm
//        .sdram_controller_ras_n (DRAM_RAS_N), //                 .ras_n
//        .sdram_controller_we_n  (DRAM_WE_N),  //                 .we_n
//        .dram_clock_clk         (DRAM_CLK),         //       dram_clock.clk
//		  
//		  //storing descriptors data
//        .outdes00_export        (w_descriptor_output[29:0]),        //         outdes00.export
//        .outdes01_export        (w_descriptor_output[59:30]),        //         outdes01.export
//        .outdes02_export        (w_descriptor_output[89:60]),        //         outdes02.export
//        .outdes03_export        (w_descriptor_output[119:90]),        //         outdes03.export
//        .outdes04_export        (w_descriptor_output[149:120]),        //         outdes04.export
//        .outdes05_export        (w_descriptor_output[179:150]),        //         outdes05.export
//        .outdes06_export        (w_descriptor_output[209:180]),        //         outdes06.export
//        .outdes07_export        (w_descriptor_output[239:210]),        //         outdes07.export
//        .outdes08_export        (w_descriptor_output[269:240]),        //         outdes08.export
//        .outdes09_export        (w_descriptor_output[119:90]),        //         outdes09.export
//        .outdes10_export        (w_descriptor_output[119:90]),        //         outdes10.export
//        .outdes11_export        (w_descriptor_output[119:90]),        //         outdes11.export
//        .outdes12_export        (w_descriptor_output[119:90]),        //         outdes12.export
//        .outdes13_export        (w_descriptor_output[119:90]),        //         outdes13.export
//        .outdes14_export        (w_descriptor_output[119:90]),        //         outdes14.export
//        .outdes15_export        (w_descriptor_output[119:90]),        //         outdes15.export
//        .outdes16_export        (w_descriptor_output[119:90]),        //         outdes16.export
//        .outdes17_export        (w_descriptor_output[119:90]),        //         outdes17.export
//        .outdes18_export        (w_descriptor_output[119:90]),        //         outdes18.export
//        .outdes19_export        (w_descriptor_output[119:90]),        //         outdes19.export
//        .outdes20_export        (w_descriptor_output[119:90]),        //         outdes20.export
//        .outdes21_export        (w_descriptor_output[119:90]),        //         outdes21.export
//        .outdes22_export        (w_descriptor_output[119:90]),        //         outdes22.export
//        .outdes23_export        (w_descriptor_output[119:90]),        //         outdes23.export
//        .outdes24_export        (w_descriptor_output[119:90]),        //         outdes24.export
//        .outdes25_export        (w_descriptor_output[119:90]),        //         outdes25.export
//        .outdes26_export        (w_descriptor_output[119:90]),        //         outdes26.export
//        .outdes27_export        (w_descriptor_output[119:90]),        //         outdes27.export
//        .outdes28_export        (<connected-to-outdes28_export>),        //         outdes28.export
//        .outdes29_export        (<connected-to-outdes29_export>),        //         outdes29.export
//        .outdes30_export        (<connected-to-outdes30_export>),        //         outdes30.export
//        .outdes31_export        (<connected-to-outdes31_export>),        //         outdes31.export
//        .outdes32_export        (<connected-to-outdes32_export>),        //         outdes32.export
//        .outdes33_export        (<connected-to-outdes33_export>),        //         outdes33.export
//        .outdes34_export        (<connected-to-outdes34_export>),        //         outdes34.export
//        .outdes35_export        (<connected-to-outdes35_export>),        //         outdes35.export
//        .outdes36_export        (<connected-to-outdes36_export>),        //         outdes36.export
//        .outdes37_export        (<connected-to-outdes37_export>),        //         outdes37.export
//        .outdes38_export        (<connected-to-outdes38_export>),        //         outdes38.export
//        .outdes39_export        (<connected-to-outdes39_export>),        //         outdes39.export
//        .outdes40_export        (<connected-to-outdes40_export>),        //         outdes40.export
//        .outdes41_export        (<connected-to-outdes41_export>)         //         outdes41.export
//);

endmodule
