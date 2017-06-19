function elev=makeElev(elevdat,xpos,data,surveyparams)
% elev=makeElev(elevdat,xpos,data,surveyparams)
%
% Returns an interpolated topography matrix for all the data points
% assuming that each profile is parallel to the x axis.
% The first profile has y-coordinate = 0,
% the second one y = surveyparams.lineincr,
% the third one y = 2 * surveyparams.lineincr
%
% If lineincr is a vector of length surveyparams.nmorelines, then the
% k-th line has y-coordinate sum(surveyparams.lineincr(k-1)) 
%
% INPUT:
%
% elevdat       if data is a single line: Vector containing elevations
%               if data is several lines: Cell array containing
%                  elevations  
%               if randomly spaced areal points: n x 3 matrix containing
%                  x, y, elev positions (no extrapolation)
% xpos          if data is a single line: Vector containing x positions
%                  of elevation measurements
%               if data is several lines: Cell array containing
%                  x positions  
%               if randomly spaced areal points: []
% data          Your loaded GPR data
% surveyparams  Your preset survey parameters
%
% OUTPUT:
%
% elev          matrix containing the interpolated topography points for
%               each GPR data point. To be used with elevCorrect
%
% Last modified by plattner-at-alumni.ethz.ch, 06/19/2017

if iscell(elevdat)
  % GPS points for individual parallel lines
  if ~iscell(xpos)
    error('if elevdat is a cell array, then xpos must be a cell array too')
  end

  % Do the simple 1-D interpolation for each line
  elev=nan(length(elevdat),length(data.finalex));  
  for i=1:length(elevdat)
      elev(i,:)=(interp1(xpos{i},elevdat{i},data.finalex,'pchip','extrap'));
  end
  % Need to transpose for easier use in ElevCorrect
  elev=elev';    
  
else
% Either randomly distributed points, or a single line.
  if isempty(xpos)
    % it's randomly distributed points
    if length(surveyparams.lineincr)==1
      % Lines are equidistant
      ygridvals=(0:1:surveyparams.nmorelines)...
	    *surveyparams.lineincr;
    else
      % lineincr gives each line increment
      ygridvals=cumsum([0 surveyparams.lineincr]);
    end
    
    xgridvals=data.finalex;
    [XX,YY]=meshgrid(xgridvals,ygridvals);
    elev=griddata(elevdat(:,1),elevdat(:,2),elevdat(:,3),XX,YY,'linear');
    % Need to transpose for easier use in ElevCorrect
    elev=elev';
    
  else
    % It's 1-d
    elev = (interp1(xpos,elevdat,data.finalex,'pchip','extrap'))';
    % pchip is much better because with spline, if you go from flat to
    % steep, you do a little undulation. This one doesn't do this.    
  end

end

