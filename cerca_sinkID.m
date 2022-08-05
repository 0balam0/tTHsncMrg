function idMin = cerca_sinkID(signalL, signalS)
    
    trs = sum(size(signalL(1:10)) == size(signalS(1:10)));
    if trs == 0
        signalS = signalS';
    end

    lenL = length(signalL);
    lenS = length(signalS);
%     if lenL<=lenS
%         idMin = 1;
%     else
    error = ones(size(signalL))*inf;
    for idStart=1:(lenL-lenS)
        error(idStart) = sum(abs(signalL(idStart:lenS+idStart-1) - signalS));
    end
    [~, idMin] = min(error);
    fprintf('id min trovato da funzione completa: %d con errore %.2f', idMin, error(idMin));
        figure();
        plot(1:1:length(signalL), error); hold on;
        plot(idMin, error(idMin), 'o');
%         figure();
%         plot(1:1:length(signalL), signalL); hold on;
%         plot((1:1:length(signalS))+idMin, signalS); hold on;
%     end
end