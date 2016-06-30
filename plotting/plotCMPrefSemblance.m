function plotCMPrefSemblance(data,trng,vrng,xmax,linenr,renorm)
% plotCMPrefSemblance(data,trng,vrng,xmax,linenr,renorm)
% 
% Plot the refraction line scores for different travel time ranges 
% and velocity ranges to see which one fits best.
%
% INPUT:
%
% data          The data structure for the CMP read from 
%               readdata2(surveyparams)
% trng          two way travel time ('depth') range
% vrng          velocity range
% xmax          maximum semi-offset 
% linenr        Which line to plot (not required)
% renorm 		Plot score of renormalized CMP gathers? (not required)
%
% Last modified by plattner-at-alumni.ethz.ch, 04/30/2015

defval('linenr',0)
defval('renorm',0)

% Shall we do this with the renormalized data?
if renorm
	for i = 1:size(data.gprdata,2)
		data.gprdata(:,i,linenr+1)=...
			data.gprdata(:,i,linenr+1)/max(abs(data.gprdata(:,i,linenr+1)));
	end
end

for i=1:length(vrng)
    for j=1:length(trng)
        scr(i,j)=refractionScore(data,trng(j),vrng(i),xmax,linenr);
    end
end


imagesc(vrng,trng,abs(scr)')
longticks
xlabel('velocity')
ylabel('two way travel time')
title('Refraction line scores for different velocities and time depths')
colorbar

