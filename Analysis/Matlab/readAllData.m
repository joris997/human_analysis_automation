function [dataIK,dataCMC] = readAllData(doCMC)
runs = {'01','02','03','04','05','06','07','08'};
% flat ground walking
for i = 1:length(runs)
    dataIK.exp00{1,i} = readFileToStructIKID('01',runs{i});
    if doCMC
    dataCMC.exp00{1,i} = readFileToStructCMC('01',runs{i});
    end
end
disp('exp00 done')

% expected drops
for i = 1:length(runs)
    dataIK.exp25{1,i} = readFileToStructIKID('02',runs{i});
    if doCMC
    dataCMC.exp25{1,i} = readFileToStructCMC('02',runs{i});
    end
end
disp('exp25 done')

for i = 1:length(runs)
    dataIK.exp50{1,i} = readFileToStructIKID('03',runs{i});
    if doCMC
    dataCMC.exp50{1,i} = readFileToStructCMC('03',runs{i});
    end
end
disp('exp50 done')

for i = 1:length(runs)
    dataIK.exp75{1,i} = readFileToStructIKID('04',runs{i});
    if doCMC
    dataCMC.exp75{1,i} = readFileToStructCMC('04',runs{i});
    end
end
disp('exp75 done')

for i = 1:length(runs)
    dataIK.exp100{1,i} = readFileToStructIKID('05',runs{i});
    if doCMC
    dataCMC.exp100{1,i} = readFileToStructCMC('05',runs{i});
    end
end
disp('exp100 done')

% unexpected drops
for i = 1:length(runs)
    dataIK.unexp25{1,i} = readFileToStructIKID('12',runs{i});
    if doCMC
    dataCMC.unexp25{1,i} = readFileToStructCMC('12',runs{i});
    end
end
disp('unexp25 done')

for i = 1:length(runs)
    dataIK.unexp50{1,i} = readFileToStructIKID('13',runs{i});
    if doCMC
    dataCMC.unexp50{1,i} = readFileToStructCMC('13',runs{i});
    end
end
disp('unexp50 done')

for i = 1:length(runs)
    dataIK.unexp75{1,i} = readFileToStructIKID('14',runs{i});
    if doCMC
    dataCMC.unexp75{1,i} = readFileToStructCMC('14',runs{i});
    end
end
disp('unexp75 done')

for i = 1:length(runs)
    dataIK.unexp100{1,i} = readFileToStructIKID('15',runs{i});
    if doCMC
    dataCMC.unexp100{1,i} = readFileToStructCMC('15',runs{i});
    end
end
disp('unexp100 done')

if ~doCMC
    dataCMC = 1;
end

end


function data = readFileToStructIKID(exp,run)
%% inverse kinematics
tic
fidMot = fopen(strcat("../IK/results/IK-",exp,"-",run,"/ik-",exp,"-",run,".mot"));
lineno = 1;
cnt = 1;
tline = fgetl(fidMot);
while ischar(tline)
    lineno = lineno + 1;
    tline = fgetl(fidMot);
    
    if lineno == 11
        data.IK.headers = strsplit(tline,'\t');
    end
    if lineno > 11
        try
            data.IK.values(cnt,:) = str2double(strsplit(tline,'\t'));
            cnt = cnt + 1;
        catch
%             disp("end of file")
        end
    end
end
toc

%% com analyze tool
tic
fidCoM = fopen(strcat("../IK/results/IK-",exp,"-",run,"/pert_sub06_BodyKinematics_pos_global.sto"));
lineno = 1;
cnt = 1;
tline = fgetl(fidCoM);
while ischar(tline)
    lineno = lineno + 1;
    tline = fgetl(fidCoM);
    
    if lineno == 19
        data.IK.headersCoM = strsplit(tline,'\t');
    end
    if lineno > 19
        try
            data.IK.valuesCoM(cnt,:) = str2double(strsplit(tline,'\t'));
            cnt = cnt + 1;
        catch
%             disp("end of file")
        end
    end
end
toc

tic
fidCoM = fopen(strcat("../IK/results/IK-",exp,"-",run,"/pert_sub06_BodyKinematics_vel_global.sto"));
lineno = 1;
cnt = 1;
tline = fgetl(fidCoM);
while ischar(tline)
    lineno = lineno + 1;
    tline = fgetl(fidCoM);
    if lineno > 19
        try
            data.IK.dvaluesCoM(cnt,:) = str2double(strsplit(tline,'\t'));
            cnt = cnt + 1;
        catch
%             disp("end of file")
        end
    end
end
toc

tic
fidCoM = fopen(strcat("../IK/results/IK-",exp,"-",run,"/pert_sub06_BodyKinematics_acc_global.sto"));
lineno = 1;
cnt = 1;
tline = fgetl(fidCoM);
while ischar(tline)
    lineno = lineno + 1;
    tline = fgetl(fidCoM);
    if lineno > 19
        try
            data.IK.ddvaluesCoM(cnt,:) = str2double(strsplit(tline,'\t'));
            cnt = cnt + 1;
        catch
%             disp("end of file")
        end
    end
end
toc

%% GRFs (added to IK because same sample time, can use the same VLO index)
tic
fidMot = fopen(strcat("../../GRFMot/grf-",exp,"-",run,".mot"));
lineno = 1;
cnt = 1;
tline = fgetl(fidMot);
while ischar(tline)
    lineno = lineno + 1;
    tline = fgetl(fidMot);
    
    if lineno == 7
        data.IK.headersGRF = strsplit(tline,'\t');
    end
    if lineno > 7
        try
            data.IK.valuesGRF(cnt,:) = str2double(strsplit(tline,'\t'));
            cnt = cnt + 1;
        catch
%             disp("end of file")
        end
    end
end
toc

%% Angular momentum, added to IK because same sample time as well
tic
fidH = fopen(strcat("../IK/results/IK-",exp,"-",run,"/angular-momentum.sto"));
lineno = 1;
cnt = 1;
tline = fgetl(fidH);
while ischar(tline)
    if lineno == 1
        data.IK.headersH = strsplit(tline,'\t');
    end
    if lineno > 1
        try
            data.IK.valuesH(cnt,:) = str2double(strsplit(tline,'\t'));
            cnt = cnt + 1;
        catch
%             disp("end of file")
        end
    end
    lineno = lineno + 1;
    tline = fgetl(fidH);
end
toc

%% inverse dynamics
tic
fidDyn = fopen(strcat("../ID/results/id-",exp,"-",run,".sto"));
lineno = 1;
cnt = 1;
tline = fgetl(fidDyn);
while ischar(tline)
    lineno = lineno + 1;
    tline = fgetl(fidDyn);
    
    if lineno == 7
        data.ID.headersDyn = strsplit(tline,'\t');
    end
    if lineno > 7
        try
            data.ID.valuesDyn(cnt,:) = str2double(strsplit(tline,'\t'));
            cnt = cnt + 1;
        catch
%             disp("end of file")
        end
    end
end
toc

end



function data = readFileToStructCMC(exp,run)

tic
fidCmcControls = fopen(strcat("../CMC/results/CMC-",exp,"-",run,"/sub06_controls.sto"));
lineno = 1;
cnt = 1;
tline = fgetl(fidCmcControls);
while ischar(tline)
    lineno = lineno + 1;
    tline = fgetl(fidCmcControls);
    
    if lineno == 7
        data.CMC.headersControls = strsplit(tline,'\t');
    end
    if lineno > 7
        try
            data.CMC.valuesControls(cnt,:) = str2double(strsplit(tline,'\t'));
            cnt = cnt + 1;
        catch
%             disp("end of file")
        end
    end
end
toc

tic
fidCmcStates = fopen(strcat("../CMC/results/CMC-",exp,"-",run,"/sub06_states.sto"));
lineno = 1;
cnt = 1;
tline = fgetl(fidCmcStates);
while ischar(tline)
    lineno = lineno + 1;
    tline = fgetl(fidCmcStates);
    
    if lineno == 7
        data.CMC.headersStates = strsplit(tline,'\t');
    end
    if lineno > 7
        try
            data.CMC.valuesStates(cnt,:) = str2double(strsplit(tline,'\t'));
            cnt = cnt + 1;
        catch
%             disp("end of file")
        end
    end
end
toc

tic
fidCmcForce = fopen(strcat("../CMC/results/CMC-",exp,"-",run,"/sub06_Actuation_force.sto"));
lineno = 1;
cnt = 1;
tline = fgetl(fidCmcForce);
while ischar(tline)
    lineno = lineno + 1;
    tline = fgetl(fidCmcForce);
    
    if lineno == 23
        data.CMC.headersForce = strsplit(tline,'\t');
    end
    if lineno > 23
        try
            data.CMC.valuesForce(cnt,:) = str2double(strsplit(tline,'\t'));
            cnt = cnt + 1;
        catch
%             disp("end of file")
        end
    end
end
toc

tic
fidCmcPower = fopen(strcat("../CMC/results/CMC-",exp,"-",run,"/sub06_Actuation_power.sto"));
lineno = 1;
cnt = 1;
tline = fgetl(fidCmcPower);
while ischar(tline)
    lineno = lineno + 1;
    tline = fgetl(fidCmcPower);
    
    if lineno == 23
        data.CMC.headersPower = strsplit(tline,'\t');
    end
    if lineno > 23
        try
            data.CMC.valuesPower(cnt,:) = str2double(strsplit(tline,'\t'));
            cnt = cnt + 1;
        catch
%             disp("end of file")
        end
    end
end
toc

tic
fidCmcSpeed = fopen(strcat("../CMC/results/CMC-",exp,"-",run,"/sub06_Actuation_speed.sto"));
lineno = 1;
cnt = 1;
tline = fgetl(fidCmcSpeed);
while ischar(tline)
    lineno = lineno + 1;
    tline = fgetl(fidCmcSpeed);
    
    if lineno == 23
        data.CMC.headersSpeed = strsplit(tline,'\t');
    end
    if lineno > 23
        try
            data.CMC.valuesSpeed(cnt,:) = str2double(strsplit(tline,'\t'));
            cnt = cnt + 1;
        catch
%             disp("end of file")
        end
    end
end
toc

%% CMC Body positions, velocities, and accelerations
tic
fidCmcCoMPos = fopen(strcat("../CMC/results/CMC-",exp,"-",run,"/pert_sub06_BodyKinematics_pos_global.sto"));
lineno = 1;
cnt = 1;
tline = fgetl(fidCmcCoMPos);
while ischar(tline)
    lineno = lineno + 1;
    tline = fgetl(fidCmcCoMPos);
    
    if lineno == 19
        data.CMC.headersCoMPos = strsplit(tline,'\t');
    end
    if lineno > 19
        try
            data.CMC.valuesCoMPos(cnt,:) = str2double(strsplit(tline,'\t'));
            cnt = cnt + 1;
        catch
%             disp("end of file")
        end
    end
end
toc

tic
fidCmcCoMVel = fopen(strcat("../CMC/results/CMC-",exp,"-",run,"/pert_sub06_BodyKinematics_vel_global.sto"));
lineno = 1;
cnt = 1;
tline = fgetl(fidCmcCoMVel);
while ischar(tline)
    lineno = lineno + 1;
    tline = fgetl(fidCmcCoMVel);
    
    if lineno == 19
        data.CMC.headersCoMVel = strsplit(tline,'\t');
    end
    if lineno > 19
        try
            data.CMC.valuesCoMVel(cnt,:) = str2double(strsplit(tline,'\t'));
            cnt = cnt + 1;
        catch
%             disp("end of file")
        end
    end
end
toc

end