function fuzzy_model = getFuzzy(acc, ang_v, ft, m)
    
    % normalize data in a range of [0,1]
    acc_norm = normalize(abs(acc),'range',[0,1]);
    ang_v_norm = normalize(abs(ang_v),'range',[0,1]);    
    ft_norm = normalize(abs(ft),'range',[0,1]);
    
    % set train data 
    raw_trans = [ft_norm(:,1:3), acc_norm(:,1:3)];    
    raw_ori = [ft_norm(:,4:6), ang_v_norm(:,1:3)];
    
    % set parameters for fuzzy C-mean clustering
    K = 2; % number of clusters
    options = [m 1000, 1e-5, false];
    
    % execute fuzzy C-mean algorithm
    [C_x, ~] = fcm(raw_trans(:,[1,4]), K, options);
    [C_y, ~] = fcm(raw_trans(:,[2,5]), K, options);
    [C_z, ~] = fcm(raw_trans(:,[3,6]), K, options);
    [C_roll, ~] = fcm(raw_ori(:,[1,4]), K, options);
    [C_pitch, ~] = fcm(raw_ori(:,[2,5]), K, options);
    [C_yaw, ~] = fcm(raw_ori(:,[3,6]), K, options);
    
    C_x = arrangeCenter(C_x);
    C_y = arrangeCenter(C_y);
    C_z = arrangeCenter(C_z);
    
    C_roll = arrangeCenter(C_roll);
    C_pitch = arrangeCenter(C_pitch);
    C_yaw = arrangeCenter(C_yaw);

    % set structure to save fuzzy model
    fuzzy_model.translation(:,:,1) = C_x;
    fuzzy_model.translation(:,:,2) = C_y;
    fuzzy_model.translation(:,:,3) = C_z;
    
    fuzzy_model.orientation(:,:,1) = C_roll;
    fuzzy_model.orientation(:,:,2) = C_pitch;
    fuzzy_model.orientation(:,:,3) = C_yaw;

    fuzzy_model.fuzziness = m;
end