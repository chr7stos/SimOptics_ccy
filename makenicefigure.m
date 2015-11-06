function makenicefigure

figure
grid on
hold on
%line([-1;1],[0;0],'Color','k','LineWidth',2)
%line([0;0],[-100;100],'Color','k','LineWidth',2)
a = linspace(-1,1);
set(gca,'FontSize', 24)
set(gca,'FontWeight','normal')
set(gca,'LineWidth', 1)
xlabel('V (V)','FontSize',24, 'FontWeight', 'normal')
ylabel('J (mA/cm²)','FontSize',24, 'FontWeight', 'normal')
%title('title','FontSize',16)