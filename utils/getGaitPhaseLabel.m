function [lss, ds, rss] = getGaitPhaseLabel(l_pz, r_pz)

    lss = zeros(length(l_pz),1);
    ds = zeros(length(l_pz),1);
    rss = zeros(length(l_pz),1);

    lss_idx = find(l_pz == 0 & r_pz ~= 0);
    ds_idx = find(l_pz == 0 & r_pz == 0);
    rss_idx = find(l_pz ~= 0 & r_pz == 0);

    lss([lss_idx]) = 1;
    ds([ds_idx]) = 1;
    rss([rss_idx]) = 1;
end