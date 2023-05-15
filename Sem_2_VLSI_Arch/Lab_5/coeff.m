clear all

fileID = fopen('coeff.txt', 'w');
a(1) = fi(-0.0841,1,16,12);
a(2) = fi(-0.0567,1,16,12);
a(3) = fi( 0.1826,1,16,12);
a(4) = fi(0.4086,1,16,12);
a(5) = fi(0.4086,1,16,12);
a(6) = fi(0.1826,1,16,12);
a(7) = fi(-0.0567,1,16,12);
a(8) = fi(-0.0841,1,16,12);
for i=1:8
    fprintf (fileID,'%s\n', hex(a(i)));
end
fclose (fileID);
