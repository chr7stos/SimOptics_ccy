function res = SolarParams(PUI)
% plots Isc, Voc, FF, Pmax, MPPpostition, Rs, Rp
found = 0;
i = 1;
Isc = 0;
Voc = 0;
Rp=0;
Rs=0;
while ((i < size(PUI,2)) & (found == 0))
    if ((PUI(1,i) == 0) | (PUI(1,i)*PUI(1,i+1)<0))
        Isc=PUI(2,i);
        Rp = (PUI(1,i+1) - PUI(1,i))/(PUI(2,i+1) - PUI(2,i))*1000;
    end
    if ((PUI(2,i) == 0) | ((PUI(2,i)*PUI(2,i+1)<0) & PUI(1,i)>0))
        Voc= PUI(1,i);
        Rs = (PUI(1,i+1) - PUI(1,i))/(PUI(2,i+1) - PUI(2,i))*1000;
        found = 1;
    end;
    i = i + 1;
end;
[Pmax,MPP] = max(PUI(1,:).*-PUI(2,:));
FF= -Pmax / (Voc*Isc);
res = [Isc Voc FF Pmax MPP Rs ]; %Rp];