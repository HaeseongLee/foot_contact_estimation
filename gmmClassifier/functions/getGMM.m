function [gmm_model, E] = getGMM(train_data, d, vis)
% Input
%     trina_data
%     d : dimension after PCA

% Output
%     E : reduction matrix
%     gmm_model: gmm result using data which is processed by PCA

    % PCA
    E = pca(train_data);
    Y = E(1:d,:)*train_data';
    gmm_model = fitgmdist(Y', 3); % 3 -> LSS, DS, RSS

% plot result of PCA and GMM
    if vis == true
        if d == 2
            figure(1)
            scatter(Y(1,:),Y(2,:),1)
            hold on
            plot(gmm_model.mu(1,1),gmm_model.mu(1,2),'xb','MarkerSize',15,'LineWidth',3)
            plot(gmm_model.mu(2,1),gmm_model.mu(2,2),'xr','MarkerSize',15,'LineWidth',3)
            plot(gmm_model.mu(3,1),gmm_model.mu(3,2),'xk','MarkerSize',15,'LineWidth',3)
            hold off
            grid on
        else
            figure(1)
            scatter3(Y(1,:),Y(2,:),Y(3,:), 1)
            hold on
            plot3(gmm_model.mu(1,1),gmm_model.mu(1,2),gmm_model.mu(1,3),'xb','MarkerSize',15,'LineWidth',3)
            plot3(gmm_model.mu(2,1),gmm_model.mu(2,2),gmm_model.mu(2,3),'xr','MarkerSize',15,'LineWidth',3)
            plot3(gmm_model.mu(3,1),gmm_model.mu(3,2),gmm_model.mu(3,3),'xk','MarkerSize',15,'LineWidth',3)
            hold off            
            grid on
        end
    end

end