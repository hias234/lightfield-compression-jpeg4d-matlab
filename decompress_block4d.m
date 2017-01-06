function decompressed_block = decompress_block4d(block1d, QX)
% decompresses a 4d-block 

    % block2d = reshape(block1d, [8,8]); % TODO this may needs to be changed... DOMINIK
    block2d = zig_zag_decode(block1d);
    block2d = double(block2d);

    block2d_dequantized = block2d .* QX; % quantize dct-coefficients using the quantization matrix
    block2d_idct = idct2(block2d_dequantized); % apply a 2-dimensional dct-transformation
    
    block2d_idct = block2d_idct + 128; % reverse the shift done in compress
    
    decompressed_block = map2dTo4d(block2d_idct, 4, 4, 2, 2); % TODO dimensions are hard coded...
    decompressed_block = uint8(decompressed_block); % TODO maybe round before - has to be tested...
end