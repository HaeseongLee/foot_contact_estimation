function plotCOMVolcity(fig_num, pev_d, t)
    figure(fig_num)
    for i = 1:3
        subplot(3,1,i)
        plot(t, pev_d(:,i))
        grid on
        if i == 1
            title("COM x velocity")
        elseif i == 2
            title("COM y velocity")
        else 
            title("COM z velocity")
        end
        ylabel("Velocity (m/s)")
        xlabel("Time (s)")

    end
end