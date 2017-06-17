function [datline,header]=dztread(filename)
% [datline,header]=dztread(filename)  
%
% Reads GSSI's dzt format
%
% INPUT:
%  
% filename     name of the file you would like to load  
%
% OUTPUT:
%
% datline      matrix containing gpr data profile
% header       header info
%
% With help from reviewdztheader.m by Andreas Tzanis
%  
% Last modified by plattner-at-alumni.ethz.ch, 6/17/2017


fid=fopen(filename);
  
% Get header information
% Need to read this byte by byte, because they change the type
nchannels=fread(fid,1,'uint16');

% Size of the header
headsize=fread(fid,1,'uint16');

% Samples per trace
header.sptrace=fread(fid,1,'uint16');

% Bits per word
bpdatum=fread(fid,1,'uint16');

% Binary offset
binoffs=fread(fid,1,'int16');

% Scans per second
header.scpsec=fread(fid,1,'float32');

% Scans per meter
header.scpmeter=fread(fid,1,'float32');
% If scpmeter==0, then no trigger wheel was used.

% Meters per mark
header.mpmark=fread(fid,1,'float32');

header.startposition=fread(fid,1,'float32');

header.nanosecptrace=fread(fid,1,'float32');

header.scansppass=fread(fid,1,'uint16');

fclose(fid);

if bpdatum == 8
  datatype = 'uint8';
elseif bpdatum == 16
  datatype = 'uint16';
elseif bpdatum == 32
  datatype = 'uint32';
else
  error('an not read data type')
end



% Now read the entire file
fid=fopen(filename);
vec=fread(fid,Inf,datatype);
fclose(fid);

% Separate between header and data
headlength=headsize/(bpdatum/8);
%header=vec(1:headlength);
datvec=vec(headlength+1:end);

% Turn unsigned integers into signed integers
datvec = datvec - (2^bpdatum)/2;

datline=reshape(datvec,header.sptrace,length(datvec)/header.sptrace);

% Remove the first two entries. They are just markers
datline=datline(3:end,:);
header.sptrace=header.sptrace-2;


