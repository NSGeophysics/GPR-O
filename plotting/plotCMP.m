function plotCMP(data,linenr,gain,renorm)
% plotCMP(data,linenr,gain,renorm)
%
% Plots the CMP gather. To be used with plotCMPhyperbola to estimate
% subsurface velocities
%
% INPUT: 
%
% data 		The data structure for the CMP read from readdata2(surveyparams)
% linenr 	Which line to plot (not required)
% gain 		make the colors stronger (not required)
% renorm 	do you want to have each trace renormalized? Yes=1, No=0 [default=1] (not required)
%
% EXAMPLE:
%
% data=readdata2(surveyparams);
% plotCMP(data);
%
% Last modified by plattner-at-alumni.ethz.ch, 2/23/2015


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


defval('minoffset',0)
% If saved with minoffset=0, add minoffset to finalex because it does not 
% start at zero
data.finalex=data.finalex+minoffset;
imagesc(data.finalex,data.finalti,data.gprdata(:,:,linenr+1));
set(gca,'FontSize',20)
dmax=max(max(abs(data.gprdata(:,:,linenr+1))));
if gain
	caxis([-dmax dmax]/gain)
end
ylabel('Two way travel time [ns]')
xlabel('position [m]')
title(sprintf('CMP gather number %d',linenr))
colormap('gray')

longticks



