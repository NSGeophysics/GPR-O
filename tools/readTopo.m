function [lon,lat,elev]=readTopo(filename)
% [lon,lat,elev]=readTopo(filename)
%
% Reads a file with lon,lat,alt information
%
% INPUT:
%
% filename      Name of the file
%
% OUTPUT:
%
% lon, lat      Longitude, latitude
% elev          altitude above your reference
%
% Last modified by plattner-at-alumni.ethz.ch, 05/07/2015

fid=fopen(filename,'r');
% Read in formatted file
points=fscanf(fid,'%d,%f,%f,%f');
pts=reshape(points,4,length(points)/4);
lon=pts(2,:);
lat=pts(3,:);
elev=pts(4,:);
