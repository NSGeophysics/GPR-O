function preprawdata(surveyparams,type)
% preprawdata(surveyparams,type)
%
% Used to transform the raw data into the mgp data format, to set the zero
% time, to set the gain, and to migrate.
%
% INPUT:
%
% surveyparams  A struct containing the following variables:
%               minline     Lowest line number
%               nmorelines  Number of lines in the survey
%               lineincr    Distance between the lines in meters
%               pnameraw    Full path to the raw data
%               pnametrf    Full path to the folder in which the
%                           transformed data should be stored
% type          which GPR system and what does the filename start with?
%               0 PulseEKKO Pro, filenames start with X (default)
%               1 PulseEKKO Pro, filenames start with Y
%               2 PulseEKKO Pro, filenames start neither with X nor with Y
%               3 GSSI  
%
% Last modified by plattner-at-alumni.ethz.ch, 6/17/2017
  
minline=surveyparams.minline;  
nmorelines=surveyparams.nmorelines;
lineincr=surveyparams.lineincr;
pnameraw=surveyparams.pnameraw;
pnametrf=surveyparams.pnametrf;

defval('XorY',0)

fprintf('First line = %d\n',surveyparams.minline)
fprintf('Number of lines = %d\n',surveyparams.nmorelines+1);
fprintf('Distance between lines = %g\n',surveyparams.lineincr);
fprintf('Folder of raw data is %s\n',surveyparams.pnameraw);
fprintf('Folder for transformed data is %s\n',surveyparams.pnametrf);

for i=minline:minline+nmorelines
    switch type
        case 0
          fname=sprintf('XLINE%02d',i);
        case 1
          fname=sprintf('YLINE%02d',i);
        case 2
          fname=sprintf('LINE%02d',i);
	case 3
	  fname=sprintf('FILE____%03d',i);
    end
    % Read the data
    if type~=3
      % Sensors and Software PulseEKKO Pro    
      % dt1read is from lbaradello@ogs.trieste.it
      filename=fullfile(pnameraw,[fname '.DT1']);
      [data,weirdhead]=dt1read(filename);
      % I prefer my own header reader:
      headername=fullfile(pnameraw,fname);
      header=readdt1header(headername);
      % We assume that all traces have an equal number of time samples:
      twtt=linspace(0,header.ttw,header.ppt);
      xpos=linspace(header.stp,header.fip,header.ntr);
      % If the unit is feet, we need to change this here
      if strcmp(header.unit,'ft')
        xpos=xpos*0.3048;
      end

    elseif type==3
      % GSSI SIR2000
      filename=fullfile(pnameraw,[fname '.DZT']);
      [data,header]=dztread(filename);
      % Each trace has the same number of time samples
      twtt=linspace(0,header.nanosecptrace,header.sptrace);
      xpos=header.startposition + ...
	   linspace(0,size(data,2)/header.scpmeter,size(data,2));
    end
    
    savename=fullfile(pnametrf,[fname '.mat']);
    try
      save(savename,'data','twtt','xpos')
    catch
      warning('Folder to save file did not exist. Making the folder now')
      mkdir(pnametrf)
      save(savename,'data','twtt','xpos')
    end
    
    fprintf('Done with line %d\n',i)
    
end



