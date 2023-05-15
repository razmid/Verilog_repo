clear all
%x = zeros[1:200];
fileinput = fopen('Input_tracker.txt', 'r');
x = fscanf(fileinput, '%f');
fclose (fileinput);
xreg = zeros(1:8);
filecoef = fopen('coefficients.txt', 'r');
coef = fscanf(filecoef, '%f');
fclose(filecoef);
y=[];
for i = 1:200
    xreg = [x(i),xreg(1:7)];
    y = [y;dot(xreg, coef)];
end
file_ID1 = fopen ('Input_tracker.txt', 'r');
A = fscanf (file_ID1,'%f');
fclose (file_ID1);
file_ID2 = fopen ('Output_tracker.txt', 'r');
B = fscanf (file_ID2,'%f');
fclose (file_ID2);
err = abs(y-B);
if (err<0.001)
    disp('Verilog & Matlab Outputs are Matching');
else
    disp('Verilog & Matlab Outputs are not matching'); 
end
tiledlayout(3,1)
nexttile
stem(A);
title('Input Data')
xlabel('Samples')
ylabel('Amplitude')
nexttile
stem(B,'r');
title('Output Data from Verilog')
xlabel('Samples')
ylabel('Amplitude')
nexttile
stem(y, 'b');
title('Output Data from Matlab')
xlabel('Samples')
ylabel('Amplitude')