function lf_rgb = lfYuvToRgb(lf_yuv)
    Y = lf_yuv(:,:,1,:,:); 
    U = lf_yuv(:,:,2,:,:); 
    V = lf_yuv(:,:,3,:,:); 
    R = Y + 1.139834576 * V;
    G = Y -.3946460533 * U -.58060 * V;
    B = Y + 2.032111938 * U;
    lf_rgb = cat(3, R, G, B) / 255; 
end