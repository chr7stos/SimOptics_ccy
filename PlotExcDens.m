function PlotExcDens(namevec);

eval(['load ExcDensgui.mat CTExcDens']);
eval(['load OpticalValgui.mat d']);
 
layers = size(CTExcDens,2);
thick(1) = 0;
for j=2:layers             %ITO,PEDOT,ZnPc,C60,BCP,Al
    thick(j) = thick(j-1) + d(j);
end
hold all
y = max(max(CTExcDens(:,:)));

for j=1:layers-1
      line([thick(j) thick(j)],[0 1.05*y],'Color','k','LineStyle','- -','LineWidth',2);
      text(thick(j),y,[' ' namevec{j+1}],'FontSize',12); 
 end    
 title('Total Exc. Density without diffusion', 'FontSize', 14);
 xlabel('Distance from glass/ITO interface [m]','Fontsize',12);
 ylabel('CT-Exc. Genreation [1/m²s]','Fontsize',12);

for j = 2:layers
    x = thick(j-1)+linspace(0,d(j));
    plot(x,CTExcDens(:,j),'LineWidth',2)
end
axis tight