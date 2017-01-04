function rl_encoded = rl_encode(input_vector)
    rl_encoded = [];
    last_character = '';
    last_character_occurences = 0;
    for elm = input_vector
        if last_character == elm %% count continuing block
            last_character_occurences = last_character_occurences + 1;
        elseif last_character_occurences >= 2 %% new character - insert last block chain
            rl_encoded = [rl_encoded last_character last_character_occurences elm]; %append nr of occurences
            last_character = elm;
            last_character_occurences = 1;
        else % new character insert character
            rl_encoded = [rl_encoded elm];
            last_character = elm;
            last_character_occurences = 1;
        end
    end
    
    %last character block
    if last_character_occurences > 1
       rl_encoded = [rl_encoded last_character last_character_occurences]; 
    end
end