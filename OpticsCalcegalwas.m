function OpticsCalcegalwas(d)

% SimOsc beta
% modified by Wolfgang Tress 21.12.07

% by Ch. Breyer
% load the 'complex' refraction indices of all the materials n,k in right
% order and from 350nm to 850nm in step of 1nm
load matvalgui.txt;
matvalues = matvalgui;
% thickness of layers
% %glass 1mm, ITO 190nm, ZnPc 30nm, C60 30 nm, Al 100nm

ls = length(d); %layers fist glas, last metal
%d = [1e-3 190e-9 30e-9 30e-9 50e-9];
% d(1) = kdglas*1e-3; %glas in mm
% d(2) = kdITO*1e-9;
% d(3) = kdPc*1e-9;
% d(4) = kdC60*1e-9;
% d(5) = kdAl*1e-9;
% declaration of variables
mesh = 501;
refractionData = zeros(mesh,2*ls);
q = zeros(mesh,ls);                  % complex refraction index of all layers including glass!
r = zeros(mesh,ls);                  % reflection coeff of all interfaces
t = zeros(mesh,ls);                  % transmission coeff of all interfaces
ksi = zeros(mesh,ls);                % phase parameter ksi
InterfaceMatrix = zeros(2,2,mesh,ls);% interface matrices of all interfaces
LayerMatrix = zeros(2,2,mesh,ls-1);    % layer matrices of all relevant layers
TransferMatrix1 = zeros(2,2,mesh,ls);% transfermatrix1 of all interfaces
TransferMatrix2 = zeros(2,2,mesh,ls);% transfermatrix2 of all interfaces
TransmitTM = zeros(mesh,ls-1);           % transmittance for each layer
rhoTM = zeros(mesh,ls-1);                % abs of complex refr index of second subsystem
deltaTM = zeros(mesh,ls-1);              % angle of complex refr index of second subsystem
subGlass = zeros(mesh,1);             % factor for the glass substrat, no thin film!
subGlassNoAbsorp = zeros(mesh,1);     % factor for the glass substrat if there is no absorption

% main routine starts

% load the data for the complex refraction of all layers

for j=1:2*ls
  refractionData(:,j) = matvalues(:,j);
end

% combine the data for the complex refraction index
% glass/ITO/ZnPc/C60/Al
for k=1:mesh    
   for j=1:ls      
     a = refractionData(k,j*2-1); 
     b = refractionData(k,j*2);
     z = a + b*i;
     q(k,j) = z;
   end
end

% creating alpha

for k=1:mesh
    alpha(k,:) = 4*pi*imag(q(k,:))./((349+k)*1e-9);      % for mesh=501
end

% calculating the reflection and transmission coeff of the interfaces
% since Pedot is already eliminated in q(k,j) it is no problem here

for j=2:ls               % interfaces within the device
    r(:,j) = (q(:,j-1) - q(:,j))./(q(:,j-1) + q(:,j));
    t(:,j) = 2.*q(:,j-1)./(q(:,j-1) + q(:,j));
end

% calculating the phase parameter ksi

for j=1:mesh
  ksi(j,:) = (2*pi/((349+j)*1e-9)).*q(j,:);     % for mesh=501
  alphaGlass(j,1) = 4*pi*imag(q(j,1))/((349+j)*1e-9);   %absorp coeff for glass
end

% calculating the factor for the glass substrat

  RAirGlass = ((real(q(:,1))-1).^2 + (imag(q(:,1))).^2) ./ ((real(q(:,1))+1).^2 + (imag(q(:,1))).^2);
  RGlassITO = ((real(q(:,2))-(real(q(:,1)))).^2 + ((imag(q(:,2)))+(imag(q(:,1)))).^2) ./...
              ((real(q(:,2))+(real(q(:,1)))).^2 + ((imag(q(:,2)))+(imag(q(:,1)))).^2);
  %subGlass = (1-RAirGlass)./(1-RGlassITO.*RAirGlass); %for no absorption in glass
for k=1:mesh
  % (real(q(k,1)) this factor (refraction index) is already in the Transmit-coeff included!! %for absorption in glass
  subGlass(k,1) = (exp(-2*alphaGlass(k,1)*d(1))-RAirGlass(k,1)*exp(-alphaGlass(k,1)*d(1)))/...
                  ((1-RGlassITO(k,1)*RAirGlass(k,1)*exp(-2*alphaGlass(k,1)*d(1)))); %for absorption in glass
  subGlassNoAbsorp(k,1) = (1 - RAirGlass(k,1))/(1-RGlassITO(k,1)*RAirGlass(k,1)); %if there is no absorption in glass            
end

% calculating the interface matrices

for k=1:mesh
  for j=2:ls
   InterfaceMatrix(:,:,k,j) = 1/t(k,j)*[1 r(k,j); r(k,j) 1];
  end
end  

% calculating the layer matrices

for k=1:mesh
  for j=2:ls-1
  LayerMatrix(:,:,k,j) = [exp(-i*ksi(k,j)*d(j)) 0; 0 exp(i*ksi(k,j)*d(j))];
  end
end 

% calculating the transfer matrices

for k=1:mesh
  for j=2:ls
    
    %TransferMatrix1
    TransferMatrix1(:,:,k,j) = eye(2,2);            %creates a unity matrix
    
    if j > 1  
      for l=2:(j-1)
        TransferMatrix1(:,:,k,j) = TransferMatrix1(:,:,k,j) * InterfaceMatrix(:,:,k,l) * LayerMatrix(:,:,k,l);
      end
    end  
    TransferMatrix1(:,:,k,j) = TransferMatrix1(:,:,k,j) * InterfaceMatrix(:,:,k,j);
    
    %TransferMatrix2
    TransferMatrix2(:,:,k,j) = eye(2,2);            %creates a unity matrix
    if j < ls-1
      for l=(j+1):ls-1
        TransferMatrix2(:,:,k,j) = TransferMatrix2(:,:,k,j) * InterfaceMatrix(:,:,k,l) * LayerMatrix(:,:,k,l);
      end
      TransferMatrix2(:,:,k,j) = TransferMatrix2(:,:,k,j) * InterfaceMatrix(:,:,k,ls);
    end
    if j == ls-1
      TransferMatrix2(:,:,k,j) = TransferMatrix2(:,:,k,j) * InterfaceMatrix(:,:,k,ls);
    end
    if j == ls
      TransferMatrix2(:,:,k,j) = zeros(2,2);
    end
  end  % j loop
end    % k loop
    
% calculating the Transmission coeff and abs and angle of second subsystem

for k=1:mesh
  for j=2:ls-1
    TransmitTM(k,j) = real(q(k,j))/real(q(k,1))*(abs((1/TransferMatrix1(1,1,k,j))/(1+(TransferMatrix1(1,2,k,j)/TransferMatrix1(1,1,k,j))...
                    *(TransferMatrix2(2,1,k,j)/TransferMatrix2(1,1,k,j))*exp(i*2*ksi(k,j)*d(j)))))^2;
    rhoTM(k,j)   = abs(TransferMatrix2(2,1,k,j)/TransferMatrix2(1,1,k,j));
    deltaTM(k,j) = angle(TransferMatrix2(2,1,k,j)/TransferMatrix2(1,1,k,j));
  end
  j = ls;
  TransmitTM(k,j) = real(q(k,j))/real(q(k,1))*(abs((1/TransferMatrix1(1,1,k,j))/(1+(TransferMatrix1(1,2,k,j)/TransferMatrix1(1,1,k,j))...
                   *exp(i*2*ksi(k,j)*d(j)))))^2;
  rhoTM(k,j)   = 0;
  deltaTM(k,j) = 0;

end
    
% variables

thick = zeros(1,ls-1);                % added thicknes of the layers
xlambda = zeros(mesh,ls);            % intervals of the layers
absorptance = zeros(mesh,ls+2);        % matrix of plots

% main begins

% symbolic integration within boundary values

  for k = 1:mesh
    for j=1:ls-2
       x = linspace(0,d(j+1));          
       qvaluex = subGlass(k,1)*alpha(k,j+1)*TransmitTM(k,j+1)*(exp(-alpha(k,j+1)*x) + rhoTM(k,j+1)^2*exp(-alpha(k,j+1)*(2*d(j+1)-x)) +...
              2*rhoTM(k,j+1)*exp(-alpha(k,j+1)*d(j+1))*cos((4*pi*real(q(k,j+1))/((349+k)*1e-9))*(d(j+1)-x) + deltaTM(k,j+1)));

       IntegrStep = d(j+1)/length(x);
       ValueIntegral = 0;
       for ii = 1:length(x)
         if ii < length(x)
           ValueInt(ii) =  0.5*(qvaluex(ii) + qvaluex(ii+1))*IntegrStep;
         end 
         if ii == length(x)
           ValueInt(ii) =  qvaluex(ii)*IntegrStep;
         end
         ValueIntegral = ValueIntegral + ValueInt(ii);
       end
       absorptance(k,j) = ValueIntegral;
       
    end

    %extinction of intensity in Al
    x = linspace(0,d(j+2));  
    qvaluex = subGlass(k,1)*alpha(k,j+2)*TransmitTM(k,j+2)*(exp(-alpha(k,j+2)*x));
    
    IntegrStep = d(j+2)/length(x);
    ValueIntegral = 0;
    for ii = 1:length(x)
      if ii < length(x)
        ValueInt(ii) =  0.5*(qvaluex(ii) + qvaluex(ii+1))*IntegrStep;
      end 
      if ii == length(x)
        ValueInt(ii) =  qvaluex(ii)*IntegrStep;
      end
      ValueIntegral = ValueIntegral + ValueInt(ii);
    end
    absorptance(k,j+1) = ValueIntegral;

  end
  
  % absorptance of glass
  absorptance(:,ls) = subGlassNoAbsorp(:,1) - subGlass(:,1);

  % total device absorptance
  for j=1:ls
    absorptance(:,ls+1) = absorptance(:,ls+1) + absorptance(:,j);
  end

  % reflectance of glass
  absorptance(:,ls+2) = absorptance(:,ls+1) + (1 - subGlassNoAbsorp(:,1));
 
  % save the calculated data
  eval(['save OpticalValgui.mat TransmitTM rhoTM deltaTM q alpha d subGlass subGlassNoAbsorp absorptance']);

% end main
