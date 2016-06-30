function elev=makeElev(elevdat,xpos,ylines,data,surveyparams)
% elev=makeElev(elevdat,xpos,ylines,data,surveyparams)
%
% Returns an interpolated topography matrix for all the data points for all
% the parallel lines
%
% INPUT:
%
% elevdat       Matrix containing the measured topography for some lines 
%               at given x position
% xpos          Vector containing the x locations for topography for the 
%               given lines
% ylines        line numbers
% data          Your loaded GPR data
% surveyparams  Your preset survey parameters
%
% OUTPUT:
%
% elev          matrix containing the interpolated topography points for
%               each GPR data point
%
% Last modified by plattner-at-alumni.ethz.ch, 05/19/2015

%if size(elevdat,1)~=size(data.gprdata,3) | size(elevdat,2)~=length(data.finalex)
%    error('Lines of elevdat matrix must be x positions, columns must be lines')
    %error('Your elevdat must be a struct! for example elevdat{1}=[points]')
%end   
    
if xpos(1)>data.finalex(1) | xpos(end)<data.finalex(end)
    warning('Extrapolation not allowed here. Elevation values will be NaN')
end

% determine if 1d or 2d interpolation
if size(elevdat,1)==1 | size(elevdat,2)==1
    
    elev = (interp1(xpos,elevdat,data.finalex,'pchip'))';
    % pchip is much better because with spline, if you go from flat to
    % steep, you do a little undulation. This one doesn't do this.
    
    
else
            
    if length(xpos)==size(elevdat,1) | length(ylines)==size(elevdat,2)
        elevdat=elevdat';
    end            
        
    [XX,YY]=meshgrid(xpos,surveyparams.lineincr*ylines);
    elev=interp2(XX,YY,elevdat,...
        data.finalex',surveyparams.lineincr*(0:(length(data.gprcell)-1)),...
        'cubic');
                
    elev=elev';
    
end
    
    
    
