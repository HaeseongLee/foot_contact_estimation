function plotFT(fig_num, l_f, r_f, t, type)
    figure(fig_num)
    if type == "force"
        for i = 1:3
            subplot(3,2,2*i-1)
            plot(t, l_f(:,i))
            grid on
            if i == 1
                title("Left Fx")
            elseif i == 2
                title("Left Fy")
            else
                title("Left Fz")
            end
            ylabel("Force (N)")
    
            subplot(3,2,2*i)
            plot(t, r_f(:,i))            
            grid on
            if i == 1
                title("Right Fx")
            elseif i == 2
                title("Right Fy")
            else
                title("Right Fz")
            end
        end
    elseif type == "moment"
        for i = 1:3
            subplot(3,2,2*i-1)
            plot(t, l_f(:,3+i))
            grid on
            if i == 1
                title("Left Mx")
            elseif i == 2
                title("Left My")
            else
                title("Left Mz")
            end
            ylabel("Moment (N/m)")
    
            subplot(3,2,2*i)
            plot(t, r_f(:,3+i))            
            grid on
            if i == 1
                title("Right Mx")
            elseif i == 2
                title("Right My")
            else
                title("Right Mz")
            end
        end
    end
    
end