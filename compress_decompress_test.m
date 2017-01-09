
%% =1======================================================
% load lightfield (the last parameter is a scaling factor for the spatial resolution)
LF = ImportLF('./lightfields/sintel_cave_entrance_512_19x19/',19,[1,1],0.25);

% size of lightfield (dimension order as it is being loaded: S,T,c,U,V
[T,S,c,U,V] = size(LF);
%% compress

quality = 50;
blocksize_st = 4;
blocksize_uv = 4;
use_rle = true;
use_huffman = false;
clc;

[compressed_lf, huffdict] = compress(LF, blocksize_st, blocksize_uv, quality, false, use_rle, use_huffman);
disp('compressed')
%% decompress

LF_dec = decompress(compressed_lf, blocksize_st, blocksize_uv, huffdict, quality, T, S, c, U, V, false, use_rle, use_huffman);
disp('decompressed')

max(max(max(max(max(LF-LF_dec)))))
nnz(compressed_lf)

im = RenderLF(LF_dec,0.25,2,-7,-7); 
figure,imshow(im);
title('image rendered from lightfield');

im2 = RenderLF(LF,0.25,2,-7,-7); 
figure,imshow(im2);
title('image rendered from lightfield');

