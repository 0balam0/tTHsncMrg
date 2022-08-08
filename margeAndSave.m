function tTH = margeAndSave(risp, idMin, prefix2, tTH1, tTH2)
            switch risp
                case 1
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
                case 2
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
            end
end