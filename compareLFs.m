function [ compression_result ] = compareLFs(LF1, LF2, lf2CompressedSizeInBytes)
%COMPARELFS Summary of this function goes here
%   Detailed explanation goes here

    % size of lightfield (dimension order as it is being loaded: S,T,c,U,V
    [T,S,c,U,V] = size(LF1);
    
    qssimSum = 0;
    
     for u=1:1:U
        for v=1:1:V
            img1 = RenderLF(LF1,0.25,2, u - U / 2, v - V / 2);
            img2 = RenderLF(LF2,0.25,2, u - U / 2, v - V / 2);
            qssimSum = qssimSum + qssim(img1, img2);
        end
     end

     compressionFactor = (T * S * c * U * V) / lf2CompressedSizeInBytes;
     
     compression_result = (qssimSum / (U * V)) * compressionFactor;
end

