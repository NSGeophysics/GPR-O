function varargout=plotdata2Dgpr2(gprdata,finalex,finalti,ttime,dy,rot)
% timeslice=plotdata2Dgpr(gprdata,finalex,finalti,ttime,dy,rot)
%
% After loading the data using READDATA2, makes a two-dimensional plot at
% a certain travel time - which you need to figure out corresponds to a
% certain depth - and rotates it by "rot" degrees. 
%
% INPUT:
%
% gprdata      The data - all this output of READDATA2
% finalex      The x positions common to all slices
% finalti      The t positions common to all slices
% ttime        The requested travel time
% dy    	   The increment between the individual measured lines (in m)
% rot          The degrees by which the image should be rotated 
%              (counterclockwise)
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
res=40;

[distt,irow]=min(abs(finalti-ttime)); 

timeslice=squeeze(gprdata(irow,:,:))';

%now make high-resolution interpolation that agrees with actual distance

y=0:dy:dy*(size(gprdata,3)-1);
x=finalex;
[xx,yy]=meshgrid(x,y);
z=timeslice;

try
    F=scatteredInterpolant(xx(:),yy(:),z(:),'natural');
catch
    F=TriScatteredInterp(xx(:),yy(:),z(:),'natural');
end

xp=linspace(min(x),max(x),(max(x)-min(x))*res);
yp=linspace(min(y),max(y),(max(y)-min(y))*res);

% Make the 2D grid, pairs of values 
[X,Y]=meshgrid(xp,yp);

% Then create the interpolation "handle"
Z=F(X,Y);

if rot~=0
    Zr=imrotate(Z,-rot);
else
    Zr=Z;
end

% Plot it:
if nargout==0
    imagesc(xp,yp,Zr)
    axis xy
    axis equal
    axis tight
    xlabel('distance [m]')
    ylabel('distance [m]')
    title(sprintf('slice at two-way travel time %g',ttime))
end

longticks

varns={Zr};
varargout=varns(1:nargout);