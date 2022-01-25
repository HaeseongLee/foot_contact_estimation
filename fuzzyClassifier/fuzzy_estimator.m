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
foot_acc = load("data/foot_acc_lpf.txt");
foot_ang_vel = load("data/foot_ang_vel_lpf.txt");
wrench = load("data/f.txt");
p = load("data/ref_p.txt");

% select data 
lf_acc = foot_acc(start_idx:end_idx-1, 1:3);
rf_acc = foot_acc(start_idx:end_idx-1., 4:6);
lf_ang_v = foot_ang_vel(start_idx:end_idx-1, 1:3);
rf_ang_v = foot_ang_vel(start_idx:end_idx-1., 4:6);
l_ft = wrench(start_idx:end_idx-1, 1:6);
r_ft = wrench(start_idx:end_idx-1, 7:12);

% get reference trajectory along z-axis
l_pz = p(start_idx:end_idx-1, 3);
r_pz = p(start_idx:end_idx-1, 6);

% get contact labels
[l_ct, r_ct] = getFootContactLabel(l_pz, r_pz);

% normalize data in a range of [0,1]
lf_acc_norm = normalize(abs(lf_acc),'range',[0,1]);
rf_acc_norm = normalize(abs(rf_acc),'range',[0,1]);
lf_ang_v_norm = normalize(abs(lf_ang_v),'range',[0,1]);
rf_ang_v_norm = normalize(abs(rf_ang_v),'range',[0,1]);
l_ft_norm = normalize(abs(l_ft),'range',[0,1]);
r_ft_norm = normalize(abs(r_ft),'range',[0,1]);

% set test data 
raw_l_trans = [l_ft_norm(:,1:3), lf_acc_norm(:,1:3)];
raw_r_trans = [r_ft_norm(:,1:3), rf_acc_norm(:,1:3)];
raw_l_ori = [l_ft_norm(:,4:6), lf_ang_v_norm(:,1:3)];
raw_r_ori = [r_ft_norm(:,4:6), rf_ang_v_norm(:,1:3)];

% load fuzzy models for each leg
l_fuzzy_model = load("model/l_fuzzy_model.mat");
l_fuzzy_model = l_fuzzy_model.l_fuzzy_model;

r_fuzzy_model = load("model/r_fuzzy_model.mat");
r_fuzzy_model = r_fuzzy_model.r_fuzzy_model;


[l_ct_hat, l_u] = fuzzyPredict(raw_l_trans, raw_l_ori, l_fuzzy_model);
[r_ct_hat, r_u]= fuzzyPredict(raw_r_trans, raw_r_ori, r_fuzzy_model);


figure(1)
subplot(2,1,1)
plotFuzzyResult(l_ct, l_ct_hat, t, "left")
subplot(2,1,2)
plotFuzzyResult(r_ct, r_ct_hat, t, "right")

figure(2)
subplot(3,2,1)
plotFuzzyClustring(raw_l_trans(:,[1,4]), l_fuzzy_model.translation(:,:,1), l_u.x)
title("left x")
subplot(3,2,3)
plotFuzzyClustring(raw_l_trans(:,[2,5]), l_fuzzy_model.translation(:,:,2), l_u.y)
title("left y")
subplot(3,2,5)
plotFuzzyClustring(raw_l_trans(:,[3,6]), l_fuzzy_model.translation(:,:,3), l_u.z)
title("left z")
subplot(3,2,2)
plotFuzzyClustring(raw_l_ori(:,[1,4]), l_fuzzy_model.orientation(:,:,1), l_u.roll)
title("left roll")
subplot(3,2,4)
plotFuzzyClustring(raw_l_ori(:,[2,5]), l_fuzzy_model.orientation(:,:,2), l_u.pitch)
title("left pitch")
subplot(3,2,6)
plotFuzzyClustring(raw_l_ori(:,[3,6]), l_fuzzy_model.orientation(:,:,3), l_u.yaw)
title("left yaw")

figure(3)
subplot(3,2,1)
plotFuzzyClustring(raw_r_trans(:,[1,4]), r_fuzzy_model.translation(:,:,1), r_u.x)
title("right x")
subplot(3,2,3)
plotFuzzyClustring(raw_r_trans(:,[2,5]), r_fuzzy_model.translation(:,:,2), r_u.y)
title("right y")
subplot(3,2,5)
plotFuzzyClustring(raw_r_trans(:,[3,6]), r_fuzzy_model.translation(:,:,3), r_u.z)
title("right z")
subplot(3,2,2)
plotFuzzyClustring(raw_r_ori(:,[1,4]), r_fuzzy_model.orientation(:,:,1), r_u.roll)
title("right roll")
subplot(3,2,4)
plotFuzzyClustring(raw_r_ori(:,[2,5]), r_fuzzy_model.orientation(:,:,2), r_u.pitch)
title("right pitch")
subplot(3,2,6)
plotFuzzyClustring(raw_r_ori(:,[3,6]), r_fuzzy_model.orientation(:,:,3), r_u.yaw)
title("right yaw")