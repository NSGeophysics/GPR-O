function data=elevCorrect(data,elev,vel)
% data=elevCorrect(data,elev,vel) 
%
% Shifts each trace by corresponding elevation
%
% INPUT:
%
% data      loaded data 
% elev      matrix containing elevation at each trace
% vel       velocity to turn elevation into travel time shift
%
% OUTPUT:
%
% data      data with corrected travel time shift
%
% Last modified by plattner-at-alunmi.ethz.ch, 5/14/2015


% Caclulate elevation deviation from elevation data
% Use 0 as minimum elevation
elev=elev-min(elev(:));

% Turn each elevation point into a two way travel-time shift.
% It's two-way travel time
etime=2*elev/vel;

% Find time step
tstep=data.finalti(2)-data.finalti(1);

% Turn etime into number of time steps
% In matlab indices always start with 1, so add 1 to make the lowest
% elevation be in pixel 1
tshift=round(etime/tstep);
maxup=max(tshift(:));
% We want the highest elevation to be zero time. Need to shift most, where
% we are the lowest
tshift=max(tshift(:))-tshift+1;

%maxdn=abs(min(tshift(:)));

% Make big 3D matrix with nans
%newdata=nan(length(data.finalti)+maxup+maxdn,...
%    length(data.finalex),length(data.gprcell));
newdata=zeros(length(data.finalti)+maxup,...
    length(data.finalex),length(data.gprcell));

%newfinalti=[-maxup*tstep:tstep:-tstep data.finalti (data.finalti(end)+tstep):tstep:(data.finalti(end)+maxdn*tstep)];
newfinalti=0:tstep:data.finalti(end)+maxup*tstep;

% For now I have no better idea than just enter every single trace of the
% data into newdata
for pos=1:length(data.finalex)
    for line=1:length(data.gprcell)
        newdata(tshift(pos,line):(tshift(pos,line)+length(data.finalti)-1)...
            ,pos,line)...
            =data.gprdata(:,pos,line);        
    end    
end

data.gprdata=newdata;
data.finalti=newfinalti;

