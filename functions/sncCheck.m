function [timeSnc, error] = sncCheck(error, timeSnc, signalL, signalS, timeL, timeS)
% idMin = verify_sink(idMin, signalL, signalS)
% idMin: id trovato do da cerca_sinkID o cerca_sink1_3
% idMin = cerca_sinkID(signalL, signalS)
% timeL: base tempi sengaleL
% timeS: base tempi segnaleS
% verifica che il segnale corto sia incluso nel segnale lungo
%     lenL = length(timeL);
%     lenS = length(timeS);
    if timeSnc==timeL(1) || timeSnc == timeL-timeS % utilizzo una parte del segnale per calcolare il sincronismo
        quest = 'short signal not included in the long one. Do you want to synchronize signals using a part of the short signal?';
        answer = questdlg(quest,...
                          'Yes','No');
        switch answer
            case 'Yes'
                [timeSnc, error] = sncTimeSearch_1_3(signalL, signalS, timeL, timeS);
            case 'No'
                return;
            case 'Cancel'
                return;
        end 
    end
end