function rl_encoded = rl_encode(input_vector)
    rl_encoded = zeros(1, size(input_vector, 2));
    last_character = '';
    last_character_occurences = 0;
    i = 1;
    for elm = input_vector
        if last_character == elm %% count continuing block
            last_character_occurences = last_character_occurences + 1;
        elseif last_character_occurences >= 2 %% new character - insert last block chain
            rl_encoded(i) = last_character; %append nr of occurences
            i = i + 1;
            rl_encoded(i) = last_character_occurences; %append nr of occurences
            i = i + 1;
            rl_encoded(i) = elm;
            i = i + 1;
            last_character = elm;
            last_character_occurences = 1;
        else % new character insert character
            rl_encoded(i) = elm;
            i = i + 1;
            last_character = elm;
            last_character_occurences = 1;
        end
    end
    
    %last character block
    if last_character_occurences > 1
        rl_encoded(i) = last_character; %append nr of occurences
        i = i + 1;
        rl_encoded(i) = last_character_occurences; %append nr of occurences
    end
    rl_encoded = rl_encoded(1:i); %cut trailing zeroes
end