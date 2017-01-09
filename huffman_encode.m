function [huffman_encode, dict] = huffman_encode(compressedLF)
    % huffman compression of the given LF
    
    %RL-encoding can give values greater than 128
    runLenghts = unique(compressedLF(compressedLF > 128)); %save the different runlenghts
    symbols = [-127:128 runLenghts];
    p = zeros(1,256 + length(runLenghts));
    i = 1;
    
    for x = symbols
      nrOfXOccurences = nnz(compressedLF == x);
      p(i) = nrOfXOccurences / length(compressedLF);
      i = i + 1;
    end

    dict = huffmandict(symbols,p);
    huffman_encode = huffmanenco(compressedLF,dict);
end