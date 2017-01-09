function block2d = map4dTo2d(block4d)
% maps a 4-dimensional block to a 2-dimensional one

    [T, S, U, V] = size(block4d);
    
    % block2d = reshape(block4d(:)', [S*U,T*V]);
    
    block2d = zeros(S*U,T*V);
    
    for t=0:T-1
        for s=0:S-1
            for u=0:U-1
                for v=0:V-1
                    block2d(s+u*S+1,t+v*T+1) = block4d(t+1,s+1,u+1,v+1);
                end
            end
        end
    end
    
end