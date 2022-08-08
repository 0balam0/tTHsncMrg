function tTH1 = margeAndSave(risp, timeSnc, prefix2, tTH1, tTH2)
% controllo la base tempi di tTH1 che contenga tutto tTH2
    [tTH1, timeSnc] = evalNewTimeSpace_tTH1(timeSnc, tTH1, tTH2);
    [~, idMin] = min(abs(tTH1.time.v - timeSnc));
            switch risp
                case 1 % Save duplicates with prefix se esistono duplicati con prefisso allora li unisce
                    names1 = fieldnames(tTH1);
                    names1Wprf2 = {};
                    for k=1:length(names1)
                        d = tTH1.(names1{k}).d;
                        s = strsplit(d, strcat(prefix2,':\\ '));
                        if length(s)>1
                            names1Wprf2{end+1} = names1{k};
                        end
                    end
                    disp(names1Wprf2)
                    names2 = fieldnames(tTH2);
                    for i =1:length(names2)
                        name2 = names2{i};
                        if ~strcmp('time', name2)
                            save_name = name2;
                            preName2 = strcat(prefix2, name2);
                            if any(strcmp(names1, name2)) 
                                if any(strcmp(names1, preName2))
                                    save_name = preName2;
                                elseif  any(strcmp(names1Wprf2, name2))
                                    save_name=name2;
                                else
                                    tTH1.(save_name) = tTH2.(name2);
                                    tTH1.(save_name).v = tTH1.time.v *0;
                                    tTH1.(save_name).d = strcat(prefix2,':\\ ',tTH1.(save_name).d);
                                    save_name = name2;
                                end
                            else                            
                                tTH1.(save_name) = tTH2.(name2);
                                tTH1.(save_name).v = tTH1.time.v .*0;
                                tTH1.(save_name).d = strcat(prefix2,':\\ ',tTH1.(save_name).d);
                            end

                            tTH1.(save_name).v(idMin:idMin+length(tTH2.time.v)-1) = tTH2.(name2).v;
                        end
                    end
                    
                case 2 % Overwrite duplicates tTH2 on tTH1
                    names1 = fieldnames(tTH1);
                    names2 = fieldnames(tTH2);
                    for i = 1:length(names2)
                        name2 = names2{i};
                        if any(strcmp(names1, name2))
                            if ~strcmp(name2, 'time')
                                tTH1.(name2).v(idMin:idMin+length(tTH2.(name2).v)-1) = tTH2.(name2).v;
                            end
                        else
                            v = zeros(size(tTH1.(names1{1}).v));
                            v(idMin:idMin+length(tTH2.(name2).v)-1) = tTH2.(name2).v;
                            tTH1.(name2) = tTH2.(name2);
                            tTH1.(name2).v = v;
                        end
                    end
            end
end