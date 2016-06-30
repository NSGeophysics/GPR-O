function makeMovie(surveyparams,data,maxti,filename,fps,leftinc,interp)
% makeMovie(surveyparams,data,maxti,filename,fps,leftinc,interp)
%
% Works only in Matlab (for now)
%
% Create a movie that goes through depth slices.
%
% INPUT:
%
% surveyparams 	same as for all other GPRcode scripts
% data 			data loaded from readdata2
% maxti 		maximum time slice
% filename      name for your movie
% fps           frames per second (movie speed)
% leftinc       If your measuring lines advanced to the left of
%               your starting point, set this value to 1. If not, you can omit it
% interp 		Want to use the interpolated plot or the boxy plot? (optional)
% 
% Last modified by plattner-at-alumni.ethz.ch, 12/12/2014

defval('interp',0)

F(maxti)=struct('cdata',[],'colormap',[]);
for tt=1:maxti
    if interp
        plotdata2DgprInterp(data,surveyparams,tt,leftinc);
    else
        plotdata2Dgpr(data,surveyparams,tt,leftinc);
    end
    F(tt)=getframe;
end

movie2avi(F,[filename '.avi'],'fps',fps)
