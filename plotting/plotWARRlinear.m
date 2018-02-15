function h=plotWARRlinear(tp,v,xmax)
% h=plotWARRlinear(tp,v,xmax)
%
% For a Wide Angle Reflection and Refraction (WARR) line plot. 
% Plots a line for velocity v, at two way travel time tp over 
% a WARR plot to estimate the subsurface velocity.
%
% INPUT:
%
% tp 		two way travel time if transmitter and receiver are on top of 
% 			each other (zero offset)
% v 		velocity
% xmax 		maximum offset from midpoint
% 
% OUTPUT:
%
% h 		plot handle for the line
%
% Last modified by plattner-at-alumni.ethz.ch, 03/25/2015
% function name change: 02/14/2018

% Evaluation location for the offset
x=0:0.01:xmax;

t=tp+x/v;

% Now plot over figure
hold on
h=plot(x,t,'m','LineWidth',4);
hold off
