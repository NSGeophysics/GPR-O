function data=omitlines(data,numbers)
% data=omitlines(data,numbers)
%
% Sets the values in the selected lines to "not a number" such that they are not plotted.
% This can be helpful if the data set has one of these odd differently colored lines.
%
% INPUT:
%
% data 		loaded gpr data structure
% numbers 	the numbers of the lines you want to not show (e.g. numbers=[1 3 5]).
% 			remember: the first line number is 0!
% OUTPUT:
% data 	the updated data structure
%
% Last modified by plattner-at-alumni.ethz.ch, 03/27/2015

% Turn line number into index
numbers = numbers+1;		

% And replace the lines
data.gprdata(:,:,numbers)=nan(size(data.gprdata(:,:,numbers)));

