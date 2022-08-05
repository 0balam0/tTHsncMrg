function idMin = cerca_sinkID(signalL, signalS)
% cerca id su signalL in cui dovrebbe partire signalS

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