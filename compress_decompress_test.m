%% =1======================================================
% load lightfield (the last parameter is a scaling factor for the spatial resolution)
LF = ImportLF('./lightfields/legoknights-small_17x17/',17,[1,1],0.25);

% size of lightfield (dimension order as it is being loaded: S,T,c,U,V
[T,S,c,U,V] = size(LF);

%%

clc;
compressed_lf = compress(LF);

%%

LF_dec = decompress(compressed_lf, T, S, c, U, V);
LF_dec = cast(LF_dec, 'uint8');

%%

%max(max(max(max(max(LF-LF_dec)))))

im = RenderLF(LF_dec,0.25,2,-7,-7); 
figure,imshow(im);
title('image rendered from lightfield');

im2 = RenderLF(LF,0.25,2,-7,-7); 
figure,imshow(im2);
title('image rendered from lightfield');