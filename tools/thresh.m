function data=thresh(data,perc)
% tdata=thresh(data,perc)
% 
% Sets all points with absolute values BELOW perc*max(abs) to zero
%
% INPUT:
%
% data      GPR-O data
% perc      threshold percentage of maximum value. Can be either a vector
%           containing values for each line, or one for all lines.
%
% OUTPUT:
%
% tdata     thresheld data
%
% Last modified by plattner@alumni.ethz.ch, 01/20/2017

nlines=size(data.gprdata,3);

if length(perc)==1
    perc=perc*ones(1,size(data.gprdata,3));
end
    
for i=1:nlines
    dat=data.gprdata(:,:,i);
    tval=perc*max(abs(dat(:)));
    dat(abs(dat)<tval)=0;
    data.gprdata(:,:,i)=dat;        
end
    
end
        