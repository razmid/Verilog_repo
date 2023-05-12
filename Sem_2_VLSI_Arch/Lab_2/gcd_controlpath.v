// GCD Controlpath

module gcd_controlpath(input clk,reset,ack,b_eq_0,A_lt_B,op_valid, output reg [1:0] A_mux_sel, output reg B_mux_sel, A_en, B_en, output gcd_valid);
  // Parameter declarations (State values)
 parameter IDLE = 2'b00;
 parameter BUSY = 2'b01;
 parameter DONE = 2'b10;
 //State register declaration 
 reg [1:0] state = 2'b0;
 reg [1:0] next_state;
  //Next state logic (Combinational)
 always @(*)
 begin
   case (state)
  	IDLE:
      begin
      A_mux_sel = 2'b00;
      B_mux_sel = 1'b0;
      A_en = 1'b1;
      B_en = 1'b1;
      if (op_valid)
       	     next_state = BUSY;
      end
    BUSY:
       begin
       if(b_eq_0)
             next_state = DONE ;
       if(A_lt_B)
         begin
         	 A_mux_sel = 2'b10;
     		 B_mux_sel = 1'b1;
     		 A_en = 1'b1;
     		 B_en = 1'b1;
         end
       else
         begin
         	 A_mux_sel = 2'b01;
     		 A_en = 1'b1;
     		 B_en = 1'b0;
         end
       end
    DONE:
       begin
       A_en = 1'b0;
       B_en = 1'b0;
       if(ack)
             next_state = IDLE;
       end
    default:
             next_state = IDLE;
   endcase
 end
  //Sequential part (State Register)	
  always @(posedge clk or posedge reset)
    begin
      if (reset)
        state <= IDLE;
      else
        state <= next_state;
    end
  //Qualifier assignment
  assign gcd_valid = (state[1]);
  
endmodule