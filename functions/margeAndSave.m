function tTH = margeAndSave(risp, timeSnc, prefix2, tTH1, tTH2)
    % controllo la base tempi di tTH1 che contenga tutto tTH2
    [tTH1, timeSnc] = evalNewTimeSpace_tTH1(timeSnc, tTH1, tTH2);
            switch risp
                case 1 % Save duplicates with prefix
                    [~, idMin] = min(abs(tTH1.time.v - tTH2.time.v(1)+timeSnc));
                    names1 = fieldnames(tTH1);
                    names2 = fieldnames(tTH2);
                    tTHtmp = tTH2;
                    for i = 1:length(names2)
                        name = names2{i};
                        if any(strcmp(names1, name))
                            name2 = strcat(prefix2, name);
                            tTHtmp.(name2) = tTHtmp.(name);
                            tTHtmp = rmfield(tTHtmp,name);
                        end
                    end
                    tTH = tTH1;
                    names1 = fieldnames(tTH1);
                    names2 = fieldnames(tTHtmp);
                    for i = 1:length(names2)
                        name = names2{i};
                        v = zeros(size(tTH.(names1{1}).v));
                        v(idMin:idMin+length(tTHtmp.(name).v)-1) = tTHtmp.(name).v;
                        tTH.(name) = tTHtmp.(name);
                        tTH.(name).v = v;
                    end
                    
                case 2 % Overwrite duplicates tTH2 on tTH1
                    [~, idMin] = min(abs(tTH1.time.v - tTH2.time.v(1)+timeSnc));
                    tTHtmp = tTH2;
                    tTH = tTH1;
                    names1 = fieldnames(tTH1);
                    names2 = fieldnames(tTHtmp);
                    for i = 1:length(names2)
                        name = names2{i};
                        if any(strcmp(names1, name))
                            if ~strcmp(name, 'time')
                                tTH.(name).v(idMin:idMin+length(tTHtmp.(name).v)-1) = tTHtmp.(name).v;
                            end
                        else
                            v = zeros(size(tTH.(names1{1}).v));
                            v(idMin:idMin+length(tTHtmp.(name).v)-1) = tTHtmp.(name).v;
                            tTH.(name) = tTHtmp.(name);
                            tTH.(name).v = v;
                        end
                    end
                    
                case 3 % Seve duplicates with prefix, marge signal with prefix
                    [~, idMin] = min(abs(tTH1.time.v - tTH2.time.v(1)+timeSnc));
                    names1 = fieldnames(tTH1);
                    names2 = fieldnames(tTH2);
                    tTHtmp = tTH2;
                    for i = 1:length(names2)
                        name = names2{i};
                        if any(strcmp(names1, name))
                            name2 = strcat(prefix2, name);
                            if ~any(strcmp(names1, name2))
                                tTHtmp.(name2) = tTHtmp.(name);
                                tTHtmp = rmfield(tTHtmp,name);
                            end
                        end
                    end
                    tTH = tTH1;
                    names1 = fieldnames(tTH1);
                    names2 = fieldnames(tTHtmp);
                    for i = 1:length(names2)
                        name = names2{i};
                        v = zeros(size(tTH.(names1{1}).v));
                        v(idMin:idMin+length(tTHtmp.(name).v)-1) = tTHtmp.(name).v;
                        tTH.(name) = tTHtmp.(name);
                        tTH.(name).v = v;
                    end
            end
% tTH = 3;
end