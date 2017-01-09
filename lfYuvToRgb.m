function lf_rgb = lfYuvToRgb(lf_yuv,TD,SD,UD,VD)

    Y = double(lf_yuv(:,:,1,:,:)); 
    U = double(lf_yuv(:,:,2,:,:)); 
    V = double(lf_yuv(:,:,3,:,:)); 
    
    
    U = U - ones(TD,SD,1,UD,VD)*80;
    V = V - ones(TD,SD,1,UD,VD)*50;
    
    R = Y + 1.139834576 * V;
    G = Y -.3946460533 * U -.58060 * V;
    B = Y + 2.032111938 * U;
%     R(R>255) = 255;
%     G(G>255) = 255;
%     B(B>255) = 255;
%     R(R<0) = 0;
%     G(G<0) = 0;
%     B(B<0) = 0;

    disp(max(max(max(max(max((R)))))))
    disp(max(max(max(max(max((G)))))))
    disp(max(max(max(max(max((B)))))))
    disp(min(min(min(min(min((R)))))))
    disp(min(min(min(min(min((G)))))))
    disp(min(min(min(min(min((B)))))))
    lf_rgb = cat(3, uint8(R), uint8(G), uint8(B)); 
end