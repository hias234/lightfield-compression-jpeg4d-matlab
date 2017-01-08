function shortened_block1d = zig_zag_encode(block2d)
%ZIG_ZAG_ENCODE encodes a 2d-block with the zig-zag pattern
%   Detailed explanation goes here

block1d = block2d(:)';

len1d = sqrt(length(block1d));

row = 2;
col = 0;

dir = -1;
shortened_block1d = zeros(length(block1d));

for pos=1:length(block1d)
    
    row = row + dir;
    col = col - dir;
    
    if row < 1
        row = 1;
        dir = -dir;
    end
    
    if row > len1d
        row = len1d;
        if pos > length(block1d) / 2
            col = min(col + 2, len1d);
        end
        
        dir = -dir;
    end
    
    if col < 1
        col = 1;
        dir = -dir;
    end
    
    if col > len1d
        col = len1d;
        if pos > length(block1d) / 2
            row = min(row + 2, len1d);
        end
        dir = -dir;
    end
    
    shortened_block1d(pos) = block2d(row,col);
end

shortened_block1d = shortened_block1d(1:length(block1d));

end

