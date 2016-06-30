function C=cellnan(J,M,N)
% C=CELLNAN(J,M,N)
%
% Initializes a cell array with nans
%
% INPUT:
%
% J      The number of cells (if a scalar) or the cell dimension
% M,N    The number of rows and columns of each element of this cell;
%        if these are vectors, every element (if J is a scalar) or every
%        row (if J has two entries) can have a different dimension
%
% OUTPUT:
%
% C      The initialized cell array
%
% EXAMPLE:
%
% cellnan(3,2,1)
% cellnan([1 3],2,1)
% cellnan([3 1],2,1)
% cellnan([3 2],2,1)
% cellnan(3,[1 2 3],[3 2 1])
% cellnan([3 1],[1 2 3],[3 2 1])
% cellnan([1 4],[1 2 3],[3 2 1])
% cellnan([3 4],[1 2 3],[3 2 1])
% 
% SEE ALSO:
%
% STRUCTEMPTY
%
% Last modified by fjsimons-at-alum.mit.edu, 03/18/2011

% Defaults
defval('J',3)
defval('M',4)
defval('N',5)

% Do it!
if isscalar(J)
  C=cell(1,J);
else
  C=cell(J(1),J(2));
end

if isscalar(M) && isscalar(N)
  % If all of them have the same number of dimensions
  [C{:}]=deal(nan(M,N));
else
  % Now every row gets the same initialization and there must be one M
  % and one N for each of the rows. Later on, can extend this.
  for ind=1:J(1)
    [C{ind,:}]=deal(nan(M(ind),N(ind)));
  end
end
