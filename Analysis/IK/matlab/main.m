clear; close all;

%% read in the data if necessary
if exist('data.mat','file') == 0
    addpath('../results')
    data = readAllData();
    save('data.mat','data')
else
    load('data.mat')
end

%% plotting of hip coords
figure
subplot(3,3,1)
hold on; grid on;
idx = getIdx(data,'hip_flexion_r');
for i = 1:8
    plot(data.exp00{i}.values(:,1),data.exp00{i}.values(:,idx))
end

subplot(3,3,4)
hold on; grid on;
idx = getIdx(data,'hip_adduction_r');
for i = 1:8
    plot(data.exp00{i}.values(:,1),data.exp00{i}.values(:,idx))
end

subplot(3,3,7)
hold on; grid on;
idx = getIdx(data,'hip_rotation_r');
for i = 1:8
    plot(data.exp00{i}.values(:,1),data.exp00{i}.values(:,idx))
end

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

subplot(3,3,2)
hold on; grid on;
idx1 = getIdx(data,'hip_flexion_r');
idx2 = getIdx(data,'hip_flexion_l');
for i = 1:8
    zeroCrossing = data.exp00{i}.zeroCrossing;
    if data.exp00{i}.rightLegVLO
        idx = idx1;
    else
        idx = idx2;
    end
    plot(linspace(0,100,zeroCrossing(2)-zeroCrossing(1)+1),...
         data.exp00{i}.values(zeroCrossing(1):zeroCrossing(2),idx))
end

subplot(3,3,5)
hold on; grid on;
idx1 = getIdx(data,'hip_adduction_r');
idx2 = getIdx(data,'hip_adduction_l');
for i = 1:8
    zeroCrossing = data.exp00{i}.zeroCrossing;
    if data.exp00{i}.rightLegVLO
        idx = idx1;
    else
        idx = idx2;
    end
    plot(linspace(0,100,zeroCrossing(2)-zeroCrossing(1)+1),...
         data.exp00{i}.values(zeroCrossing(1):zeroCrossing(2),idx))
end

subplot(3,3,8)
hold on; grid on;
idx1 = getIdx(data,'hip_rotation_r');
idx2 = getIdx(data,'hip_rotation_l');
for i = 1:8
    zeroCrossing = data.exp00{i}.zeroCrossing;
    if data.exp00{i}.rightLegVLO
        idx = idx1;
    else
        idx = idx2;
    end
    data.exp00{i}.xGait = linspace(0,100,zeroCrossing(2)-zeroCrossing(1)+1)';
    plot(data.exp00{i}.xGait,...
         data.exp00{i}.values(zeroCrossing(1):zeroCrossing(2),idx))
end

%% mean and bounds
idx1 = getIdx(data,'hip_flexion_r');
idx2 = getIdx(data,'hip_flexion_l');
zeroCrossing1 = data.exp00{1}.zeroCrossing;
xOrig = linspace(0,100,zeroCrossing(2)-zeroCrossing(1)+1)';
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
    data.exp00{i}.valuesMean = mean(y,2);
    header = data.exp00{1}.headers{idx1};
    data.exp00{i}.headersMean = header(1:end-2);
    
    data.exp00{i}.valuesSD = std(y,0,2);
    data.exp00{i}.headersSD = header(1:end-2);
end

subplot(3,3,3)
hold on; grid on;
plot(xOrig,mean(y,2),'b','LineWidth',2)
plot(xOrig,mean(y,2)+std(y,0,2),'r')
plot(xOrig,mean(y,2)-std(y,0,2),'r')







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