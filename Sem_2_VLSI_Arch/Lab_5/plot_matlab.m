clear all;
file_ID1 = fopen ('Input_tracker.txt', 'r');
A = fscanf (file_ID1,'%f');
fclose (file_ID1);
%plot(A);

file_ID2 = fopen ('Output_tracker.txt', 'r');
B = fscanf (file_ID2,'%f');
fclose (file_ID2);
%plot(B);
tiledlayout(2,1)
nexttile
stem(A);
title('Input Data')
xlabel('Samples')
ylabel('Amplitude')
nexttile
stem(B);
title('Output Data')
xlabel('Samples')
ylabel('Amplitude')

