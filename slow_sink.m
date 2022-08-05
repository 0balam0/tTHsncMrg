function idMin = slow_sink(signalL, signalS)
    split = 5;
    lenL = length(signalL);
    lenS = length(signalS);
    lenS_red = ceil(lenS/split);
    lenS_redV = [1, [1,2,3,4]*lenS_red, lenS];
    idMinv = [];
    fprintf('L:%d, %d\n', lenS, lenS_red)
    for i=1:split
        fprintf('%d) %d:%d\n', i, 1+lenS_redV(i),lenS_redV(i+1))
        signalS_red = signalS(1+lenS_redV(i):lenS_redV(i+1));
%         signalS_red = signalS(1+lenS_red*(i-1):lenS_red*i);
        idMinv(i) = cerca_sinkID(signalL, signalS_red);
    end
    idMinv
    error = [];
    figure()
    for i=1:split
        error_s =[];
        fprintf('a ');
        for a=1:split
%             fprintf('%d, ', idMinv(i)+(lenS_redV(a)-lenS_redV(i)) - idMinv(a))
            error_s(a) = abs(idMinv(i)+(lenS_redV(a)-lenS_redV(i)) - idMinv(a));
        end
        fprintf('%d) %d %d %d %d %d\n', i, error_s(1), error_s(2), error_s(3), error_s(4), error_s(5));
%         [~, idem] = min(error_s);
%         error_s(idem) = [];
        [~, ideM] = max(error_s);
        error_s(ideM) = [];
        error(i) = sum(error_s);
    end
    
    plot(error)
    [~, idemin] = min(error);
    fprintf('id_min: %d\n', idMinv(idemin)-(lenS_redV(idemin)-1));
    idMin = idMinv(idemin);
%    idMin = idMinV(idemin) - lenS_red * (idemin-1);
end