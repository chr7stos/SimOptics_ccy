function res = GenExProfile
global tau
% Calculation exciton generation profile before and after diffusion
% While Christian solves the diffusion equation for his monochromatic considerations analytically, 
% the polychromatic case here needs to solve the differential equation numerically (by Matlab's bvp4c solver)
%
% this script needs input OpticalValuegui.mat where most optical caluclations are already included

% SimOsc beta
% by Wolfgang Tress 21.12.07
% using code by Christian Breyer (read his diploma thesis!)
% last modified by Stefan Zwiers
% warnings appearing after pressing "calculate optics" like
% "variable p, dir_name, al_nr not found" don't harm :-)


h = 6.626e-34;	%Planck const (in J*s)
c = 3e8;		%speed of light (in m/s)
ec = 1.602e-19;	%electron charge (in C)
% Christian:  tau = 10e-9;
% lifetime of excitons [ns] value So1991 p.4 (PTCDA)
tau = 10e-9; % in s

% Eph = h*c/lambda, with lambda=500nm -> Eph = 4e-19J -> total irradition of 1000W/m^2 corresponds to 2.5e21 photons / (m^2*s)
% Wolfgang uses in his electrical simulation EXCITON generation rate of about 5e21 /(cm^3*s) = 5e27 / (m^3*s), see his thesis p54
% Here, the output is a polychromatic Exciton generation rate of about 1e19 to 1e20 /(m^2*s)
% in Wolfgangs electrical SimOsc Program this rate is then "absorbed" in his 3nm thick "CT-generation layer"
% what means 1e19/3e-9 excitons/(m^3*s) = 3e27 / (m^3*s)

% optical data is available from 350nm to 850nm with 1nm stepwidth
mesh = 501;
alpha = 0;

eval(['load OpticalValgui.mat TransmitTM rhoTM deltaTM q alpha d subGlass subGlassNoAbsorp absorptance']);
% d is layer thickness in m

% solar spectrum from 350 to 850 nm, unit of sprectral irradiance is W*m^-2*nm^-1, so watt per surface and wavelength. 
% used by Christian, downloaded Sept 2006 from http://rrdec.nrel.gov/solar/spectra/am1.5
load SpectrumAM15G350850Irradiance.txt  
	%OLDCODE: alternatively:
	%SpectrumAM15G350850.txt % Spectral photon number

%Initialization
CTExcDens = zeros(100,length(d));
CurrentDens = zeros(100,length(d));
CTExcDensAv = zeros(1,length(d));
CurrentDensTotal = zeros(1,length(d));

% loop all layers, even non-absorber layers are considered, but not the glas substrate (first layer)
for j=2:length(d)   
  ExcDensI = 0;
  CTExcDensI = 0;
  x = linspace(0,d(j)); % spatial dimension. 100 points linearly spaced between 0 and d(j)
  % loop all wavelengths
  for k = 1:mesh
			%OLDCODE
			%IntegrStep = d(j+1)/length(x);
	   % "energy flow dissipation per unit time" See his Christians thesis or his source, the Sariciftci book "Organic Photovoltaics (2005), chapter 5.4. 
	   % book: "unit is W/(m^2*nm*s), where it is indicated that z is measured in nm."
	   % HERE while calculating unit is W/m^3 (see for example OPticsplotegalwas.m line368, scaling there before plotting by 1e-9 to convert to W/(m^2*nm*s)
	   % intensity I0 in optical calculations is unity, solar spectrum is considered later (see below)
	   % the figures by SimSoc (and in christians thesis) also show pure qvaluex without solar irradition
       qvaluex = subGlass(k,1)*alpha(k,j)*TransmitTM(k,j)*(exp(-alpha(k,j)*x) + rhoTM(k,j)^2*exp(-alpha(k,j)*(2*d(j)-x)) +...
                 2*rhoTM(k,j)*exp(-alpha(k,j)*d(j))*cos((4*pi*real(q(k,j))/((349+k)*1e-9))*(d(j)-x) + deltaTM(k,j)));
			%OLDCODE
			%SpecDens = SpectrumAM15G350850(k,1).* qvaluex;
			%SpecExDens = SpectrumAM15G350850(k,1).* qvaluex*1e-9;%SpecDens ./ (h*c/(SpectrumAM15G350850Irradiance(k,1))); 
		

		%Exciton density for specific wavelength. Since I0 in qvaluex is unity, here just multiplication with solar spectral irradiance
        ExcDens = SpectrumAM15G350850Irradiance(k,2).* qvaluex./ (h*c/((349+k)*1e-9)); % factor (h*c/((349+k)*1e-9)) is photon energy, 
		% unit is now particles/(m^3*s*nm) nm comes from spectral irradiation.
		% order of magnitude is 1e24 (quite hight because light is absorbed in aver thin layer only) 

		%Exciton density for all wavelengths
        CTExcDensI = CTExcDensI + ExcDens; 
		% loop is "integration" over spectrum -> unit is now particles/(m^3*s). 
		% in the end total CTExcDensI is about 1e28
			%OLDCODE
			%ExcDensI = ExcDensI + SpecExDens;        
			%SpecDens = SpectrumAM15G350850(k,1).* qvaluex ./1.6e-19;
   end
		%OLDCODE
		%SpecDensI = SpecDensI * d(j+1)/length(x);
		%ExcDensTotal = sum(ExcDensI)
		ehtotal = sum(CTExcDensI)*d(j)/100/1e4; % Wolfgang: "e/h per square cm s".  accumulated over 100 points --> e/h per m^2/s --> /1e4 --> e/h per cm^2/s
		%CurrentDens(:,j) = SpecDensI;
		CTExcDensAv(j) = ehtotal/d(j)/1e2;
		CurrentDensTotal(j) = ehtotal*ec*1000; %mA/cm2
	CTExcDens(:,j) = CTExcDensI; 
 
end
	%OLDCODE
	%ExcDensAv
	%SpecDensAv
	%CurrentDensTotal
	%CTExcDensAv
CTExcDensI
% save Exciton density. Is evaluated in the diffusion part below.
eval(['save ExcDensgui.mat CTExcDens']);

% save Values of Blend or ZnPC/C_60 layers for usage in SimOSC2
eval(['load layernames.mat name d L p dir_name al_nr']);

if(~exist('dir_name') || isempty(dir_name))
    dir_name = 'generation_library';
end
if(exist('al_nr'))
    absorber_layers = al_nr
    Var2 = 0;
    if(length(absorber_layers) > 2)
		%trilayer
        Var1 = CTExcDens(:,absorber_layers(1));
        Var2 = CTExcDens(:,absorber_layers(2));
        Var3 = CTExcDens(:,absorber_layers(3));
        mat4bvp_trilayer(d(absorber_layers(1)),d(absorber_layers(2)),d(absorber_layers(3)),L(absorber_layers(1)),L(absorber_layers(2)),L(absorber_layers(3)),Var1,Var2,Var3,name(absorber_layers(1)),name(absorber_layers(2)),name(absorber_layers(3)), dir_name);
    elseif(length(absorber_layers) > 1)
		%bilayer
		Var1 = CTExcDens(:,absorber_layers(1));
        Var2 = CTExcDens(:,absorber_layers(2));
        mat4bvp_bilayer(d(absorber_layers(1)),d(absorber_layers(2)),L(absorber_layers(1)),L(absorber_layers(2)),p(absorber_layers(1)),p(absorber_layers(2)),Var1,Var2,name(absorber_layers(1)),name(absorber_layers(2)), dir_name);
    elseif(length(absorber_layers) > 0)
		%singlelayer
		Var = CTExcDens(:,absorber_layers);
        if(p(absorber_layers) == 4)
            filename = strcat(dir_name, '/single__', char(name(absorber_layers)), '_D', num2str(d(absorber_layers)* 1e+009), '_L', num2str(L(absorber_layers)), '.mat');
            save(filename, 'Var');    
        else
            mat4bvp_single(d(absorber_layers),L(absorber_layers),p(absorber_layers),Var,name(absorber_layers),dir_name);
        end
    end
end


clear dir_name;
% return to main program (Wolfgang, not used by Stefan)
res(:,1) = CurrentDensTotal;
res(:,2) = CTExcDensAv;







%
%DIFFUSION IN SINGLE LAYER
%

function mat4bvp_single(d,L,p,Var,name,dir_name)
global tau Q di l qx

Q = Var; % Var is exciton generation summed over all wavelength (~10^27) per m^3*s. 100 points.
di = d; % global thickness in m
l = L*1e-9; %global diffusion length in m
qx = linspace(0,di); %x-vector to y-vector Q
% p is paramter saying if exciton quenching on left or right side etc. See main programm SimOscOptics.

if(p == 21)
	%left quenching
    solinit = bvpinit(linspace(0,di,10),@mat4init_left);
    sol = bvp4c(@mat4ode,@mat4bc_left,solinit);

    Sxint = deval(sol,qx);
    res = Sxint(1,:)/tau; %Excitons in layer1 after diffusion
    intRes = di/100*trapz(res); %Excitons in layer1 after diffusion integrated over thickness --> intRes in Exc/(m^2s)

    intVar = di/100*trapz(Var); %Excitons in layer1 before diffusion integrated over thickness --> intRes in Exc/(m^2s)
    
    gen = intVar - intRes;	% effective generation rate
    
elseif(p == 11)
	%right quenching
    solinit = bvpinit(linspace(0,di,10),@mat4init_right);
    sol = bvp4c(@mat4ode,@mat4bc_right,solinit);

    Sxint = deval(sol,qx);
    res = Sxint(1,:)/tau; %Excitons in layer1 after diffusion
    intRes = di/100*trapz(res); %Excitons in layer1 after diffusion integrated over thickness --> intRes in Exc/(m^2s)

    intVar = di/100*trapz(Var); %Excitons in layer1 before diffusion integrated over thickness --> intRes in Exc/(m^2s)
    
    gen = intVar - intRes;	% effective generation rate
end

filename = strcat(dir_name, '/single__', char(name), '_D', num2str(d*1e+9), '_L', num2str(L), '.mat');
try
    save(filename, 'Var','res','gen');
catch
    save(filename, 'Var');
end



%
%DIFFUSION IN BILAYER
%



function mat4bvp_bilayer(d1,d2,L1,L2,p1,p2,Var1,Var2,name1,name2,dir_name)
% d1, d2, L1, L2 in nm
global tau Q qx di l;

Q_help = [Var1, Var2];   
di_help = [d1, d2];     
l_help = [L1,L2];        
p = [p1,p2];
bl = 0;

for i = 1:2
    Q = Q_help(:,i);    %  exciton generation summed over all wavelength (~10^27) per m^3*s. 100 points.
    di = di_help(i);     %global thickness in m
    l = l_help(i)*1e-9; %global diffusion length in m
    qx = linspace(0,di); %x-vector to y-vector Q

    if(p(i) == 21)
        solinit = bvpinit(linspace(0,di,10),@mat4init_left);
        sol = bvp4c(@mat4ode,@mat4bc_left,solinit);

        Sxint = deval(sol,qx);
        res = Sxint(1,:)/tau;
		intRes = di/100*trapz(res);

        intVar = di/100*trapz(Q);

        gen = intVar - intRes;

    elseif(p(i) == 11)
        solinit = bvpinit(linspace(0,di,10),@mat4init_right);
        sol = bvp4c(@mat4ode,@mat4bc_right,solinit);

        Sxint = deval(sol,qx);
        res = Sxint(1,:)/tau;
        intRes = di/100*trapz(res);

        intVar = di/100*trapz(Q);

        gen = intVar - intRes;
        
    else
            bl = bl + i;
    end
    if(i == 1)
        Var1 = Q;
        if(exist('res')) res1 = res; end
        if(exist('res')) gen1 = gen; end
    else
        Var2 = Q;
        if(exist('res')) res2 = res; end
        if(exist('res')) gen2 = gen; end
    end
end

filename = strcat(dir_name, '/bilayer__', char(name1), '-', char(name2), '_D', num2str(d1*1e+9), '_', num2str(d2*1e+9), '_L', num2str(L1), '_', num2str(L2), '.mat');

if(bl == 0)
    save(filename, 'Var1','Var2','res1','res2','gen1','gen2');
elseif(bl == 1)
    save(filename, 'Var1','Var2','res2','gen2');
elseif(bl == 2)
    save(filename, 'Var1','Var2','res1','gen1');
else
    save(filename, 'Var1','Var2');
end



%
%DIFFUSION IN TRILAYER
%

% for example ZnPc/Blend/C60
% generation profile of Znpc and C60 are integrated, respectively


function mat4bvp_trilayer(d1,d2,d3,L1,L2,L3,Var1,Var2,Var3,name1,name2,name3,dir_name)
% d1, d2, L1, L2 in nm
global tau Q qx di l;

%load('d:\difftest\GEN__C_60-ZnPc_D60_60_L40_10.mat', 'Var1', 'Var2');

%left layer
%adjustment of global variables
Q = Var1; % exciton generation summed over all wavelength (~10^27) per m^3*s. 100 points.
di = d1; %global thickness in m
l = L1*1e-9; %global diffusion length in m
qx = linspace(0,di); %x-vector to y-vector Q

solinit = bvpinit(linspace(0,di,10),@mat4init_left);
sol = bvp4c(@mat4ode,@mat4bc_left,solinit);

Sxint = deval(sol,qx);
res1 = Sxint(1,:)/tau

intRes1 = di/100*trapz(res1);

intVar1 = di/100*trapz(Var1);

gen1 = intVar1 - intRes1

% intermediate layer: just taken the profile as it is 
% (no integration here, integration later in SimOscOpticGraphic.m, there also summing up of all 3 generation rates)


% right layer
% adjustment of global variables
Q = Var3; % exciton generation summed over all wavelength (~10^27) per m^3*s. 100 points.
di = d3 %global thickness in m
l = L3*1e-9; %global diffusion length in m
qx = linspace(0,di); %x-vector to y-vector Q

solinit = bvpinit(linspace(0,di,10),@mat4init_right);
sol = bvp4c(@mat4ode,@mat4bc_right,solinit);
 
Sxint = deval(sol,qx);
Sxint(1,:)
res3 = Sxint(1,:)/tau;

intRes3 = di/100*trapz(res3);

intVar3 = di/100*trapz(Var3);

gen3 = intVar3 - intRes3;

filename = strcat(dir_name, '/trilayer__', char(name1), '-', char(name2), '-', char(name3), '_D', num2str(d1*1e+9), '_', num2str(d2*1e+9), '_', num2str(d3*1e+9), '_L', num2str(L1), '_', num2str(L2), '_', num2str(L3), '.mat')
save(filename, 'Var1','Var2','Var3','res1','res3','gen1','gen3');



%
% FUNCTIONS REALLY SOLVING THE DIFFUSION EQUATION
%





function dydx = mat4ode(x,y)
global Q qx l tau;
% first order differential equation system
% y1' = f(y1,y2,y3)
% y2' = f(y1,y2,y3)
% y3' = f(y1,y2,y3)
% second order y''+y=0 like:
% y1' = y2
% y2' = -y1
% here y1=y, y2=y'


% diffusion equation: D*dx^2(n(x))-n(x)/tau+Q(x)=0
% Q(x) is generation profile in particles/(m^3*s), it's NOT qvaluex as in Christians thesis.
% in Christian's thesis, page 80, Q is qvaluex. phi1/(h*ny)*Q(x) should come from  optics, where phi1 is quant eff of excitation and here assumed to be 100%

L = l; % in m
D=L.^2/tau;
  %      
dydx = [ y(2)
         1/D*(y(1)/tau-interp1(qx,Q,x)) ];

% since Q is generated excitons/(Volume*time) and n=y(1) is excitons/Volume one of them has to be scaled.
% the excitons that don't dissociate and are remaining in the layer, that's what the time-independent 
% concentration n=y(1) gives, are recombining (maybe better word: decaying) with tau.
% So in the calling functions above the result y(1) from here is multiplied by 1/tau
% so
% In Christians diploma work (page80), instead
%G is scaled by tau and not the loss V by 1/tau when efficiency calc is done or diffdensity is scaled
%by 1/tau in exdiff3.m , e.g. line 806 or 930
%what the equation: at low L, nearly no exciton can reach D/A interface and disappear through it->gen profile and diff
%profile (then nearly no diff only recomb) should be the same (gen=recomb at equilibrium)

% ------------------------------------------------------------
function res = mat4bc_left(ya,yb)
% boundary conditions = 0
% ya left side, yb right side
% left: no quenching, first derivative=0-> ya(2)
% right: complete dissociation, number=0-> yb(1)      
res = [  ya(2)
         yb(1) ];
% ------------------------------------------------------------

function res = mat4bc_right(ya,yb)
% boundary conditions = 0
% ya left side, yb right side
% right: no quenching, first derivative=0-> yb(2)
% left: complete dissociation, number=0-> ya(1)      
res = [  yb(2)
         ya(1) ];
% ------------------------------------------------------------

function yinit = mat4init_left(x)
global di;
% interp1 test - works!
% xx = linspace(0,pi);
% yy = cos(4*xx);
% interp1(xx,yy,x)
%first guess
% y1=y=5e27*cos(x/60e-9*pi/2)
% y2=y'=
yinit = [ 5e27*cos(x/di*pi/2)
         -5e27/di*pi/2*sin(x/di*pi/2) ]; 
     
function yinit = mat4init_right(x)
global di;
% interp1 test - works!
% xx = linspace(0,pi);
% yy = cos(4*xx);
% interp1(xx,yy,x)
%first guess
% y1=y=5e27*cos(x/60e-9*pi/2)
% y2=y'=
yinit = [ 5e27*sin(x/di*pi/2)
          5e27/di*pi/2*cos(x/di*pi/2) ]; 