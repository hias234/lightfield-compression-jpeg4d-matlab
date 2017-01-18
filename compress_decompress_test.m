
%% =1======================================================
% load lightfield (the last parameter is a scaling factor for the spatial resolution)
%LF = ImportLF('./lightfields/tarot_smallangle_17x17/',17,[1,1],0.1);
LF = ImportLF('./lightfields/legoknights-small_17x17/',17,[1,1],0.25);
%LF = ImportLF('./lightfields/sintel_lion_512_19x19/',19,[0,1],0.25);
%LF = ImportLF('./lightfields/sintel_cave_entrance_512_19x19/',19,[0,1],0.25);

% size of lightfield (dimension order as it is being loaded: S,T,c,U,V
[T,S,c,U,V] = size(LF);
%% compress

quality = 50;
blocksize_st = 4;
blocksize_uv = 6;
use_colorspace_conversion = true;
use_rle = false;
use_huffman = false;
use_subsampling_t = true;
clc;

disp('start compressing')
[compressed_lf, huffdict] = compress(LF, blocksize_st, blocksize_uv, quality, use_colorspace_conversion, use_subsampling_t, use_rle, use_huffman);
disp('compressed')
%% decompress

disp('start decompressing')
LF_dec = decompress(compressed_lf, blocksize_st, blocksize_uv, huffdict, quality, T, S, c, U, V, use_colorspace_conversion, use_subsampling_t, use_rle, use_huffman);
disp('decompressed')

max(max(max(max(max(LF-LF_dec)))))
nnz(compressed_lf)

im = RenderLF(LF_dec,0.25,2,-7,-7); 
figure,imshow(im);
title('comp image rendered from lightfield');

im2 = RenderLF(LF,0.25,2,-7,-7); 
figure,imshow(im2);
title('image rendered from lightfield');

im2 = RenderLF(abs(LF-LF_dec),0.25,2,-7,-7); 
figure,imshow(im2);
title('err rendered from lightfield');