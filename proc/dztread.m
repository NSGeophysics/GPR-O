function datline=dztread(filename,bpt)
% datline=dztread(filename,bpt)  
%
% Reads GSSI's dzt format
%
% INPUT:
%  
% filename     name of the file you would like to load
% bpt          bytes per trace [default: 256]   
%
% OUTPUT:
%
% datline      matrix containing gpr data profile
%
% Last modified by plattner-at-alumni.ethz.ch, 6/16/2017

% Default for number of bytes per trace  
if nargin<2
  bpt=256
end

% Data type is unsigned 16 bit integer
typ='uint16';

fid=fopen(filename);
datvec=fread(fid,Inf,typ);

datline=reshape(datvec,bpt,length(datvec)/bpt);



