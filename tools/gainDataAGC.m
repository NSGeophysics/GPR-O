function data=gainDataAGC(data,AGwindow,lines)
% dataout=gainDataAGC(data,AGwindow,lines)
%
% Makes things further down more visible (normalizes each trace using an
% along-trace moving energy norm
%
% INPUT:
%
% data      The data you want to make better visible
% AGwindow  The width of the normalization window
% lines     If you only want to do gain for one single line or a goup of
%           lines, then you can enter them: [0] or [0 3 4]. If you want to
%           do it for all lines, simply omit this.
%
% OUTPUT:
%
% dataout   The processed data
%
% Last modified by plattner-at-alumni.ethz.ch, 4/30/2015

defval('lines',0:size(data.gprdata,3)-1);
gprdataout=data.gprdata;

for li=1:length(lines)

    for tr=1:size(data.gprdata,2)
        gprdataout(:,tr,lines(li)+1)=...
            AutoGain(data.gprdata(:,tr,lines(li)+1),AGwindow);
    end
    fprintf('gainData: Processed line %d\n',lines(li))
end
data.gprdata=gprdataout;
