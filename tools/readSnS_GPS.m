function [N,W,Z,trace,position]=readSnS_GPS(filename)
% [N,W,Z,trace,position]=readSnS_GPS(filename)
%
% Reads GPS data from Sensors and Software data format .GPR
% 
% WARNING: This program has not been thoroughly tested with various GPS 
% files. The format of the .GPS files may depend on the UTM zone and or
% processing. So use with care!
%
% INPUT:
%
% filename      name (including path) of the .GPS file
% 
% OUTPUT: 
%
% N             Northing UTM coordinate [m]
% W             West UTM coordinate [m]
% Z             Elevation coordinate [m]
% trace         Correspoinding trace number in dt1 data set
% position      Along-track position
%
% Last modified by plattner-at-alumni.ethz.ch, 4/20/2017


fid=fopen(filename,'r');

trace=[];
position=[];
N=[];
W=[];
Z=[];

while ~feof(fid)
    line=fgets(fid);
    A=sscanf(line,'Trace #%d at position %g');
    trace=[trace;A(1)];
    position=[position;A(2)];
    
    line=fgets(fid);
    
    line=fgets(fid);
    A=sscanf(line,'$GPGGA,%g,%g,N,%g,W,%d,%d,%g,%g,M,%g,M,%d,%g');
    N=[N;A(2)];    
    W=[W;A(3)];
    Z=[Z;A(7)];
    
    
    line=fgets(fid);
end

fclose(fid);