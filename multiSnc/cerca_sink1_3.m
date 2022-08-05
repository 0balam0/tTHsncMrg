function idMin = cerca_sink1_3(signalL, signalS)
    lenL = length(signalL);
    lenS = length(signalS);
    lenS_red = ceil(lenS/3);
    signalS_red = signalS(lenS_red:lenS_red*2);
    idMin = cerca_sinkID(signalL, signalS_red);
    idMin = idMin - lenS_red+1;
    fprintf('id min trovato da un 1/3: %d\n', idMin);
end