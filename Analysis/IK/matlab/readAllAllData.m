function data = readAllData()
runs = {'01','02','03','04','05','06','07','08'};
% flat ground walking
for i = 1:length(runs)
    data.exp00{1,i} = readFileToStruct('01',runs{i});
end

% expected drops
for i = 1:length(runs)
    data.exp25{1,i} = readFileToStruct('02',runs{i});
end

for i = 1:length(runs)
    data.exp50{1,i} = readFileToStruct('03',runs{i});
end

for i = 1:length(runs)
    data.exp75{1,i} = readFileToStruct('04',runs{i});
end

for i = 1:length(runs)
    data.exp100{1,i} = readFileToStruct('05',runs{i});
end

% unexpected drops
for i = 1:length(runs)
    data.unexp25{1,i} = readFileToStruct('12',runs{i});
end

for i = 1:length(runs)
    data.unexp50{1,i} = readFileToStruct('13',runs{i});
end

for i = 1:length(runs)
    data.unexp75{1,i} = readFileToStruct('14',runs{i});
end

for i = 1:length(runs)
    data.unexp100{1,i} = readFileToStruct('15',runs{i});
end

end


function data = readFileToStruct(exp,run)
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
    
    if lineno == 19
        data.headersCoM = strsplit(tline,'\t');
    end
    if lineno > 19
        try
            data.valuesCoM(cnt,:) = str2double(strsplit(tline,'\t'));
            cnt = cnt + 1;
        catch
%             disp("end of file")
        end
    end
end

end