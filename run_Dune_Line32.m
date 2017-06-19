
% Set all the directories
initialize

% Define the survey parameters
surveyparams.minline=32;
surveyparams.nmorelines=0;
surveyparams.lineincr=30; % Distance between the lines in meters
surveyparams.pnameraw='data/raw/dune/'; % Directory for the raw data
surveyparams.pnametrf='data/processed/dune/';

% Define the directory for the topography
topodatadir='data/topo/dune/';

preprawdata(surveyparams,3);
data=readdata(surveyparams);

plotGPRline(data,0);

% From a table or separate investigation
vel=0.15;


% In this example we only want to look at a single line
% Load topography for line 32
linenr=32;
topoline=load(fullfile(topodatadir,sprintf('FILE____%03d.txt',linenr)));

% Build topography matrix
elev=makeElev(topoline(:,2),topoline(:,1),0,data,surveyparams);

% Correct for topography
data=elevCorrect(data,elev,vel);

% Show topography
plotGPRline(data,0,3,vel)
