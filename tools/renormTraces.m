function data=renormTraces(data,lines)
% dataout=renormTraces(data,lines)
%
% Makes each trace have the same power. This is particularly helpful when
% after a processing step you have broad multitrace vertical bands and you
% would like to remove these.
%
% INPUT:
%
% data      The data you want to make better visible
% lines     If you only want to do gain for one single line or a goup of
%           lines, then you can enter them: [0] or [0 3 4]. If you want to
%           do it for all lines, simply omit this.
%
% OUTPUT:
%
% dataout   The processed data
%
% Last modified by plattner-at-alumni.ethz.ch, 4/12/2017

defval('lines',0:size(data.gprdata,3)-1);
gprdataout=data.gprdata;

for li=1:length(lines)
    try
    factor=1./sqrt(sum(data.gprdata(:,:,lines(li)+1).^2,1)); 
    catch
        keyboard
        end
    factmat=repmat(factor,size(data.gprdata,1),1);
    gprdataout(:,:,lines(li)+1)=factmat.*data.gprdata(:,:,lines(li)+1);
    
    fprintf('gainDatatpow: Processed line %d\n',lines(li))
end
data.gprdata=gprdataout;
