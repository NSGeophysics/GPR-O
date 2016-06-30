function longticks(handel,fac)
% LONGTICKS(handel,fac)
%
% handel   Handle to the figure panel [default: gca]
% fac      Divides the default length(s) by this/these
%          (Note this is for 2D/3D views, not for X/Y)
%
% Last modified by fjsimons-at-alum.mit.edu, 03/19/2008

defval('handel',gca)
defval('fac',1)

set(handel,'TickDir','out','TickLength',[0.02 0.025]./fac)
