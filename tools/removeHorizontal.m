function data=removeHorizontal(data,width,lines)
% dataout=removeHorizontal(data,width,lines)
%
% Removes horizontal stripes such as the airwave and makes underlying
% things more visible
%
% INPUT: 
%
% data      The data you want to make better visible
% width     How many traces do you want to use to calculate the horizontal
%           stripes?
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
    gprdataout(:,:,li)=removeHorizfeat(data.gprdata(:,:,lines(li)+1),width);
    fprintf('removeHorizontal: Processed line %d\n',lines(li))
end
data.gprdata=gprdataout;

