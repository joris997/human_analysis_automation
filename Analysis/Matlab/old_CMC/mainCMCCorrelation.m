clear all; close all; clc;

load('processedCMC.mat')
data = dataCMC;

fieldnames = fields(data);

%% Arrays of muscle groups
allm = false;
allg = false;
loadGroupsAndMuscles;

%% Inter-muscular reflexes
swst = {'sw','st'};
leg = swst{2};
exps = {'exp00','exp25','exp50','exp75','exp100',...
                'unexp25','unexp50','unexp75','unexp100'};
exp = exps{1};

% for each major muscle group
for i = 1:length(groups)
    if groups{i} == "knee_flexion"
%     if groups{i} == "hip_flexion"
        figure
        % for each muscle in the group
        for m = 1:length(muscles{i})
            corr.(groups{i}).(muscles{i}{m}).allLA = zeros(2,2,8);
            corr.(groups{i}).(muscles{i}{m}).allFA = zeros(2,2,8);
            % for each experiment run
            for ii = 1:8
                zC = data.exp00{ii}.CMC.zeroCrossing;
                
                strActivation = strcat('/forceset/',muscles{i}{m},leg,'/activation');
                strLength     = strcat('/forceset/',muscles{i}{m},leg,'/fiber_length');
                strForce      = strcat(muscles{i}{m},leg);
                strVelocity   = strcat(muscles{i}{m},leg);
                
                idxActivation = getIdxStates(data,strActivation);
                idxLength     = getIdxStates(data,strLength);
                idxForce      = getIdxForce(data,strForce);
                idxVelocity   = getIdxForce(data,strVelocity);
                
                Activation = data.(exp){ii}.CMC.valuesStates(zC(1):zC(2),idxActivation);
                Length     = data.(exp){ii}.CMC.valuesStates(zC(1):zC(2),idxLength);
                Force      = data.(exp){ii}.CMC.valuesForce(zC(1):zC(2),idxForce);
                Velocity   = data.(exp){ii}.CMC.valuesSpeed(zC(1):zC(2),idxVelocity);
                
                Time = data.(exp){ii}.CMC.valuesStates(zC(1):zC(2),1);
%                 plot(time,activation)
%                 plot(time,length)
%                 plot(time,force)

                % plotting and computing of correlation
                figure(1)
                subplot(2,3,m); hold on; grid on;
                plot(Length,Activation,'o')
                xlabel('Muscle Length [m]')
                ylabel('Actiavtion [0-1]')
                title(muscles{i}{m})
                
                sgtitle(strcat(groups{i},' len corr'))
                corr.(groups{i}).(muscles{i}{m}).allLA(:,:,ii) = corrcoef(Length,Activation);
                
                
                figure(2)
                subplot(2,3,m); hold on; grid on;
                plot(Force,Activation,'o')
                xlabel('Muscle Force [N]')
                ylabel('Actiavtion [0-1]')
                title(muscles{i}{m})
                
                sgtitle(strcat(groups{i},' frc corr'))
                corr.(groups{i}).(muscles{i}{m}).allFA(:,:,ii) = corrcoef(Force,Activation);
                
                
                figure(3)
                subplot(2,3,m); hold on; grid on;
                plot(Velocity,Activation,'o')
                xlabel('Muscle Velocity [m/s]')
                ylabel('Actiavtion [0-1]')
                title(muscles{i}{m})
                
                sgtitle(strcat(groups{i},' vel corr'))
                corr.(groups{i}).(muscles{i}{m}).allVA(:,:,ii) = corrcoef(Velocity,Activation);
                
                a = 1;
            end
            corr.(groups{i}).(muscles{i}{m}).meanLA = mean(corr.(groups{i}).(muscles{i}{m}).allLA,3);
            corr.(groups{i}).(muscles{i}{m}).meanFA = mean(corr.(groups{i}).(muscles{i}{m}).allFA,3);
            corr.(groups{i}).(muscles{i}{m}).meanVA = mean(corr.(groups{i}).(muscles{i}{m}).allVA,3);
        end
    end
end

%% Leg cross extension-flexion reflex
swst = {'sw','st'};
leg = swst{2};
exps = {'exp00','exp25','exp50','exp75','exp100',...
                'unexp25','unexp50','unexp75','unexp100'};
exp = exps{1};

% for each major muscle group
for i = 1:length(groups)
    if groups{i} == "knee_flexion"
%     if groups{i} == "hip_flexion"
        figure
        % for each muscle in the group
        for m = 1:length(muscles{i})
            corr.(groups{i}).(muscles{i}{m}).allLA = zeros(2,2,8);
            corr.(groups{i}).(muscles{i}{m}).allFA = zeros(2,2,8);
            % for each experiment run
            for ii = 1:8
                zC = data.exp00{ii}.CMC.zeroCrossing;
                
                strActivation = strcat('/forceset/',muscles{i}{m},leg,'/activation');
                
                idxActivation = getIdxStates(data,strActivation);
                
                Activation = data.(exp){ii}.CMC.valuesStates(zC(1):zC(2),idxActivation);
                Time = data.(exp){ii}.CMC.valuesStates(zC(1):zC(2),1);
                
                % get the other leg name for leg cross reflex
                if data.(exp){ii}.CMC.rightLegVLO
                    swleg = "calcn_l";
                else
                    swleg = "calcn_r";
                end
                [L,dL] = getpos(data.(exp){ii}.CMC,swleg);
                L = L(zC(1):zC(2));
                dL = dL(zC(1):zC(2));
                
                % plotting and computing of correlation
                figure(4)
                subplot(2,3,m); hold on; grid on;
                plot(L,Activation,'o')
                xlabel('Leg Length [m]')
                ylabel('Activation [0-1]')
                title(muscles{i}{m})
                
                sgtitle(strcat(groups{i},' leg length corr'))
                corr.(groups{i}).(muscles{i}{m}).allLLA(:,:,ii) = corrcoef(L,Activation);
                
                
                figure(5)
                subplot(2,3,m); hold on; grid on;
                plot(dL,Activation,'o')
                xlabel('Leg Velocity [m/s]')
                ylabel('Activation [0-1]')
                title(muscles{i}{m})
                
                sgtitle(strcat(groups{i},' leg velocity corr'))
                corr.(groups{i}).(muscles{i}{m}).allLVA(:,:,ii) = corrcoef(dL,Activation);
                
                
                a = 1;
            end
            corr.(groups{i}).(muscles{i}{m}).meanLLA = mean(corr.(groups{i}).(muscles{i}{m}).allLLA,3);
            corr.(groups{i}).(muscles{i}{m}).meanLVA = mean(corr.(groups{i}).(muscles{i}{m}).allLVA,3);
        end
    end
end



%% Function
function [L,dL] = getpos(data,string)
    adds = ["_X","_Y","_Z"];
    for i = 1:length(adds)
        str{i}  = string + adds(i);
        strP{i} = "pelvis" + adds(i);
        
        idx(i)  = getIdxCoMPos(data,str{i});
        idxP(i) = getIdxCoMPos(data,strP{i});
    end
    
    xyz = data.valuesCoMPos(:,idx);
    xyzP = data.valuesCoMPos(:,idxP);

    dxyz = data.valuesCoMVel(:,idx);
    dxyzP = data.valuesCoMVel(:,idxP);
       
    L = zeros(size(xyz,1),1);
    dL = zeros(size(xyz,1),1);
    for i = 1:size(xyz,1)
        L(i)  = norm(xyz(i,:) - xyzP(i,:));
        dL(i) = norm(dxyz(i,:) - dxyzP(i,:));
    end
end


function idx = getIdxCoMPos(data,name)
    idx = find(contains(data.headersCoMPos,name));
end

function idx = getIdxCoMVel(data,name)
    idx = find(contains(data.headersCoMVel,name));
end

function idx = getIdxControls(data,name)
    idx = find(contains(data.exp00{1}.CMC.headersControlsMean,name));
end

function idx = getIdxStates(data,name)
    idx = find(contains(data.exp00{1}.CMC.headersStatesMean,name));
end

function idx = getIdxForce(data,name)
    idx = find(contains(data.exp00{1}.CMC.headersForceMean,name));
end

function idx = getIdxPower(data,name)
    idx = find(contains(data.exp00{1}.CMC.headersPowerMean,name));
end