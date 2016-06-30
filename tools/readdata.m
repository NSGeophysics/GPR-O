function varargout=readdata(surveyparams)
% data=readdata(surveyparams)
%
% Reads the GPR data from the MAT files and stores it in a struct named data
%
% INPUT: 
%
%  surveyparams: A struct with the following fields:
%   nlines: The highest line number
%   lineincr: The distance between the lines (in meters)
%   pnameraw: String containing the directory of the raw files dt1
%   pnametrf: String containing the directory for the processed files
%
%
% OUTPUT: 
%  data  A cell containing the following:
%   gprdata: A three dimensional matrix with the data in it
%       Rows: two-way travel time
%       Columns: x position
%       Third dimension: different scan in y direction
%  finalex: The x positions common to all slices
%  finalti: The t positions common to all slices
%  gprcell: A cell array with all the mismatched data slices
%
% EXAMPLES:
%
% data=readdata(surveyparams);
% 
% Last modified by fjsimons-at-alum.mit.edu, ??
% Last modified by plattner-at-alumni.ethz.ch, 7/15/2015



diro=surveyparams.pnametrf;

% Find out what is in the directory
stuff=ls2cell(fullfile(diro,'*.mat'));

% Initialize range variables
exmima=[-1e9 1e9];
tsmima=[-1e9 1e9];
dex=0;
dti=0;
% Load the individual data files, first ONLY to determine their size
for index=1:length(stuff)
  disp(sprintf('Attempting to load %s',stuff{index}))
  % We're using a custom made read file here
  d=load(fullfile(diro,stuff{index}));
  % Get the data sizes
  sizes(index,:)=size(d.data);
  % Get the x-positions
  exes{index}=d.xpos(:)';
  % Get the time positions
  times{index}=d.twtt(:);
  % Figure out the smallest x position range
  exmima=[max(exmima(1),min(exes{index})) ...
	  min(exmima(2),max(exes{index}))];
  % Figure out the smallest time range
  tsmima=[max(tsmima(1),min(times{index})) ...
	  min(tsmima(2),max(times{index}))];
  % Figure out the coarsest x sampling
  dx=d.xpos(2)-d.xpos(1);
  dex=max(dex,dx); 
  disp(sprintf('x sampling interval was %g is now %g',dx,dex))
  % Figure out the coarsest t sampling
  dt=d.twtt(2)-d.twtt(1);
  dti=max(dti,dt);
  disp(sprintf('t sampling interval was %g is now %g',dt,dti))
end

% So we'll be limiting ourselves to a x position as:
finalex=exmima(1):dex:exmima(2);
% So we'll be limiting ourselves to a t position as:
finalti=tsmima(1):dti:tsmima(2);

% Now make an empty array to preallocate the memory
gprcell=cellnan([length(stuff) 1],sizes(:,1)',sizes(:,2)');
gprdata=nan(length(finalti),length(finalex),length(stuff));

% For private use only while testing
xver=0;

% And then load it all again this time save the data
for index=1:length(stuff)
  d=load(fullfile(diro,stuff{index}));
  % Stick it all in a cell
  gprcell{index}=d.data;
  % But now cut it down to the minimum range
  gprdata(:,:,index)=interp2(exes{index},times{index},d.data,...
			     finalex(:)',finalti(:));
  
  % Let's make a plot for inspection
  if xver==1
    subplot(121)
    imagesc(exes{index},times{index},d.data)
    aks=axis;
    title('original')
    xlabel('scan axis (m)')
    ylabel('two-way travel time (ns)')
    subplot(122)
    imagesc(finalex,finalti,gprdata(:,:,index))
    axis(aks)
    title('interpolated')
    xlabel('scan axis (m)')
    ylabel('two-way travel time (ns)')
    pause
  end
end

% [gprdata,finalex,finalti,gprcell]=readdata2(diro)
data.gprdata = gprdata;
data.finalex=finalex;
data.finalti=finalti;
data.gprcell=gprcell;
                             
% Provide output if requested
varns={data};
%varns={gprdata,finalex,finalti,gprcell};
varargout=varns(1:nargout);
