function block4d = map2dTo4d(block2d, T, S, U, V)
% maps a 4-dimensional block to a 2-dimensional one

    block4d = zeros(T,S,U,V);

    for t=0:T-1
        for s=0:S-1
            for u=0:U-1
                for v=0:V-1
                    block4d(t+1,s+1,u+1,v+1) = block2d(s+u*S+1,t+v*T+1);
                end
            end
        end
    end
end