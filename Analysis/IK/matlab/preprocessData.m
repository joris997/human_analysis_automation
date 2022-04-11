clear; close all;

%% read in the data if necessary
addpath('../results')
data = readAllData();

disp('--- Files done ---');

%% set idx strings
idxStrings = {'pelvis_tilt','pelvis_tilt';
              'pelvis_list','pelvis_list';
              'pelvis_rotation','pelvis_rotation';
              'pelvis_tx','pelvis_tx';
              'pelvis_ty','pelvis_ty';
              'pelvis_tz','pelvis_tz';
              'hip_flexion_r','hip_flexion_l';
              'hip_adduction_r','hip_adduction_l';
              'hip_rotation_r','hip_rotation_l';
              'knee_angle_r','knee_angle_l';
              'ankle_angle_r','ankle_angle_l';
              'subtalar_angle_r','subtalar_angle_l';
              'mtp_angle_r','mtp_angle_l';
              'lumbar_extension','lumbar_extension';
              'lumbar_bending','lumbar_bending';
              'lumbar_rotation','lumbar_rotation'};

              
%% detect stride (VLO_i --> VLO_i)
% just for exp00
idx1 = getIdx(data,'hip_flexion_r');
idx2 = getIdx(data,'hip_flexion_l');
for i = 1:8
    zeroCross_r = getPosZeroCross(data.exp00{i}.values(:,idx1));
    zeroCross_l = getPosZeroCross(data.exp00{i}.values(:,idx2));
    if zeroCross_r(1) < zeroCross_l(1)
        data.exp00{i}.rightLegVLO = true;
        data.exp00{i}.zeroCrossing = zeroCross_r;
    else
        data.exp00{i}.rightLegVLO = false;
        data.exp00{i}.zeroCrossing = zeroCross_l;
    end
    data.exp00{i}.zeroCrossingT = data.exp00{i}.values(...
        data.exp00{i}.zeroCrossing,1);
end

for i = 1:8
    zeroCrossing = data.exp00{i}.zeroCrossing;
    if data.exp00{i}.rightLegVLO
        idx = idx1;
    else
        idx = idx2;
    end
    data.exp00{i}.xGait = linspace(0,100,zeroCrossing(2)-zeroCrossing(1)+1)';
end

for i = 1:8
    data.exp00{i}.headersMean = cell(1,length(idxStrings));
    data.exp00{i}.headersSD = cell(1,length(idxStrings));
end

%% mean and bounds
for headeri = 1:length(idxStrings)
    idx1 = getIdx(data,idxStrings(headeri,1));
    idx2 = getIdx(data,idxStrings(headeri,2));
    
    zeroCrossing1 = data.exp00{1}.zeroCrossing;
    xOrig = linspace(0,100,zeroCrossing1(2)-zeroCrossing1(1)+1)';
    y = [];
    for i = 1:8
        zeroCrossing = data.exp00{i}.zeroCrossing;
        if data.exp00{i}.rightLegVLO
            idx = idx1;
        else
            idx = idx2;
        end
        y = [y interp1(data.exp00{i}.xGait,...
                      data.exp00{i}.values(zeroCrossing(1):zeroCrossing(2),idx),...
                      xOrig)];
    end

    for i = 1:8
        header = data.exp00{1}.headers{idx1};
        if ~isfield(data.exp00{i},'valuesMean')
            data.exp00{i}.valuesMean = mean(y,2);

            data.exp00{i}.valuesSD = std(y,0,2);
        else
            data.exp00{i}.valuesMean = [data.exp00{i}.valuesMean mean(y,2)];
            data.exp00{i}.valuesSD = [data.exp00{i}.valuesSD std(y,0,2)];
        end
        % remove _r or _l if the indices are not equal
        if idx1 == idx2
            data.exp00{i}.headersMean{headeri} = header;
            data.exp00{i}.headersSD{headeri} = header;
        else
            data.exp00{i}.headersMean{headeri} = header(1:end-2);
            data.exp00{i}.headersSD{headeri} = header(1:end-2);
        end
    end
end


save('data.mat','data')

%% helper functions
function idx = getIdx(data,name)
    idx = find(contains(data.exp00{1}.headers,name));
end

function idx = getPosZeroCross(array)
    idx = [];
    for i = 1:length(array)-1
        if array(i) > 0 && array(i+1) < 0
            idx = [idx; i];
        end
    end
end

