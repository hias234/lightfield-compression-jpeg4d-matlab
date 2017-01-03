function [huffman_encode, dict] = huffman_encode(compressedLF)
    % huffman compression of the given LF
    symbols = -127:128;
    p = zeros(1,256);
    i = 1;
    for x = symbols
      nrOfXOccurences = nnz(compressedLF == x);
      p(i) = nrOfXOccurences / length(compressedLF);
      i = i + 1;
    end 

    dict = huffmandict(symbols,p);
    huffman_encode = huffmanenco(compressedLF,dict);
end