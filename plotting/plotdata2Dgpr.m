function varargout=plotdata2Dgpr(data,surveyparams,ttime,leftinc,stretch)
% timeslice=plotdata2Dgpr(data,surveyparams,ttime,leftinc,stretch)
%
% After loading the data using READDATA, makes a two-dimensional plot at
% a certain travel time - which you need to figure out corresponds to a
% certain depth!
%
% INPUT:
%
% data          The data structure read from readdata(surveyparams)
% surveyparams  The survey parameters to process your data
% ttime         The requested travel time (equivalent to depth)
% leftinc       If your measuring lines advanced to the left of
%               your starting point, set this value to 1. If not, you can omit it
% stretch 		do you want to stretch the plot for better visibility? 1=yes 0=no=default
% 
% OUTPUT:
%
% timeslice    The time slice that you just asked for. If no output
%              requested, will just make a plot
% 
% EXAMPLE:
%
% data=readdata2(surveyparams);
% plotdata2Dgpr(data,surveyparams,25);
%
% Last modified by fjsimons-at-alum.mit.edu, 10/10/2012
% Last modified by plattner-at-alumni.ethz.ch, 6/6/2017

defval('leftinc',0)
defval('stretch',0)

% timeslice=plotdata2Dgpr(gprdata,finalex,finalti,ttime)
gprdata=data.gprdata;
finalex=data.finalex;
finalti=data.finalti;

yvalues=0:(surveyparams.nmorelines - 1);
yvalues=yvalues*surveyparams.lineincr;
%0:surveyparams.lineincr:surveyparams.nmorelines;

% Find the row in the three-dimensional matrix closest to the requested
% time slice
[distt,irow]=min(abs(finalti-ttime)); 

% And return that (nearest) time slice
timeslice=squeeze(gprdata(irow,:,:))';

% Figure out sampling interval
dx=range(finalex)/[size(gprdata,2)-1];
dy=surveyparams.lineincr;
%dy=0.5;

% And plot it!
if nargout==0
    imagesc(finalex,yvalues,timeslice)
    set(gca,'FontSize',20)
    colormap(gray)
    if ~stretch
	    axis equal
	end
if leftinc
    axis ij
    axis xy
end
 %  axis([finalex(1) finalex(end) 1 size(gprdata,3)]+[-dx/2 dx/2 -dy/2 dy/2])
    title(sprintf('slice at two-way travel time %g ns',ttime))
    xlabel('scan axis [m]')
    %    ylabel('third dimension (lines)')
    ylabel('[m]')
end 

longticks


% Provide output if requested
varns={timeslice};
varargout=varns(1:nargout);

