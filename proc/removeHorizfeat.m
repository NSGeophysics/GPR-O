function dataout=removeHorizfeat(data,ntraces)

% First check if window length is too large. If it is, make it the maximum
if ntraces>size(data,2)
    ntraces=size(data,2)-1;
    fprintf('Window length set to number of traces %d\n',ntraces)
end


dataout=nan(size(data));

% For the first ntraces, we just take the average of all ntr
for i=1:size(data,2)
    winstart=i-floor(ntraces/2);
    winend=i+floor(ntraces/2);
    % Gotta make sure that the indices are not negative or zero. In that
    % case we need to add at the end or in the beginning
    if winstart<1        
        winend=winend-winstart+1;
        winstart=1;
    end
    if winend>size(data,2)
        winstart=winstart-(winend-size(data,2));
        winend=size(data,2);
    end            
    
    % Here we calculate the running mean and subtract it
    avg= mean(data(:,winstart:winend),2);
%    fprintf('window %d to %d, width %d\n',winstart,winend,winend-winstart)
    dataout(:,i)=data(:,i)-avg;

end
    


