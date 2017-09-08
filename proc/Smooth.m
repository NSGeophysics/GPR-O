function traceout=Smoothing(trace,window)


% Similar to AutoGain, we use a running window to
% calculate the average in each window and then replace the samples with
% that average

traceout=nan(size(trace));

% First check if window length is too large. If it is, make it the maximum
if window>length(trace)
    window=length(trace)-1;
    fprintf('Window length set to number of time samples %d\n',window)
end



for i=1:length(trace)
    winstart=i-floor(window/2);
    winend=i+floor(window/2);
    if winstart<1        
        winend=winend-winstart+1;
        winstart=1;
    end
    if winend>length(trace)
        winstart=winstart-(winend-length(trace));
        winend=length(trace);
    end            
    
    traceout(i)=mean(trace(winstart:winend));
end

    
    