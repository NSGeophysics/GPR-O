function varargout=plotGPRline(data,linenr,gain,vel,maxelev)
% line=plotGPRline(data,linenr,gain,vel,maxelev)
%
% Plot a single GPR line from the data that you use in the 3D plot.
% IMPORTANT: You don't plot the entire line but only the part that 
% is in the horizontal slices.
%
% INPUT: 
%
% data 			The data structure read from readdata2(surveyparams)
% linenr 		Which line to plot
% gain 			make the colors stronger (not required)
% vel 			Velocity if you want to change time to depth 
%               (not required)
% maxelev       Maximum elevation (default: 0)
%
% OUTPUT:
%
% line 			The line you asked for. If no output requested, will
%               just make a plot
%
% EXAMPLE:
%
% data=readdata2(surveyparams);
% plotGPRline(data,0); % Plots the first line
%
% Last modified by plattner-at-alumni.ethz.ch, 4/14/2017

defval('gain',0)
defval('vel',0)
defval('maxelev',0)

if vel & ~ maxelev
	data.finalti=data.finalti*vel/2;
elseif vel & maxelev
    data.finalti = maxelev - data.finalti*vel/2;
end
imagesc(data.finalex,data.finalti,data.gprdata(:,:,linenr+1));
set(gca,'FontSize',20)
dmax=max(max(abs(data.gprdata(:,:,linenr+1))));
if gain
	caxis([-dmax dmax]/gain)
end
if vel & ~maxelev
	ylabel('Depth [m]')
elseif vel & maxelev
    ylabel('Elevation [m]')
    axis xy
else
	ylabel('Two way travel time [ns]')
end
xlabel('position [m]')
title(sprintf('Line number %d',linenr))

colormap('gray')
axis tight

longticks

varns={data.finalti};
varargout=varns(1:nargout);
