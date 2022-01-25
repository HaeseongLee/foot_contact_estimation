function plotFuzzyResult(y_true, y_hat, t, type)
    
    plot(t, y_true,'LineWidth',2);
    hold on
    plot(t, y_hat, '--','LineWidth',2)
    ylim([-0.1, 1.2])
    grid on
    hold off    
    yticks([0, 1])
    yticklabels({'N' 'P'})
    set(gca,'FontName','Times','FontSize',10);
    ylabel("Contact", FontName='Times New Romman', FontSize=12)
    xlabel("Time (s)", FontName='Times New Romman', FontSize=12)
    if type == "left"
        title("Left Leg Contact Probability", FontName='Times', FontSize=12, FontWeight='normal')
        legend('Ground Truth', 'Estimation')
    else
        title("Right Leg Contact Probability", FontName='Times', FontSize=12, FontWeight='normal')
    end
    

end