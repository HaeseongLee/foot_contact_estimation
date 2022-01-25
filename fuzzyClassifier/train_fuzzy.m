clc
clear all

addpath("../utils/")
addpath("functions/")

save_data = false;

% load raw data
foot_acc = load("../data/train/foot_acc_lpf.txt");
foot_ang_vel = load("../data/train/foot_ang_vel_lpf.txt");
wrench = load("../data/train/f.txt");
p = load("../data/train/ref_p.txt");

% select data 
lf_acc = foot_acc(:, 1:3);
rf_acc = foot_acc(:, 4:6);
lf_ang_v = foot_ang_vel(:, 1:3);
rf_ang_v = foot_ang_vel(:, 4:6);
l_ft = wrench(:, 1:6);
r_ft = wrench(:, 7:12);

m = 2; %fuzziness
l_fuzzy_model = getFuzzy(lf_acc, lf_ang_v, l_ft, m);
r_fuzzy_model = getFuzzy(rf_acc, rf_ang_v, r_ft, m);

if save_data ==true
    save model/l_fuzzy_model.mat l_fuzzy_model
    save model/r_fuzzy_model.mat r_fuzzy_model
end