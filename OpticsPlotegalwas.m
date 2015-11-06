function OpticsPlotegalwas(PlotMode, namevec) 


% SimOsc beta
% modified by Wolfgang Tress 21.12.07
% Breyer

% List of different PlotModes
% 1 - creating color map uv2red
%% 2 - inversion of the color order
%% 3 - intensity plot
% 4 - absorptance of each layer
%% 5 - interference 2 LambertBeer
% 6 - Q-Profile
% 7 - sum Q-Profile
%% 8 - separated contribution of Lambert-Beer, reflection and interference
%% 9 - absorptance on hugh mesh
%% 10 - transmittance of glass

% constants
mesh = 501;

% load the optical data


eval(['load OpticalValgui.mat TransmitTM rhoTM deltaTM q alpha d subGlass subGlassNoAbsorp absorptance']);
%eval(['load OpticalValITO' num2str(kdPc) 'Pc' num2str(kdC60) 'C60190ITO17BCP.mat TransmitTM rhoTM deltaTM q alpha d subGlass subGlassNoAbsorp absorptance']);
%eval(['load OpticalValPEDOT' num2str(kdPc) 'Pc' num2str(kdC60) 'C60100ITO25PEDOT10BCP.mat TransmitTM rhoTM deltaTM q alpha d subGlass subGlassNoAbsorp absorptance']);

%  due to mystic problems alpha is recalculated although seeming senseless :-( 
for k=1:mesh
    alpha(k,:) = 4*pi*imag(q(k,:))./((349+k)*1e-9);      % for mesh=501
end

layers = length(d)-1;

% start of the PlotModes

% creating colormap uv2red
if PlotMode == 1
   %layers = 6; %ITO/PEDOT/ZnPc/C60/BCP/Al     
   colors = zeros(mesh*layers,3);     
   for k=1:mesh
     if k<31
        RGBvalue(1,1) = 1;
        RGBvalue(1,2) = 0;
        RGBvalue(1,3) = 1;
        for j=0:(layers-1)
          colors(k*layers-j,:) = RGBvalue(1,:);
        end
     end
     
     if k>30
        if k<91
          RGBvalue(1,1) = -(350+k - 440) / (440 - 380);
          RGBvalue(1,2) = 0;
          RGBvalue(1,3) = 1;
          for j=0:(layers-1)
            colors(k*layers-j,:) = RGBvalue(1,:);
          end
        end
     end
     
     if k>90
        if k<141
          RGBvalue(1,1) = 0;
          RGBvalue(1,2) = (350+k - 440) / (490 - 440);
          RGBvalue(1,3) = 1;
          for j=0:(layers-1)
            colors(k*layers-j,:) = RGBvalue(1,:);
          end
        end
     end
      
     if k>140
        if k<161
          RGBvalue(1,1) = 0;
          RGBvalue(1,2) = 1;
          RGBvalue(1,3) = -(350+k - 510) / (510 - 490);
          for j=0:(layers-1)
            colors(k*layers-j,:) = RGBvalue(1,:);
          end
        end
     end

     if k>160
        if k<231
          RGBvalue(1,1) = (350+k - 510) / (580 - 510);
          RGBvalue(1,2) = 1;
          RGBvalue(1,3) = 0;
          for j=0:(layers-1)
            colors(k*layers-j,:) = RGBvalue(1,:);
          end
        end
     end
     
     if k>230
        if k<295
          RGBvalue(1,1) = 1;
          RGBvalue(1,2) = -(350+k - 645) / (645 - 580);
          RGBvalue(1,3) = 0;
          for j=0:(layers-1)
            colors(k*layers-j,:) = RGBvalue(1,:);
          end
        end
     end

     if k>294
          RGBvalue(1,1) = 1;
          RGBvalue(1,2) = 0;
          RGBvalue(1,3) = 0;
          for j=0:(layers-1)
            colors(k*layers-j,:) = RGBvalue(1,:);
          end
     end
   end
   save colorRGBgui.mat colors
end



% inversion of the color order
if PlotMode == 2
   %layers = 6;  %ITO/PEDOT/ZnPc/C60/BCP/Al
   load colorRGBgui.mat colors
 
   colors1 = colors;
   colors2 = zeros(1503,3);
   for k=1:mesh
     for j=0:(layers-1)
       colors2(k*layers-j,:) = colors1((mesh+1-k)*layers-j,:);
     end
   end
   colors = colors2;
   save colorRGBgui.mat colors
end
   


% Intensity Plot 
if PlotMode == 3
    
  % the colorMatrix colors is included!
  load colorRGBgui.mat
  
  % varibles for this plotting     
  thick = zeros(1,layers);                % added thicknes of the layers
  x = zeros(layers,100,mesh);                    % intervals of the layers
  plothv = zeros(layers,100,mesh);             % matrix of plots

  %LineInterval
  %1-every wavelength, 2-every second, 5-every fifth and so on
  LineInterval = 20; 
  if LineInterval == 1
    set(gcf,'DefaultAxesColorOrder',colors);
  end
  if LineInterval > 1
    colorsLI = zeros(((mesh-1)/LineInterval+1)*layers,3);
    colorsLI(1:layers,:) = colors(1:layers,:);
    for k = 2:mesh
      if ~mod(k,LineInterval)
        colorsLI(((k/LineInterval)*layers+1):((k/LineInterval)*layers+layers),:)=colors(k*layers+1:k*layers+layers,:);
      end
    end
    set(gcf,'DefaultAxesColorOrder',colorsLI);
  end
 % defining the grid and consequtive thicknesses 
 for k=1:mesh
  for j=1:layers             %ITO,PEDOT,ZnPc,C60,BCP,Al
   if j == 1
    thick(j) = 0;
    x(j,:,k) = linspace(thick(j),(thick(j)+d(j+1)));
   end
   if j > 1
    thick(j) = thick(j-1) + d(j);
    x(j,:,k) = linspace(thick(j),(thick(j)+d(j+1)));
   end
  end
 end    

 % creating of all curves for plotting
 for k = 1:mesh;
  for j=1:layers-1      % ITO,PEDOT,ZnPc,C60,BCP
    plothv(j,:,k) = subGlass(k,1)*(real(q(k,1))/real(q(k,j+1)))*TransmitTM(k,j+1)*(exp(-alpha(k,j+1)*(x(j,:,k)-thick(j))) +...
       rhoTM(k,j+1)^2*exp(-alpha(k,j+1)*(2*d(j+1)-(x(j,:,k)-thick(j)))) +...
       2*rhoTM(k,j+1)*exp(-alpha(k,j+1)*d(j+1))*cos((4*pi*real(q(k,j+1))/((349+k)*1e-9))*...
       (d(j+1)-(x(j,:,k)-thick(j))) + deltaTM(k,j+1)));
    
  end
  %extinction of intensity in Al
  plothv(j+1,:,k) = subGlass(k,1)*(real(q(k,1))/real(q(k,j+2)))*TransmitTM(k,j+2)*(exp(-alpha(k,j+2)*(x(j+1,:,k)-thick(j+1))));
 end

% start with the plotting
%  normal order
  k=1; 
  for j = 1:layers
   plot(x(j,:,k),plothv(j,:,k),'LineWidth',2)
  end
  %plot(x(1,:,k),plothv(1,:,k),x(2,:,k),plothv(2,:,k),x(3,:,k),plothv(3,:,k),x(4,:,k),plothv(4,:,k),x(5,:,k),plothv(5,:,k),x(6,:,k),plothv(6,:,k));
  %reverse order
%  k=mesh; 
%  plot(x(1,:,k),plothv(1,:,k),x(2,:,k),plothv(2,:,k),x(3,:,k),plothv(3,:,k),x(4,:,k),plothv(4,:,k),x(5,:,k),plothv(5,:,k));
  
  % editing the axis 
  for j=2:layers
    line([thick(j) thick(j)],[0 2.5],'Color','k','LineStyle','- -','LineWidth',1);
  end

  v = axis;
   %pause(1);
  ypos = max(max(max(plothv(:,:,:))))  
  hold all;
  xlabel('Distance from glass/ITO interface of a Solar Cell  [m]','Fontsize',10);
    ylabel('EE*  [a.u.]','Fontsize',10);
    for j=1:layers
      line([thick(j) thick(j)],[0 1.05*ypos],'Color','k','LineStyle','- -','LineWidth',2);
      text(thick(j),ypos,[' ' namevec{j+1}],'FontSize',12);     % old value 95
    end
    axis tight

  for k=1:(mesh-1)            %normal order
%  for k=(mesh-1):-1:1          %reverse order
    drawnow;
    if ~mod(k,LineInterval)        
      %plot(x(1,:,k+1),plothv(1,:,k+1),x(2,:,k+1),plothv(2,:,k+1),x(3,:,k+1),plothv(3,:,k+1),x(4,:,k+1),plothv(4,:,k+1),x(5,:,k+1),plothv(5,:,k+1),x(6,:,k+1),plothv(6,:,k+1));
    for j = 1:layers
        plot(x(j,:,k),plothv(j,:,k),'LineWidth',2)
    end
    end
    % editing the plot
    
  end

end



% Plotting the absorption of each layer
if PlotMode == 4 
% definition of a individual color order
set(gcf,'DefaultAxesColorOrder',[0 1 1;0 1 0;1 0 0;0 0 1;0.5 0 0;1 0 1;0.5 0.5 0.5;0 0 0;1 0.7 0.3]);
%000Black111White100Red010Green001Blue110Yellow101Magenta011Cyan0.50.50.5Gray0.500Dark red10.620.40Copper0.4910.83Aquama

   for j=1:layers + 3;
     xlambda(:,j) = linspace(350e-9, 850e-9,mesh);
   end

   j=1;
   plot(xlambda(:,j),absorptance(:,j), 'LineWidth',2);
   title('Absorptance within the layered Solar Cell','Fontsize',14);
   xlabel('Wavelength [m]','Fontsize',12);
   ylabel('Absorptance','Fontsize',12);
   layers
   for j=2:layers+3;
     hold all;
     plot(xlambda(:,j),absorptance(:,j),'LineWidth',2);
     hold off;
   end
   for j=1:layers
       nanoglas{j} = namevec{j+1};
   end
   nanoglas{layers+1} = 'glass';
   nanoglas{layers+2} = 'sum Absorp';
   nanoglas{layers+3} = 'Absorp&GlassReflec';
   legend(nanoglas);
%    for j=1:layers
%        legend{j} = namevec{j+1};
%    end
%    legend{layers+1} = 'sum Absorp';
%    legend{layers+2} = 'Absorp&GlassReflec';
   %legend('ITO','PEDOT:PSS','ZnPc','C_6_0','BCP','Al','Glass','sum Absorp','Absorp&GlassReflec',1);
end    



% interference 2 LambertBeer
if PlotMode == 5
  ReCalc = 0;

  % varibles for this plotting
  PcSteps = 108; %5:5:400
  
 if ReCalc == 1
  x = zeros(PcSteps,100,mesh);                    % intervals of the layers
  plothvInt = zeros(PcSteps,100,mesh);             % matrix of plots
  plothvLam = zeros(PcSteps,100,mesh);             % matrix of plots
 % creating of all curves for plotting
 kdC60 = 30;
 j = 3;  % 4 is ZnPc layer no. but always (j+1) expressions!!!
 for kdPc = 5:5:540 
   % load the optical data    
   eval(['load OpticalValPEDOT' num2str(kdPc) 'Pc' num2str(kdC60) 'C60190ITO25PEDOT17BCP.mat TransmitTM rhoTM deltaTM q alpha d subGlass subGlassNoAbsorp absorptance']);
   for k = 1:mesh;
      % defining the grid and consequtive thicknesses 
      x(kdPc/5,:,k) = linspace(0,d(j+1));
      % defining the curves of Interference and LambertBeer
      % (real(q(k,1))/real(q(k,j+1)))*
      plothvInt(kdPc/5,:,k) = subGlass(k,1)*TransmitTM(k,j+1)*(exp(-alpha(k,j+1)*(x(kdPc/5,:,k))) +...
            rhoTM(k,j+1)^2*exp(-alpha(k,j+1)*(2*d(j+1)-(x(kdPc/5,:,k)))) +...
            2*rhoTM(k,j+1)*exp(-alpha(k,j+1)*d(j+1))*cos((4*pi*real(q(k,j+1))/((349+k)*1e-9))*...
            (d(j+1)-(x(kdPc/5,:,k))) + deltaTM(k,j+1)));
      % (real(q(k,1))/real(q(k,j+1)))*
      plothvLam(kdPc/5,:,k) = subGlass(k,1)*TransmitTM(k,j+1)*(exp(-alpha(k,j+1)*(x(kdPc/5,:,k))));
    end
 end
 save Int2LamData.mat x plothvInt plothvLam
end
 
load Int2LamData.mat x plothvInt plothvLam
% start with the plotting
  k=272; 
  
%for cycle = 0:3  
cycle = 5;
  plot(x(18*cycle+1,:,k),plothvInt(18*cycle+1,:,k),'g',x(18*cycle+1,:,k),plothvLam(18*cycle+1,:,k),'k','LineWidth',2);
  % editing the axis 
  v = axis;
  pause(3);
  hold all;
  for kdPc = (cycle*90+10):5:(cycle*90+90)            %normal order
    drawnow;
    plot(x(kdPc/5,:,k),plothvInt(kdPc/5,:,k),'g',x(kdPc/5,:,k),plothvLam(kdPc/5,:,k),'k','LineWidth',2);
    pause(1);
    xlabel('Distance in ZnPc [m]','Fontsize',16);
    ylabel('EE*  [a.u.]','Fontsize',16);
    legend('real profile','only Lambert-Beer');
  end  
%end
end



% plotting the Q-Profile
if PlotMode == 6
  
  % varibles for this plotting
  %layers = 6; %ITO/PEDOT/ZnPc/C60/BCP/Al     
  thick = zeros(1,layers);                % added thicknes of the layers
  x = zeros(layers,100,mesh);                    % intervals of the layers
  qvaluex = zeros(layers,100,mesh);             % matrix of plots

 % defining the grid and consequtive thicknesses 
 for k=1:mesh
  for j=1:layers             %ITO,PEDOT,ZnPc,C60,BCP,Al
   if j == 1
    thick(j) = 0;
    x(j,:,k) = linspace(thick(j),(thick(j)+d(j+1)));
   end
   if j > 1
    thick(j) = thick(j-1) + d(j);
    x(j,:,k) = linspace(thick(j),(thick(j)+d(j+1)));
   end
  end
 end    

 % creating of all curves for plotting
 for k = 1:mesh;
  for j=1:layers-1      % ITO,PEDOT,ZnPc,C60,BCP
    qvaluex(j,:,k) = subGlass(k,1)*alpha(k,j+1)*TransmitTM(k,j+1)*(exp(-alpha(k,j+1)*(x(j,:,k)-thick(j))) +...
       rhoTM(k,j+1)^2*exp(-alpha(k,j+1)*(2*d(j+1)-(x(j,:,k)-thick(j)))) +...
       2*rhoTM(k,j+1)*exp(-alpha(k,j+1)*d(j+1))*cos((4*pi*real(q(k,j+1))/((349+k)*1e-9))*...
       (d(j+1)-(x(j,:,k)-thick(j))) + deltaTM(k,j+1)));
   end
  %extinction of intensity in Al
  qvaluex(j+1,:,k) = subGlass(k,1)*alpha(k,j+2)*TransmitTM(k,j+2)*(exp(-alpha(k,j+2)*(x(j+1,:,k)-thick(j+1))));
 end
 % shifting the units from W/(m^2*m) to W/(m^2*nm)
 qvaluex = qvaluex * 1e-9;
 ypos = max(max(max(qvaluex)));
% start with the plotting
  set(gcf,'DefaultAxesColorOrder',[0 0 1;0 1 0;1 0 0]);
  %000Black111White100Red010Green001Blue110Yellow101Magenta011Cyan0.50.50.5Gray0.500Dark red10.620.40Copper0.4910.83Aquama
  for cycle = 1:1:layers
    k1=97;     % wavelength of 447nm
    k3=200;    % wavelength of 550nm
    k2=272;    % wavelength of 622nm
    plot(x(cycle,:,k1),qvaluex(cycle,:,k1),x(cycle,:,k3),qvaluex(cycle,:,k3),x(cycle,:,k2),qvaluex(cycle,:,k2),'LineWidth',2);
    v = axis;
    hold all;
    drawnow;
  end
  
 legend('447 nm','550 nm','622 nm',2);
 
 for j=1:layers
      line([thick(j) thick(j)],[0 1.05*ypos],'Color','k','LineStyle','- -','LineWidth',2);
      text(thick(j),ypos,[' ' namevec{j+1}],'FontSize',12);     % old value 95
 end    
 title('Q-Profile at different wavelengthes', 'FontSize', 14);
 xlabel('Distance from glass/ITO interface [m]','Fontsize',12);
 ylabel('Q  [W/m^2 nm]','Fontsize',12);
 axis tight
 hold off; 
end



% plotting the sume Q-Profile
if PlotMode == 7
  
  % varibles for this plotting
  %layers = 6; %ITO/PEDOT/ZnPc/C60/BCP/Al     
  thick = zeros(1,layers);                % added thicknes of the layers
  x = zeros(layers,100,mesh);                    % intervals of the layers
  qvaluex = zeros(layers,100,mesh);             % matrix of plots

 % defining the grid and consequtive thicknesses 
 for k=1:mesh
  for j=1:layers             %ITO,PEDOT,ZnPc,C60,BCP,Al
   if j == 1
    thick(j) = 0;
    x(j,:,k) = linspace(thick(j),(thick(j)+d(j+1)));
   end
   if j > 1
    thick(j) = thick(j-1) + d(j);
    x(j,:,k) = linspace(thick(j),(thick(j)+d(j+1)));
   end
  end
 end    

 % creating of all curves for plotting
 for k = 1:mesh;
  for j=1:layers-1      % ITO,PEDOT,ZnPc,C60,BCP
    qvaluex(j,:,k) = subGlass(k,1)*alpha(k,j+1)*TransmitTM(k,j+1)*(exp(-alpha(k,j+1)*(x(j,:,k)-thick(j))) +...
       rhoTM(k,j+1)^2*exp(-alpha(k,j+1)*(2*d(j+1)-(x(j,:,k)-thick(j)))) +...
       2*rhoTM(k,j+1)*exp(-alpha(k,j+1)*d(j+1))*cos((4*pi*real(q(k,j+1))/((349+k)*1e-9))*...
       (d(j+1)-(x(j,:,k)-thick(j))) + deltaTM(k,j+1)));
   end
  %extinction of intensity in Al
  qvaluex(j+1,:,k) = subGlass(k,1)*alpha(k,j+2)*TransmitTM(k,j+2)*(exp(-alpha(k,j+2)*(x(j+1,:,k)-thick(j+1))));
 end
 % shifting the units from W/(m^2*m) to W/(m^2*nm)
 qvaluex = qvaluex * 1e-9;
 
 % summing up all single Q values
 for j=1:layers      % ITO,PEDOT,ZnPc,C60,BCP,Al
   for k = 2:mesh
     qvaluex(j,:,1) = qvaluex(j,:,1) + qvaluex(j,:,k);
   end
 end
 ypos = max(max(max(qvaluex)));
% start with the plotting
  k=1;
  hold on
  for j = 1:layers
        plot(x(j,:,k),qvaluex(j,:,k),'Color','blue','LineWidth',2)
  end
   % plot(x(1,:,k),qvaluex(1,:,k),'b',x(2,:,k),qvaluex(2,:,k),'b',x(3,:,k),qvaluex(3,:,k),'b',x(4,:,k),qvaluex(4,:,k),'b',x(5,:,k),qvaluex(5,:,k),'b','LineWidth',2);

 for j=1:layers
      line([thick(j) thick(j)],[0 1.1*ypos],'Color','k','LineStyle','- -','LineWidth',2);
      text(thick(j),ypos,[' ' namevec{j+1}],'FontSize',12);     % old value 95
 end    
hold off
 title('Sum of Q-Profile', 'FontSize', 14);
 xlabel('Distance from glass/ITO interface [m]','Fontsize',12);
 ylabel('Q  [W/m^2 nm]','Fontsize',12);
 axis tight
 hold off;  
end



% plotting separated contribution of LambertBeer, reflection, interference
if PlotMode == 8
  
  % varibles for this plotting
  layers = 6; %ITO/PEDOT/ZnPc/C60/BCP/Al     
  thick = zeros(1,layers);                % added thicknes of the layers
  x = zeros(layers,100,mesh);                    % intervals of the layers
  qvaluex = zeros(layers,100,mesh);             % matrix of plots

 % defining the grid and consequtive thicknesses 
 for k=1:mesh
  for j=1:layers             %ITO,PEDOT,ZnPc,C60,BCP,Al
   if j == 1
    thick(j) = 0;
    x(j,:,k) = linspace(thick(j),(thick(j)+d(j+1)));
   end
   if j > 1
    thick(j) = thick(j-1) + d(j);
    x(j,:,k) = linspace(thick(j),(thick(j)+d(j+1)));
   end
  end
 end    

 % creating of all curves for plotting
 for k = 1:mesh;
  for j=1:layers-1      % ITO,PEDOT,ZnPc,C60,BCP
    qvalueAll(j,:,k) = subGlass(k,1)*(real(q(k,1))/real(q(k,j+1)))*TransmitTM(k,j+1)*(exp(-alpha(k,j+1)*(x(j,:,k)-thick(j))) +...
       rhoTM(k,j+1)^2*exp(-alpha(k,j+1)*(2*d(j+1)-(x(j,:,k)-thick(j)))) +...
       2*rhoTM(k,j+1)*exp(-alpha(k,j+1)*d(j+1))*cos((4*pi*real(q(k,j+1))/((349+k)*1e-9))*...
       (d(j+1)-(x(j,:,k)-thick(j))) + deltaTM(k,j+1)));
    qvalueLam(j,:,k) = subGlass(k,1)*(real(q(k,1))/real(q(k,j+1)))*TransmitTM(k,j+1)*(exp(-alpha(k,j+1)*(x(j,:,k)-thick(j))));
    qvalueRef(j,:,k) = subGlass(k,1)*(real(q(k,1))/real(q(k,j+1)))*TransmitTM(k,j+1)*(rhoTM(k,j+1)^2*exp(-alpha(k,j+1)*(2*d(j+1)-(x(j,:,k)-thick(j)))));
    qvalueInt(j,:,k) = subGlass(k,1)*(real(q(k,1))/real(q(k,j+1)))*TransmitTM(k,j+1)*(2*rhoTM(k,j+1)*exp(-alpha(k,j+1)*d(j+1))*...
        cos((4*pi*real(q(k,j+1))/((349+k)*1e-9))*(d(j+1)-(x(j,:,k)-thick(j))) + deltaTM(k,j+1)));
   end
  %extinction of intensity in Al
  qvalueAll(j+1,:,k) = subGlass(k,1)*(real(q(k,1))/real(q(k,j+2)))*TransmitTM(k,j+2)*(exp(-alpha(k,j+2)*(x(j+1,:,k)-thick(j+1))));
  qvalueLam(j+1,:,k) = subGlass(k,1)*(real(q(k,1))/real(q(k,j+2)))*TransmitTM(k,j+2)*(exp(-alpha(k,j+2)*(x(j+1,:,k)-thick(j+1))));
  qvalueRef(j+1,:,k) = 0;
  qvalueInt(j+1,:,k) = 0;
 end
    
% start with the plotting
  k=272; 
  
  subplot(4,1,1)
  plot(x(1,:,k),qvalueAll(1,:,k),'r',x(2,:,k),qvalueAll(2,:,k),'r',x(3,:,k),qvalueAll(3,:,k),'r',x(4,:,k),qvalueAll(4,:,k),'r',x(5,:,k),qvalueAll(5,:,k),'r',x(6,:,k),qvalueAll(6,:,k),'r','LineWidth',2);
  for j=2:layers
    line([thick(j) thick(j)],[0 3],'Color','k','LineStyle','- -','LineWidth',2);
  end
  xlabel('Distance from glass/ITO interface of a ITO/PEDOT:PSS/ZnPc/C_6_0/BCP/Al Solar Cell  [nm]','Fontsize',14);
  ylabel('EE*  [a.u.]','Fontsize',14);
  text( 95e-9,2.25,'ITO','FontSize',14);
  text(192e-9,2.25,'PED','FontSize',14);
  text(220e-9,2.25,'ZnPc','FontSize',14);
  text(250e-9,2.25,'C_6_0','FontSize',14);
  text(275e-9,2.25,'BCP','FontSize',14);
  text(300e-9,2.25,'Al','FontSize',14); 
  legend('@ 622 nm',2);
  
  subplot(4,1,2)
  plot(x(1,:,k),qvalueLam(1,:,k),'r',x(2,:,k),qvalueLam(2,:,k),'r',x(3,:,k),qvalueLam(3,:,k),'r',x(4,:,k),qvalueLam(4,:,k),'r',x(5,:,k),qvalueLam(5,:,k),'r',x(6,:,k),qvalueLam(6,:,k),'r','LineWidth',2);
  for j=2:layers
    line([thick(j) thick(j)],[0 1],'Color','k','LineStyle','- -','LineWidth',2);
  end
  xlabel('Contribution of Lambert-Beer term','Fontsize',14);
  ylabel('EE*  [a.u.]','Fontsize',14);
  
  subplot(4,1,3)
  plot(x(1,:,k),qvalueRef(1,:,k),'r',x(2,:,k),qvalueRef(2,:,k),'r',x(3,:,k),qvalueRef(3,:,k),'r',x(4,:,k),qvalueRef(4,:,k),'r',x(5,:,k),qvalueRef(5,:,k),'r',x(6,:,k),qvalueRef(6,:,k),'r','LineWidth',2);
  for j=2:layers
    line([thick(j) thick(j)],[0 1],'Color','k','LineStyle','- -','LineWidth',2);
  end
  xlabel('Contribution of reflection term','Fontsize',14);
  ylabel('EE*  [a.u.]','Fontsize',14);
  
  subplot(4,1,4)
  plot(x(1,:,k),qvalueInt(1,:,k),'r',x(2,:,k),qvalueInt(2,:,k),'r',x(3,:,k),qvalueInt(3,:,k),'r',x(4,:,k),qvalueInt(4,:,k),'r',x(5,:,k),qvalueInt(5,:,k),'r',x(6,:,k),qvalueInt(6,:,k),'r','LineWidth',2);
  for j=2:layers
    line([thick(j) thick(j)],[-2 2],'Color','k','LineStyle','- -','LineWidth',2);
  end
  xlabel('Contribution of interference term','Fontsize',14);
  ylabel('EE*  [a.u.]','Fontsize',14);
  
end



% 9 - absorptance on hugh mesh
if PlotMode == 9
SearchMode = 0;   % 0 - plot, 1 - collect the data    
    
 if SearchMode == 1
     
   AbsorpMaxITO = zeros(80,80,2);
   AbsorpMaxPEDOT = zeros(80,80,2);
   for kdPc = 5:5:400
     for kdC60 = 5:5:400
      eval(['load OpticalValITO' num2str(kdPc) 'Pc' num2str(kdC60) 'C60190ITO17BCP.mat TransmitTM rhoTM deltaTM q alpha d subGlass subGlassNoAbsorp absorptance']);      
      AbsorpMaxITO(kdPc/5,kdC60/5,1) = absorptance(272,2);   % ITO: ZnPc at 622 nm i.e. 272
      AbsorpMaxITO(kdPc/5,kdC60/5,2) = absorptance(97,3);    % ITO: C60  at 447 nm i.e. 97
    
      eval(['load OpticalValPEDOT' num2str(kdPc) 'Pc' num2str(kdC60) 'C60190ITO25PEDOT17BCP.mat TransmitTM rhoTM deltaTM q alpha d subGlass subGlassNoAbsorp absorptance']);      
      AbsorpMaxPEDOT(kdPc/5,kdC60/5,1) = absorptance(272,3); % PEDOT: ZnPc at 622 nm i.e. 272
      AbsorpMaxPEDOT(kdPc/5,kdC60/5,2) = absorptance(97,4);  % PEDOT: C60  at 447 nm i.e. 97    
     end
     disp([' kdPc '  num2str(kdPc) ' kdC60 '  num2str(kdC60) ]); 
   end

   save AbsorpMaxHugh.mat AbsorpMaxITO AbsorpMaxPEDOT
   
 end
 
 if SearchMode == 0
     
   % ZnPc (622nm) and C60 (447nm)

   load AbsorpMaxHugh.mat AbsorpMaxITO AbsorpMaxPEDOT

   x = 5:5:400;
   y = 5:5:400;
   xx = 5:5:100;
   yy = 5:5:100;
   xxx = 5:5:50;
   yyy = 5:5:50;

   subplot(3,2,1); 
    surf(x,y,AbsorpMaxITO(:,:,1));
    colormap = hsv;
    colorbar;
    xlabel('C_6_0 Thickness [nm]','FontSize',14,'FontWeight','bold'); 
    ylabel('ZnPc Thickness [nm]','FontSize',14,'FontWeight','bold');
    zlabel('Absorptance','FontSize',14,'FontWeight','bold'); 

   subplot(3,2,2); 
    surf(x,y,AbsorpMaxITO(:,:,2));
    colormap = hsv;
    colorbar;
    xlabel('C_6_0 Thickness [nm]','FontSize',14,'FontWeight','bold'); 
    ylabel('ZnPc Thickness [nm]','FontSize',14,'FontWeight','bold');
    zlabel('Absorptance','FontSize',14,'FontWeight','bold'); 

   subplot(3,2,3); 
    surf(xx,yy,AbsorpMaxITO(1:1:20,1:1:20,1));
    colormap = hsv;
    colorbar;
    xlabel('C_6_0 Thickness [nm]','FontSize',14,'FontWeight','bold'); 
    ylabel('ZnPc Thickness [nm]','FontSize',14,'FontWeight','bold');
    zlabel('Absorptance','FontSize',14,'FontWeight','bold'); 

   subplot(3,2,4); 
    surf(xx,yy,AbsorpMaxITO(1:1:20,1:1:20,2));
    colormap = hsv;
    colorbar;
    xlabel('C_6_0 Thickness [nm]','FontSize',14,'FontWeight','bold'); 
    ylabel('ZnPc Thickness [nm]','FontSize',14,'FontWeight','bold');
    zlabel('Absorptance','FontSize',14,'FontWeight','bold'); 
  
   subplot(3,2,5); 
    surf(xxx,yyy,AbsorpMaxITO(1:1:10,1:1:10,1));
    colormap = hsv;
    colorbar;
    xlabel('C_6_0 Thickness [nm]','FontSize',14,'FontWeight','bold'); 
    ylabel('ZnPc Thickness [nm]','FontSize',14,'FontWeight','bold');
    zlabel('Absorptance','FontSize',14,'FontWeight','bold'); 

   subplot(3,2,6); 
    surf(xxx,yyy,AbsorpMaxITO(1:1:10,1:1:10,2));
    colormap = hsv;
    colorbar;
    xlabel('C_6_0 Thickness [nm]','FontSize',14,'FontWeight','bold'); 
    ylabel('ZnPc Thickness [nm]','FontSize',14,'FontWeight','bold');
    zlabel('Absorptance','FontSize',14,'FontWeight','bold'); 

 end
 
end


% 10 - Transmittance of Glass
if PlotMode == 10
% plot the data

    xlambda(:,1) = linspace(350e-9, 850e-9,mesh);
    plot(xlambda(:,1),subGlassNoAbsorp(:,1),'b',xlambda(:,1),subGlass(:,1),'k','LineWidth',2);
    xlabel('Wavelength [nm]','Fontsize',12);
    ylabel('Transmittance','Fontsize',12);
    legend('without Absorption','with Absorption',4);

end    





% end of function