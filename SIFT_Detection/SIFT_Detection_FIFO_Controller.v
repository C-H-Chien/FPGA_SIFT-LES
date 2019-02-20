
`timescale 1 ps / 1 ps

module SIFT_Detection_FIFO_Controller(
		input               iclk,
		input               ireset,
		input               iwrite_en,     
		input               iread_en,
		input               idata,
		output    reg       odata_en,
		output              odata,
		output    [14:0]    ousedw
);

wire            write_request;
wire            read_request;
wire	           w_empty;
wire	           w_full;

assign write_request = (iwrite_en == 0) ? 0 : !w_full;  // check for write
assign read_request = (iread_en == 0) ? 0 : !w_empty;  // // check for read

always@(posedge iclk or negedge ireset) begin
  if (!ireset) begin
    odata_en <= 0;  
  end
  else begin
    odata_en <= read_request;
  end
end  


SIFT_Detection_FIFO DCFIFO_Controller1(
	.aclr(!ireset),
	.clock(iclk),
	.data(idata),
	.rdreq(read_request),
	.wrreq(write_request),
	.empty(w_empty),
	.full(w_full),
	.q(odata),
	.usedw(ousedw)
);

endmodule
