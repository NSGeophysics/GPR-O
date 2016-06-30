function plotWARR(data,linenr,gain,renorm)
% plotWARR(data,linenr,gain,renorm)
% 
% Plots the Wide Angle Reflection and Refraction (WARR) line. 
% To be used with plotWARRhyperbola to estimate subsurface velocities
%
% INPUT: 
%
% data 		The data structure for the WARR read from readdata2(surveyparams)
% linenr 	Which line to plot (not required)
% gain 		make the colors stronger (not required)
% renorm 	do you want to have each trace renormalized? Yes=1, No=0 [default=1] (not required)
%
% EXAMPLE:
%
% data=readdata2(surveyparams);
% plotWARR(data);
%
% Last modified by plattner-at-alumni.ethz.ch, 3/25/2015


defval('linenr',0)
defval('gain',0)
defval('renorm',1)

if renorm
	% To clearly see the hyperbola: renormalize every trace!
	for i = 1:size(data.gprdata,2)
		data.gprdata(:,i,linenr+1)=...
			data.gprdata(:,i,linenr+1)/max(abs(data.gprdata(:,i,linenr+1)));
	end
end

imagesc(data.finalex,data.finalti,data.gprdata(:,:,linenr+1));
set(gca,'FontSize',20)
dmax=max(max(abs(data.gprdata(:,:,linenr+1))));
if gain
	caxis([-dmax dmax]/gain)
end
ylabel('Two way travel time [ns]')
xlabel('position [m]')
title(sprintf('WARR line number %d',linenr))
colormap('gray')

longticks