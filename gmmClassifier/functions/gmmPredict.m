function [ds_hat, lss_hat, rss_hat] = gmmPredict(X, G, E)
% Input
%     X : input data to be estimated
%     G : trained GMM model
%     E : reduction matrix from PCA

mu = G.mu;
sigma = G.Sigma;
w = G.ComponentProportion;
K = G.NumComponents; % number of clusters

% reduce the dimension of X
pca_data = (E * X')';

% compute probability of X
N = length(X);
prob = zeros(N,K);
for i = 1:K
    prob(:,i) = mvnpdf(pca_data, mu(i,:), sigma(:,:,i));
end

% compute responsibility for each input 
resp = zeros(N,K); % responsibility
den = zeros(N,1);  % sum of all weighted responsibility
for i = 1:K
    den = den + w(i)*prob(:,i);
end
for i = 1:K
    resp(:,i) = w(i)*prob(:,i)./den;
end
r = resp';
r = max(r);
[pca_dim, ~] = size(E);

% estimation
if pca_dim == 3
    ds_index = find(resp(:,3) == r'); % 1 = ds
    lss_index = find(resp(:,2) == r'); % 2 = lss
    rss_index = find(resp(:,1) == r'); % 3 = rss
elseif pca_dim == 2
    ds_index = find(resp(:,3) == r'); % 1 = ds
    lss_index = find(resp(:,1) == r'); % 2 = lss
    rss_index = find(resp(:,2) == r'); % 3 = rss
end

ds_hat = zeros(N,1);
lss_hat = zeros(N,1);
rss_hat = zeros(N,1);

ds_hat([ds_index]) = 1;
lss_hat([lss_index]) = 1;
rss_hat([rss_index]) = 1; 



end