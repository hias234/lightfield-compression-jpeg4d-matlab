function I = RenderLFVarPersp(LF,disparityfactor,cu,cv)
    
    %disp('start rendering light field');
    
    % get light field size
    [T,S,c,U,V] = size(LF);
    
    
    % compute center position
    UC=floor((U+1)/2);
    VC=floor((V+1)/2);
    
    % allocate output image
    varim = zeros(T,S,3);
    
    %compare to
    sumim = im2double(LF(:,:,:,cu+UC,cv+VC));
    
    sumw = 0;
    fw = ((U*U)+(V*V))^(1/2);
    
    for u = 1:U;
        for v = 1:V;
            % compute offset for current perspective to chosen render perspective
            du = u-(cu+UC);
            dv = v-(cv+VC);
            
            %for faster shift view use this code:
            %tmpim = shiftViewX(LF(:,:,:,u,v),[ disparityfactor * dv, disparityfactor * du]);
            %for slow shift view use this code:
            tmpim = shiftView(im2double(LF(:,:,:,u,v)),[ disparityfactor * dv, disparityfactor * du]);
            
            %optional: compute some weight depending on position
            w = (fw -((du*du)+(dv*dv))^(1/2))/fw;
            sumw = sumw + w;
            
            %compute difference to desired perspective
            varim = varim + (((sumim - tmpim).^2).*w);
        end
    end
    
    varim = max(varim,[],3)/(sumw); %get max variance of colors
    
    % return image
    I=varim;
    
    %disp('finished rendering light field');
    
end