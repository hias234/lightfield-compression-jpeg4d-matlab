function decompressed = decompress(compressed, blocksize_st, blocksize_uv, huffdict, quality, T,S,c,U,V, useYuvConversion, useRLE, useHuffman)
    % decompresses a lightfield :)
    if useHuffman
        compressed = huffmandeco(compressed, huffdict);
    end
    if useRLE
       compressed = rl_decode(compressed);
    end

    blocksize = blocksize_st*blocksize_st*blocksize_uv*blocksize_uv;
    disp(length(compressed))
    disp(length(compressed)/blocksize)
    
    decompressed = zeros(T,S,c,U,V,'uint8');
    
    % Standard JPEG quantization matrix
    Q50 = double([  16 11 10 16 24 40 51 61;
                    12 12 14 19 26 58 60 55;
                    14 13 16 24 40 57 69 56;
                    14 17 22 29 51 87 80 62; 
                    18 22 37 56 68 109 103 77;
                    24 35 55 64 81 104 113 92;
                    49 64 78 87 103 121 120 101;
                    72 92 95 98 112 100 103 99]);
    if blocksize == 256
        Q50 = repelem(Q50, 2, 2); %repeat quantization matrix elements to match blocksize
        Q50(1, 1) = Q50(1, 1) * 1.4;
        %Q50(8:16, 8:16) = 255;
    end
    if blocksize == 1024
        Q50 = repelem(Q50, 4, 4); %repeat quantization matrix elements to match blocksize
        Q50(1,1) = Q50(1,1) * 2.0;
    end
    if blocksize == 4096
        Q50 = repelem(Q50, 8, 8); %repeat quantization matrix elements to match blocksize
        Q50(1,1) = Q50(1,1) * 4.0;
    end
    if blocksize == 6400
        Q50 = repelem(Q50, 10, 10); %repeat quantization matrix elements to match blocksize
        Q50(1,1) = Q50(1,1) * 7.0;
    end
    
    if quality > 50
        QX = round(Q50.*(ones(size(Q50, 1))*((100-quality)/50)));
    elseif quality < 50
        QX = round(Q50.*(ones(size(Q50, 1))*(50/quality)));
    elseif quality == 50
        QX = Q50;
    end
    
    index = 1;
    for color=1:c
        for t=1:blocksize_st:T
            t_to=min([t+blocksize_st-1, T]);
            
            for s=1:blocksize_st:S
                s_to=min([s+blocksize_st-1, S]);
            
                for u=1:blocksize_uv:U
                    u_to=min([u+blocksize_uv-1, U]);
                
                    for v=1:blocksize_uv:V
                        v_to=min([v+blocksize_uv-1, V]);
                        compressed_block1d = compressed(index:index+blocksize-1);
                        decompressed_block4d = decompress_block4d(compressed_block1d, blocksize_st, blocksize_uv, QX);
                        
                        decompressed(t:t_to,s:s_to,color,u:u_to,v:v_to) = decompressed_block4d(1:t_to-t+1,1:s_to-s+1,1:u_to-u+1,1:v_to-v+1); % TODO
                        
                        index = index+blocksize;
                    end
                end
            end
        end
    end
    
    if useYuvConversion
        decompressed = lfYuvToRgb(decompressed);
    end
end