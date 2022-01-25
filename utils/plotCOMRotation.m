function plotCOMRotation(fig_num, pev_r, t)
    figure(fig_num)
    for i = 1:3
        subplot(3,1,i)
        plot(t, pev_r(:,i))
        grid on
        if i == 1
            title("COM roll")
        elseif i == 2
            title("COM pitch")
        else 
            title("COM yaw")
        end
        ylabel("Anlge (rad)")
        xlabel("Time (s)")

    end
end