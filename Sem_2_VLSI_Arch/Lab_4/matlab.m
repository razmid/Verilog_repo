clear all
fileID = fopen('angle_hex.txt', 'w');
for i=1:10
    angle(i) = fi(pi/18*i,1,16,14);
    fprintf (fileID,'%s\n', hex(angle(i)));
end
for j=1:16
    cordic_angle(j) =fi(atan(2 .^ (-(j-1))),1,16,14);
end
fclose (fileID);