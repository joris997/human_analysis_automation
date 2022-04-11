load('processedIKID.mat')
data = dataIKID;


%% plotting mean
figure

subplot(1,3,1); hold on; grid on;
zC = data.exp00{1}.IK.zeroCrossing;
zCT = data.exp00{1}.IK.zeroCrossingT;
ev = data.exp00{1}.IK.eventArray;
evT = data.exp00{1}.IK.eventArrayT;
ang_R_x = data.exp00{1}.IK.valuesHMean(:,1);
ang_L_x = data.exp00{1}.IK.valuesHMean(:,2);
time = data.exp00{1}.IK.values(zC(1):zC(2),1);
xline(evT(1))
xline(evT(2))
xline(evT(3))
xline(evT(4))
xline(evT(5))
xline(evT(6))
% stance leg: VLO -> TD
plot(time(1:ev(2)-zC(1)),ang_R_x(1:ev(2)-zC(1)),'b')
% DSP: TD -> LO
plot(time(ev(2)-zC(1):ev(3)-zC(1)),ang_R_x(ev(2)-zC(1):ev(3)-zC(1)),'b')
plot(time(ev(2)-zC(1):ev(3)-zC(1)),ang_L_x(ev(2)-zC(1):ev(3)-zC(1)),'r')
% stance leg: LO -> TD
plot(time(ev(3)-zC(1):ev(4)-zC(1)),ang_L_x(ev(3)-zC(1):ev(4)-zC(1)),'r')
% DSP: TD -> LO
plot(time(ev(4)-zC(1):ev(5)-zC(1)),ang_R_x(ev(4)-zC(1):ev(5)-zC(1)),'b')
plot(time(ev(4)-zC(1):ev(5)-zC(1)),ang_L_x(ev(4)-zC(1):ev(5)-zC(1)),'r')
% stance leg: LO -> VLO
plot(time(ev(5)-zC(1):end),ang_R_x(ev(5)-zC(1):end),'b')
% shade area of DSP
x_points = [evT(2), evT(2), evT(3), evT(3)];  
y_points = [-100, 100, 100, -100];
color = [0, 0, 1];
DSP1 = fill(x_points, y_points, color);
DSP1.FaceAlpha = 0.1;
x_points = [evT(4), evT(4), evT(5), evT(5)];  
y_points = [-100, 100, 100, -100];
color = [0, 0, 1];
DSP1 = fill(x_points, y_points, color);
DSP1.FaceAlpha = 0.1;
ylim([20 60])
xlabel('time [s]')
ylabel('angular momentum [kg m/s]')
title('exp00')
set(gca,'FontSize',15)

subplot(1,3,2); hold on; grid on;
zC = data.exp100{1}.IK.zeroCrossing;
zCT = data.exp100{1}.IK.zeroCrossingT;
ev = data.exp100{1}.IK.eventArray;
evT = data.exp100{1}.IK.eventArrayT;
ang_R_x = data.exp100{1}.IK.valuesHMean(:,1);
ang_L_x = data.exp100{1}.IK.valuesHMean(:,2);
time = data.exp00{1}.IK.values(zC(1):zC(2),1);
xline(evT(1))
xline(evT(2))
xline(evT(3))
xline(evT(4))
xline(evT(5))
xline(evT(6))
% stance leg: VLO -> TD
plot(time(1:ev(2)-zC(1)),ang_R_x(1:ev(2)-zC(1)),'b')
% DSP: TD -> LO
plot(time(ev(2)-zC(1):ev(3)-zC(1)),ang_R_x(ev(2)-zC(1):ev(3)-zC(1)),'b')
plot(time(ev(2)-zC(1):ev(3)-zC(1)),ang_L_x(ev(2)-zC(1):ev(3)-zC(1)),'r')
% stance leg: LO -> TD
plot(time(ev(3)-zC(1):ev(4)-zC(1)),ang_L_x(ev(3)-zC(1):ev(4)-zC(1)),'r')
% DSP: TD -> LO
plot(time(ev(4)-zC(1):ev(5)-zC(1)),ang_R_x(ev(4)-zC(1):ev(5)-zC(1)),'b')
plot(time(ev(4)-zC(1):ev(5)-zC(1)),ang_L_x(ev(4)-zC(1):ev(5)-zC(1)),'r')
% stance leg: LO -> VLO
plot(time(ev(5)-zC(1):end),ang_R_x(ev(5)-zC(1):end),'b')
% shade area of DSP
x_points = [evT(2), evT(2), evT(3), evT(3)];  
y_points = [-100, 100, 100, -100];
color = [0, 0, 1];
DSP1 = fill(x_points, y_points, color);
DSP1.FaceAlpha = 0.1;
x_points = [evT(4), evT(4), evT(5), evT(5)];  
y_points = [-100, 100, 100, -100];
color = [0, 0, 1];
DSP1 = fill(x_points, y_points, color);
DSP1.FaceAlpha = 0.1;
ylim([20 60])
xlabel('time [s]')
ylabel('angular momentum [kg m/s]')
title('exp100')
set(gca,'FontSize',15)

subplot(1,3,3); hold on; grid on;
zC = data.unexp100{1}.IK.zeroCrossing;
zCT = data.unexp100{1}.IK.zeroCrossingT;
ev = data.unexp100{1}.IK.eventArray;
evT = data.unexp100{1}.IK.eventArrayT;
ang_R_x = data.unexp100{1}.IK.valuesHMean(:,1);
ang_L_x = data.unexp100{1}.IK.valuesHMean(:,2);
time = data.exp00{1}.IK.values(zC(1):zC(2),1);
xline(evT(1))
xline(evT(2))
xline(evT(3))
xline(evT(4))
xline(evT(5))
xline(evT(6))
% stance leg: VLO -> TD
plot(time(1:ev(2)-zC(1)),ang_R_x(1:ev(2)-zC(1)),'b')
% DSP: TD -> LO
plot(time(ev(2)-zC(1):ev(3)-zC(1)),ang_R_x(ev(2)-zC(1):ev(3)-zC(1)),'b')
plot(time(ev(2)-zC(1):ev(3)-zC(1)),ang_L_x(ev(2)-zC(1):ev(3)-zC(1)),'r')
% stance leg: LO -> TD
plot(time(ev(3)-zC(1):ev(4)-zC(1)),ang_L_x(ev(3)-zC(1):ev(4)-zC(1)),'r')
% DSP: TD -> LO
plot(time(ev(4)-zC(1):ev(5)-zC(1)),ang_R_x(ev(4)-zC(1):ev(5)-zC(1)),'b')
plot(time(ev(4)-zC(1):ev(5)-zC(1)),ang_L_x(ev(4)-zC(1):ev(5)-zC(1)),'r')
% stance leg: LO -> VLO
plot(time(ev(5)-zC(1):end),ang_R_x(ev(5)-zC(1):end),'b')
% shade area of DSP
x_points = [evT(2), evT(2), evT(3), evT(3)];  
y_points = [-100, 100, 100, -100];
color = [0, 0, 1];
DSP1 = fill(x_points, y_points, color);
DSP1.FaceAlpha = 0.1;
x_points = [evT(4), evT(4), evT(5), evT(5)];  
y_points = [-100, 100, 100, -100];
color = [0, 0, 1];
DSP1 = fill(x_points, y_points, color);
DSP1.FaceAlpha = 0.1;
ylim([30 55])
xlabel('time [s]')
ylabel('angular momentum [kg m/s]')
title('unexp100')
set(gca,'FontSize',13)

% linkaxes
% sgtitle('Total momentum around feet')
