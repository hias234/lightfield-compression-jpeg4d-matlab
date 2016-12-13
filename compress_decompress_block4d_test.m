%% =1======================================================
% load lightfield (the last parameter is a scaling factor for the spatial resolution)
LF = ImportLF('./lightfields/legoknights-small_17x17/',17,[1,1],0.1);

% size of lightfield (dimension order as it is being loaded: S,T,c,U,V
[T,S,c,U,V] = size(LF);

%%

clc;

block4d = squeeze(LF(1:4,1:4,1,1:2,1:2));

compressed = compress_block4d(block4d);
disp(compressed)

decompressed = decompress_block4d(compressed);
disp(decompressed)

disp(double(block4d) - decompressed)