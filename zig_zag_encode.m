function shortened_block1d = zig_zag_encode(block2d)
%ZIG_ZAG_ENCODE encodes a 2d-block with the zig-zag pattern
%   Detailed explanation goes here

block1d = block2d(:)';

len1d = sqrt(length(block1d));

row = 1;
col = 1;

dir = -1;

last_non_zero = 1;

shortened_block1d = zeros(length(block1d));

for pos=1:length(block1d)
    
    if pos < length(block1d) / 2
        row = row + dir;
        col = col - dir;
    else
        
    end
    
    if row < 1
        row = 1;
        dir = -dir;
    end
    
    if row > len1d
        row = len1d;
        dir = -dir;
    end
    
    if col < 1
        col = 1;
        dir = -dir;
    end
    
    if col > len1d
        col = len1d;
        dir = -dir;
    end
    
    value = block2d(row,col);
    
    if value ~= 0
        last_non_zero = pos;
    end
    
    shortened_block1d(pos) = value;
end

shortened_block1d = [last_non_zero shortened_block1d(1:last_non_zero)];

end

