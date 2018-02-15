function h=plotCMPlinear(tp,v,xmax)
% h=plotCMPlinear(tp,v,xmax)
%
% For a common midpoint (CMP) investigation. Plots a line for 
% velocity v at two way travel time tp over a CMP plot to estimate the 
% subsurface veclocity for linear moveout
%
% INPUT:
%
% tp 		two way travel time if transmitter and receiver are on top of 
% 			each other (zero offset)
% v 		velocity in layer
% xmax 		maximum offset from midpoint
% 
% OUTPUT:
%
% h 		plot handle for the line
%
% Last modified by plattner-at-alumni.ethz.ch, 02/23/2015
% function name change: 02/14/2018

% Evaluation location for the offset
x=0:0.01:xmax;

t=tp+2*x/v;

% Now plot over figure
hold on
h=plot(x,t,'m','LineWidth',4);
hold off
