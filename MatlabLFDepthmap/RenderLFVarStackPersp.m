function I = RenderLFVarStackPersp(LF,disparityfactor1,disparityfactor2,slices,cu,cv)
%RenderLFVarStack
    
    stepw = (disparityfactor2-disparityfactor1)/(slices-1);
    
    [T,S,c,U,V] = size(LF);
    
    stack = zeros(T,S,slices);
    
    for count=1:1:slices
        fprintf('%d/%d\n',count,slices);
        stack(:,:,count) = RenderLFVarPersp(LF,disparityfactor1+(count-1)*stepw,cu,cv);
    end
    
    I=stack;
end