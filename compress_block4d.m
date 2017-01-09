function compressed_block = compress_block4d(block4d, QX)
% compresses a 4d-block 
% QX - quantization matrix
% right now the block4d has to have a size of 64 - this should be
% adaptable
    
    block2d = map4dTo2d(block4d); %map 4d-block to 2d
    block2d = double(block2d); % convert uint8 types to double
    
    block2d = block2d - 128; % shift mean to zero

    block2d_dct = dct2(block2d); % apply a 2-dimensional dct-transformation
    block2d_quantized = block2d_dct ./ QX; % quantize dct-coefficients using the quantization matrix
    
    block2d_zigzag = zig_zag_encode(block2d_quantized);
    
    if block2d_zigzag(1) < -128 || block2d_zigzag(1) > 128
        disp(block2d_zigzag(1))
    end
    
    compressed_block = int16(round(block2d_zigzag));
    
end