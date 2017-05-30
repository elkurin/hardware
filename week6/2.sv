`default_nettype none

module div32p2
	( input wire [63:0] x,
	  input wire [31:0] d,
	  output wire [31:0] q,
	  output wire [31:0] r,
	  input wire clk,
	  input wire rstn);

	reg [47:0] tempx;
	reg [31:0] tempd;
	reg [15:0] tempq1;
	reg [31:0] tempq2;
	reg [31:0] tempr;
	reg [31:0] tempR;
	reg [31:0] Q;
	reg [31:0] R;
	div16 div16_1(.xh(x[63:16]), .dh(d), .qh(tempq1), .rh(tempr));
	div16 div16_2(.xh(tempx), .dh(tempd), .qh(tempq2[15:0]), .rh(tempR));
	always @(posedge clk) begin
		tempx <= {tempr, x[15:0]};
		tempd <= d;
		tempq2[31:16] <= tempq1;
		Q <= tempq2;
		R <= tempR;
	end
	assign q = Q;
	assign r = R;
endmodule

module div16
	( input wire [47:0] xh,
	  input wire [31:0] dh,
	  output wire [15:0] qh,
	  output wire [31:0] rh);
	genvar i;
	wire [31:0] rl [0:16];
	assign rl[0] = xh[47:16];
	for (i = 0; i < 16; i = i + 1) begin
		wire [32:0] xl = {rl[i], xh[15-i:15-i]};
		wire [32:0] flag = {1'b0, xl} - {1'b0, dh};
		assign qh[15-i:15-i] = flag[32] ? 0 : 1;
		assign rl[i+1] = flag[32] ? xl : flag[31:0];
	end
	assign rh = rl[16][31:0];
endmodule

`default_nettype wire
