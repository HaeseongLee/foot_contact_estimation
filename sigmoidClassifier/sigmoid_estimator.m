clc
clear all

addpath("../utils/")
addpath("functions/")

hz = 2000;
walking_start = 4; % s
walking_end = 20; % s

[t, start_idx, end_idx] = setTime(walking_start, walking_end, hz);

wrench = load("data/f.txt");
p = load("data/ref_p.txt");

% get ground reaction force long z-axis
l_fz = wrench(start_idx:end_idx-1, 3);
r_fz = wrench(start_idx:end_idx-1, 9);

% get reference trajectory along z-axis
l_pz = p(start_idx:end_idx-1, 3);
r_pz = p(start_idx:end_idx-1, 6);

% get contact labels
[l_ct, r_ct] = getFootContactLabel(l_pz, r_pz);

% load model for the left leg
l_sig_model = load("model/l_sig_model.mat");
l_sig_model = l_sig_model.l_sig_model;

% load model for the right leg
r_sig_model = load("model/r_sig_model.mat");
r_sig_model = r_sig_model.r_sig_model;

% estimate contact probability for each legs
l_ct_hat = getSigmoidContactProbability(l_fz, l_sig_model.a, l_sig_model.b);
r_ct_hat = getSigmoidContactProbability(r_fz, r_sig_model.a, r_sig_model.b);

% plot result
figure(1)
subplot(2,1,1)
plotSigmoidResult(l_ct, l_ct_hat, t, "left")
subplot(2,1,2)
plotSigmoidResult(r_ct, r_ct_hat, t, "right")
