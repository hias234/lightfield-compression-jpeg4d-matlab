%% =1======================================================
% load lightfield (the last parameter is a scaling factor for the spatial resolution)
LF = ImportLF('./lightfields/tarot_smallangle_17x17/',17,[1,1],0.25);
%LF = ImportLF('./lightfields/legoknights-small_17x17/',17,[1,1],0.25);
%LF = ImportLF('./lightfields/sintel_lion_512_19x19/',19,[0,1],0.25);
%LF = ImportLF('./lightfields/sintel_cave_entrance_512_19x19/',19,[0,1],0.25);

% size of lightfield (dimension order as it is being loaded: S,T,c,U,V
[T,S,c,U,V] = size(LF);
%% ========================================================

%% =2======================================================
% RenderLF Renders a lightfield in the spatial domain.
%   RenderLF(LF,disparityfactor,aperturesize,cu,cv) returns a rendered image focused
%   at a focal plane with the given disparity (or shift) factor 
%   (= disparity of the focal plane in pixel between two neighboring perspectives). 
%   The render position is given by cu,cv (center = 0,0).
im = RenderLF(LF,0.5,8,2.5,0.4); 
figure,imshow(im);
title('image rendered from lightfield');
%% ========================================================

%% =3======================================================
% LF(:,:,:,u,v) gives you one proper perspective image at u,v
% tile perspective images into one big 2D image
LF_Image = zeros(U*S,V*T,c);
for u=0:U-1
    for v=0:V-1
        im=LF(:,:,:,u+1,v+1);
        LF_Image(u*S+1:u*S+S,v*T+1:v*T+T,1:3)=im;
    end
end
LF_Image=LF_Image/255;
%--------------------------------------------------------
% This is the two line Matlab-pro alternative to the code above
% LF_ = permute(LF,[1,5,2,4,3]); % order dimensions in such a way that Matlab... 
% LF_Image = reshape(LF_,[V*T,U*S,c]); %...can store everything sequentially in the right way
%--------------------------------------------------------
figure; imshow(LF_Image);
title('perspective image representation');
%% ========================================================

%% =5======================================================
%switch to direction order: V,U,c,S,T (LF2(:,:,:,s,t) gives you one proper microimage at s,t
%(keep in mind that matlab stores images in column-order)
LF2=permute(LF,[5 4 3 1 2]);
% tile microimages into one big 2D image
LF2_Image = zeros(S*U,T*V,c);

for s=0:S-1
    for t=0:T-1
        im=LF2(:,:,:,s+1,t+1);
        LF2_Image(s*U+1:s*U+U,t*V+1:t*V+V,1:3)=im;
    end
end
LF2_Image=LF2_Image/255;
%--------------------------------------------------------
% % This is the two line Matlab-pro alternative to the code above
% LF2 = permute(LF,[5,1,4,2,3]); % order dimensions in such a way that Matlab... 
% LF2_Image = reshape(LF2,[T*V,S*U,c]); %...can store everything sequentially in the right way
%--------------------------------------------------------
figure; imshow(LF2_Image);
title('microimage representation');
%% ========================================================

