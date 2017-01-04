function rl_decoded = rl_decode(encoded)
    rl_decoded = [];
    last_character = '';
    chain_detected = false;
    for elm = encoded
        if chain_detected 
            rl_decoded = [rl_decoded (ones(1, elm - 2) * last_character)];
            chain_detected = false;
        elseif last_character == elm %% count continuing block
            chain_detected = true;
            rl_decoded = [rl_decoded elm];
        else
            last_character = elm;
            rl_decoded = [rl_decoded elm];
        end
    end
end