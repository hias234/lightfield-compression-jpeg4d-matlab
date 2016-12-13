function block2d = map4dTo2d(block4d)
% maps a 4-dimensional block to a 2-dimensional one

    [T, S, U, V] = size(block4d);

    block1d = block4d(:)'; % first approach -> let matlab figure it out ;)
    block2d = reshape(block1d, [T*U, S*V]);
end