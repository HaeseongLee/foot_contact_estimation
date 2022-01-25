function plotJointAngle(fig_num, l_q, l_ref_q, r_q, r_ref_q, t)
    figure(fig_num) 
    subplot(2,1,1)
    plot(t, l_q)
    hold on
    plot(t, l_ref_q, '--' )
    grid on
    hold off
    title("Left Joint Angle")
    ylabel("Angle (rad)")

    subplot(2,1,2)
    plot(t, r_q)
    hold on
    plot(t, r_ref_q, '--' )
    grid on
    hold off
    title("Right Joint Angle")
    ylabel("Angle (rad)")
    xlabel("Time (s)")
end