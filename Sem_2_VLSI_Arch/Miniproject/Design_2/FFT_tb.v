`timescale 1ns/1ns
// Test Bench 
module testbench;
  //scaling Factor
  parameter SF = 2.0**(-12);
  //Input output to the DUT declared
  reg clk, reset;
  reg signed [15:0] x[0:7][0:1];
  reg signed [15:0] data_in[0:7][0:1];
  wire signed [15:0] y[0:7][0:1];
  
  reg [15:0] reall, imag;
  integer i, write_data;
  //DUT instantiation
  dit_fft_8 dit_fft_8_test(.clk(clk),.reset(reset),.x(x),.y(y));
  //clock period 
  parameter clkper = 10;
  //stimulus initialization
initial
   begin
    clk = 1;
    reset = 0;
            for (i=0;i<8;i=i+1)
            begin 
                x[i][0] = 16'sh0000;
                x[i][1] = 16'sh0000;
            end
   end
  //Clock Generation
always
   begin
      #(clkper/2) clk = ~clk;
   end
  //Dump all variables for wave generation
initial 
  begin
    $dumpfile("dump.vcd");
    $dumpvars(0);
  end
  //Stimulus application
initial
   begin
     drive_reset();
     $readmemh("input1.txt", data_in);
     drive_input(data_in);
     check_output();
     $readmemh("input2.txt", data_in);
     drive_input(data_in);
     check_output();
  
  #100
  $finish;    
  end
  //Task to Drive a new input
  task drive_input (input signed [15:0] data_in [0:7][0:1]);
    @(negedge clk)
    x = data_in;
    $display("Driving a new Data to FFT Module \n");
    for (i=0;i<8;i=i+1) 
      begin
      reall = data_in[i][0];
      imag = data_in[i][1];
        $display("x[%0d] = %f + %fj \n", i, $itor(($signed(reall)*SF)), $itor(($signed(imag)*SF)));
      end
  endtask
  //Task to Write the output to a file
  task check_output();
    begin
    repeat(4)@(posedge clk);
      @(posedge clk)
      write_data = $fopen("Output_tracker.txt","a");
      $display("Obtained the Output From FFT Module \n");
    for (i=0;i<8;i=i+1) 
        begin
        reall = y[i][0];
        imag = y[i][1];
         $fdisplay (write_data, "%f %f", $itor($signed(reall)*SF), $itor($signed(imag)*SF));
         $display("y(%0d) = %f + %fj \n", i, $itor($signed(reall)*SF), $itor($signed(imag)*SF));
        end
        $fclose(write_data); 
    end
  endtask
  //Task to drive the reset
  task drive_reset();
    begin
      @(negedge clk)
        reset = 1'b1;
      @(negedge clk)
        reset = 1'b0;
    end
  endtask  
  		
endmodule
