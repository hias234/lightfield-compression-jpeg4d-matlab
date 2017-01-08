function output_block2d = zig_zag_decode(input_block1d)
%ZIG_ZAG_DECODE zig-zag-decodes the args
%   Detailed explanation goes here

len1d = sqrt(length(input_block1d));

row = 2;
col = 0;

dir = -1;
output_block2d = zeros(len1d,len1d);

for pos=1:length(input_block1d)
    row = row + dir;
    col = col - dir;
    
    if row < 1
        row = 1;
        dir = -dir;
    end
    
    if row > len1d
        row = len1d;
        if pos > length(input_block1d) / 2
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
        if pos > length(input_block1d) / 2
            row = min(row + 2, len1d);
        end
        dir = -dir;
    end
    
    output_block2d(row,col) = input_block1d(pos);
end

end

