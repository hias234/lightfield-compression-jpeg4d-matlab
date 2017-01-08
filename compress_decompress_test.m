
%% =1======================================================
% load lightfield (the last parameter is a scaling factor for the spatial resolution)
LF = ImportLF('./lightfields/legoknights-small_17x17/',17,[1,1],0.1);

% size of lightfield (dimension order as it is being loaded: S,T,c,U,V
[T,S,c,U,V] = size(LF);
%% compress

quality = 20;
clc;

[compressed_lf, huffdict] = compress(LF, 4, 2, quality, false, true, false);
disp('compressed')
%% decompress

LF_dec = decompress(compressed_lf, 4, 2, huffdict, quality, T, S, c, U, V, false, true, false);
disp('decompressed')

max(max(max(max(max(LF-LF_dec)))))
nnz(compressed_lf)

im = RenderLF(LF_dec,0.25,2,-7,-7); 
figure,imshow(im);
title('image rendered from lightfield');

im2 = RenderLF(LF,0.25,2,-7,-7); 
figure,imshow(im2);
title('image rendered from lightfield');

