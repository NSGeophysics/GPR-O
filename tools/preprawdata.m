function preprawdata(surveyparams,XorY)
% preprawdata(surveyparams,XorY)
%
% Used to transform the raw data into the mgp data format, to set the zero
% time, to set the gain, and to migrate.
%
% INPUT:
%
% surveyparams  A struct containing the following variables:
%               nlines      Number of lines in the survey
%               lineincr    Distance between the lines in meters
%               pnameraw    Full path to the raw data
%               pnametrf    Full path to the folder in which the
%                           transformed data should be stored
% XorY          are the filenames starting with X or Y or nothing?
%               X then set XorY=0 (or leave it out)
%               Y then set XorY=1
%               nothing then set XorY=2
%
% Last modified by plattner-at-alumni.ethz.ch, 6/16/2015

nlines=surveyparams.nlines;
lineincr=surveyparams.lineincr;
pnameraw=surveyparams.pnameraw;
pnametrf=surveyparams.pnametrf;

defval('XorY',0)

fprintf('Number of lines = %d\n',surveyparams.nlines);
fprintf('Line increment = %g\n',surveyparams.lineincr);
fprintf('Folder of raw data is %s\n',surveyparams.pnameraw);
fprintf('Folder for transformed data is %s\n',surveyparams.pnametrf);

for i=0:nlines
    switch XorY
        case 0
            fname=sprintf('XLINE%02d',i);
        case 1
            fname=sprintf('YLINE%02d',i);
        case 2
            fname=sprintf('LINE%02d',i);
    end
    % Read the data
    % This is from lbaradello@ogs.trieste.it
    [data,weirdhead]=dt1read([pnameraw fname '.DT1']);
    % I prefer my own header reader:
    header=readdt1header([pnameraw fname]);
    % We assume that all traces have an equal number of time samples:
    twtt=linspace(0,header.ttw,header.ppt);
    xpos=linspace(header.stp,header.fip,header.ntr);

    
    % These are processing steps. I want to be able to do them without
    % needing to read and write the data again.
%     % Do AGC (automated gain controll) that makes the traces have roughly
%     % constant energy (amplify weaker signals from further away)
%     for tr=1:size(data,2)
%         data(:,tr)=AutoGain(data(:,tr),AGwindow);
%     end
%     
%     % Remove Horizontal features
%     if removeHorz~=0
%     	% First find the right time coordinate entry:
%     	%timewidth=max(2,max(find(IPD.tt2w<=timewindow)));
%     	% Now do it
%     	%IPD.d = csuf_rmswbackgr(IPD.d,removeHorz,timewidth);
%         data=removeHorizfeat(data,removeHorz);
%     end
    
    save([pnametrf fname '.mat'],'data','twtt','xpos')
    
    fprintf('Done with line %d\n',i)
    
end



