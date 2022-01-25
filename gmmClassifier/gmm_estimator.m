clc
clear all

addpath("../utils/")
addpath("functions/")

hz = 2000;
walking_start = 4; % s
walking_end = 20; % s

N = (walking_end - walking_start)*hz;

[t, start_idx, end_idx] = setTime(walking_start, walking_end, hz);

% load raw data
com_p = load("../data/c.txt");
com_r = load("../data/com_r.txt");
wrench = load("../data/f.txt");
p = load("../data/ref_p.txt");

c_p = com_p(start_idx:end_idx-1, :); % x, y, z
c_r = com_r(start_idx:end_idx-1, 1:2); % roll, pitch
l_f = wrench(start_idx:end_idx-1, 1:3); % left ground reaction force
l_t = wrench(start_idx:end_idx-1, 4:6); % left ground reaction torque
r_f = wrench(start_idx:end_idx-1, 7:9); % right ground reaction force
r_t = wrench(start_idx:end_idx-1, 10:12); % right ground reaction torque

% get reference trajectory along z-axis
l_pz = p(start_idx:end_idx-1, 3);
r_pz = p(start_idx:end_idx-1, 6);

% get contact labels
[lss, ds, rss] = getGaitPhaseLabel(l_pz, r_pz);

delta_c_p = zeros(N, 3);
delta_c_r = zeros(N, 2);

% get sequential differnce
delta_c_p(2:end,:) = c_p(2:end,:) - c_p(1:end-1,:);
delta_c_r(2:end,:) = c_r(2:end,:) - c_r(1:end-1,:);
delta_f = l_f - r_f;
delta_t = l_t - r_t;

% normalize data in a range of [-1, 1]
delta_c_p_norm = normalize(delta_c_p, 'range', [-1, 1]);
delta_c_r_norm = normalize(delta_c_r, 'range', [-1, 1]);
delta_f_norm = normalize(delta_f, 'range', [-1, 1]);
delta_t_norm = normalize(delta_t, 'range', [-1, 1]);

% set input raw data
raw_data = [delta_c_p_norm, delta_c_r_norm, delta_f_norm, delta_t_norm];

% load GMM model
gmm_model = load("model/gmm_model_3.mat");
gmm_model = gmm_model.gmm_model;

% load PCA result
reduction_matrix = load("model/reduction_matrix_3.mat");
reduction_matrix = reduction_matrix.e; % reduce the input dimention into 2 or 3

[ds_hat, lss_hat, rss_hat] = gmmPredict(raw_data, gmm_model, reduction_matrix);

figure(1)
subplot(3,1,1)
plotGMMResult(lss, lss_hat, t, "LSS")
subplot(3,1,2)
plotGMMResult(ds, ds_hat, t, "DS")
subplot(3,1,3)
plotGMMResult(rss, rss_hat, t, "RSS")
