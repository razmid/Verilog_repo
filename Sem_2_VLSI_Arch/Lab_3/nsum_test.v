//Test Bench starts here
module nsum_test;
  //Inputs to the Models are declared as reg here
  reg [2:0] N, N_gen;
  reg clk,reset, N_valid;
  //Outputs from the models are declared as wire here
  wire [7:0] sum, out_behav;
  wire sum_valid;
  //Iterative variable declared here
  integer i;
  //DUT instantiation 
  NSUM model_1(.N(N), .clk(clk), .reset(reset), .N_valid(N_valid), .sum_valid(sum_valid), .sum(sum));
  //Functional model instantiation
  NSUM_behav nsum_behav1(.N(N), .Y(out_behav));
  //Clock streaming starts here
  always 
    #5 clk = ~clk;
  //Value changes in the nets and registers are dumped for viewing
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0);
  end
  //Stimulus applied here
  initial 
    begin 
      drive_reset();
      for (i=5; i>0; i--)
        begin
      		N_gen = $urandom % 8;
      		drive_input(N_gen);
     		check_output();
        end
      repeat(15)@(negedge clk);    
      $finish;
    end
  // Task for driving reset
  task drive_reset();
    $display ("Driving the reset");
    clk = 1'b0;
    N_valid = 1'b0;
    @ (negedge clk)
    reset = 0;
    @ (negedge clk)
    reset = 1;
    @ (negedge clk)
    reset = 0;
  endtask 
  // Task for driving the inputs
  task drive_input(input [2:0] N_gen);
    @ (negedge clk)
    begin
        N_valid = 1;
        N = N_gen;
      $display("Driving with %d ", N);
    end
    @ (negedge clk)
    	N_valid = 0;
  endtask 
  //Task for Checking the output 
  task check_output();
    $display("Waiting for sum_valid");
    @ (posedge sum_valid)
    begin
    	$display ("Recieved sum Valid");
    	if(sum == out_behav)
      		$display ("Test Succeeded");
    	else
      		$display("Test failed");
    end
    repeat(15)@(negedge clk); 
  endtask 
endmodule 