function idMin = cerca_sink1_3(signalL, signalS)
% idMin = cerca_sink1_3(signalL, signalS)
% richiama la funzione cerca_sinkID, utilizzando come valori si signalS il
% terzo centrale del segnale di partenza. Da utilizzare nel caso in cui
% signalS non è strettamente contenuto in signalL

    lenS = length(signalS);
    lenS_red = ceil(lenS/3);
    signalS_red = signalS(lenS_red:lenS_red*2);
    idMin = cerca_sinkID(signalL, signalS_red);
    idMin = idMin - lenS_red+1;
%     fprintf('id min trovato da un 1/3: %d\n', idMin);
end