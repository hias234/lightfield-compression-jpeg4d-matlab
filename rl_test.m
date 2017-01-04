clc;

test_array = [ 3, 3, 3, 3, 5, 6, 6, 0, 0, 0, 0, 1, 4, 5, 5, 0, 1, 0, 0, 0, 0 ];
                
               
test_output = rl_encode(test_array);
disp(test_output)

dec = rl_decode(test_output);
disp(dec)
 
isequal(dec, test_mat)