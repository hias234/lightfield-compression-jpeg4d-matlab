%% =1======================================================
% load lightfield (the last parameter is a scaling factor for the spatial resolution)
LF = ImportLF('./lightfields/legoknights-small_17x17/',17,[1,1],0.1);

% size of lightfield (dimension order as it is being loaded: S,T,c,U,V
[T,S,c,U,V] = size(LF);

%% Test mapping functions

clc;

block4d = squeeze(LF(1:4,1:4,1,1:2,1:2));
disp(block4d)

block2d = map4dTo2d(block4d);
disp(block2d)

block4d_dc = map2dTo4d(block2d, 4, 4, 2, 2);
disp(size(block4d))
disp(size(block4d_dc))
disp(block4d_dc - block4d)