// Test Bench
module test_fir ();
  // Parameters declared
  parameter width = 'd16;
  parameter SF = 2.0**(-12);
  // Inputs, Outputs, wires and regs are declared
  reg signed [width-1:0] x_in;
  reg clk, reset;
  wire signed [width-1:0] y_out;
  reg signed [width-1:0] data_in[0:199];
  integer i, j, write_data, write_input;
  
  //DUT instantiation
  fir DUT (.x(x_in), .clk(clk), .reset(reset),.y(y_out));
  
  //clock signal
  always #5 clk = ~clk;
  
  //stimulus 
  initial
    begin
      x_in = 'h0;     
      drive_reset();
      $display("\n****Driving inputs from the file****\n");
      $readmemh("input.txt", data_in);
      for (i=0;i<200;i=i+1)
      	begin
          drive_input(data_in[i]);
          check_output();
      	end
      repeat(30) @ (negedge clk);
      $finish;     
    end
  
  //Waveform Generation
  initial 
    begin
      $dumpfile("dump.vcd");
      $dumpvars(0);
    end
  
  //Task for Resetting
  task drive_reset();
    clk = 0;
    reset = 1'b0;
    @(negedge clk)
    reset = 1'b1;
    @(negedge clk)
    reset = 1'b0;
  endtask
  
  //Task for Driving Input 
  task drive_input (input signed [15:0] data_in);
    @(negedge clk)
    x_in = data_in;
          write_input = $fopen("Input_tracker.txt","a");
          $fdisplay (write_input, "%f", $itor($signed(data_in*SF)));
          $fclose(write_input); 
  endtask
 
  //Task for Checking Output
  task check_output();
    begin
      @(y_out)
  		write_data = $fopen("Output_tracker.txt","a");
      $fdisplay (write_data, "%f", $itor(y_out*SF));
      $display("Input = %f & Output = %f", $itor($signed(data_in[i]*SF)), $itor(y_out*SF));
  		$fclose(write_data);  
   end 
  endtask

endmodule