function cls=ls2cell(ddir)
% cls=LS2CELL(ddir)
%
% Makes cell array with the names in a directory
%
% INPUT:
%
% ddir     A directory name string, (some) wildcards possible
%
% OUTPUT:
%
% cls      A cell structure with the file names (only)
%
% EXAMPLE:
%
% names=ls2cell(fullfile(pwd,'*SAC'));
% names=ls2cell([pwd '/*SAC'])
%
% Last modified by fjsimons-at-alum.mit.edu, 05/07/2008


% Get the directory-content information
d=dir(ddir);

if ~prod(size(d))
   error('This directory or file does not exist')
end 
%files=str2mat(d.name);
files=char(d.name);

mino=3;
% When using a wildcard that refers directly to a file
if findstr(ddir,'*')
  mino=1;
end

for index=mino:size(files,1)
  cls{index-mino+1}=deblank(files(index,:));
end
