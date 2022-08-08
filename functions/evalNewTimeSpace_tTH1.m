function [tTH1, timeSnc] = evalNewTimeSpace_tTH1(timeSnc, tTH1, tTH2)
% timeSnc: tempo su tTH1 in cui inizia tTH2

    if timeSnc<min(tTH1.time.v)
% tTH2 inizia prima di tTH1 aggiunge 0 i testa a tTH1
%   ........++++++++++++++++++++++++++++++++++++++++++++.......    
%   ........00000-------------------------------------------...
%         fprintf('trovato id negativo, traslo tTH2 e azzero id');
        names = fieldnames(tTH1);
        step = tTH1.time.v(2) - tTH1.time.v(1);
        for i=1:length(names)
            % controllo che siano vettori colonna altrimenti traspongo
            s = size(tTH1.(names{i}).v);
            if s(2)>s(1) 
                tTH1.(names{i}).v = tTH1.(names{i}).v';
            end
            dt = abs(timeSnc - tTH1.time.v(1));
            tTH1.(names{i}).v = [zeros(ceil(dt/step),1); tTH1.(names{i}).v];
        end
        tTH1.time.v = ((cumsum(ones(size(tTH1.time.v))))-1)*step;
        timeSnc = min(tTH1.time.v);
    end

    if tTH1.time.v(end)< (tTH2.time.v(end)+timeSnc)
% tTH2 finisce dopo tTH1
%   ........++++++++++++++++++++++++++++++++++++++++++++.......    
%   .....------------------------------------------00000...
        dt =  (tTH2.time.v(end)+timeSnc)-tTH1.time.v(end);
        step = tTH1.time.v(2) - tTH1.time.v(1);
        names = fieldnames(tTH1);
        for i=1:length(names)
            s = size(tTH1.(names{i}).v);
            if s(2)>s(1)
                tTH1.(names{i}).v = tTH1.(names{i}).v';
            end
            tTH1.(names{i}).v = [ tTH1.(names{i}).v; zeros(ceil(dt/step),1)];
        end
        tTH1.time.v = ((cumsum(ones(size(tTH1.time.v))))-1)*step;
    end
  
end
