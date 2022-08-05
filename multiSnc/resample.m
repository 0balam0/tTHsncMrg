function tTH = resample(tTH, step)

    oldTime = tTH.time.v;
    names = fieldnames(tTH);
    timeSpace = oldTime(1):step: oldTime(end);
    
    for i=1:length(names)
        tTH.(names{i}).v = interp1(oldTime, tTH.(names{i}).v, timeSpace);
    end   
end
