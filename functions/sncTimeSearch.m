function [timeSnc, error] = sncTimeSearch(signalL, signalS, timeL)
% idMin = cerca_sinkID(signalL, signalS)
% signalL: segnale che contiene signalS
% signalS: segnale contenuto in signalL
% idMin: id di signalL in cui dovrebbe cominciale signalS
% errore: valori della funzione d'errore per ogni id di signalL

% traspone signalS se non è coerente con signalL (2 vettori riga/ 3 vettori
% colonna)
    trs = sum(size(signalL(1:10)) == size(signalS(1:10)));
    if trs == 0
        signalS = signalS';
    end

    lenL = length(signalL);
    lenS = length(signalS);

 % per ogni punto id (da 1  ad lenL-lenS) di signalL calcola la differenza
 % tra i due segnali.
    error = ones(size(signalL))*inf;
    for idStart=1:(lenL-lenS)
        error(idStart) = sum(abs(signalL(idStart:lenS+idStart-1) - signalS));
    end
    [~, idMin] = min(error);    
    timeSnc = timeL(idMin);
% plot dell'errore 
%     fprintf('id min trovato da funzione completa: %d con errore %.2f', idMin, error(idMin));
%     figure();
%     plot(1:1:length(signalL), error); hold on;
%     plot(idMin, error(idMin), 'o');
% %         figure();
% %         plot(1:1:length(signalL), signalL); hold on;
% %         plot((1:1:length(signalS))+idMin, signalS); hold on;
% %     end
end