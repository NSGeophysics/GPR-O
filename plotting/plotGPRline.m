function varargout=plotGPRline(data,linenr,gain,vel)
% line=plotGPRline(data,linenr,gain,vel)
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
% 			(not required)
%
% OUTPUT:
%
% line 			The line you asked for. If no output requested, will
%  			just make a plot
%
% EXAMPLE:
%
% data=readdata2(surveyparams);
% plotGPRline(data,0); % Plots the first line
%
% Last modified by plattner-at-alumni.ethz.ch, 1/16/2015

defval('gain',0)
defval('vel',0)

if vel
	data.finalti=data.finalti*vel/2;
end
imagesc(data.finalex,data.finalti,data.gprdata(:,:,linenr+1));
set(gca,'FontSize',20)
dmax=max(max(abs(data.gprdata(:,:,linenr+1))));
if gain
	caxis([-dmax dmax]/gain)
end
if vel
	ylabel('Depth [m]')
else
	ylabel('Two way travel time [ns]')
end
xlabel('position [m]')
title(sprintf('Line number %d',linenr))

colormap('gray')

longticks

varns={data.finalti};
varargout=varns(1:nargout);
