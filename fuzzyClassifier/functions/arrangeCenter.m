function V = arrangeCenter(C)
% organize the C as in ascent order

% C : [K, N, M]
%     K : number of cluters. it is fixed as 2 for all case
%     N : dimension of input. it is fixed as 2 or 1 (only two cases)
%     M : number of coordinate i.e., x,y,z
    V = C;
    [~,~,M] = size(C);
    for i = 1:M
        x = C(1,:,i);
        y = C(2,:,i);
        if x(1,1) > y(1,1) % -> large y(1,1) is supposed to be foot contact state
            V(1,:,i) = y;
            V(2,:,i) = x;
        end
    end

end