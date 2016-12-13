
%load LF
LF = ImportLF('./lightfields/legoknights-small_17x17/',17,[1,1],1);

%get dimensions
[T,S,c,U,V] = size(LF);

%permute LF to get high-performance access to S,U epi images:
LFP = permute(LF,[2,4,3,1,5]); %S,U,c,T,V
 
%get an S,U epi image for each T,V
for v = 1:V
     disp(v);
     for t = 1:T
               
        %get epi image
        epiimage = im2double(LFP(:,:,:,t,v));
            
        %do something with it...
        
        %... e.g. display center epi image
        if(t==ceil(T/2) && v==ceil(V/2))
            figure, imshow(epiimage);
        end
        
      end
end
    
%permute LF to get high-performance access to T,V epi images:
LFP = permute(LF,[1,5,3,2,4]); %T,V,c,S,U

%get an T,V epi image for each S,U
for u = 1:U
    disp(u);
    for s = 1:S
               
        %get epi image
        epiimage = im2double(LFP(:,:,:,s,u));
            
        %do something with it...
        
        %... e.g. display center epi image
        if(s==ceil(S/2) && u==ceil(U/2))
            figure, imshow(epiimage);
        end
        
    end
end

