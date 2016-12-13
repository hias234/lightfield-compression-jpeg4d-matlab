function block4d = map2dTo4d(block2d, T, S, U, V)
% maps a 4-dimensional block to a 2-dimensional one

    block1d = block2d(:)'; % first approach -> let matlab figure it out ;)
    block4d = reshape(block1d, [T, S, U, V]);
end