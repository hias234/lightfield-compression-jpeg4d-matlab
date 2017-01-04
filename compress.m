function [compressed, huffdict] = compress(LF)
% compresses a lightfield :)
    
    LF = lfRgbToYuv(LF);
    % size of lightfield (dimension order as it is being loaded: S,T,c,U,V
    [T,S,c,U,V] = size(LF);

    blocksize_st = 4;
    blocksize_uv = 2;
    
    compressed = [];
    
    for color=1:c
        LF_c = squeeze(LF(:,:,color,:,:));
        
        for t=1:blocksize_st:T
            t_to=min([t+blocksize_st-1, T]);
            
            for s=1:blocksize_st:S
                s_to=min([s+blocksize_st-1, S]);
            
                for u=1:blocksize_uv:U
                    u_to=min([u+blocksize_uv-1, U]);
                
                    for v=1:blocksize_uv:V
                        v_to=min([v+blocksize_uv-1, V]);
                        
                        block4d = zeros(4,4,2,2);
                        block4d(1:t_to-t+1,1:s_to-s+1,1:u_to-u+1,1:v_to-v+1) = LF_c(t:t_to,s:s_to,u:u_to,v:v_to);
                        compressed_block1d = compress_block4d(block4d);
                        
                        compressed = [compressed compressed_block1d];
                    end
                end
            end
        end
    end
    huffdict = 0;
    %[compressed, huffdict] = huffman_encode(compressed);
end