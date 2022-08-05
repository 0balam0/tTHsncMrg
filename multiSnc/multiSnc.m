clear; clc; close all;
file1.dir = '.\';   
file2.dir = '.\';  
addpath(genpath('C:\Users\matteo.demarco\Desktop\Funzioni_matlab'));
colori = [[0 0.4470 0.7410];[0.8500 0.3250 0.0980];[0.9290 0.6940 0.1250];[0.4940 0.1840 0.5560];[0.4660 0.6740 0.1880];[0.3010 0.7450 0.9330];[0.6350 0.0780 0.1840]];                                                           

step = 0.05;
sinkName1 = 'EngineSpeed';
sinkName2 = 'EngineSpeed';
prefix2 = 'CAN_';
%%
[file1.name, file1.dir] = uigetfile(strcat(file1.dir,'*.mat'),'trace 1 (long trace)');
tTH1  = load(strcat(file1.dir,file1.name)); tTH1 = tTH1.tTH;
tTH1 = resample(tTH1,step);
%%
[file2.names, file2.dir] = uigetfile(strcat(file1.dir,'*.mat'),'trace 2-n (short traces)', 'Multiselect', 'on');
for i=1:length(file2.names)
    fprintf('%d di %d...', i, length(file2.names));
    try
        tTH2  = load(strcat(file2.dir,file2.names{i})); tTH2 = tTH2.tTH;
        tTH2 = resample(tTH2,step);

        idMin = cerca_sinkID(tTH1.(sinkName1).v, tTH2.(sinkName2).v); 
        idMin = verify_sink(idMin, tTH1.(sinkName1).v,  tTH2.(sinkName2).v);
        [tTH1, tTH2, idMin] = update_tTH_space(idMin, tTH1, tTH2);
        names1 = fieldnames(tTH1); 
        names2 = fieldnames(tTH2);
        for j = 1:length(names2)
            name = names2{j};
            if any(strcmp(names1, name))
                if ~strcmp(name, 'time')
                    tTH1.(name).v(idMin:idMin+length(tTH2.(name).v)-1) = tTH2.(name).v;
                end
            else
                if ~strcmp(name, 'time')
                    v = zeros(size(tTH1.(names1{1}).v));
                    v(idMin:idMin+length(tTH2.(name).v)-1) = tTH2.(name).v;
                    tTH1.(name) = tTH2.(name);
                    tTH1.(name).v = v;
                end
            end 
            name_snc = strcat(prefix2,sinkName2);
        end
        if ~any(strcmp(names1, name_snc))
            fprintf('aggiuto Campo\n');
            v = zeros(size(tTH1.(names1{1}).v));
            tTH1.(name_snc) = tTH2.(sinkName2);
            tTH1.(name_snc).v = v;
        end
        tTH1.(name_snc).v(idMin:idMin+length(tTH2.(sinkName2).v)-1) = tTH2.(sinkName2).v;
    catch 
        fprintf('errore di qualche tipo\n')
    end
    
end

%%
[f, sp] = plot_tTH_v4(tTH1,'time',{{'Vel_C','LHFWheelSpeed'},...
                                    {'EngineSpeed', 'CAN_EngineSpeed'}},[0 tTH1.time.v(end) ],0,0);

