function U = computeMembership(X, C, m)
    [N, D] = size(X); % number of samples
    [K, ~] = size(C); % number of clusters, C = [K, input dimension]
    
    U = zeros(K,N);
    
    den = 0;
    for k = 1:K
        dis = X - C(k,:);
        if D == 1
            dis = abs(dis');
        else
            dis = vecnorm(dis');
        end
        den = den + (1./dis).^(2/(m-1));
    end

    num = zeros(K,N);
    for j = 1:K
        dis = X - C(j,:);
        if D == 1
            dis = abs(dis');
        else
            dis = vecnorm(dis');
        end
        num(j,:) = dis.^(2/(m-1));
    end
    for i = 1:K
        x = num(i,:).*den;
        U(i,:) = 1./x;
    end

end