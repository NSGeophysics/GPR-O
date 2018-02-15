function scr=WARRlinearScore(data,tp,v,xmax,linenr)
% scr=WARRlinearScore(data,tp,v,xmax,linenr)
% 
% Calculates the sum of the values along a line over a WARR data set
% to give a relative value of how well the chosen velocity/depth-time  
% linear moveout fits the image
%
% INPUT:
%
% data          The data structure for the WARR read from 
%               readdata2(surveyparams)
% tp            two way travel time at which the hyperbola peak should be
%               placed ("depth")
% v             subsurface velocity guess        
% xmax          maximum semi-offset 
% linenr        Which WARR line to plot (not required)
%
% OUTPUT:
%
% scr           (sum of values)/(number of evaluation points)
%
% Last modified by plattner-at-alumni.ethz.ch, 02/23/2015
% function name change: 02/14/2018

defval('linenr',0)

%% First we will make the line

% Evaluation location for the offset
x=min(data.finalex):0.01:xmax;

% Refraction line as a function of offset
t=tp+x/v;

%% Next we need to evaluate the figure at the line points

vals=interp2(data.finalex,data.finalti,...
    data.gprdata(:,:,linenr+1),...
    x,t);

% And calculate the average along the line    
scr=sum(vals)/length(vals);   
