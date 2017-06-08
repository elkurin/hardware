`timescale 1ns / 100ps
`default_nettype none

module test_fadd();
   wire [31:0] x1,x2,y;
   wire        ovf;
   logic [31:0] x1i,x2i;
   shortreal    fx1,fx2,fy;
   int          i,j,k,it,jt;
   bit [22:0]   m1,m2;
   bit [9:0]    dum1,dum2;
   logic [31:0] fybit;
   int          s1,s2;
   logic [23:0] dy;
   bit [22:0] tm;

   assign x1 = x1i;
   assign x2 = x2i;
   
   fadd u1(x1,x2,y,ovf);

  int o;
  int b;
   initial begin
      // $dumpfile("test_fadd.vcd");
      // $dumpvars(0);

      for (i=0; i<256; i++) begin
         for (j=0; j<256; j++) begin
            for (s1=0; s1<2; s1++) begin
               for (s2=0; s2<2; s2++) begin
                  for (it=0; it<8; it++) begin
                     for (jt=0; jt<8; jt++) begin
                        #1;

                        case (it)
                          0 : m1 = 23'b0;
                          1 : m1 = {22'b0,1'b1};
                          2 : m1 = {21'b0,2'b10};
                          3 : m1 = {1'b0,3'b111,19'b0};
                          4 : m1 = {1'b1,22'b0};
                          5 : m1 = {2'b10,{21{1'b1}}};
                          6 : m1 = {23{1'b1}};
                          default : begin
                             if (i==256) begin
                                {m1,dum1} = 0;
                             end else begin
                                {m1,dum1} = $urandom();
                             end
                          end
                        endcase

                        case (jt)
                          0 : m2 = 23'b0;
                          1 : m2 = {22'b0,1'b1};
                          2 : m2 = {21'b0,2'b10};
                          3 : m2 = {1'b0,3'b111,19'b0};
                          4 : m2 = {1'b1,22'b0};
                          5 : m2 = {2'b10,{21{1'b1}}};
                          6 : m2 = {23{1'b1}};
                          default : begin
                             if (i==256) begin
                                {m2,dum2} = 0;
                             end else begin
                                {m2,dum2} = $urandom();
                             end
                          end
                        endcase
                        
                        x1i = {s1[0],i[7:0],m1};
                        x2i = {s2[0],j[7:0],m2};

                        fx1 = $bitstoshortreal(x1i);
                        fx2 = $bitstoshortreal(x2i);
                        fy = fx1 + fx2;
                        fybit = $shortrealtobits(fy);
                        
                        #1;

                        if (y !== fybit) begin
						   $display("x1 = %b\n", x1);
						   $display("x2 = %b\n", x2);
                           $display("%e %b\n", fy, $shortrealtobits(fy));
                           $display("%e %b\n", $bitstoshortreal(y), y);
						   //$display("BAD\n");
						   b++;
						end
						if (y == fybit) begin
						   //$display("OK\n");
						   o++;
                        end
                     end
                  end
               end
            end
         end
      end

      for (i=0; i<255; i++) begin
         for (s1=0; s1<2; s1++) begin
            for (s2=0; s2<2; s2++) begin
               for (j=0;j<23;j++) begin
                  //repeat(10) begin
                     #1;

                     {m1,dum1} = $urandom();
                     x1i = {s1[0],i[7:0],m1};
                     {m2,dum2} = $urandom();
                     for (k=0;k<j;k++) begin
                        tm[k] = m2[k];
                     end
                     for (k=j;k<23;k++) begin
                        tm[k] = m1[k];
                     end
                     x2i = {s2[0],i[7:0],tm};

                     fx1 = $bitstoshortreal(x1i);
                     fx2 = $bitstoshortreal(x2i);
                     fy = fx1 + fx2;
                     fybit = $shortrealtobits(fy);
                     
                     #1;

                     if (y !== fybit) begin
                        $display("x1 = %b\n", x1);
                        $display("x2 = %b\n", x2);
                        $display("%e %b\n", fy, $shortrealtobits(fy));
                        $display("%e %b\n", $bitstoshortreal(y), y);
					    //$display("BAD\n");
						b++;
					 end
					 if (y == fybit) begin
					    //$display("OK\n");
						o++;
                     end
                  //end
               end
            end
         end
      end
      $finish;
   end
   //$display("OK : %b\n", o);
   //$display("BAD : %b\n", b);
endmodule

`default_nettype wire