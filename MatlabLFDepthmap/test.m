%RUNNING the code
%you need to copy the lightfields data directory (see lab 3) to the same
%directory befor you run the code

%OPTIONAL: speeding up the code
%you can use a faster version of shiftView to speed up depth computation
%binary for windows 7 x64 included, others need to compile first:
%mex shiftViewX.cpp
%ask google how to enable OpenMP for mex (additional speedup)
%alternatively slow version of shiftView should work too
%if you do this, you need to change one line of code in RenderLFVarPersp.m
%(see comment in the file)
%if you don't do this, you can leave the code as is 
%it will give you the same results, but will be slower

%load some light field to LF
LF = ImportLF('./lightfields/legoknights-small_17x17/',17,[1,1],0.25);

%min and max disparity factor for light field have to be found manually
%(these values work for the full resolution lego knight light field)
mindepth = -3;
maxdepth = 3;
%depth resolution
depthslices = 30;
%calc for center persp.
du=0; 
dv=0; 

%calc depth, might take several minutes!!!
depth = calcDepth(LF,mindepth,maxdepth,depthslices,du,dv);

%optional filtering
depth = medfilt2(depth,[3 3]);

%show depth image
figure, imshow(depth,[mindepth maxdepth]);