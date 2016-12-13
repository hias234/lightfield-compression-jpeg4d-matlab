function depth = calcDepth(LF,minfactor, maxfactor,slices,uo,vo)

    [T,S,c,U,V] = size(LF);
    UC=floor((U+1)/2);
    VC=floor((V+1)/2);

    stepw = (maxfactor-minfactor)/(slices-1);

    %render variance stack
    tmpvarstack = RenderLFVarStackPersp(LF,minfactor,maxfactor,slices,uo,vo);
    
    %find slice with min variance for each pixel
    [vim,depth] = min(tmpvarstack,[],3);
    
    %transform to disparities
    depth = (depth-1).*stepw+minfactor;

end