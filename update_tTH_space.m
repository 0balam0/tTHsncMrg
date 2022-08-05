function [tTH1, tTH2, idMin] = update_tTH_space(idMin, tTH1, tTH2)
% [tTH1, tTH2, idMin] = update_tTH_space(idMin, tTH1, tTH2)
% tTH1 -; tTH2 +;
% aggiorna tTH1 aggiungendo 0 in testa o in coda in funzione dell'ID di
% sincronizzazione trovato, tTH1 risultate inclue tTH2

    if idMin<1 
% tTH2 inizia prima di tTH1 aggiunge 0 i testa a tTH1
%   ........++++++++++++++++++++++++++++++++++++++++++++.......    
%   ........00000-------------------------------------------...
%         fprintf('trovato id negativo, traslo tTH2 e azzero id');
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
        idMin = 1; % riazzera idMin
    end

    if tTH1.time.v(end)< (tTH2.time.v(end)+tTH1.time.v(idMin))
% tTH2 finisce dopo tTH1
%   ........++++++++++++++++++++++++++++++++++++++++++++.......    
%   .....------------------------------------------00000...
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
  
end
