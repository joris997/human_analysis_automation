function data = readAllData()
data.exp00{1,1} = readFileToStruct('ik-01-01.mot');
data.exp00{1,2} = readFileToStruct('ik-01-02.mot');
data.exp00{1,3} = readFileToStruct('ik-01-03.mot');
data.exp00{1,4} = readFileToStruct('ik-01-04.mot');
data.exp00{1,5} = readFileToStruct('ik-01-05.mot');
data.exp00{1,6} = readFileToStruct('ik-01-06.mot');
data.exp00{1,7} = readFileToStruct('ik-01-07.mot');
data.exp00{1,8} = readFileToStruct('ik-01-08.mot');

data.exp25{1,1} = readFileToStruct('ik-02-01.mot');
data.exp25{1,2} = readFileToStruct('ik-02-02.mot');
data.exp25{1,3} = readFileToStruct('ik-02-03.mot');
data.exp25{1,4} = readFileToStruct('ik-02-04.mot');
data.exp25{1,5} = readFileToStruct('ik-02-05.mot');
data.exp25{1,6} = readFileToStruct('ik-02-06.mot');
data.exp25{1,7} = readFileToStruct('ik-02-07.mot');
data.exp25{1,8} = readFileToStruct('ik-02-08.mot');

data.exp50{1,1} = readFileToStruct('ik-03-01.mot');
data.exp50{1,2} = readFileToStruct('ik-03-02.mot');
data.exp50{1,3} = readFileToStruct('ik-03-03.mot');
data.exp50{1,4} = readFileToStruct('ik-03-04.mot');
data.exp50{1,5} = readFileToStruct('ik-03-05.mot');
data.exp50{1,6} = readFileToStruct('ik-03-06.mot');
data.exp50{1,7} = readFileToStruct('ik-03-07.mot');
data.exp50{1,8} = readFileToStruct('ik-03-08.mot');

data.exp75{1,1} = readFileToStruct('ik-04-01.mot');
data.exp75{1,2} = readFileToStruct('ik-04-02.mot');
data.exp75{1,3} = readFileToStruct('ik-04-03.mot');
data.exp75{1,4} = readFileToStruct('ik-04-04.mot');
data.exp75{1,5} = readFileToStruct('ik-04-05.mot');
data.exp75{1,6} = readFileToStruct('ik-04-06.mot');
data.exp75{1,7} = readFileToStruct('ik-04-07.mot');
data.exp75{1,8} = readFileToStruct('ik-04-08.mot');

data.exp100{1,1} = readFileToStruct('ik-05-01.mot');
data.exp100{1,2} = readFileToStruct('ik-05-02.mot');
data.exp100{1,3} = readFileToStruct('ik-05-03.mot');
data.exp100{1,4} = readFileToStruct('ik-05-04.mot');
data.exp100{1,5} = readFileToStruct('ik-05-05.mot');
data.exp100{1,6} = readFileToStruct('ik-05-06.mot');
data.exp100{1,7} = readFileToStruct('ik-05-07.mot');
data.exp100{1,8} = readFileToStruct('ik-05-08.mot');




data.unexp25{1,1} = readFileToStruct('ik-12-01.mot');
data.unexp25{1,2} = readFileToStruct('ik-12-02.mot');
data.unexp25{1,3} = readFileToStruct('ik-12-03.mot');
data.unexp25{1,4} = readFileToStruct('ik-12-04.mot');
data.unexp25{1,5} = readFileToStruct('ik-12-05.mot');
data.unexp25{1,6} = readFileToStruct('ik-12-06.mot');
data.unexp25{1,7} = readFileToStruct('ik-12-07.mot');
data.unexp25{1,8} = readFileToStruct('ik-12-08.mot');

data.unexp50{1,1} = readFileToStruct('ik-13-01.mot');
data.unexp50{1,2} = readFileToStruct('ik-13-02.mot');
data.unexp50{1,3} = readFileToStruct('ik-13-03.mot');
data.unexp50{1,4} = readFileToStruct('ik-13-04.mot');
data.unexp50{1,5} = readFileToStruct('ik-13-05.mot');
data.unexp50{1,6} = readFileToStruct('ik-13-06.mot');
data.unexp50{1,7} = readFileToStruct('ik-13-07.mot');
data.unexp50{1,8} = readFileToStruct('ik-13-08.mot');

data.unexp75{1,1} = readFileToStruct('ik-14-01.mot');
data.unexp75{1,2} = readFileToStruct('ik-14-02.mot');
data.unexp75{1,3} = readFileToStruct('ik-14-03.mot');
data.unexp75{1,4} = readFileToStruct('ik-14-04.mot');
data.unexp75{1,5} = readFileToStruct('ik-14-05.mot');
data.unexp75{1,6} = readFileToStruct('ik-14-06.mot');
data.unexp75{1,7} = readFileToStruct('ik-14-07.mot');
data.unexp75{1,8} = readFileToStruct('ik-14-08.mot');

data.unexp100{1,1} = readFileToStruct('ik-15-01.mot');
data.unexp100{1,2} = readFileToStruct('ik-15-02.mot');
data.unexp100{1,3} = readFileToStruct('ik-15-03.mot');
data.unexp100{1,4} = readFileToStruct('ik-15-04.mot');
data.unexp100{1,5} = readFileToStruct('ik-15-05.mot');
data.unexp100{1,6} = readFileToStruct('ik-15-06.mot');
data.unexp100{1,7} = readFileToStruct('ik-15-07.mot');
data.unexp100{1,8} = readFileToStruct('ik-15-08.mot');


end


function data = readFileToStruct(filename)
fid = fopen(filename);

lineno = 1;
cnt = 1;
tline = fgetl(fid);
while ischar(tline)
    lineno = lineno + 1;
    tline = fgetl(fid);
    
    if lineno == 11
        data.headers = strsplit(tline,'\t');
    end
    if lineno > 11
        try
            data.values(cnt,:) = str2double(strsplit(tline,'\t'));
            cnt = cnt + 1;
        catch
%             disp("end of file")
        end
    end
end

end



function data = readFileToStruct2(exp,run)
fidMot = fopen(["IK-",exp,"-",run,"/ik-",exp,"-",run,".mot"]);

lineno = 1;
cnt = 1;
tline = fgetl(fidMot);
while ischar(tline)
    lineno = lineno + 1;
    tline = fgetl(fidMot);
    
    if lineno == 11
        data.headers = strsplit(tline,'\t');
    end
    if lineno > 11
        try
            data.values(cnt,:) = str2double(strsplit(tline,'\t'));
            cnt = cnt + 1;
        catch
%             disp("end of file")
        end
    end
end


fidCoM = fopen(["IK-",exp,"-",run,"/sub06_.sto"]);
lineno = 1;
cnt = 1;
tline = fgetl(fidCoM);
while ischar(tline)
    lineno = lineno + 1;
    tline = fgetl(fidCoM);
    
    if lineno == 11
        data.headersCoM = strsplit(tline,'\t');
    end
    if lineno > 11
        try
            data.valuesCoM(cnt,:) = str2double(strsplit(tline,'\t'));
            cnt = cnt + 1;
        catch
%             disp("end of file")
        end
    end
end

end