function cycledepth(surveyparams,data,maxti,weit,leftinc,interp)
% cycledepth(surveyparams,data,maxti,weit,leftinc,interp)
% 
% Shows depth slices after each other (going down)
%
% INPUT:
%
% surveyparams 	same as for all other GPRcode scripts
% data 			data loaded from readdata2
% maxti 		maximum time slice
% weit 		    how long to wait between frames (in s) 
% 				if set to zero: press key to advance
% leftinc       If your measuring lines advanced to the left of
%               your starting point, set this value to 1. If not, you can omit it
% interp 		Want to use the interpolated plot or the boxy plot? (optional)
% 
% Last modified by plattner-at-alumni.ethz.ch, 12/11/2014

defval('interp',0)
defval('leftinc',0)

for tt=1:min(maxti,max(data.finalti))
	if interp
		plotdata2DgprInterp(data,surveyparams,tt,leftinc)
	else
		plotdata2Dgpr(data,surveyparams,tt,leftinc)
	end
	if weit
		pause(weit)
	else
		pause
	end
end