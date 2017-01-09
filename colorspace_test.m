
%% =1======================================================
% load lightfield (the last parameter is a scaling factor for the spatial resolution)
%LF = ImportLF('./lightfields/tarot_smallangle_17x17/',17,[1,1],1.0);
LF = ImportLF('./lightfields/legoknights-small_17x17/',17,[1,1],0.2);
%LF = ImportLF('./lightfields/sintel_lion_512_19x19/',19,[0,1],0.25);
%LF = ImportLF('./lightfields/sintel_cave_entrance_512_19x19/',19,[0,1],0.25);

% size of lightfield (dimension order as it is being loaded: S,T,c,U,V
[T,S,c,U,V] = size(LF);
%% toyuv

yuv = lfRgbToYuv(LF);
disp('yuved')
%% decompress

LF_dec = lfYuvToRgb(yuv);
disp('rgbed')

max(max(max(max(max(LF-LF_dec)))))

im = RenderLF(LF_dec,0.25,2,-7,-7); 
figure,imshow(im);
title('image rendered from lightfield');

im2 = RenderLF(LF,0.25,2,-7,-7); 
figure,imshow(im2);
title('image rendered from lightfield');

