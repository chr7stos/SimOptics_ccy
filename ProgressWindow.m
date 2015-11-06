function ProgressWindow(Fig, name, prog)
if prog > 100 prog = 100;
end
figure(Fig)
%clf reset
%axis([0 100 -0.1 0.1])
%axis off
%set(Fig,'Visible', 'on')
%if get(Fig,)
if strcmp(get(Fig,'name'),name) == 0
set(Fig,'Position',[10  100 400 50 ])
set(Fig,'NumberTitle', 'off')
set(Fig,'Name', name)
set(Fig,'Toolbar', 'none')
set(Fig,'Menubar', 'none')
set(Fig,'Resize', 'off')
set(Fig,'SelectionHighlight', 'off')
%set(Fig,'WindowStyle','docked')
end
plot([0 100],[0 0],'LineWidth',1)
hold on
plot([0 prog],[0 0],'LineWidth',10)
hold off
axis off
%figure;