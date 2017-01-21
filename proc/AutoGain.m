function traceout=AutoGain(trace,window)


% Similar to remove horizontal features, we use a running window to
% calculate the energy in each window and then normalize the samples with
% that energy

energy=nan(size(trace));
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
    
    energy(i)=max(norm(trace(winstart:winend)),sqrt(eps));
end

% Now normalize trace entries by energy in each window
    
traceout=trace./energy;
    
    