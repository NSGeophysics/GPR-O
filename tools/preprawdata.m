function preprawdata(surveyparams,XorY)
% preprawdata(surveyparams,XorY)
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
% XorY          are the filenames starting with X or Y or nothing?
%               X then set XorY=0 (or leave it out)
%               Y then set XorY=1
%               nothing then set XorY=2
%
% Last modified by plattner-at-alumni.ethz.ch, 6/6/2017

minline=surveyparams.minline;  
nmorelines=surveyparams.nmorelines;
lineincr=surveyparams.lineincr;
pnameraw=surveyparams.pnameraw;
pnametrf=surveyparams.pnametrf;

defval('XorY',0)

fprintf('Number of lines = %d\n',surveyparams.nmorelines);
fprintf('Line increment = %g\n',surveyparams.lineincr);
fprintf('Folder of raw data is %s\n',surveyparams.pnameraw);
fprintf('Folder for transformed data is %s\n',surveyparams.pnametrf);

for i=minline:minline+nmorelines
    switch XorY
        case 0
            fname=sprintf('XLINE%02d',i);
        case 1
            fname=sprintf('YLINE%02d',i);
        case 2
            fname=sprintf('LINE%02d',i);
    end
    % Read the data
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
    savename=fullfile(pnametrf,[fname '.mat']);
    save(savename,'data','twtt','xpos')
    
    fprintf('Done with line %d\n',i)
    
end



