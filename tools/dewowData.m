function data=dewowData(data,window,lines)
% dataout=dewowData(data,window,lines)
%
% Removes low frequency noise by subtracting a running mean of
% window length "window" from each sample
%
% INPUT:
%
% data      The data you want to smooth
% window    The width of the averaging window
% lines     If you only want to do gain for one single line or a goup of
%           lines, then you can enter them: [0] or [0 3 4]. If you want to
%           do it for all lines, simply omit this.
%
% OUTPUT:
%
% dataout   The processed data
%
% Last modified by plattner-at-alumni.ethz.ch, 09/08/2017

defval('lines',0:size(data.gprdata,3)-1);
gprdataout=data.gprdata;

for li=1:length(lines)

    for tr=1:size(data.gprdata,2)
        gprdataout(:,tr,lines(li)+1)=...
            Dewow(data.gprdata(:,tr,lines(li)+1),window);
    end
    fprintf('dewowData: Processed line %d\n',lines(li))
end
data.gprdata=gprdataout;
