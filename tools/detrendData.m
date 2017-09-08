function data=detrendData(data,lines)
% dataout=detrendData(data,lines)
%
% Removes a linear trend in the data
%
% INPUT:
%
% data      The data you want to smooth
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
        [m,q]=fitlin(data.finalti,data.gprdata(:,tr,lines(li)+1));
        trend=m*data.finalti+q;
                
        gprdataout(:,tr,lines(li)+1)=...
            data.gprdata(:,tr,lines(li)+1) - trend';
    end
    fprintf('smoothData: Processed line %d\n',lines(li))
end
data.gprdata=gprdataout;

end

function [m,q]=fitlin(x,y)
% [m,q]=fitlin(x,y)
%
% The simplest possible linear least squares

x=x(:);
y=y(:);

A=[x ones(size(x))];

v=(A'*A)\(A'*y);
m=v(1);
q=v(2);

end
