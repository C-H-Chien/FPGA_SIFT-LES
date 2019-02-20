`timescale 1 ps / 1 ps

module DCFIFO_Controller(
		input               iclk_input,     //50M
		input               iclk_output,    //400M
		input               ireset,
		input     [127:0]   idata,
		output              oread_request,
		output    [15:0]    odata,
		output    [10:0]    rdusedw,
		output    [7:0]     wrusedw
);

wire            write_request;
wire            read_request;
wire	           rdempty;
wire	           rdfull;
wire	           wrempty;
wire	           wrfull;

assign write_request = !wrfull;  // check for write
assign read_request = !rdempty;  // // check for read
assign oread_request = read_request;

Orientation_DCFIFO DCFIFO_Controller1(
	.aclr(!ireset),
	.data(idata),
	.rdclk(iclk_output),
	.rdreq(read_request),
	.wrclk(iclk_input),
	.wrreq(write_request),
	.q(odata),
	.rdempty(rdempty),
	.rdfull(rdfull),
	.rdusedw(rdusedw),
	.wrempty(wrempty),
	.wrfull(wrfull),
	.wrusedw(wrusedw)
);

endmodule