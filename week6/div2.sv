module unsigned_div1(
    input [63:0] x1,
    input [31:0] d1,
    output [63:0] r1,
    output q1);

    wire [64:0] work = {x1,1'b0} - {d1, 32'b0};
    assign r1 = work[64] ? {x1[62:0], 1'b0} : work[63:0];
    assign q1 = ~work[64]; 
endmodule

module unsigned_div2(
    input [63:0] x2,
    input [31:0] d2,
    output [63:0] r2,
    output [1:0] q2);

    wire [63:0] work;
    unsigned_div1 div1_1(.x1(x2), .d1(d2), .r1(work), .q1(q2[1]));
    unsigned_div1 div1_2(.x1(work), .d1(d2), .r1(r2), .q1(q2[0]));
endmodule

module unsigned_div4(
    input [63:0] x4,
    input [31:0] d4,
    output [63:0] r4,
    output [3:0] q4);

    wire [63:0] work;
    unsigned_div2 div2_1(.x2(x4), .d2(d4), .r2(work), .q2(q4[3:2]));
    unsigned_div2 div2_2(.x2(work), .d2(d4), .r2(r4), .q2(q4[1:0]));
endmodule

module unsigned_div8(
    input [63:0] x8,
    input [31:0] d8,
    output [63:0] r8,
    output [7:0] q8);

    wire [63:0] work;
    unsigned_div4 div4_1(.x4(x8), .d4(d8), .r4(work), .q4(q8[7:4]));
    unsigned_div4 div4_2(.x4(work), .d4(d8), .r4(r8), .q4(q8[3:0]));
endmodule

module unsigned_div16(
    input [63:0] x16,
    input [31:0] d16,
    output [63:0] r16,
    output [15:0] q16);

    wire [63:0] work;
    unsigned_div8 div8_1(.x8(x16), .d8(d16), .r8(work), .q8(q16[15:8]));
    unsigned_div8 div8_2(.x8(work), .d8(d16), .r8(r16), .q8(q16[7:0]));
endmodule

module div32(
    input [63:0] x,
    input [31:0] d,
    output [31:0] r,
    output [31:0] q);

    wire [63:0] work1, work2;
    assign q = work2[63:32];
    unsigned_div16 div16_1(.x16(x), .d16(d), .r16(work1), .q16(r[31:16]));
    unsigned_div16 div16_2(.x16(work1), .d16(d), .r16(work2), .q16(r[15:0]));
endmodule
