clear all; close all; clc;

load('processedIKID.mat')
data = dataIKID;

%% plot ankle moment
exps = {'exp00','exp100','unexp100'};
ankleLeft = 26;
ankleRight = 25;

figure
for i = 1:length(exps)
    exp = exps{i};
    
    subplot(1,length(exps),i); hold on; grid on;
    for ii = 1:8
        time = data.(exp){ii}.ID.valuesDyn(:,1);
        aL = data.(exp){ii}.ID.valuesDyn(:,ankleLeft);
        aR = data.(exp){ii}.ID.valuesDyn(:,ankleRight);
        plot(time,aL,'r');
        plot(time,aR,'b');
    end
    title(exp)
    xlabel('time [s]')
    ylabel('z_{CoM} [m]')
end


%% Fz
figure
subplot(1,3,1); hold on; grid on;
plot(data.exp00{1}.IK.xGait,data.exp00{1}.IK.valuesGRFMean(:,3),'LineWidth',3)
plot(data.exp00{1}.IK.xGait,data.exp00{1}.IK.valuesGRFMean(:,4),'LineWidth',3)
xline(31.95,'LineWidth',2)
xline(81.33,'LineWidth',2)
title('exp00')
set(gca,'FontSize',15)
xlabel('VLO-VLO [%]')
ylabel('F_z [N]')

subplot(1,3,2); hold on; grid on;
plot(data.exp100{1}.IK.xGait,data.exp100{1}.IK.valuesGRFMean(:,3),'LineWidth',3)
plot(data.exp100{1}.IK.xGait,data.exp100{1}.IK.valuesGRFMean(:,4),'LineWidth',3)
xline(33.83,'LineWidth',2)
xline(78.2,'LineWidth',2)
set(gca,'FontSize',15)
title('exp100')
xlabel('VLO-VLO [%]')
ylabel('F_z [N]')

subplot(1,3,3); hold on; grid on;
plot(data.unexp100{1}.IK.xGait,data.unexp100{1}.IK.valuesGRFMean(:,3),'LineWidth',3)
plot(data.unexp100{1}.IK.xGait,data.unexp100{1}.IK.valuesGRFMean(:,4),'LineWidth',3)
xline(34.77,'LineWidth',2)
xline(76.17,'LineWidth',2)
set(gca,'FontSize',15)
title('unexp100')
xlabel('VLO-VLO [%]')
ylabel('F_z [N]')

linkaxes

