function [l_ct, r_ct] = getFootContactLabel(l_pz, r_pz)
    l_ct = zeros(length(l_pz),1);
    r_ct = zeros(length(r_pz),1);
    
    l_contact_idx = find(l_pz == 0);
    r_contact_idx = find(r_pz == 0);
    
    l_ct([l_contact_idx]) = 1;
    r_ct([r_contact_idx]) = 1;

end