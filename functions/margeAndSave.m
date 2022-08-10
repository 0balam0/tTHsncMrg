function tTH1 = margeAndSave(risp, timeSnc, prefix2, tTH1, tTH2)
% controllo la base tempi di tTH1 che contenga tutto tTH2
    [tTH1, timeSnc] = evalNewTimeSpace_tTH1(timeSnc, tTH1, tTH2);
    [~, idMin] = min(abs(tTH1.time.v - timeSnc));
            switch risp
                case 1 % Samart marge f.== field name
%                     if f. tTH2 is in  fs. tTH1 
%                         if prefix+f. tTH2 in fs.
%                               tTH1 marge prefix+f. tTH2 to prefix+f. tTH1
%                          else
%                               create prefix+f. in tTH1
%                     else
%                          create f. in tTH1

                    names1 = fieldnames(tTH1);
                    names1Wprf2 = {};
                    for k=1:length(names1) %identifico le tracce in tTH1 che sono state aggiunte da tTH2
                        d = tTH1.(names1{k}).d;
                        s = strsplit(d, strcat(prefix2,':\\ '));
                        if length(s)>1
                            names1Wprf2{end+1} = names1{k};
                        end
                    end
%                     disp(names1Wprf2)
                    names2 = fieldnames(tTH2);
                    for i =1:length(names2)
                        name2 = names2{i};
                        if ~strcmp('time', name2)
                            save_name = name2;
                            preName2 = strcat(prefix2, name2);
                            if any(strcmp(names1, name2))  %se di tTH2 è già in tTH1
                                if any(strcmp(names1, preName2)) % se il nome con prefisso è gia esistente es.CAN_EngineSpeed
                                    save_name = preName2;
                                elseif  any(strcmp(names1Wprf2, name2)) % se è stato gia creato un nome senza prefisso appartenente a tTH2 es. Vel_C
                                    save_name=name2;
                                else % se non esiste il nome con il prefisso ad es. crea CAN_EngineSpeed
                                    tTH1.(preName2) = tTH2.(name2);
                                    tTH1.(preName2).v = tTH1.time.v *0;
                                    tTH1.(preName2).d = strcat(prefix2,':\\ ',tTH1.(preName2).d);
                                    save_name = preName2;
                                end
                            else                            
                                tTH1.(save_name) = tTH2.(name2);
                                tTH1.(save_name).v = tTH1.time.v .*0;
                                tTH1.(save_name).d = strcat(prefix2,':\\ ',tTH1.(save_name).d);
                            end

                            tTH1.(save_name).v(idMin:idMin+length(tTH2.time.v)-1) = tTH2.(name2).v;
                        end
                    end
                    
                case 2 % add prefix. if exist marge
                    names1 = fieldnames(tTH1);
                    names2 = fieldnames(tTH2);
                    
                    for i = 1:length(names2)
                        name2 = names2{i};
                        preName2 = strcat(prefix2, name2);
                        if any(strcmp(names1, preName2))
                            disp(4)
                            if ~strcmp(name2, 'time')
                                tTH1.(preName2).v(idMin:idMin+length(tTH2.(name2).v)-1) = tTH2.(name2).v;
                                tTH1.(preName2).d = strcat(prefix2,':\\ ',tTH1.(preName2).d);
                            end
                        else
                            tTH1.(preName2) = tTH2.(name2);
                            tTH1.(preName2).v = tTH1.time.v *0;
                            tTH1.(preName2).d = strcat(prefix2,':\\ ',tTH2.(name2).d);
                            tTH1.(preName2).v(idMin:idMin+length(tTH2.time.v)-1) = tTH2.(name2).v;
                        end
                    end
                    
                  case 3 %No prefix if exist ignore
                    names1 = fieldnames(tTH1);
                    names2 = fieldnames(tTH2);
                    for i = 1:length(names2)
                        name2 = names2{i};
                        if ~any(strcmp(names1, name2))
                            tTH1.(name2) = tTH2.(name2);
                            tTH1.(name2).v = tTH1.time.v *0;
                            tTH1.(name2).d = strcat(prefix2,':\\ ',tTH1.(name2).d);
                            tTH1.(name2).v(idMin:idMin+length(tTH2.(name2).v)-1) = tTH2.(name2).v;
                        end
                    end
                    
                    case 4 %No prefix if exist overwrite
                    names1 = fieldnames(tTH1);
                    names2 = fieldnames(tTH2);
                    for i = 1:length(names2)
                        name2 = names2{i};
                        if ~(strcmp(name2, 'time'))
                            if ~any(strcmp(names1, name2))
                                tTH1.(name2) = tTH2.(name2);
                                tTH1.(name2).v = tTH1.time.v *0;
                                tTH1.(name2).d = strcat(prefix2,':\\ ',tTH1.(name2).d);
                                tTH1.(name2).v(idMin:idMin+length(tTH2.(name2).v)-1) = tTH2.(name2).v;
                            else
                                tTH1.(name2).d = strcat(prefix2,':\\ ',tTH1.(name2).d);
                                tTH1.(name2).v(idMin:idMin+length(tTH2.(name2).v)-1) = tTH2.(name2).v;
                            end
                        end
                    end
            end
end