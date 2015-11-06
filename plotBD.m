function plotBD(Arch,Gen, UBIAS, str, varargin);

Ausg = 0;
for i=1:length(str)
    switch str(i)
        case 'n' 
            Ausg = Ausg + 1;
        case 'I' 
            Ausg = Ausg + 2;
        case 'E' 
            Ausg = Ausg + 4;
        case 'B' 
            Ausg = Ausg + 8
        case 'O' 
            Ausg = Ausg + 16;
    end
end

vara = varargin;
addpos = size(vara,2);
vara{addpos + 1} = 'OP';
vara{addpos + 2} = Ausg;

SimOSC(Arch,Gen,UBIAS,UBIAS,2,vara);