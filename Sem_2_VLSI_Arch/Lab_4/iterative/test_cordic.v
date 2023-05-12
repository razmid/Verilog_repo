// Testbench starts here
module test_cordic ();
  parameter width = 16;
  localparam SF = 2.0**(-14);
  reg signed [width-1:0] x_in, y_in, q_in;
  reg in_val, clk, reset;
  wire signed [width-1:0] cosq, sinq, q_out;
  wire out_val, ready; 
  reg [width-1:0] angle_data[0:9];
  integer i, write_data;
  //DUT instantiation
  CORDIC DUT (.x_in(x_in), .y_in(y_in), .in_val(in_val), .out_val(out_val), .q_in(q_in), .clk(clk), .reset(reset), .cosq(cosq), .sinq(sinq), .q_out(q_out), .ready(ready));
  //clock signal
  always #5 clk = ~clk;
  //stimulus 
  initial
    begin
      
      drive_reset();
      $readmemh("angle_hex.txt", angle_data);
      $display("Driving the inputs");
      for (i=0;i<9;i=i+1)
      begin
      
      drive_input(angle_data[i]);
      check_output(); 
       end
      $display("\n");
      //drive_input('h1657);
      //drive_input('h2183);
      //repeat(30) @ (negedge clk);
      $finish;     
    end
  //For Waveform Generation
  initial 
    begin
      $dumpfile("dump.vcd");
      $dumpvars(0);
    end
    //Task for resetting
  task drive_reset();
    $display("Driving the reset");
    clk = 0;
    reset = 1'b0;
    @(negedge clk)
    reset = 1'b1;
    @(negedge clk)
    reset = 1'b0;
  endtask
  //Task for driving one input
  task drive_input (input [15:0] theta_in);
    
    wait (ready==1)
    @(negedge clk)
    in_val = 1;
    x_in = 16'h26DD;
    y_in = 0;
    q_in = theta_in;
    @(negedge clk)
    in_val = 0;
    //repeat(20) @ (negedge clk);
  endtask
  task check_output();
   begin
     @ (posedge out_val)
     begin
     $display ("Cosine of angle %f degrees = %f, Sine of angle %f radians = %f ", $itor(q_in*SF*57.2958), $itor(cosq*SF), $itor(q_in*SF), $itor(sinq*SF)); 
   write_data = $fopen("Output_tracker.txt","a");
       $fdisplay (write_data, "Cosine of angle %f degrees = %f, Sine of angle %f radians = %f", $itor(q_in*SF*57.2958), $itor(cosq*SF), $itor(q_in*SF), $itor(sinq*SF));
  $fclose(write_data); 
      
     end
   end 
   endtask
    
    
endmodule
