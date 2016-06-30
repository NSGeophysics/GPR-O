function scr=WARRhyperbScore(data,tp,v,xmax,linenr)
% WARRhyperbScore(data,tp,v,xmax,linenr)
% 
% Calculates the sum of the values along a hyperbola over a WARR line to give a relative
% value of how well the chosen hyperbola fits a hyperbola in the image
%
% INPUT:
%
% data          The data structure for the WARR read from 
%               readdata2(surveyparams)
% tp            two way travel time at which the hyperbola peak should be
%               placed ("depth")
% v             subsurface velocity guess        
% xmax          maximum semi-offset 
% linenr        Which line to plot (not required)
%
% OUTPUT:
%
% scr           sum of values / number of evaluation points
%
% Last modified by plattner-at-alumni.ethz.ch, 03/25/2015

defval('linenr',0)

%% First we will make the hyperbola

% Depth of the layer depending on velocity and two way travel time
% placement
d=tp/2*v;

% Evaluation location for the offset
x=min(data.finalex):0.01:xmax;

% Two way travel time as function of offset
t=sqrt(x.^2 + 4*d.^2)/v;

%% Next we need to evaluate the figure at the hyperbola points

vals=interp2(data.finalex,data.finalti,...
    data.gprdata(:,:,linenr+1),...
    x,t);

% And calculate the average along the hyperbola
scr=sum(vals)/length(vals);


