function decompressed = decompress(compressed, huffdict, T,S,c,U,V, useYuvConversion, useRLE, useHuffman)
    % decompresses a lightfield :)
    if useHuffman
        compressed = huffmandeco(compressed, huffdict);
    end
    if useRLE
       compressed = rl_decode(compressed);
    end
    blocksize_st = 4;
    blocksize_uv = 2;
    blocksize = blocksize_st*blocksize_st*blocksize_uv*blocksize_uv;
    
    decompressed = zeros(T,S,c,U,V,'uint8');
    
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
                        decompressed_block4d = decompress_block4d(compressed_block1d);
                        
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