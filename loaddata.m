 function res = loaddata(filename,ncols,commentsign) %(filename)
% loads ASCII-file in a data matrix with
% ncols: number of colums
% commentsdign: sign for headerinfo
%     
% 06.07.2007 WT
% 06.11.2015 CCY

% The measured_spectra folder is added to the path, otherwise it does not
% work

addpath(measured_spectra)

fin = fopen(filename,'r'); % open file with error handling 
if fin < 0
   error(['Could not open ',filename,' for input']); % If fopen cannot open the file, then fileID is -1.
end

buffer = commentsign;   % get number of header lines
numbheadlines = -1;
while buffer(1) == commentsign
    buffer = fgetl(fin);
    numbheadlines = numbheadlines+1;
end
fclose(fin);
fin = fopen(filename,'r');  % reopen file to jump to first data line
for i = 1:numbheadlines fgetl(fin);
end

data = fscanf(fin,'%f');  %  load hole data in one long vector
nd = length(data);        %  total number of data points
nr = nd/ncols;            %  number of rows; check (next statement) to make sure
if nr ~= round(nd/ncols)
   fprintf(1,'\ndata: nrow = %f\tncol = %d\n',nr,ncols);
   fprintf(1,'number of data points = %d does not equal nrow*ncol\n',nd);
   error('data is not rectangular')
end
fclose(fin);
res = reshape(data,ncols,nr)';   %  notice the transpose operator