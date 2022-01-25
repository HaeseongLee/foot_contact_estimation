function plotFuzzyClustring(data, center, label)

    maxU = max(label);
    
    index1 = find(label(1,:) == maxU);
    index2 = find(label(2,:) == maxU);

    plot(data(index1,1),data(index1,2),'ob', 'MarkerSize',1)
    hold on
    plot(data(index2,1),data(index2,2),'or', 'MarkerSize',1)
    plot(center(1,1),center(1,2),'xb','MarkerSize',15,'LineWidth',3)
    plot(center(2,1),center(2,2),'xr','MarkerSize',15,'LineWidth',3)
    hold off
    grid on
end