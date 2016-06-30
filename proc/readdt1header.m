function hd=readdt1header(filename)
% hd=readdt1header(filename)
%
% Returns a struct containing header information
%
% Last modified by plattner-at-alumni.ethz.ch, 4/29/2015

fid=fopen([filename '.HD'],'r');

% The first 6 are not so important for our reasons
for i=1:6
    line=fgets(fid);
end

% The next one starts to get good:

% NUMBER OF TRACES
line=fgets(fid);
cont=textscan(line,'%s%s%s%s%f');
hd.ntr=cont{5};

% NUMBER OF PTS/TRC
line=fgets(fid);
line=fgets(fid);
cont=textscan(line,'%s%s%s%s%f');
hd.ppt=cont{5};

% TIMEZERO AT POINT 
line=fgets(fid);
line=fgets(fid);
cont=textscan(line,'%s%s%s%s%f');
hd.tzp=cont{5};

% TOTAL TIME WINDOW
line=fgets(fid);
line=fgets(fid);
cont=textscan(line,'%s%s%s%s%f');
hd.ttw=cont{5};

% STARTING POSITION
line=fgets(fid);
line=fgets(fid);
cont=textscan(line,'%s%s%s%f');
hd.stp=cont{4};

% FINAL POSITION
line=fgets(fid);
line=fgets(fid);
cont=textscan(line,'%s%s%s%f');
hd.fip=cont{4};

% STEP SIZE USED
line=fgets(fid);
line=fgets(fid);
cont=textscan(line,'%s%s%s%s%f');
hd.ssu=cont{5};