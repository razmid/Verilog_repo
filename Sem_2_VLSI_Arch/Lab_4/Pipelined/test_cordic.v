// Testbench starts here
module test_cordic ();
  localparam width = 16;
  localparam SF = 2.0**(-14);
  reg signed [width-1:0] x_in, y_in, q_in;
  reg clk, reset, mode;
  wire signed [width-1:0] cosq, sinq, q_out;
  reg [width-1:0] angle_data[0:9];
  reg [width-1:0] data [0:2][0:2];
  integer i, j, write_data;
  
  //DUT instantiation
  cordic DUT (.x(x_in), .y(y_in), .q(q_in), .clk(clk), .reset(reset), .mode(mode), .cosq(cosq), .sinq(sinq), .qout(q_out));
  
  //clock signal
  always #5 clk = ~clk;
  
  //stimulus 
  initial
    begin
      x_in = 'h0;
      y_in = 'h0;
      q_in = 'h0;
      mode = 1'b0;
      drive_reset();
      $display("\n****Driving inputs with Rotation Mode****\n");
      $readmemh("angle_hex.txt", angle_data);
      for (i=0;i<9;i=i+1)
      	begin
      		drive_input_rot(angle_data[i]);
      	end
      repeat(8) @ (posedge clk);
      check_output_rot();
      $display("\n****Driving inputs with Vector Mode****\n");
      mode = 1'b1;
      $readmemh("vec_hex.txt", data);
      for (i=0;i<3;i=i+1)
      	begin
        	drive_input_vec(data[i][0], data[i][1], data[i][2]);
      	end
      repeat(14) @ (posedge clk);
      check_output_vec();
      repeat(30) @ (negedge clk);
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
    clk = 0;
    reset = 1'b0;
    @(negedge clk)
    reset = 1'b1;
    @(negedge clk)
    reset = 1'b0;
  endtask
  
  //Task for driving input in Rotation Mode
  task drive_input_rot (input [15:0] theta_in);
    @(negedge clk)
    x_in = 16'h26DD;
    y_in = 0;
    q_in = theta_in;
  endtask
  
  //Task for driving input in Vector Mode
  task drive_input_vec (input [15:0] x, y, theta_in);
    @(negedge clk)
    x_in = x;
    y_in = y;
    q_in = theta_in;
  endtask
  
  //Task for Checking output in Rotation Mode  
  task check_output_rot();
   for (j=0;j<9;j=j+1)
  	begin
   		@(posedge clk)
  		$display ("Cosine of angle %f degrees = %f, Sine of angle %f radians = %f ", $itor(angle_data[j]*SF*57.2958), $itor(cosq*SF), $itor(angle_data[j]*SF), $itor(sinq*SF)); 
   		write_data = $fopen("Output_tracker.txt","a");
  		$fdisplay (write_data, "Cosine of angle %f degrees = %f, Sine of angle %f radians = %f ", $itor(angle_data[j]*SF*57.2958), $itor(cosq*SF), $itor(angle_data[j]*SF), $itor(sinq*SF));
  		$fclose(write_data);  
   end 
  endtask
  
  //Task for Checking output in Vector Mode  
  task check_output_vec();
    for (j=0;j<3;j=j+1)
  	begin
   		@(posedge clk)
      $display ("The Magnitude of x %f and y %f = %f and angle = %f radians", $itor(data[j][0]*SF/0.607239), $itor(data[j][1]*SF/0.607239), $itor(cosq*SF), $itor(q_out*SF)); 
    end
    $display("\n");
 endtask

endmodule