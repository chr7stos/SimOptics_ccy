function IscQEegalwas(L, prop)

% SimOsc beta
% modified by Wolfgang Tress 21.12.07
% prop: property: 0 inactive, 1 charge collect left 2 charge collect right
% 3 charge collect both, 11 no quenching 21 no quenching

% 2006 07 07 ch breyer


% load the optical data   
eval(['load OpticalValgui.mat TransmitTM rhoTM deltaTM q alpha d subGlass subGlassNoAbsorp absorptance']);

% some constants
  mesh = 501;
  tau = ones(1,length(d))*1e-10; % in the end exciton lifetime is not needed since it is gekürzt in the end formulas!!
  c = zeros(1,12);            % coeff for diff.eq c12 (ITO/Pc/C60)
                              % c34 (Membran/Pc/C60)  c56 (Pedot/Pc/C60)
                              % c78 (Pc/C60/Al)      c910 (Pc/C60/Membran)
                              % c1112 (Pc/C60/Pedot-BCP)

%  due to mystic problems alpha is recalculated although seeming senseless :-( 
for k=1:mesh
    alpha(k,:) = 4*pi*imag(q(k,:))./((349+k)*1e-9);      % for mesh=501
end


%% QuantumEfficiencyITOAl;     
  % main begins
  % preparing values for the exciton density function
  % boundary conditions are a full quenching at Pc and C60
  % Pc layer
  QEValue = zeros(100,9);
  Iscright = zeros(1,length(d));
  Iscleft = zeros(1,length(d));
  numberl = zeros(1,length(d));
  numberl(1) = 1;
for l = 2:length(d) %skip glas


if (prop(l) > 0) & (prop(l) ~= 4)

for k=1:100
  lambda=k*5;
  x = linspace(d(l-1)*1e9,(d(l-1)+d(l))*1e9);  
  % without intensity!!
  gamma = alpha(lambda,l)*TransmitTM(lambda,l) / (((L(l)*1e-9)^2/tau(l))*(1/(L(l)*1e-9)^2-alpha(lambda,l)^2));
  % equal C1 and C2
  delta(1) = rhoTM(lambda,l)^2*exp(-2*alpha(lambda,l)*d(l));
  delta(2) = (1/(L(l)*1e-9)^2-alpha(lambda,l)^2) / (1/(L(l)*1e-9)^2+(4*pi*real(q(lambda,l))/((lambda+349)*1e-9))^2) *2*rhoTM(lambda,l)*exp(-alpha(lambda,l)*d(l));
  qvaluex = subGlass(lambda,1)*alpha(lambda,l)*TransmitTM(lambda,l)*(exp(-alpha(lambda,l)*(x*1e-9-d(l-1))) + rhoTM(lambda,l)^2*exp(-alpha(lambda,l)*(2*d(l)-(x*1e-9-d(l-1)))) +...
              2*rhoTM(lambda,l)*exp(-alpha(lambda,l)*d(l))*cos((4*pi*real(q(lambda,l))/((349+lambda)*1e-9))*(d(l)-(x*1e-9-d(l-1))) + deltaTM(lambda,l)));
  genPc = qvaluex;

 if (prop(l) == 2) | (prop(l) == 21) | (prop(l) == 3)
  %ITOPcC60Boundary;  
  M = [exp(-d(l)*1e9/L(l)) exp(d(l)*1e9/L(l)); 1 1];   % coeff matrix for c12
  dv = [(-exp(-alpha(lambda,l)*d(l)) -delta(1)*exp(alpha(lambda,l)*d(l)) - delta(2)*cos(deltaTM(lambda,l)));
        (-1 - delta(1) - delta(2)*cos((4*pi*real(q(lambda,l))/((lambda+349)*1e-9))*d(l) + deltaTM(lambda,l)))]; %disturbtion vector
  sv = inv(M)*dv;                                         % solution vector
  c(1) = sv(1);
  c(2) = sv(2);
   
  nPcITO = (1/tau(l))*subGlass(lambda,1)*gamma*(c(1)*exp(-(x*1e-9-d(l-1))/(L(l)*1e-9)) + c(2)*exp((x*1e-9-d(l-1))/(L(l)*1e-9)) + exp(-alpha(lambda,l)*(x*1e-9-d(l-1))) + delta(1)*exp(alpha(lambda,l)*(x*1e-9-d(l-1))) +...
           delta(2)*cos((4*pi*real(q(lambda,l))/((lambda+349)*1e-9))*(d(l-1)+d(l)-x*1e-9) + deltaTM(lambda,l)));
  
  
  %PedotPcC60Boundary;    % be careful there is a index shift and the pedot boundary is assumed!!!
  M = [exp(-d(l)/(L(l)*1e-9)) exp(d(l)/(L(l)*1e-9)); -1/(L(l)*1e-9) 1/(L(l)*1e-9)];   % coeff matrix for c56
  dv = [(-exp(-alpha(lambda,l)*d(l)) - delta(1)*exp(alpha(lambda,l)*d(l)) - delta(2)*cos(deltaTM(lambda,l)));...
        (alpha(lambda,l) - alpha(lambda,l)*delta(1) - delta(2)*(4*pi*real(q(lambda,l))/((lambda+349)*1e-9))*...
         sin((4*pi*real(q(lambda,l))/((lambda+349)*1e-9))*d(l) + deltaTM(lambda,l)))];   %disturbtion vector
  sv = inv(M)*dv;                                         % solution vector
  c(5) = sv(1);
  c(6) = sv(2);
  
  nPcPedot = (1/tau(l))*subGlass(lambda,1)*gamma*(c(5)*exp(-(x*1e-9-d(l-1))/(L(l)*1e-9)) + c(6)*exp((x*1e-9-d(l-1))/(L(l)*1e-9)) + exp(-alpha(lambda,l)*(x*1e-9-d(l-1))) + delta(1)*exp(alpha(lambda,l)*(x*1e-9-d(l-1))) +...
             delta(2)*cos((4*pi*real(q(lambda,l))/((lambda+349)*1e-9))*(d(l-1)+d(l)-x*1e-9) + deltaTM(lambda,l)));
  % nPcITO./nPcPedot 
  if prop(l) == 21 
      verlPc = nPcPedot;
      nPcITO = nPcPedot;
  else
      % Verl-func ITOPlots
  etad = (1. - (x-d(l-1)*1e9)./(d(l)*1e9));
  etam = zeros(1,length(nPcITO(1,:)));
  for ii = 1:length(nPcITO(1,:))
    if nPcPedot(ii) > 0
      if nPcPedot(ii) < genPc(ii)
        etam(ii) = (nPcPedot(ii) - nPcITO(ii))/nPcPedot(ii);
      end
    end
    verlPc(ii) = nPcPedot(ii) + (genPc(ii) - nPcPedot(ii))*etam(ii)*etad(ii);  
  end
  end % of if prop(l) = 2 else
 else
 
  y = x;
  genC60 = genPc;
  %PcC60BCPBoundary;
  M = [1 1; exp(-(1/(L(l)*1e-9))*d(l)) exp((1/(L(l)*1e-9))*d(l))];   % coeff matrix for c78
  dv = [(-1 - delta(1) - delta(2)*cos((4*pi*real(q(lambda,l))/((lambda+349)*1e-9))*d(l) + deltaTM(lambda,l)));
        (-exp(-alpha(lambda,l)*d(l)) - delta(1)*exp(alpha(lambda,l)*d(l)) - delta(2)*cos(deltaTM(lambda,l)))];   %disturbtion vector
  sv = inv(M)*dv;                                         % solution vector
  c(7) = sv(1);
  c(8) = sv(2);   
   
  nC60Al = (1/tau(l))*subGlass(lambda,1)*gamma*(c(7)*exp(-(y*1e-9-d(l-1))/(L(l)*1e-9)) + c(8)*exp((y*1e-9-d(l-1))/(L(l)*1e-9)) + exp(-alpha(lambda,l)*(y*1e-9-d(l-1))) +...
            delta(1)*exp(alpha(lambda,l)*(y*1e-9-d(l-1))) +...
            delta(2)*cos((4*pi*real(q(lambda,l))/((lambda+349)*1e-9))*(d(l-1)+d(l)-y*1e-9) + deltaTM(lambda,l)));
    
  %PcC60BCPBoundary;
  M = [1 1; -(1/(L(l)*1e-9))*exp(-(1/(L(l)*1e-9))*d(l)) (1/(L(l)*1e-9))*exp((1/(L(l)*1e-9))*d(l))];   % coeff matrix for c1112
  dv = [(-1 - delta(1) - delta(2)*cos((4*pi*real(q(lambda,l))/((lambda+349)*1e-9))*d(l) + deltaTM(lambda,l)));
        (alpha(lambda,l)*exp(-alpha(lambda,l)*d(l)) - alpha(lambda,l)*delta(1)*exp(alpha(lambda,l)*d(l)) -...
        delta(2)*(4*pi*real(q(lambda,l))/((lambda+349)*1e-9))*sin(deltaTM(lambda,l)))];   %disturbtion vector
  sv = inv(M)*dv;                                         % solution vector
  c(11) = sv(1);
  c(12) = sv(2);
    
  nC60BCP = (1/tau(l))*subGlass(lambda,1)*gamma*(c(11)*exp(-(y*1e-9-d(l-1))/(L(l)*1e-9)) + c(12)*exp((y*1e-9-d(l-1))/(L(l)*1e-9)) + exp(-alpha(lambda,l)*(y*1e-9-d(l-1))) +...
             delta(1)*exp(alpha(lambda,l)*(y*1e-9-d(l-1))) +...
             delta(2)*cos((4*pi*real(q(lambda,l))/((lambda+349)*1e-9))*(d(l-1)+d(l)-y*1e-9) + deltaTM(lambda,l)));
   
   % Verl-func Al
  if prop(l) == 11
      verlC60 = nC60BCP;
      nC60Al = nC60BCP;
  else
    etadC60 = (y -d(l-1)*1e9)./(d(l)*1e9);   %since y=(d3,d3+d4)
    etamC60 = zeros(1,length(nC60Al(1,:)));
    for i = 1:length(nC60Al(1,:))
      if nC60BCP(i) > 0
        if nC60BCP(i) < genC60(i)
          etamC60(i) = (nC60BCP(i) - nC60Al(i))/nC60BCP(i);
        end
      end
      verlC60(i) = nC60BCP(i) + (genC60(i) - nC60BCP(i))*etamC60(i)*etadC60(i);
    end

  end % of if prop(l) ==1 else
  verlPc = verlC60;
  nPcITO = nC60Al;
  nPcPedot = nC60BCP;
  end % of if prop(l) == 21 etc else 
 
%     
% end    % BoundaryOption == 1  ITO/  /Al optics and boundary conditions
%   
%   
% if BoundaryOption == 2  
%   
%   % C60 layer
%   % without intensity !!
%   y=linspace(d(3)*1e9,(d(3)*1e9+d(4)*1e9));
%   gamma = alpha(lambda,4)*TransmitTM(lambda,4) / (((L(2)*1e-9)^2/tau(2))*(1/(L(2)*1e-9)^2-alpha(lambda,4)^2));
%   % equal C1 and C2
%   delta(1) = rhoTM(lambda,4)^2*exp(-2*alpha(lambda,4)*d(4));
%   delta(2) = (1/(L(2)*1e-9)^2-alpha(lambda,4)^2) / (1/(L(2)*1e-9)^2+(4*pi*real(q(lambda,4))/((lambda+349)*1e-9))^2) *2*rhoTM(lambda,4)*exp(-alpha(lambda,4)*d(4));
%   qvaluey = subGlass(lambda,1)*alpha(lambda,4)*TransmitTM(lambda,4)*(exp(-alpha(lambda,4)*(y*1e-9-d(3))) +...
%             rhoTM(lambda,4)^2*exp(-alpha(lambda,4)*(2*d(4)-(y*1e-9-d(3)))) +...
%             2*rhoTM(lambda,4)*exp(-alpha(lambda,4)*d(4))*cos((4*pi*real(q(lambda,4))/((349+lambda)*1e-9))*(d(3)+d(4)-y*1e-9) + deltaTM(lambda,4)));
%   genC60 = qvaluey;
%     
%   %PcC60BCPBoundary;
%   M = [1 1; -(1/(L(2)*1e-9))*exp(-(1/(L(2)*1e-9))*d(4)) (1/(L(2)*1e-9))*exp((1/(L(2)*1e-9))*d(4))];   % coeff matrix for c1112
%   dv = [(-1 - delta(1) - delta(2)*cos((4*pi*real(q(lambda,4))/((lambda+349)*1e-9))*d(4) + deltaTM(lambda,4)));
%         (alpha(lambda,4)*exp(-alpha(lambda,4)*d(4)) - alpha(lambda,4)*delta(1)*exp(alpha(lambda,4)*d(4)) -...
%         delta(2)*(4*pi*real(q(lambda,4))/((lambda+349)*1e-9))*sin(deltaTM(lambda,4)))];   %disturbtion vector
%   sv = inv(M)*dv;                                         % solution vector
%   c(11) = sv(1);
%   c(12) = sv(2);
%     
%   nC60BCP = (1/tau(2))*subGlass(lambda,1)*gamma*(c(11)*exp(-(y*1e-9-d(3))/(L(2)*1e-9)) + c(12)*exp((y*1e-9-d(3))/(L(2)*1e-9)) + exp(-alpha(lambda,4)*(y*1e-9-d(3))) +...
%              delta(1)*exp(alpha(lambda,4)*(y*1e-9-d(3))) +...
%              delta(2)*cos((4*pi*real(q(lambda,4))/((lambda+349)*1e-9))*(d(3)+d(4)-y*1e-9) + deltaTM(lambda,4)));
%   verlC60 = nC60BCP;
% 
% end   % BoundaryOption == 2 Al optics but BCP boundary  
%   
  
  % efficiency calculations
  % eta Pc
  IntegrStep = d(l)*1e9/length(verlPc(1,:));
  ValueLossPc = 0;
    for ii = 1:length(verlPc(1,:))
      if ii < length(verlPc(1,:))
        ValueRecombPc(ii) =  0.5*(verlPc(ii) + verlPc(ii+1))*IntegrStep;
      end 
      if ii == length(verlPc(1,:))
        ValueRecombPc(ii) =  verlPc(ii)*IntegrStep;
      end
      ValueLossPc = ValueLossPc + ValueRecombPc(ii);
    end
    IntegrStep= d(l)*1e9/length(genPc(1,:));
    ValueProfitPc = 0;
    for ii=1:length(genPc(1,:))
      if ii < length(genPc(1,:))
        ValueProfPc(ii) =  0.5*(genPc(ii) + genPc(ii+1))*IntegrStep;
      end 
      if ii == length(genPc(1,:))
        ValueProfPc(ii) =  genPc(ii)*IntegrStep;
      end
      ValueProfitPc = ValueProfitPc + ValueProfPc(ii);
    end
    IntegrStep= d(l)*1e9/length(nPcITO(1,:));
    ValueEQuiPc = 0;
    for ii=1:length(nPcITO(1,:))
      if ii < length(nPcITO(1,:))
        ValueEQPc(ii) =  0.5*(nPcITO(ii) + nPcITO(ii+1))*IntegrStep;
      end 
      if ii == length(nPcITO(1,:))
        ValueEQPc(ii) =  nPcITO(ii)*IntegrStep;
      end
      ValueEQuiPc = ValueEQuiPc + ValueEQPc(ii);
    end
    
    
    
    
%    % eta C60
%     IntegrStep = d(4)*1e9/length(verlC60(1,:));
%     ValueLossC60 = 0;
%     for ii = 1:length(verlC60(1,:))
%       if ii < length(verlC60(1,:))
%         ValueRecombC60(ii) =  0.5*(verlC60(ii) + verlC60(ii+1))*IntegrStep;
%       end 
%       if ii == length(verlC60(1,:))
%         ValueRecombC60(ii) =  verlC60(ii)*IntegrStep;
%       end
%       ValueLossC60 = ValueLossC60 + ValueRecombC60(ii);
%     end
%     IntegrStep= d(4)*1e9/length(genC60(1,:));
%     ValueProfitC60 = 0;
%     for ii=1:length(genC60(1,:))
%       if ii < length(genC60(1,:))
%         ValueProfC60(ii) =  0.5*(genC60(ii) + genC60(ii+1))*IntegrStep;
%       end 
%       if ii == length(genC60(1,:))
%         ValueProfC60(ii) =  genC60(ii)*IntegrStep;
%       end
%       ValueProfitC60 = ValueProfitC60 + ValueProfC60(ii);
%     end
%   
   % exciton diffusion efficiency
   QEValue(k,1) =  0;    % senseless since every active layer has to be separately regarded
   QEValue(k,2) = (ValueProfitPc - ValueLossPc)/ValueProfitPc; % on the CT side
   QEValue(k,3) = (- ValueEQuiPc + ValueLossPc)/ValueProfitPc; % on the other side
   
% 
%    % internal quantum efficiency
%    QEValue(k,7) = 0;    % senseless since every active layer has to be separately regarded
%    QEValue(k,8) = QEValue(k,2) * (absorptance(k*5,2)/absorptance(k*5,6));  %ZnPc; automation mode: absorpData(kdPc/2,kdC60/2,lambda,1);
%    QEValue(k,9) = QEValue(k,3) * (absorptance(k*5,3)/absorptance(k*5,6));  %C60;  automation mode: absorpData(kdPc/2,kdC60/2,lambda,2);
%    
%    % external quantum efficiency
    QEValue(k,5) = QEValue(k,2) * absorptance(lambda,l-1);  %ZnPc; automation mode: absorpData(kdPc/2,kdC60/2,lambda,1);
    QEValue(k,6) = QEValue(k,3) * absorptance(lambda,l-1);  %C60;  automation mode: absorpData(kdPc/2,kdC60/2,lambda,2);
%    QEValue(k,4) = QEValue(k,5) + QEValue(k,6);
%    

 
end % of for k...






% if BoundaryOption == 1         % ITO/  / Al optics and boundary conditions
%  eval(['save QEITOAl' num2str(kLPc) 'Pc' num2str(kLC60) 'C60' num2str(kdPc) 'kdPc' num2str(kdC60) 'kdC60.mat QEValue absorptance']);
% end 
%  
% if BoundaryOption == 2         % ITO/  / Al optics and BCP boundary conditions
%  eval(['save QEITOAlopticsBCPboundary' num2str(kLPc) 'Pc' num2str(kLC60) 'C60' num2str(kdPc) 'kdPc' num2str(kdC60) 'kdC60.mat QEValue absorptance']);
% end 
 
% calculate Isc  
  
 load SpectrumAM15G350850.txt
 Spectrum = SpectrumAM15G350850;
 IscAll = 0;
%  Iscright(l) = 0;
%  Iscleft(l) = 0;
 for ii=1:100
   %IscAll = IscAll + 5*QEValue(ii,4)*Spectrum(ii*5);
   Iscright(l) = Iscright(l) + 5*QEValue(ii,5)*Spectrum(ii*5);
   Iscleft(l) = Iscleft(l) + 5*QEValue(ii,6)*Spectrum(ii*5);   
 end
 if prop(l) == 1 | prop(l) == 11
     dd = Iscright(l);
     Iscright(l) = Iscleft(l);
     Iscleft(l) = dd;
 end
 %disp(['Values: kLPc ' num2str(kLPc) ' kLC60 ' num2str(kLC60) ' kdPc ' num2str(kdPc) ' kdC60 ' num2str(kdC60) ' IscAll ' num2str(IscAll) ' IscPc ' num2str(IscPc) ' IscC60 ' num2str(IscC60) ' ']); 
 end % of if prop > 0
 disp([num2str(l) ': current left side ' num2str(Iscleft(l)) '; right side ' num2str(Iscright(l))])
 numberl(l) = l;
end % of for l...
I_sc = [numberl; Iscleft; Iscright; Iscleft./1.6e-19./1000; Iscright./1.6e-19./1000]';
save('Currentsgui.txt', 'I_sc', '-ASCII');