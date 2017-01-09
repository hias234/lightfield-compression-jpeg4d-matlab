function rl_decoded = rl_decode(encoded)
    rl_decoded = [];
    zero_detected = false;
    for elm = encoded
        if elm == 0 
            zero_detected = true;
        elseif zero_detected %% insert zeroes
            rl_decoded = [rl_decoded zeros(1, elm)];
            zero_detected = false;
        else
            rl_decoded = [rl_decoded elm];
        end
    end
end