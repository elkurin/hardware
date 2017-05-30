`default_nettype none

module div32
	( input wire [63:0] x,
	  input wire [31:0] d,
	  output wire [31:0] q,
	  output wire [31:0] r);
  
  genvar i;
  wire [31:0] rh [0:32];
  assign rh[0] = x[63:32];
  for (i = 0; i < 32; i = i + 1) begin
	 wire [32:0] xh = {rh[i], x[31-i:31-i]};
	 wire [32:0] flag = {1'b0, xh} - {1'b0, d};
	 assign q[31-i:31-i] = flag[32] ? 0 : 1;
	 assign rh[i+1] = flag[32] ? xh : flag[31:0];
  end
  assign r = rh[32][31:0];

endmodule

`default_nettype wire

