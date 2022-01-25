function plotFootPosition(fig_num, l_p, l_ref_p, r_p, r_ref_p, t)
    figure(fig_num)

    for i = 1:3
        subplot(3,2,2*i-1)
        plot(t, l_p(:,i))
        hold on
        plot(t, l_ref_p(:,i),'--')
        grid on
        hold off
        if i == 1
            title("Left Foot X")
        elseif i == 2
            title("Left Foot Y")
        else
            title("Left Foot Z")
        end
        ylabel("Position (m)")

        subplot(3,2,2*i)
        plot(t, r_p(:,i))
        hold on
        plot(t, r_ref_p(:,i),'--')
        grid on
        hold off
        if i == 1
            title("Right Foot X")
        elseif i == 2
            title("Right Foot Y")
        else
            title("Right Foot Z")
        end
    end
end