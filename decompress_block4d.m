function decompressed_block = decompress_block4d(block1d)
% decompresses a 4d-block 

    block2d = reshape(block1d, [8,8]); % TODO this may needs to be changed... DOMINIK
    block2d = double(block2d);
    
    % Standard JPEG quantization matrix
    Q50 = double([  16 11 10 16 24 40 51 61;
                    12 12 14 19 26 58 60 55;
                    14 13 16 24 40 57 69 56;
                    14 17 22 29 51 87 80 62; 
                    18 22 37 56 68 109 103 77;
                    24 35 55 64 81 104 113 92;
                    49 64 78 87 103 121 120 101;
                    72 92 95 98 112 100 103 99]);
                
    QX = Q50; % TODO here a different matrix according to quality settings can be applied

    block2d_dequantized = block2d .* QX; % quantize dct-coefficients using the quantization matrix
    block2d_idct = idct2(block2d_dequantized); % apply a 2-dimensional dct-transformation
    
    block2d_idct = block2d_idct + 128; % reverse the shift done in compress
    
    decompressed_block = map2dTo4d(block2d_idct, 4, 4, 2, 2); % TODO dimensions are hard coded...
    decompressed_block = uint8(decompressed_block); % TODO maybe round before - has to be tested...
end