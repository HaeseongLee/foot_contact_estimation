clc
clear all

addpath("../utils/")
addpath("functions/")

save_data = true;

wrench = load("../data/train/f.txt");
p = load("../data/train/ref_p.txt");

% get ground reaction force long z-axis
l_fz = wrench(:, 3);
r_fz = wrench(:, 9);

% get reference trajectory along z-axis
l_pz = p(:, 3);
r_pz = p(:, 6);

% get contact labels
[l_ct, r_ct] = getFootContactLabel(l_pz, r_pz);

% curve fitting using cftool for a left leg
[l_sig_model, ~] = getSigmoidModel(l_fz, l_ct);

% curve fitting using cftool for a right leg
[r_sig_model, ~] = getSigmoidModel(r_fz, r_ct);

% save the results
if save_data == true
    save model/l_sig_model.mat l_sig_model
    save model/r_sig_model.mat r_sig_model
end
