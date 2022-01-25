function plotCOMPosition(fig_num, pev, ref_pev, t)
    figure(fig_num)
    for i = 1:3
        subplot(3,1,i)
        plot(t, pev(:,i))
        hold on
        plot(t, ref_pev(:,i), '--')
        grid on
        hold off
        if i == 1
            title("COM x")
        elseif i == 2
            title("COM y")
        else
            title("COM z")
        end
        ylabel("Position (m)")
        xlabel("Time (s)")

    end
end