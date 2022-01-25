function plotJointAngluarVelocity(fig_num, l_qd, r_qd, t)
    figure(fig_num) 
    subplot(2,1,1)
    plot(t, l_qd)
    grid on
    title("Left Joint Angular Velocity")
    ylabel("Angle (rad)")

    subplot(2,1,2)
    plot(t, r_qd)
    grid on
    title("Right Joint Angluar Velocity")
    ylabel("Angle (rad)")
    xlabel("Time (s)")
end