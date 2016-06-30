function data=lingain(data,max)
% data=lingain(data,max)
%
% Increases the data amplitude linearly with depth to make deeper reflectors more visible
%
% INPUT:
%
% data 		The data that you loaded
% max 		The maximum gain you want to apply (for the deepest point)
%
% OUTPUT:
%
% data 		The data with applied gain
%
% Last modified by plattner-at-alumni.ethz.ch, 04/01/2015



tvals=data.finalti;

gainfunct=linspace(1,max,length(tvals))';

for line=1:size(data.gprdata,3)
	for trace=1:size(data.gprdata,2)
		data.gprdata(:,trace,line)=data.gprdata(:,trace,line).*gainfunct;
	end
end



