`default_nettype none

module fadd
	( input wire  [31:0] x1,
	  input wire  [31:0] x2,
	  output wire [31:0] y,
  	  output wire ovf);
  wire [0:0]  x1s;
  wire [0:0]  x2s;
  wire [7:0]  x1e;
  wire [7:0]  x2e;
  wire [22:0] x1m;
  wire [22:0] x2m;

  assign x1s = x1[31:31];
  assign x2s = x2[31:31];
  assign x1e = x1[30:23];
  assign x2e = x2[30:23];
  assign x1m = x1[22:0];
  assign x2m = x2[22:0];

  wire [8:0] b256 = 8'b11111111;
  wire x1nan = x1e == b256 && x1m != 23'b0 ? 1'b1 : 1'b0;
  wire x2nan = x2e == b256 && x2m != 23'b0 ? 1'b1 : 1'b0;

  wire [7:0] w1e = x1e == 8'b0 ? 8'b1 : x1e;
  wire [7:0] w2e = x2e == 8'b0 ? 8'b1 : x2e;
  wire flag = w1e < w2e ? 1'b1 : 1'b0;
  wire [7:0] elarge = flag ? w2e : w1e;
  wire [7:0] esmall = flag ? w1e : w2e;
  wire [7:0] shift = elarge - esmall;
  wire [49:0] x1w;
  wire [49:0] x2w;
  wire [1:0] x1top = x1e == 8'b0 ? 2'b0 : 2'b1;
  wire [1:0] x2top = x2e == 8'b0 ? 2'b0 : 2'b1;
  wire [49:0] shifter = flag ? {x1top, x1m, 25'b0} : {x2top, x2m, 25'b0};
  wire [49:0] shifted = shifter >> shift;
  assign x1w = flag ? shifted : {x1top, x1m, 25'b0};
  assign x2w = flag ? {x2top, x2m, 25'b0} : shifted;
  wire comp = x1w < x2w ? 1'b1 : 1'b0;
  wire [49:0] xlarge = comp ? x2w : x1w;
  wire [49:0] xsmall = comp ? x1w : x2w;
  wire [49:0] temp = 
	  x1s[0] == x2s[0] ? x1w + x2w : xlarge - xsmall;
  wire ws =
	  x1s[0] && x2s[0] ? 1'b1 :
	  x1s[0] ? (comp ? 1'b0 : 1'b1) :
	  x2s[0] ? (comp ? 1'b1 : 1'b0) :
	  1'b0;

  wire [48:0] temp1 =
	  temp[49] ? temp[48:0] 		 :
	  temp[48] ? {temp[47:0], 1'b0}  :
	  temp[47] ? {temp[46:0], 2'b0}  :
	  temp[46] ? {temp[45:0], 3'b0}  :
	  temp[45] ? {temp[44:0], 4'b0}  :
	  temp[44] ? {temp[43:0], 5'b0}  :
	  temp[43] ? {temp[42:0], 6'b0}  :
	  temp[42] ? {temp[41:0], 7'b0}  :
	  temp[41] ? {temp[40:0], 8'b0}  :
	  temp[40] ? {temp[39:0], 9'b0}  :
	  temp[39] ? {temp[38:0], 10'b0} :
	  temp[38] ? {temp[37:0], 11'b0} :
	  temp[37] ? {temp[36:0], 12'b0} :
	  temp[36] ? {temp[35:0], 13'b0} :
	  temp[35] ? {temp[34:0], 14'b0} :
	  temp[34] ? {temp[33:0], 15'b0} :
	  temp[33] ? {temp[32:0], 16'b0} :
	  temp[32] ? {temp[31:0], 17'b0} :
	  temp[31] ? {temp[30:0], 18'b0} :
	  temp[30] ? {temp[29:0], 19'b0} :
	  temp[29] ? {temp[28:0], 20'b0} :
	  temp[28] ? {temp[27:0], 21'b0} :
	  temp[27] ? {temp[26:0], 22'b0} :
	  temp[26] ? {temp[25:0], 23'b0} : 
	  temp[25] ? {temp[24:0], 24'b0} : 
	  temp[24] ? {temp[23:0], 25'b0} : 49'b0;
	  
  wire [8:0] keta = flag ? {1'b0, w2e} : {1'b0, w1e};

  wire [8:0] minus = 
	  temp[49] ? 9'b111111111 : 
	  temp[48] ? 9'b0 	  : 
	  temp[47] ? 9'b1     :
	  temp[46] ? 9'b10    :
	  temp[45] ? 9'b11    :
	  temp[44] ? 9'b100   :
	  temp[43] ? 9'b101   :
	  temp[42] ? 9'b110   :
	  temp[41] ? 9'b111   :
	  temp[40] ? 9'b1000  :
	  temp[39] ? 9'b1001  :
	  temp[38] ? 9'b1010  :
	  temp[37] ? 9'b1011  :
	  temp[36] ? 9'b1100  :
	  temp[35] ? 9'b1101  :
	  temp[34] ? 9'b1110  :
	  temp[33] ? 9'b1111  :
	  temp[32] ? 9'b10000 :
	  temp[31] ? 9'b10001 :
	  temp[30] ? 9'b10010 :
	  temp[29] ? 9'b10011 :
	  temp[28] ? 9'b10100 :
	  temp[27] ? 9'b10101 :
	  temp[26] ? 9'b10110 : 
	  temp[25] ? 9'b10111 : 
	  temp[24] ? 9'b11000 : 9'b100000000;
  wire [8:0] temp2 = minus[8:7] == 2'b10 ? 9'b0 : keta - minus;

  wire [22:0] temp1top = temp1[48:26];
  wire [23:0] tempagari = {1'b0, temp1top};
  wire [23:0] ketaagari = 
	  temp1[25] ? 
	  	(temp1[24:0] == 25'b0 && temp1[26] == 0 ? tempagari : tempagari + 24'b1)
	  	: tempagari;
  assign y[30:23] = 
	  x1e == b256 || x2e == b256 ? b256 :
	  temp2[8] ? 8'b0 :
	  ketaagari[23] ? temp2[7:0] + 8'b1 : temp2[7:0];
  assign y[22:0] =
	  x2nan ? {1'b1, x2m[21:0]} :
	  x1nan ? {1'b1, x1m[21:0]} :
	  x1[30:0] == 31'b0 && x2[30:0] == 31'b0 ? 23'b0 :
	  x1e == b256 && x2e == b256 && x1s != x2s ? {1'b1, temp[47:26]} :
	  x1[30:0] == x2[30:0] && x1[31] != x2[31] ? 23'b0 :
	  y[30:23] == b256 ? 23'b0 :
	  temp2[8] ? {1'b1, temp1[48:27]} >> (9'b0 - temp2) :
	  temp2 == 9'b0 ? {1'b1, temp1[48:27]} :
	  temp1[25] ? 
	  	(temp1[24:0] == 25'b0 && temp1[26] == 0 ? temp1top : temp1top + 23'b1)
	  	: temp1top;
  assign y[31:31] = 
	  x1nan && x2nan ? x2s :
	  x1e == b256 && x2e == b256 && x1m == 23'b0 && x2m == 23'b0 && x1s != x2s ? 1'b1 :
	  y[30:0] == 31'b0 ? (x1[31] == 1'b1 && x2[31] == 1'b1 ? 1'b1 : 1'b0) : ws;

endmodule

`default_nettype wire
