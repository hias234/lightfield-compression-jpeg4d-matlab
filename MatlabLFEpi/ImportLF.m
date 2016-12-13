function LF = ImportLF(path,U,firstimpos,resizefactor)
%IMPORTLF Opens a light field from disk and returns a light field datastructure.
%   Loads a light field from a file path given the number of horizontal light field
%   perspectives. The images are expected to be in the png image format and sorted to be read line by line.
%   firstimpos describes the position of first image file ([0,0] = left top, [1,0] = right top, ...)
    
    if ~exist('resizefactor','var')
        resizefactor=1;
    end

    disp('start loading light field');
    
    % list light field perspectives
    files = dir(strcat(path,'/*.png'));

    % compute number vertical light field perspectives.
    V = size(files,1)/U;

    % open first image to get image size.
    imagename = strcat(path,'/',files(1).name);
    I = imread(imagename);
    if(resizefactor~=1)
        I = imresize(I,resizefactor);
    end
    
    % allocate memory (image height (T), image width (S), #color channels, hor. lf persp. (U), vert. lf. persp. (V))
    LF = zeros(size(I,1),size(I,2),3,U,V,'uint8');

    for i=1:size(files,1)
        % compute current u and v coordinate
        cv = floor((i-1)/U)+1;
        cu = mod((i-1),U)+1;
        
        % invert if first image is not top left image
        if(firstimpos(1) == 1)
            cu = U-cu+1;
        end
        if(firstimpos(2) == 1)
            cv = V-cv+1;    
        end
        
        % load image from file
        imagename = strcat(path,'/',files(i).name);
        I = imread(imagename);
        if(resizefactor~=1)
            I = imresize(I,resizefactor);
        end
        LF(:,:,:,cu,cv)=I;
    end
    
    disp('finished loading light field');
end

