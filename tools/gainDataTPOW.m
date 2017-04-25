function data=gainDataTPOW(data,tpow,maxt,lines)
% dataout=gainDataTPOW(data,tpow,maxt,lines)
%
% Makes things further down more visible by multiplying each trace with
% t^tpow
%
% INPUT:
%
% data      The data you want to make better visible
% tpow      The exponent for the time
% maxt      maximum time for which to amplify (default: all the way)
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
defval('maxt',max(data.finalti))
gprdataout=data.gprdata;

for li=1:length(lines)
    factor=(min(data.finalti,maxt)').^tpow; 
    %factor=(data.finalti').^tpow;
    factmat=repmat(factor,1,size(data.gprdata,2));
    gprdataout(:,:,lines(li)+1)=factmat.*data.gprdata(:,:,lines(li)+1);
    
    fprintf('gainDatatpow: Processed line %d\n',lines(li))
end
data.gprdata=gprdataout;
