clc;

test_mat = [    16 11 10 16 24 40 51 61;
                12 12 14 19 26 58 60 55;
                14 13 16 24 0 57 69 56;
                14 17 22 29 0 0 80 62; 
                18 22 37 56 68 109 103 77;
                24 35 55 64 81 104 113 0;
                49 64 78 87 103 0 0 0;
                72 92 95 98 112 0 0 0];
                
               
test_output = zig_zag_encode(test_mat);
disp(test_output)

dec = zig_zag_decode(test_output);
disp(dec)

isequal(dec, test_mat)