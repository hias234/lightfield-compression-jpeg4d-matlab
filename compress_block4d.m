function compressed_block = compress_block4d(block4d)
% compresses a 4d-block 
% right now the block4d has to have a size of 64 - this should be
% adaptable!!! - DOMINIK :)
    
    block2d = map4dTo2d(block4d); %map 4d-block to 2d
    block2d = double(block2d); % convert uint8 types to double
    
    block2d = block2d - 128; % shift mean to zero
    
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

    block2d_dct = dct2(block2d); % apply a 2-dimensional dct-transformation
    block2d_quantized = block2d_dct ./ QX; % quantize dct-coefficients using the quantization matrix
    
    block2d_zigzag = zig_zag_encode(block2d_quantized);
   
    compressed_block = int8(round(block2d_zigzag));
    
end