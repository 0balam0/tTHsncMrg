function opt = extOpt(file_name)
    opt = struct();
    fileID = fopen(file_name,'r');
    A = fscanf(fileID,'%s');
    while ~isempty(A)
        splt = strsplit(A, '->');
        name = strtrim(splt(1));
        def = strtrim(splt(2));
        opt.(name{1}) = def{1};
        A = fscanf(fileID,'%s');
    end
    fclose(fileID);
end