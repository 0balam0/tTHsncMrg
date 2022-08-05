function [tTH1, tTH2, idMin] = update_tTH_space(idMin, tTH1, tTH2)
%     size(tTHl.time.v)
%     fprintf('update tTH, id in: %d\n', idMin);
% figure()
% plot(tTH1.time.v, tTH1.EngineSpeed.v); hold on;
    if idMin<1
        fprintf('trovato id negativo, traslo tTH2 e azzero id');
        names = fieldnames(tTH1);
        step = tTH1.time.v(2) - tTH1.time.v(1);
        for i=1:length(names)
            s = size(tTH1.(names{i}).v);
            if s(2)>s(1)
                tTH1.(names{i}).v = tTH1.(names{i}).v';
            end
            tTH1.(names{i}).v = [zeros(abs(idMin)+1,1); tTH1.(names{i}).v];
        end
        tTH1.time.v = ((cumsum(ones(size(tTH1.time.v))))-1)*step;
        idMin = 1;
        fprintf('idMin finale %d:\n',idMin)
    end

    if tTH1.time.v(end)< (tTH2.time.v(end)+tTH1.time.v(idMin))
        fprintf('aggiungo\n')
        delta_time =  (tTH2.time.v(end)+tTH1.time.v(idMin))-tTH1.time.v(end);
        step = tTH1.time.v(2) - tTH1.time.v(1);
        names = fieldnames(tTH1);
        for i=1:length(names)
            s = size(tTH1.(names{i}).v);
            if s(2)>s(1)
                tTH1.(names{i}).v = tTH1.(names{i}).v';
            end
            tTH1.(names{i}).v = [ tTH1.(names{i}).v; zeros(ceil(delta_time/step),1)];
        end
        tTH1.time.v = ((cumsum(ones(size(tTH1.time.v))))-1)*step;
    end
% plot(tTH1.time.v, tTH1.EngineSpeed.v);    
end

%     if idMin+length(tTH2.time.v)> length(tTH1.time.v)
%         len1 = length(tTH1.time.v);
%         len2 = length(tTH2.time.v);
%         names = fieldnames(tTH1);
%         step = tTH1.time.v(2) - tTH1.time.v(1);
%         for i=1:length(names)
%             s = size(tTH1.(names{i}).v);
%             if s(2)>s(1)
%                 tTH1.(names{i}).v = tTH1.(names{i}).v';
%             end
%             tTH1.(names{i}).v = [tTH1.(names{i}).v; zeros((idMin+len2-len1),1)];
%         end
%         tTH1.time.v = (tTH1.time.v(1): step: (length(tTH1.time.v)-1)*step);
%         fprintf('caso id min +len SignalS> len signalL\n')
