// Code your testbench here
// or browse Examples

`timescale 1ns/1ns
module testbench;
  parameter SF = 2.0**(-12);
  // Reg Declarations
  reg clk, reset, mode;
  reg signed [15:0] x[0:7][0:1];
  reg signed [15:0] data_in[0:7][0:1];
  reg [15:0] reall, imag;
  //Wire Declarations (Output)
  wire signed [15:0] y[0:7][0:1];
  //Integer declarations
  integer i, write_data;
  //DUT instantiation
  dit_fft_8 dit_fft_8_test(.clk(clk),.mode(mode),.reset(reset),.x(x),.y(y));
  //Clock Period set as perameter 
  parameter clkper = 10;
// Initializations
  initial
    begin
        clk = 1;
        reset = 0;
        mode = 0;
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
  //Dumping the variables for Waveform Generation  
  initial 
    begin
        $dumpfile("dump.vcd");
        $dumpvars(0);
    end
  //Stimulus Generation
  initial
   begin
     drive_reset();
     $display("\n Operating in FFT Mode ");
     $readmemh("input1.txt", data_in);
     drive_input(data_in);
     check_output();
     $readmemh("input2.txt", data_in);
     drive_input(data_in);
     check_output();
     #100
     $finish;    
    end
  //Task for Driving the inputs  
  task drive_input (input signed [15:0] data_in [0:7][0:1]);
    begin
        @(negedge clk)
            x = data_in;
            $display("\n Driving a new Data to FFT Module \n");
            for (i=0;i<8;i=i+1) 
                begin
                    reall = data_in[i][0];
                    imag = data_in[i][1];
                    $display("x[%0d] = %f + j%f ", i, $itor(($signed(reall)*SF)), $itor(($signed(imag)*SF)));
                end
    end
  endtask
  //Task to Print the outputs to the console and to a file
  task check_output();
    begin
      repeat(2) @(posedge clk);
      @(posedge clk)
      begin
        write_data = $fopen("Output_tracker1.txt","a");
        $display("\n Obtained the Output From FFT Module \n");
        for (i=0;i<8;i=i+1) 
            begin
                reall = y[i][0];
                imag = y[i][1];
                $fdisplay (write_data, "%f %f", $itor($signed(reall)*SF), $itor($signed(imag)*SF));
                $display("y(%0d) = %f + j%f ", i, $itor($signed(reall)*SF), $itor($signed(imag)*SF));
            end
        $display();
        $fclose(write_data);
      end
    end
  endtask
  //Task for driving the reset
  task drive_reset();
    begin
      @(negedge clk)
        reset = 1'b1;
      @(negedge clk)
        reset = 1'b0;
    end
  endtask  
  		
endmodule
