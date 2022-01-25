clc
clear all

save_data = true;

addpath("../utils/")
addpath("functions/")

% load raw data
delta_c_p = load("../data/train/delta_c_p.txt");
delta_c_r = load("../data/train/delta_c_r.txt");
wrench = load("../data/train/f.txt");

l_f = wrench(:, 1:3); % left ground reaction force
l_t = wrench(:, 4:6); % left ground reaction torque
r_f = wrench(:, 7:9); % right ground reaction force
r_t = wrench(:, 10:12); % right ground reaction torque

% get sequential differnce
delta_f = l_f - r_f;
delta_t = l_t - r_t;

% normalize data in a range of [-1, 1]
delta_c_p_norm = normalize(delta_c_p, 'range', [-1, 1]);
delta_c_r_norm = normalize(delta_c_r, 'range', [-1, 1]);
delta_f_norm = normalize(delta_f, 'range', [-1, 1]);
delta_t_norm = normalize(delta_t, 'range', [-1, 1]);

% set input raw data
raw_data = [delta_c_p_norm, delta_c_r_norm, delta_f_norm, delta_t_norm];

% train model
target_dim = 3;
[gmm_model, E] = getGMM(raw_data, target_dim, true);
e = E(1:target_dim, :);
if save_data && target_dim == 3
    save model/gmm_model_3.mat gmm_model
    save model/reduction_matrix_3.mat e
elseif save_data && target_dim == 2
    save model/gmm_model_2.mat gmm_model
    save model/reduction_matrix_2.mat e
end
