function lf_yuv = lfRgbToYuv(LF)

    R = double(LF(:,:,1,:,:)); %double??? http://stackoverflow.com/questions/19555372/convert-rgb-image-to-yuv-and-convert-back-in-matlab
    G = double(LF(:,:,2, :, :)); 
    B = double(LF(:,:,3,:,:)); 
    Y = 0.299 * R + 0.587 * G + 0.114 * B;
    U = -0.14713 * R - 0.28886 * G + 0.436 * B;
    V = 0.615 * R - 0.51499 * G - 0.10001 * B;
    
    U = U + ones(128,128, 1,17,17)*80;
    V = V + ones(128,128,1,17,17)*50;
%     Y(Y>255) = 255;
%     U(U>255) = 255;
%     V(V>255) = 255;
%     Y(Y<0) = 0;
%     U(U<0) = 0;
%     V(V<0) = 0;

    disp(max(max(max(max(max((Y)))))))
    disp(max(max(max(max(max((U)))))))
    disp(max(max(max(max(max((V)))))))
    disp(min(min(min(min(min((Y)))))))
    disp(min(min(min(min(min((U)))))))
    disp(min(min(min(min(min((V)))))))
    lf_yuv = cat(3,Y,U,V); 
    
    %Code unterhalb mit normalem bild funktioniert 
%     RGB = imread('./lightfields/legoknights-small_17x17/out_00_00_-381.909271_1103.376221.png');
% 
% R = double(RGB(:,:,1));
% G = double(RGB(:,:,2));
% B = double(RGB(:,:,3));
% 
% Y = 0.299 * R + 0.587 * G + 0.114 * B;
% U = -0.14713 * R - 0.28886 * G + 0.436 * B;
% V = 0.615 * R - 0.51499 * G - 0.10001 * B;
% 
% R = Y + 1.139834576 * V;
% G = Y -.3946460533 * U -.58060 * V;
% B = Y + 2.032111938 * U;
% 
% RGB2 = cat(3,R,G,B) /255;
% figure, imshow(RGB); 
% figure, imshow(RGB2); 

end