function varargout=plotdata2DgprInterp(data,surveyparams,ttime,leftinc,rot)
% timeslice=plotdata2DgprInterp(data,surveyparams,ttime,leftinc,rot)
%
% After loading the data using READDATA2, makes a two-dimensional plot at
% a certain travel time - which you need to figure out corresponds to a
% certain depth - and rotates it by "rot" degrees. 
%
% INPUT:
%
% data          The data structure read from readdata2(surveyparams)
% surveyparams  The survey parameters to process your data
% ttime         The requested travel time (equivalent to depth)
% leftinc       If your measuring lines advanced to the left of
%               your starting point, set this value to 1. If not, you can omit it
% rot           The degrees by which the image should be rotated 
%               (counterclockwise)
% 
% OUTPUT:
%
% timeslice    The time slice that you just asked for. If no output
%              requested, will just make a plot
% 
% EXAMPLE:
%
% [gprdata,finalex,finalti]=readdata2;
% timeslice=plotdata2Dgpr2(gprdata,finalex,finalti,15,0.2,10);
%
% Last modified by plattner-at-alumni.ethz.ch, 11/15/2013

% If you want the interpolation to be finer (or coarser), change the
% resolution here:
res=100;%40;

defval('rot',0)
defval('leftinc',0)

gprdata=data.gprdata;
finalex=data.finalex;
finalti=data.finalti;

%y=0:(surveyparams.nmorelines -1);
y=0:(surveyparams.nmorelines);
y=y*surveyparams.lineincr;


[distt,irow]=min(abs(finalti-ttime)); 

timeslice=squeeze(gprdata(irow,:,:))';

%now make high-resolution interpolation that agrees with actual distance

%y=0:dy:dy*(size(gprdata,3)-1);
x=finalex;
[xx,yy]=meshgrid(x,y);
z=timeslice;


% These are the points on which you want to plot the interpolation
xp=linspace(min(x),max(x),(max(x)-min(x))*res);
yp=linspace(min(y),max(y),(max(y)-min(y))*res);

% Make the 2D grid, pairs of values 
[X,Y]=meshgrid(xp,yp);

%keyboard
Z=interp2(xx,yy,z,X,Y);

% Then create the interpolation "handle"
%Z=F(X,Y);

if rot~=0
    Zr=imrotate(Z,-rot);
else
    Zr=Z;
end

% Plot it:
if nargout==0
    imagesc(xp,yp,Zr)
    colormap(gray)
    %axis xy
    axis equal
    axis tight
    xlabel('distance [m]')
    ylabel('distance [m]')
    title(sprintf('slice at two-way travel time %g',ttime))    
    if leftinc
    	axis ij    	
	end
end

longticks

varns={Zr};
varargout=varns(1:nargout);
