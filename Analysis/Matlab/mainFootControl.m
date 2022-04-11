load('processedIKID.mat')
data = dataIKID;

%% Flat-ground walking
obj_dx = []; obj_stepsize = []; obj_H = [];

for i = 1:8
    datai = data.exp00{i}.IK;
    
    idx = getIdxCoM(data,'center_of_mass_Y');
    ycom = datai.valuesCoM(:,getIdxCoM(data,'center_of_mass_Y'));
    footR = datai.valuesCoM(:,getIdxCoM(data,'calcn_r_X'));
    footL = datai.valuesCoM(:,getIdxCoM(data,'calcn_l_X'));
    
%     figure; hold on; grid on;
%     plot(ycom)
%     plot(footR)
%     plot(footL)
%     legend('CoM Z','Right foot','Left Foot')
    
    [valPeaks,idxPeaks] = findpeaks(ycom,'MinPeakDistance',40);
    timePeaks = datai.values(idxPeaks,1);
    xPeaks = datai.valuesCoM(idxPeaks,getIdxCoM(data,'center_of_mass_X'));
    dxPeaks = datai.dvaluesCoM(idxPeaks,getIdxCoM(data,'center_of_mass_X'));
    HL = datai.valuesH(idxPeaks,3);
    HR = datai.valuesH(idxPeaks,6);
    
%     plot(datai.valuesCoM(:,getIdxCoM(data,'center_of_mass_X')))
    
    [stanceStartsR,stanceEndingsR] = getStanceIndices(footR);
    [stanceStartsL,stanceEndingsL] = getStanceIndices(footL);
    
    footLocsR = zeros(1,length(stanceStartsR));
    footLocsL = zeros(1,length(stanceStartsL));
    for ii = 1:length(stanceStartsR)
        footLocsR(ii) = mean(footR(stanceStartsR(ii):stanceEndingsR(ii)));
    end
    for ii = 1:length(stanceStartsL)
        footLocsL(ii) = mean(footR(stanceStartsL(ii):stanceEndingsL(ii)));
    end
    
    % now we subtract the foot pos' of all the vlo pos' and when it is in a
    % safe range we assume it's an actual step
    for ii = 1:length(footLocsR)
        lengths = footLocsR(ii) - xPeaks;
        for iii = 1:length(lengths)
            if lengths(iii) > 0.65 && lengths(iii) < 0.9
                % now we know that we should consider this as an actual
                % step! The index to consider is still p though
                obj_dx = [obj_dx dxPeaks(ii)];
                obj_stepsize = [obj_stepsize lengths(iii)];
                obj_H  = [obj_H HL(ii)];
            end
        end
    end
    % do it for length steps as well
    for ii = 1:length(footLocsL)
        lengths = footLocsL(ii) - xPeaks;
        for iii = 1:length(lengths)
            if lengths(iii) > 0.6 && lengths(iii) < 0.9
                obj_dx = [obj_dx dxPeaks(ii)];
                obj_stepsize = [obj_stepsize lengths(iii)];
                obj_H  = [obj_H HR(ii)];
            end
        end
    end
    
%     % now we can obtain the foot durations for right
%     % p: loop through all the peaks we've found
%     for p = 1:length(idxPeaks)
%         % p2: try as long as there are foot contact durations
%         for p2 = 1:max([length(stanceStartsR) length(stanceStartsL)])
%             % for the first time, we should detect which foot comes after
%             % the VLO, the second etc. time we can rely on foot alternation
%             if p == 1
%                 switchR = 0; switchL = 0;
%                 % check if we have a foot contact after the peak
%                 try
%                     if stanceStartsR(p2) > idxPeaks(p)
%                         switchR = 1;
%                     end
%                 catch
%                     switchR = 0;
%                 end
%                 try
%                     if stanceStartsL(p2) > idxPeaks(p)
%                         switchL = 1;
%                     end
%                 catch
%                     switchL = 0;
%                 end
%                 % also delete the other foot's first index as it can never
%                 % be the next 
%                 if switchR
%                     stanceStartsL(1) = [];
%                     stanceEndingsL(1) = [];
%                 else
%                     stanceStartsR(1) = [];
%                     stanceEndingsR(1) = [];
%                 end
%             else
%                 % for p>1, we should just switch the leg we are considering
%                 % since we know they are alternating
%                 switchL = ~switchL;
%                 switchR = ~switchR;
%             end
%             % now we have three different situations
%             if switchR && switchL
%                 % we need to check which foot is actually closest fully on
%                 % the ground after the peak
%                 if stanceStartsR(p2) > stanceStartsL(p2)
%                     footLoc = mean(footR(stanceStartsR(p2):stanceEndingsR(p2)));
%                     stanceStartsR(p2) = [];
%                     stanceEndingsR(p2) = [];
%                 else
%                     footLoc = mean(footL(stanceStartsL(p2):stanceEndingsL(p2)));
%                     stanceStartsL(p2) = [];
%                     stanceEndingsL(p2) = [];
%                 end
%             elseif switchR
%                 footLoc = mean(footR(stanceStartsR(p2):stanceEndingsR(p2)));
%                 stanceStartsR(p2) = [];
%                 stanceEndingsR(p2) = [];
%             elseif switchL
%                 footLoc = mean(footL(stanceStartsL(p2):stanceEndingsL(p2)));
%                 stanceStartsL(p2) = [];
%                 stanceEndingsL(p2) = [];
%             else
%                 break;
%             end
%             obj_dx = [obj_dx dxPeaks(p)];
%             obj_stepsize = [obj_stepsize footLoc - xPeaks(p)];
%             break;            
%         end
%     end
end

% TODO: this has obj_dx equal for two to three trials, that cannot be
figure;
subplot(1,2,1); hold on; grid on;
plot(obj_dx,obj_stepsize,'ro')
xlabel('\dot{x}_{vlo} [m/s]')
ylabel('stepsize [m]')

subplot(1,2,2); hold on; grid on;
plot(obj_H,obj_stepsize,'ro')
xlabel('H [m^2/s]')
ylabel('stepsize [m]')

%% Helper functions
function [starts,endings] = getStanceIndices(data)
    % we detect foot on ground if diff(footi) < 5e-4
    idx = find(diff(data) < 6e-4);
    % group the indices in 'foot-on-ground' moments
    group = 1;
    starts = 1;
    for k = 1:length(idx)-1
        if idx(k+1) - idx(k) < 2
            endings(group) = idx(k+1);
        else
            group = group + 1;
            starts(group) = idx(k+1);
        end
    end
    % clear nonsensical durations (i.e. only 1-5 index is lower than 5e-4)
    if length(endings) < length(starts)
        endings = [endings idx(end)];
    end
    durations = endings - starts;
    endings(durations < 20) = [];
    starts(durations < 20) = [];
end

function idx = getIdx(data,name)
    idx = find(contains(data.exp00{1}.IK.headers,name));
end

function idx = getIdxMean(data,name)
    idx = find(contains(data.exp00{1}.IK.headersMean,name));
end

function idx = getIdxSD(data,name)
    idx = find(contains(data.exp00{1}.IK.headersSD,name));
end

function idx = getIdxCoM(data,name)
    idx = find(contains(data.exp00{1}.IK.headersCoM,name));
end

function idx = getIdxDyn(data,name)
    idx = find(contains(data.exp00{1}.ID.headersDyn,name));
end