function idMin = verify_sink(idMin, signalL, signalS)
% idMin = verify_sink(idMin, signalL, signalS)
% idMin: id trovato do da cerca_sinkID o cerca_sink1_3
% idMin = cerca_sinkID(signalL, signalS)
% signalL: segnale che contiene signalS
% signalS: segnale contenuto in signalL
% verifica che il segnale corto sia incluso nel segnale lungo
    lenL = length(signalL);
    lenS = length(signalS);
    fprintf('id min trovato da un verify: %d\n', idMin);
    if idMin==1 || idMin == lenL-lenS % utilizzo una parte del segnale per calcolare il sincronismo
        quest = 'short signal not included in the long one. Do you want to synchronize signals using a part of the short signal?';
        answer = questdlg(quest,...
                          'Yes','No');
        switch answer
            case 'Yes'
                idMin = cerca_sink1_3(signalL, signalS);
            case 'No'
                return;
            case 'Cancel'
                return;
        end 
    end
end