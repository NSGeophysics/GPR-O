function data=timeZeroAdjust(data,lines)
% data=timeZeroAdjust(data,lines)
%
% Find maximum spike and align all traces such that the maximum spike is at
% average arrival time
%
% INPUT:
%
% data      loaded data 
% lines     If you only want to do gain for one single line or a goup of
%           lines, then you can enter them: [0] or [0 3 4]. If you want to
%           do it for all lines, simply omit this.
%
% OUTPUT:
%
% data      data with adjusted zero time
%
% Last modified by plattner-at-alunmi.ethz.ch, 09/08/2017

defval('lines',0:size(data.gprdata,3)-1);


for li=1:length(lines)
    maxind=nan(size(data.gprdata,2),1);
    for tr=1:size(data.gprdata,2)
        % Find max spike
        [val,maxind(tr)]=max(abs(data.gprdata(:,tr,lines(li)+1)));          
    end
    % Find mean spike index 
    meanind=round(mean(maxind));
    
    % Go through all traces. 
    for tr=1:size(data.gprdata,2)
        % If max index is smaller than mean index, prepend zeroes with the
        % difference length and remove at the end
        if meanind>maxind(tr)
            differ=meanind-maxind(tr);
            data.gprdata(:,tr,lines(li)+1) = ...
                [zeros(differ,1);data.gprdata(1:end-differ,tr,lines(li)+1)];
        elseif meanind<maxind(tr)
            differ=maxind(tr)-meanind;
            data.gprdata(:,tr,lines(li)+1) = ...
                [data.gprdata(differ+1:end,tr,lines(li)+1);zeros(differ,1)];
        end
    
    end
        
    fprintf('timeZeroAdjust: Processed line %d\n',lines(li))
end



