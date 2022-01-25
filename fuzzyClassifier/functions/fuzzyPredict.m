function [ct_hat, U] = fuzzyPredict(X_lin, X_ang, F)
% Input
%     X_lin : linear acceleration input data to be estimated
%     X_ang : angluar velocity input data to be estimated
%     F : trained fuzzy model
%     foot : left foot or right foot
    
    c_trans = F.translation(:,:,1:3);
    c_ori = F.orientation(:,:,1:3);
       
    % compute degree of membership for each component
    % it is organized that the second row component to be meant 
    % the contact probability
    m = F.fuzziness;    
    U.x = computeMembership(X_lin(:,[1,4]),c_trans(:,:,1), m);
    U.y = computeMembership(X_lin(:,[2,5]),c_trans(:,:,2), m);
    U.z = computeMembership(X_lin(:,[3,6]),c_trans(:,:,3), m);
    U.roll = computeMembership(X_ang(:,[1,4]),c_ori(:,:,1), m);
    U.pitch = computeMembership(X_ang(:,[2,5]),c_ori(:,:,2), m);
    U.yaw = computeMembership(X_ang(:,[3,6]),c_ori(:,:,3), m);
    
    % apply moving average filter 
    window_size = 40;
    p_x = movmean(U.x(1,:), [window_size-1, 0]);
    p_y = movmean(U.y(1,:), [window_size-1, 0]);
    p_z = movmean(U.z(1,:), [window_size-1, 0]);
    p_roll = movmean(U.roll(1,:), [window_size-1, 0]);
    p_pitch = movmean(U.pitch(1,:), [window_size-1, 0]);
    p_yaw = movmean(U.yaw(1,:), [window_size-1, 0]);
        
    ct_index = find(p_x>0.5 & p_y>0.5 & p_z>0.5 & ...
                         p_roll>0.5 & p_pitch>0.5 & p_yaw>0.5);
%     ct_index = find(p_x>0.5 & p_y>0.5 & p_z>0.5);  
    % ct_index = find(p_z>0.5);
    [N, ~] = size(X_lin);
%     ct_hat = zeros(N,1);
%     ct_hat([ct_index]) = 1;
    
    ct_hat = ones(N,1);
    ct_hat([ct_index]) = 0;

%     subplot(2,1,2)
%     plot(U_yaw(2,:))
%     hold on
% %     plot(1- U_x(2,:),'--')
%     hold off
%     grid on

%     subplot(3,2,1)
%     plotFuzzyClustring(X_lin(:,[1,4]), c_trans(:,:,1), U_x)
%     title("Left X")
%     subplot(3,2,3)
%     plotFuzzyClustring(X_lin(:,[2,5]), c_trans(:,:,2), U_y)
%     title("Left Y")
%     subplot(3,2,5)
%     plotFuzzyClustring(X_lin(:,[3,6]), c_trans(:,:,3), U_z)
%     title("Left Z")
%     subplot(3,2,2)
%     plotFuzzyClustring(X_ang(:,[1,4]), c_ori(:,:,1), U_roll)
%     title("Left Roll")
%     subplot(3,2,4)
%     plotFuzzyClustring(X_ang(:,[2,5]), c_ori(:,:,2), U_pitch)
%     title("Left Pitch")
%     subplot(3,2,6)
%     plotFuzzyClustring(X_ang(:,[3,6]), c_ori(:,:,3), U_yaw)
%     title("Left Yaw")
 


end