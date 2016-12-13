function I = RenderLF(LF,disparityfactor,apertureradius,cu,cv)
%RenderLF Renders a light field in the spatial domain.
%   RenderLF(LF,disparityfactor,aperturesize,cu,cv) returns a rendered image focused
%   at a focal plane with the given disparity (or shift) factor 
%   (= disparity of the focal plane in pixel between two neighboring perspectives). 
%   The render position is given by cu,cv (center = 0,0).
    
    disp('start rendering light field');
    
    % get light field size
    [T,S,C,U,V] = size(LF);
    
    % check aperture radius
    if(apertureradius > U/2 || apertureradius > V/2)
        disp('Apertureradius must not be larger than U/2 or V/2 in this implementation!');
        return;
    end
    
    % compute center position
    UC=floor((U+1)/2);
    VC=floor((V+1)/2);
    
    % generate disk aperture matrix
    aperture = zeros(U,V);
    disk = fspecial('disk',apertureradius);
    aperture(UC-apertureradius:UC+apertureradius,VC-apertureradius:VC+apertureradius)=disk;
    % shift aperture to render position
    aperture = shiftView(aperture, [cu, cv]);
    % normalize aperture weights
    aperture = aperture./sum(aperture(:));
    
    % allocate output image
    sumim = zeros(T,S,3);
    
    % resample light field
    for u = 1:U;
        for v = 1:V;
            % compute offset for current perspective to chosen render perspective
            du = u-(cu+UC);
            dv = v-(cv+VC);
            
            if (aperture(u,v)>0) % (speedup) don't compute if not within aperture
                
                %get image from light field
                tmpim = im2double(LF(:,:,:,u,v));
                % shift perspective, multiply with aperture weight and add to sum
                sumim = sumim + (shiftView(tmpim,[ disparityfactor * dv, disparityfactor * du]) .* aperture(u,v));
                
            end
        end
    end
    
    % return image
    I=sumim;
    
    disp('finished rendering light field');
end