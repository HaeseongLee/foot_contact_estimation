function plotFootRotation(fig_num, l_r, l_ref_r, r_r, r_ref_r, t)
    figure(fig_num)
    for i = 1:3
        subplot(3,2,2*i-1)
        plot(t, l_r(:,i))
        hold on
        plot(t, l_ref_r(:,i),'--')
        grid on
        hold off
        if i == 1
            title("Left Foot Roll")
        elseif i == 2
            title("Left Foot Pitch")
        else
            title("Left Foot Yaw")
        end
        ylabel("Rotation (rad)")

        subplot(3,2,2*i)
        plot(t, r_r(:,i))
        hold on
        plot(t, r_ref_r(:,i),'--')
        grid on
        hold off
        if i == 1
            title("Right Foot Roll")
        elseif i == 2
            title("Right Foot Pitch")
        else
            title("Right Foot Yaw")
        end
    end

end