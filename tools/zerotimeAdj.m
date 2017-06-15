function data=zerotimeAdj(data,timeshift)
% outdata=zerotimeAdj(data,timeshift)
%
% Moves the time axis by subtracting timeshift from the
% two-way travel time values  
%
% INPUT:
%  
% data         GPR-O data structure  
% timeshift    Amount of time by which you want to shift the
%              two-way travel times
%
% OUTPUT:      
%
% outdata      data with shifted zero-time
%
% Last modified by plattner-at-alumni.ethz.ch, 6/15/2017  


data.finalti=data.finalti - timeshift;  
