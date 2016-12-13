%% =1======================================================
% load lightfield (the last parameter is a scaling factor for the spatial resolution)
%LF = ImportLF('./lightfields/tarot_smallangle_17x17/',17,[1,1],0.25);
LF = ImportLF('./lightfields/legoknights-small_17x17/',17,[1,1],0.5);
%LF = ImportLF('./lightfields/sintel_lion_512_19x19/',19,[0,1],0.25);
%LF = ImportLF('./lightfields/sintel_cave_entrance_512_19x19/',19,[0,1],0.25);

% size of lightfield (dimension order as it is being loaded: S,T,c,U,V
[T,S,c,U,V] = size(LF);

%%

blocksize_st=4;
blocksize_uv=2;
block = LF(250:250+blocksize_st-1,250:250+blocksize_st-1,color,1:blocksize_uv,1:blocksize_uv);

% block1d = zeros(blocksize_st*blocksize_st*blocksize_uv*blocksize_uv);
% for index=0:blocksize_st*blocksize_st*blocksize_uv*blocksize_uv-1
%     
% end

block1d = cast(block(:)', 'double');

block1d_dct = dct(block1d);
reshape(block1d_dct, [8,8])

block1d = block1d - 128; %shift mean to zero
block1d_dct = dct(block1d);
reshape(block1d_dct, [8,8])

%%

blocksize_st=4;
blocksize_uv=2;
block = LF(250:250+blocksize_st-1,250:250+blocksize_st-1,color,1:blocksize_uv,1:blocksize_uv);

% block1d = zeros(blocksize_st*blocksize_st*blocksize_uv*blocksize_uv);
% for index=0:blocksize_st*blocksize_st*blocksize_uv*blocksize_uv-1
%     
% end

block1d = cast(block(:)', 'double');
block1d = block1d - 128; %shift mean to zero
block1d_dct = dct(block1d);
%block1d_dct(1) = block1d_dct(1) / 100;
%block1d_dct
block_dct = reshape(block1d_dct, [blocksize_st*blocksize_uv, blocksize_st*blocksize_uv])
block_dct(3:8,3:8) = 0;
block_dct
% block_dct(3:7,3:7) = 0;
% block_dct(3+8:7,3+8:7) = 0;
% block_dct(3:7+8,3:7+8) = 0;
% block_dct(3+8:7+8,3+8:7+8) = 0;
block_re = idct(block_dct(:)');
round(reshape(block1d-block_re, [8,8]))


%% =2=======================================================
clc;
blocksize_st=4;
blocksize_uv=2;

blocksize_1d = blocksize_st*blocksize_st*blocksize_uv*blocksize_uv;
dct_encoded = zeros(3, blocksize_1d*S*T);


for color=1:3
index = 1;
for s=1:blocksize_st:S
    for t=1:blocksize_st:T
        block = LF(t:t+blocksize_st-1,s:s+blocksize_st-1,color,1:blocksize_uv,1:blocksize_uv);
        block1d = cast(block(:)', 'double');
        block1d = block1d - 128; %shift mean to zero
        block1d_dct = dct(block1d);
        
        %block1d_dct(1) = block1d_dct(1) / 50;
        
%         if index == 64*63+1
%             block1d
%             block1d_dct
%         end
       
%         for x=1:blocksize_1d-blocksize_1d/8
%            if abs(block1d_dct(x)) < 10
%               block1d_dct(x) = 0;
%            end
%         end
%         
%         for x=blocksize_1d-blocksize_1d/8:blocksize_1d
%             block1d_dct(x) = 0;
%         end

        block_dct = reshape(block1d_dct, [blocksize_st*blocksize_uv, blocksize_st*blocksize_uv]);
%         block_dct(3:6,3:6) = 0;
%         block_dct(3+8:6,3+8:6) = 0;
%         block_dct(3:6+8,3:6+8) = 0;
%         block_dct(3+8:6+8,3+8:6+8) = 0;
        block_dct(4:8,4:8) = 0;
        
        dct_encoded(color,index:index+blocksize_1d-1) = block_dct(:)';
        index = index+blocksize_1d;
    end
end
end

max(max(dct_encoded))
size(dct_encoded)
nnz(dct_encoded) 

dct_encoded = round(dct_encoded);
%dct_encoded = cast(dct_encoded, 'uint8');

size(dct_encoded)
nnz(dct_encoded)

%%

LF_dec = LF;

%dct_encoded = cast(dct_encoded, 'double');

for color=1:3
index = 1;
for s=1:blocksize_st:S
    for t=1:blocksize_st:T
        dct_block1d = dct_encoded(color,index:index+blocksize_1d-1);
        %dct_block1d(1) = dct_block1d(1) * 50;
        block1d = idct(dct_block1d);
        block1d = cast(block1d + 128, 'uint8');
        
        LF_dec(t:t+blocksize_st-1,s:s+blocksize_st-1,color,1:blocksize_uv,1:blocksize_uv) = reshape(block1d, [blocksize_st,blocksize_st,blocksize_uv,blocksize_uv]);
        
        index = index + blocksize_1d;
    end
end
end

max(max(LF(1:T,1:S,1,1,1)-LF_dec(1:T,1:S,1,1,1)))

im = RenderLF(LF_dec,0.25,2,-7,-7); 
figure,imshow(im);
title('image rendered from lightfield');

im2 = RenderLF(LF,0.25,2,-7,-7); 
figure,imshow(im2);
title('image rendered from lightfield');

%%

block1 = LF(1:8,1:8,1,1:8,1:8);
block1d = [];
for u=1:8
    for v=1:8
        for s=1:8
            block1d = [block1d LF(:,s,1,u,v)'];
        end
    end
end

dec = mdwtdec('r',block1d,10,'db2');
[XC,decCMP,THRESH] = mswcmp('cmp',dec,'N0_perf',50);
XC
decCMP
THRESH
%blockdct = dct(typecast(block1d, 'double'))

%%


%%
clc;
%diff = LF(:,:,1,1,1) - LF(:,:,1,1,2)
%diff1d = diff(:)';

%diff = LF(71:74,64:67,1,1:4,1:4);% - LF(1:8,1:8,1,1,2)
diff = LF(1:4,1:4,1,1:4,1:4);
diff1d = cast(diff(:)', 'double');

reshape(diff1d, [16,16])

% [cA,cD] = dwt(diff1d, 'sym4');
%cA
%cD

dctdiff1d = dct(diff1d)

reshape(dctdiff1d, [16,16])

for x=1:4*4*4*4
   if abs(dctdiff1d(x)) < 10
      dctdiff1d(x) = 0;
   end
end


reshape(dctdiff1d, [16,16])

idctdiff1d = idct(dctdiff1d);
reshape(idctdiff1d, [16,16]) - reshape(diff1d, [16,16])
max(max(reshape(idctdiff1d, [16,16]) - reshape(diff1d, [16,16])))

% clc;
% asdf = zeros(256);
% asdf(1) = 2779.1;
% idctdiff1d = idct(asdf);
% reshape(idctdiff1d, [16,16]) - reshape(diff1d, [16,16])

%clc;
%inverse = idwt(dctdiff, 'sym4')

%% asdf

LF(1:16,1:16,1,1,1)

dct2(asdf)



%% =2======================================================
% RenderLF Renders a lightfield in the spatial domain.
%   RenderLF(LF,disparityfactor,aperturesize,cu,cv) returns a rendered image focused
%   at a focal plane with the given disparity (or shift) factor 
%   (= disparity of the focal plane in pixel between two neighboring perspectives). 
%   The render position is given by cu,cv (center = 0,0).
im = RenderLF(LF,0.25,2,2.5,0.4); 
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

%% =4======================================================
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

