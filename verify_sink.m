function idMin = verify_sink(idMin, signalL, signalS)
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
%                 lenS_red = ceil(lenS/3);
%                 signalS_red = signalS(lenS_red:lenS_red*2);
%                 idMin = cerca_sinkID(signalL, signalS_red);
%                 idMin = idMin - lenS_red+1;
%                 fprintf('id min trovato con 1/3 della acq s: %d\n', idMin);
            case 'No'
                fprintf('la a');
            case 'Cancel'
                fprintf('la a');
        end 
    end
end