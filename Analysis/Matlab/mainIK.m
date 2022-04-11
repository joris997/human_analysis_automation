clear; close all;

load('processedIKID.mat')
data = dataIKID;

fs = 13;

%% some preliminary plotting
% figure
% subplot(3,3,1); hold on; grid on;
% idx = getIdxMean(data,'hip_flexion_st');
% x = linspace(0,200,length(data.exp00{1}.IK.valuesMean(:,idx)));
% plot(x,data.exp00{1}.IK.valuesMean(:,idx),'r')
% plot(x,data.exp00{1}.IK.valuesMean(:,idx)+data.exp00{1}.IK.valuesSD(:,idx),'b')
% plot(x,data.exp00{1}.IK.valuesMean(:,idx)-data.exp00{1}.IK.valuesSD(:,idx),'b')
% idx = getIdxMean(data,'hip_flexion_sw');
% plot(x,data.exp00{1}.IK.valuesMean(:,idx),'g')
% plot(x,data.exp00{1}.IK.valuesMean(:,idx)+data.exp00{1}.IK.valuesSD(:,idx),'b')
% plot(x,data.exp00{1}.IK.valuesMean(:,idx)-data.exp00{1}.IK.valuesSD(:,idx),'b')
% title('Flat-ground walking') 
% ylabel('Hip flexion [rad]')
% set(gca,'FontSize',fs)
% 
% subplot(3,3,4); hold on; grid on;
% idx = getIdxMean(data,'knee_angle_st');
% x = linspace(0,200,length(data.exp00{1}.IK.valuesMean(:,idx)));
% plot(x,data.exp00{1}.IK.valuesMean(:,idx),'r')
% plot(x,data.exp00{1}.IK.valuesMean(:,idx)+data.exp00{1}.IK.valuesSD(:,idx),'b')
% plot(x,data.exp00{1}.IK.valuesMean(:,idx)-data.exp00{1}.IK.valuesSD(:,idx),'b')
% idx = getIdxMean(data,'knee_angle_sw');
% plot(x,data.exp00{1}.IK.valuesMean(:,idx),'g')
% plot(x,data.exp00{1}.IK.valuesMean(:,idx)+data.exp00{1}.IK.valuesSD(:,idx),'b')
% plot(x,data.exp00{1}.IK.valuesMean(:,idx)-data.exp00{1}.IK.valuesSD(:,idx),'b')
% ylabel('Knee flexion [rad]')
% set(gca,'FontSize',fs)
% 
% subplot(3,3,7); hold on; grid on;
% idx = getIdxMean(data,'ankle_angle_st');
% x = linspace(0,200,length(data.exp00{1}.IK.valuesMean(:,idx)));
% plot(x,data.exp00{1}.IK.valuesMean(:,idx),'r')
% plot(x,data.exp00{1}.IK.valuesMean(:,idx)+data.exp00{1}.IK.valuesSD(:,idx),'b')
% plot(x,data.exp00{1}.IK.valuesMean(:,idx)-data.exp00{1}.IK.valuesSD(:,idx),'b')
% idx = getIdxMean(data,'ankle_angle_sw');
% plot(x,data.exp00{1}.IK.valuesMean(:,idx),'g')
% plot(x,data.exp00{1}.IK.valuesMean(:,idx)+data.exp00{1}.IK.valuesSD(:,idx),'b')
% plot(x,data.exp00{1}.IK.valuesMean(:,idx)-data.exp00{1}.IK.valuesSD(:,idx),'b')
% xlabel('percentage of gait [-]')
% ylabel('Ankle dorsiflexion [rad]')
% set(gca,'FontSize',fs)
% 
% % expected
% subplot(3,3,2); hold on; grid on;
% idx = getIdxMean(data,'hip_flexion_st');
% x = linspace(0,200,length(data.exp100{1}.IK.valuesMean(:,idx)));
% plot(x,data.exp100{1}.IK.valuesMean(:,idx),'r')
% plot(x,data.exp100{1}.IK.valuesMean(:,idx)+data.exp100{1}.IK.valuesSD(:,idx),'b')
% plot(x,data.exp100{1}.IK.valuesMean(:,idx)-data.exp100{1}.IK.valuesSD(:,idx),'b')
% idx = getIdxMean(data,'hip_flexion_sw');
% plot(x,data.exp100{1}.IK.valuesMean(:,idx),'g')
% plot(x,data.exp100{1}.IK.valuesMean(:,idx)+data.exp100{1}.IK.valuesSD(:,idx),'b')
% plot(x,data.exp100{1}.IK.valuesMean(:,idx)-data.exp100{1}.IK.valuesSD(:,idx),'b')
% set(gca,'FontSize',fs)
% % xline(data.exp100{1}.IK.touchDown/length(data.exp100{1}.IK.valuesMean(:,idx))*100)
% title('Expected 10cm drop')
% 
% subplot(3,3,5); hold on; grid on;
% idx = getIdxMean(data,'knee_angle_st');
% x = linspace(0,200,length(data.exp100{1}.IK.valuesMean(:,idx)));
% plot(x,data.exp100{1}.IK.valuesMean(:,idx),'r')
% plot(x,data.exp100{1}.IK.valuesMean(:,idx)+data.exp100{1}.IK.valuesSD(:,idx),'b')
% plot(x,data.exp100{1}.IK.valuesMean(:,idx)-data.exp100{1}.IK.valuesSD(:,idx),'b')
% idx = getIdxMean(data,'knee_angle_sw');
% plot(x,data.exp100{1}.IK.valuesMean(:,idx),'g')
% plot(x,data.exp100{1}.IK.valuesMean(:,idx)+data.exp100{1}.IK.valuesSD(:,idx),'b')
% plot(x,data.exp100{1}.IK.valuesMean(:,idx)-data.exp100{1}.IK.valuesSD(:,idx),'b')
% set(gca,'FontSize',fs)
% % xline(data.exp100{1}.IK.touchDown/length(data.exp100{1}.IK.valuesMean(:,idx))*100)
% 
% subplot(3,3,8); hold on; grid on;
% idx = getIdxMean(data,'ankle_angle_st');
% x = linspace(0,200,length(data.exp100{1}.IK.valuesMean(:,idx)));
% plot(x,data.exp100{1}.IK.valuesMean(:,idx),'r')
% plot(x,data.exp100{1}.IK.valuesMean(:,idx)+data.exp100{1}.IK.valuesSD(:,idx),'b')
% plot(x,data.exp100{1}.IK.valuesMean(:,idx)-data.exp100{1}.IK.valuesSD(:,idx),'b')
% idx = getIdxMean(data,'ankle_angle_sw');
% plot(x,data.exp100{1}.IK.valuesMean(:,idx),'g')
% plot(x,data.exp100{1}.IK.valuesMean(:,idx)+data.exp100{1}.IK.valuesSD(:,idx),'b')
% plot(x,data.exp100{1}.IK.valuesMean(:,idx)-data.exp100{1}.IK.valuesSD(:,idx),'b')
% xlabel('percentage of gait [-]')
% set(gca,'FontSize',fs)
% % xline(data.exp100{1}.IK.touchDown/length(data.exp100{1}.IK.valuesMean(:,idx))*100)
% 
% % unexpected
% subplot(3,3,3); hold on; grid on;
% idx = getIdxMean(data,'hip_flexion_st');
% x = linspace(0,200,length(data.unexp100{1}.IK.valuesMean(:,idx)));
% plot(x,data.unexp100{1}.IK.valuesMean(:,idx),'r')
% idx = getIdxMean(data,'hip_flexion_sw');
% plot(x,data.unexp100{1}.IK.valuesMean(:,idx),'g')
% 
% idx = getIdxMean(data,'hip_flexion_st');
% plot(x,data.unexp100{1}.IK.valuesMean(:,idx)+data.unexp100{1}.IK.valuesSD(:,idx),'b')
% plot(x,data.unexp100{1}.IK.valuesMean(:,idx)-data.unexp100{1}.IK.valuesSD(:,idx),'b')
% idx = getIdxMean(data,'hip_flexion_sw');
% plot(x,data.unexp100{1}.IK.valuesMean(:,idx)+data.unexp100{1}.IK.valuesSD(:,idx),'b')
% plot(x,data.unexp100{1}.IK.valuesMean(:,idx)-data.unexp100{1}.IK.valuesSD(:,idx),'b')
% set(gca,'FontSize',fs)
% % xline(data.unexp100{1}.IK.touchDown/length(data.unexp100{1}.IK.valuesMean(:,idx))*100)
% title('Unexpected 10cm drop')
% legend('stance leg','swing leg')
% 
% subplot(3,3,6); hold on; grid on;
% idx = getIdxMean(data,'knee_angle_st');
% x = linspace(0,200,length(data.unexp100{1}.IK.valuesMean(:,idx)));
% plot(x,data.unexp100{1}.IK.valuesMean(:,idx),'r')
% plot(x,data.unexp100{1}.IK.valuesMean(:,idx)+data.unexp100{1}.IK.valuesSD(:,idx),'b')
% plot(x,data.unexp100{1}.IK.valuesMean(:,idx)-data.unexp100{1}.IK.valuesSD(:,idx),'b')
% idx = getIdxMean(data,'knee_angle_sw');
% plot(x,data.unexp100{1}.IK.valuesMean(:,idx),'g')
% plot(x,data.unexp100{1}.IK.valuesMean(:,idx)+data.unexp100{1}.IK.valuesSD(:,idx),'b')
% plot(x,data.unexp100{1}.IK.valuesMean(:,idx)-data.unexp100{1}.IK.valuesSD(:,idx),'b')
% set(gca,'FontSize',fs)
% % xline(data.unexp100{1}.IK.touchDown/length(data.unexp100{1}.IK.valuesMean(:,idx))*100)
% 
% subplot(3,3,9); hold on; grid on;
% idx = getIdxMean(data,'ankle_angle_st');
% x = linspace(0,200,length(data.unexp100{1}.IK.valuesMean(:,idx)));
% plot(x,data.unexp100{1}.IK.valuesMean(:,idx),'r')
% plot(x,data.unexp100{1}.IK.valuesMean(:,idx)+data.unexp100{1}.IK.valuesSD(:,idx),'b')
% plot(x,data.unexp100{1}.IK.valuesMean(:,idx)-data.unexp100{1}.IK.valuesSD(:,idx),'b')
% idx = getIdxMean(data,'ankle_angle_sw');
% plot(x,data.unexp100{1}.IK.valuesMean(:,idx),'g')
% plot(x,data.unexp100{1}.IK.valuesMean(:,idx)+data.unexp100{1}.IK.valuesSD(:,idx),'b')
% plot(x,data.unexp100{1}.IK.valuesMean(:,idx)-data.unexp100{1}.IK.valuesSD(:,idx),'b')
% xlabel('percentage of gait [-]')
% set(gca,'FontSize',fs)
% % xline(data.unexp100{1}.IK.touchDown/length(data.unexp100{1}.IK.valuesMean(:,idx))*100)
% 
% 
% linkaxes

%% Check com velocity
figure
for i = 1:8
    com = data.exp00{i}.IK.dvaluesCoM(:,[2,3,4]);
    time = data.exp00{i}.IK.dvaluesCoM(:,1);
    
    subplot(1,3,1);
    plot(time,com(:,1))
    
    subplot(1,3,2);
    plot(time,com(:,2))
    
    subplot(1,3,3);
    plot(time,com(:,3))
end

figure
subplot(1,3,1); hold on; grid on;
for i = 1:8
    zeroCrossingT = data.exp00{i}.IK.zeroCrossingT;
    [~,t0] = min(abs(data.exp00{i}.IK.valuesCoM(:,1)-zeroCrossingT(1)));
    [~,tf] = min(abs(data.exp00{i}.IK.valuesCoM(:,1)-zeroCrossingT(2)));
    time = data.exp00{i}.IK.dvaluesCoM(t0:tf,1) - data.exp00{i}.IK.dvaluesCoM(t0,1);
    dcomx = data.exp00{i}.IK.dvaluesCoM(t0:tf,2);
    plot(time,dcomx)
end
title('Flag-ground walking')
xlabel('time [s]')
ylabel('Horizontal CoM velocity [m/s]')
set(gca,'FontSize',fs)

subplot(1,3,2); hold on; grid on;
for i = 1:8
    zeroCrossingT = data.exp100{i}.IK.zeroCrossingT;
    [~,t0] = min(abs(data.exp100{i}.IK.valuesCoM(:,1)-zeroCrossingT(1)));
    [~,tf] = min(abs(data.exp100{i}.IK.valuesCoM(:,1)-zeroCrossingT(2)));
    time = data.exp100{i}.IK.dvaluesCoM(t0:tf,1) - data.exp100{i}.IK.dvaluesCoM(t0,1);
    dcomx = data.exp100{i}.IK.dvaluesCoM(t0:tf,2);
    plot(time,dcomx)
end
title('Expected 10cm drop')
xlabel('time [s]')
ylabel('Horizontal CoM velocity [m/s]')
set(gca,'FontSize',fs)

subplot(1,3,3); hold on; grid on;
for i = 1:8
    zeroCrossingT = data.unexp100{i}.IK.zeroCrossingT;
    [~,t0] = min(abs(data.unexp100{i}.IK.valuesCoM(:,1)-zeroCrossingT(1)));
    [~,tf] = min(abs(data.unexp100{i}.IK.valuesCoM(:,1)-zeroCrossingT(2)));
    time = data.unexp100{i}.IK.dvaluesCoM(t0:tf,1) - data.unexp100{i}.IK.dvaluesCoM(t0,1);
    dcomx = data.unexp100{i}.IK.dvaluesCoM(t0:tf,2);
    plot(time,dcomx)
end
title('Unexpected 10cm drop')
xlabel('time [s]')
ylabel('Horizontal CoM velocity [m/s]')
set(gca,'FontSize',fs)

linkaxes


a = 1;

%% Phasing variable femur_Oz
% % figure
% % for i = 1:8
% %     zC = data.exp00{i}.IK.zeroCrossing;
% %     zCT = data.exp00{i}.IK.zeroCrossingT;
% %     
% %     time    = data.exp00{i}.IK.values(zC(1):zC(2),1) - zCT(1);
% %     tibia_r_O = data.exp00{i}.IK.valuesCoM(zC(1):zC(2),[17,18,19]);
% %     tibia_l_O = data.exp00{i}.IK.valuesCoM(zC(1):zC(2),[47,48,49]);
% %     grf_r     = data.exp00{i}.IK.valuesGRF(zC(1):zC(2),[2,3,4]);
% %     grf_l     = data.exp00{i}.IK.valuesGRF(zC(1):zC(2),[8,9,10]);
% %     
% %     subplot(1,2,1); hold on; grid on;
% % %     plot(time,tibia_r_O(:,1),'r')
% % %     plot(time,tibia_r_O(:,2),'b')
% %     plot(time,tibia_r_O(:,3),'g')
% % %     plot(time,grf_r(:,1),'r-')
% %     plot(time,grf_r(:,2),'b-')
% % %     plot(time,grf_r(:,3),'g-')
% %     
% %     subplot(1,2,2); hold on; grid on;
% % %     plot(time,tibia_l_O(:,1),'r')
% % %     plot(time,tibia_l_O(:,2),'b')
% %     plot(time,tibia_l_O(:,3),'g')
% % %     plot(time,grf_l(:,1),'r-')
% %     plot(time,0.1.*grf_l(:,2),'b-')
% % %     plot(time,grf_l(:,3),'g-')
% % 
% %     touchDownT = data.exp00{i}.IK.touchDownT;
% %     eventArrayT = data.exp00{i}.IK.eventArrayT;
% %     touchDownD = eventArrayT(5) - eventArrayT(2);
% %     
% %     p = polyfit((time-touchDownT),0.5.*tibia_l_O(:,3),7);
% %     plotTime = 0:0.001:touchDownD;
% %     plot(plotTime,polyval(p,plotTime))
% % end
% % % for wip_xF the SSP duration is 0.4079
% 
% %% plot knee angle hip angle all trials SWING LEG
% figure
% subplot(2,2,1); hold on; grid on;
% idx = getIdxMean(data,'hip_flexion_sw');
% plot(data.exp00{1}.IK.valuesMean(:,idx),'r','LineWidth',2)
% plot(data.exp25{1}.IK.valuesMean(:,idx))
% plot(data.exp50{1}.IK.valuesMean(:,idx))
% plot(data.exp75{1}.IK.valuesMean(:,idx))
% plot(data.exp100{1}.IK.valuesMean(:,idx))
% xline(data.exp25{1}.IK.belowGroundMean - data.exp25{1}.IK.zeroCrossing(1),'g')
% % xline(data.exp25{1}.IK.touchDownMean,'b')
% legend('00','25','50','75','100')
% title('Expected walking, hip flexion')
% ylabel('Hip flexion [rad]')
% ylim([-30 70])
% set(gca,'FontSize',15)
% set(gca,'XTickLabel',0:20:200)
% 
% subplot(2,2,2); hold on; grid on;
% idx = getIdxMean(data,'knee_angle_sw');
% plot(data.exp00{1}.IK.valuesMean(:,idx),'r','LineWidth',2)
% plot(data.exp25{1}.IK.valuesMean(:,idx))
% plot(data.exp50{1}.IK.valuesMean(:,idx))
% plot(data.exp75{1}.IK.valuesMean(:,idx))
% plot(data.exp100{1}.IK.valuesMean(:,idx))
% xline(data.exp25{1}.IK.belowGroundMean - data.exp25{1}.IK.zeroCrossing(1),'g')
% % xline(data.exp25{1}.IK.touchDownMean,'b')
% legend('00','25','50','75','100')
% title('Expected walking, knee flexion')
% ylabel('Knee flexion [rad]')
% set(gca,'FontSize',15)
% set(gca,'XTickLabel',0:20:200)
% 
% % unexpected
% subplot(2,2,3); hold on; grid on;
% idx = getIdxMean(data,'hip_flexion_sw');
% plot(data.exp00{1}.IK.valuesMean(:,idx),'r','LineWidth',2)
% plot(data.unexp25{1}.IK.valuesMean(:,idx))
% plot(data.unexp50{1}.IK.valuesMean(:,idx))
% plot(data.unexp75{1}.IK.valuesMean(:,idx))
% plot(data.unexp100{1}.IK.valuesMean(:,idx))
% xline(data.exp25{1}.IK.belowGroundMean - data.exp25{1}.IK.zeroCrossing(1),'g')
% % xline(data.exp25{1}.IK.touchDownMean,'b')
% legend('00','25','50','75','100')
% title('Unexpected walking, hip flexion')
% ylabel('Hip flexion [rad]')
% ylim([-30 70])
% set(gca,'FontSize',15)
% set(gca,'XTickLabel',0:20:200)
% 
% subplot(2,2,4); hold on; grid on;
% idx = getIdxMean(data,'knee_angle_sw');
% plot(data.exp00{1}.IK.valuesMean(:,idx),'r','LineWidth',2)
% plot(data.unexp25{1}.IK.valuesMean(:,idx))
% plot(data.unexp50{1}.IK.valuesMean(:,idx))
% plot(data.unexp75{1}.IK.valuesMean(:,idx))
% plot(data.unexp100{1}.IK.valuesMean(:,idx))
% xline(data.exp25{1}.IK.belowGroundMean - data.exp25{1}.IK.zeroCrossing(1),'g')
% % xline(data.exp25{1}.IK.touchDownMean,'b')
% legend('00','25','50','75','100')
% title('Unexpected walking, knee flexion')
% ylabel('Knee flexion [rad]')
% set(gca,'FontSize',15)
% set(gca,'XTickLabel',0:20:200)
% 
% sgtitle('Swing leg')

%% plot knee angle hip angle all trials STANCE LEG
% figure
% subplot(2,2,1); hold on; grid on;
% idx = getIdxMean(data,'hip_flexion_st');
% plot(data.exp00{1}.IK.valuesMean(:,idx),'r','LineWidth',2)
% plot(data.exp25{1}.IK.valuesMean(:,idx))
% plot(data.exp50{1}.IK.valuesMean(:,idx))
% plot(data.exp75{1}.IK.valuesMean(:,idx))
% plot(data.exp100{1}.IK.valuesMean(:,idx))
% xline(data.exp25{1}.IK.belowGroundMean - data.exp25{1}.IK.zeroCrossing(1),'g')
% % xline(data.exp25{1}.IK.touchDownMean,'b')
% legend('00','25','50','75','100')
% title('Expected walking, hip flexion')
% ylabel('Hip flexion [rad]')
% set(gca,'FontSize',15)
% set(gca,'XTickLabel',0:20:200)
% 
% subplot(2,2,2); hold on; grid on;
% idx = getIdxMean(data,'knee_angle_st');
% plot(data.exp00{1}.IK.valuesMean(:,idx),'r','LineWidth',2)
% plot(data.exp25{1}.IK.valuesMean(:,idx))
% plot(data.exp50{1}.IK.valuesMean(:,idx))
% plot(data.exp75{1}.IK.valuesMean(:,idx))
% plot(data.exp100{1}.IK.valuesMean(:,idx))
% xline(data.exp25{1}.IK.belowGroundMean - data.exp25{1}.IK.zeroCrossing(1),'g')
% % xline(data.exp25{1}.IK.touchDownMean,'b')
% legend('00','25','50','75','100')
% title('Expected walking, knee flexion')
% ylabel('Knee flexion [rad]')
% ylim([-100 0])
% set(gca,'FontSize',15)
% set(gca,'XTickLabel',0:20:200)
% 
% % unexpected
% subplot(2,2,3); hold on; grid on;
% idx = getIdxMean(data,'hip_flexion_st');
% plot(data.exp00{1}.IK.valuesMean(:,idx),'r','LineWidth',2)
% plot(data.unexp25{1}.IK.valuesMean(:,idx))
% plot(data.unexp50{1}.IK.valuesMean(:,idx))
% plot(data.unexp75{1}.IK.valuesMean(:,idx))
% plot(data.unexp100{1}.IK.valuesMean(:,idx))
% xline(data.exp25{1}.IK.belowGroundMean - data.exp25{1}.IK.zeroCrossing(1),'g')
% % xline(data.exp25{1}.IK.touchDownMean,'b')
% legend('00','25','50','75','100')
% title('Unexpected walking, hip flexion')
% ylabel('Hip flexion [rad]')
% set(gca,'FontSize',15)
% set(gca,'XTickLabel',0:20:200)
% 
% subplot(2,2,4); hold on; grid on;
% idx = getIdxMean(data,'knee_angle_st');
% plot(data.exp00{1}.IK.valuesMean(:,idx),'r','LineWidth',2)
% plot(data.unexp25{1}.IK.valuesMean(:,idx))
% plot(data.unexp50{1}.IK.valuesMean(:,idx))
% plot(data.unexp75{1}.IK.valuesMean(:,idx))
% plot(data.unexp100{1}.IK.valuesMean(:,idx))
% xline(data.exp25{1}.IK.belowGroundMean - data.exp25{1}.IK.zeroCrossing(1),'g')
% % xline(data.exp25{1}.IK.touchDownMean,'b')
% legend('00','25','50','75','100')
% title('Unexpected walking, knee flexion')
% ylabel('Knee flexion [rad]')
% ylim([-100 0])
% set(gca,'FontSize',15)
% set(gca,'XTickLabel',0:20:200)
% 
% sgtitle('Stance leg')

%% Swing leg positions
idxrX = getIdxCoM(data,'calcn_r_X');
idxlX = getIdxCoM(data,'calcn_l_X');
idxrY = getIdxCoM(data,'calcn_r_Y');
idxlY = getIdxCoM(data,'calcn_l_Y');
idxrZ = getIdxCoM(data,'calcn_r_Z');
idxlZ = getIdxCoM(data,'calcn_l_Z');

figure; 
subplot(1,3,1); hold on; grid on;
for i = 1:8
    zeroCrossingT = data.exp00{i}.IK.zeroCrossingT;
    [~,t0] = min(abs(data.exp00{i}.IK.valuesCoM(:,1)-zeroCrossingT(1)));
    [~,tf] = min(abs(data.exp00{i}.IK.valuesCoM(:,1)-zeroCrossingT(2)));
    
    plot(data.exp25{i}.IK.valuesCoM(t0:tf,1),data.exp25{i}.IK.valuesCoM(t0:tf,idxrX))
%     plot(data.exp25{i}.IK.valuesCoM(t0:tf,idxlX))
end
title('X')
subplot(1,3,2); hold on; grid on;
for i = 1:8
    zeroCrossingT = data.exp00{i}.IK.zeroCrossingT;
    [~,t0] = min(abs(data.exp00{i}.IK.valuesCoM(:,1)-zeroCrossingT(1)));
    [~,tf] = min(abs(data.exp00{i}.IK.valuesCoM(:,1)-zeroCrossingT(2)));
    
    plot(data.exp25{i}.IK.valuesCoM(t0:tf,1),data.exp25{i}.IK.valuesCoM(t0:tf,idxrY))
%     plot(data.exp25{i}.IK.valuesCoM(t0:tf,idxlY))
    zsw = data.exp25{i}.IK.valuesCoM(t0:tf,idxrY)
    zswt = data.exp25{i}.IK.valuesCoM(t0:tf,1)
    
    dzsw = data.exp25{i}.IK.dvaluesCoM(t0:tf,idxrY)
    dzswt = data.exp25{i}.IK.dvaluesCoM(t0:tf,1)
end
title('Y')
save('zsw.mat','zsw','zswt','dzsw','dzswt')

subplot(1,3,3); hold on; grid on;
for i = 1:8
    zeroCrossingT = data.exp00{i}.IK.zeroCrossingT;
    [~,t0] = min(abs(data.exp00{i}.IK.valuesCoM(:,1)-zeroCrossingT(1)));
    [~,tf] = min(abs(data.exp00{i}.IK.valuesCoM(:,1)-zeroCrossingT(2)));
    
    plot(data.exp25{i}.IK.valuesCoM(t0:tf,1),data.exp25{i}.IK.valuesCoM(t0:tf,idxrZ))
%     plot(data.exp25{i}.IK.valuesCoM(t0:tf,idxlZ))
end
title('Z')

%% com from VLO to VLO
figure
subplot(1,3,1); hold on; grid on;
idxX = getIdxCoM(data,'center_of_mass_X');
idxY = getIdxCoM(data,'center_of_mass_Y');
idxZ = getIdxCoM(data,'center_of_mass_Z');
minCoMexp00 = [];
for i = 1:8
    zeroCrossingT = data.exp00{i}.IK.zeroCrossingT;
    [~,t0] = min(abs(data.exp00{i}.IK.valuesCoM(:,1)-zeroCrossingT(1)));
    [~,tf] = min(abs(data.exp00{i}.IK.valuesCoM(:,1)-zeroCrossingT(2)));
    plot(data.exp00{i}.IK.valuesCoM(t0:tf,idxX)-data.exp00{i}.IK.valuesCoM(t0,idxX),...
        data.exp00{i}.IK.valuesCoM(t0:tf,idxY))
    minCoMexp00 = [minCoMexp00 min(data.exp00{i}.IK.valuesCoM(t0:tf,idxY))];
end
% ylim([0 1])
title('Flag-ground walking')
xlabel('horizontal CoM displacement [m]')
ylabel('vertical CoM displacement [m]')
set(gca,'FontSize',fs)

minCoMexp100 = [];
subplot(1,3,2); hold on; grid on;
for i = 1:length(data.exp100)
    zeroCrossingT = data.exp100{i}.IK.zeroCrossingT;
    [~,t0] = min(abs(data.exp100{i}.IK.valuesCoM(:,1)-zeroCrossingT(1)));
    [~,tf] = min(abs(data.exp100{i}.IK.valuesCoM(:,1)-zeroCrossingT(2)));
    plot(data.exp100{i}.IK.valuesCoM(t0:tf,idxX)-data.exp100{i}.IK.valuesCoM(t0,idxX),...
        data.exp100{i}.IK.valuesCoM(t0:tf,idxY))
    minCoMexp100 = [minCoMexp100 min(data.exp100{i}.IK.valuesCoM(t0:tf,idxY))];
end
% ylim([0 1])
title('Expected 10cm drop')
xlabel('horizontal CoM displacement [m]')
ylabel('vertical CoM displacement [m]')
set(gca,'FontSize',fs)

minCoMunexp100 = [];
subplot(1,3,3); hold on; grid on;
for i = 1:length(data.unexp100)
    zeroCrossingT = data.unexp100{i}.IK.zeroCrossingT;
    [~,t0] = min(abs(data.unexp100{i}.IK.valuesCoM(:,1)-zeroCrossingT(1)));
    [~,tf] = min(abs(data.unexp100{i}.IK.valuesCoM(:,1)-zeroCrossingT(2)));
    plot(data.unexp100{i}.IK.valuesCoM(t0:tf,idxX)-data.unexp100{i}.IK.valuesCoM(t0,idxX),...
        data.unexp100{i}.IK.valuesCoM(t0:tf,idxY))
    minCoMunexp100 = [minCoMunexp100 min(data.unexp100{i}.IK.valuesCoM(t0:tf,idxY))];
end
% ylim([0 1])
title('Unexpected 10cm drop')
xlabel('horizontal CoM displacement [m]')
ylabel('vertical CoM displacement [m]')
set(gca,'FontSize',fs)

linkaxes

percent = (mean(minCoMexp00) - mean(minCoMexp100))/mean(minCoMexp00)
percent = (mean(minCoMexp00) - mean(minCoMunexp100))/mean(minCoMexp00)

%% get the approximated mean of all the trials for each experiment
clearvars x y z t dx dy dz ddx ddy ddz
fields = fieldnames(data);
for fn = 1:length(fields)
    numFields = length(data.(fields{fn}));
    for i = 1:numFields
        zeroCrossingT = data.(fields{fn}){i}.IK.zeroCrossingT;
        [~,t0] = min(abs(data.(fields{fn}){i}.IK.valuesCoM(:,1)-zeroCrossingT(1)));
        [~,tf] = min(abs(data.(fields{fn}){i}.IK.valuesCoM(:,1)-zeroCrossingT(2)));
        x{i} = data.(fields{fn}){i}.IK.valuesCoM(t0:tf,idxX)-data.(fields{fn}){i}.IK.valuesCoM(t0,idxX);
        y{i} = data.(fields{fn}){i}.IK.valuesCoM(t0:tf,idxY);%-data.(fields{fn}){i}.IK.valuesCoM(t0,idxY);
        z{i} = data.(fields{fn}){i}.IK.valuesCoM(t0:tf,idxZ);%-data.(fields{fn}){i}.IK.valuesCoM(t0,idxZ);
        t{i} = data.(fields{fn}){i}.IK.values(t0:tf,1)-data.(fields{fn}){i}.IK.values(t0,1);
    end
    for i = 1:numFields
        zeroCrossingT = data.(fields{fn}){i}.IK.zeroCrossingT;
        [~,t0] = min(abs(data.(fields{fn}){i}.IK.valuesCoM(:,1)-zeroCrossingT(1)));
        [~,tf] = min(abs(data.(fields{fn}){i}.IK.valuesCoM(:,1)-zeroCrossingT(2)));
        dx{i} = data.(fields{fn}){i}.IK.dvaluesCoM(t0:tf,idxX);
        dy{i} = data.(fields{fn}){i}.IK.dvaluesCoM(t0:tf,idxY);
        dz{i} = data.(fields{fn}){i}.IK.dvaluesCoM(t0:tf,idxZ);
    end
    for i = 1:numFields
        zeroCrossingT = data.(fields{fn}){i}.IK.zeroCrossingT;
        [~,t0] = min(abs(data.(fields{fn}){i}.IK.valuesCoM(:,1)-zeroCrossingT(1)));
        [~,tf] = min(abs(data.(fields{fn}){i}.IK.valuesCoM(:,1)-zeroCrossingT(2)));
        ddx{i} = data.(fields{fn}){i}.IK.ddvaluesCoM(t0:tf,idxX);
        ddy{i} = data.(fields{fn}){i}.IK.ddvaluesCoM(t0:tf,idxY);
        ddz{i} = data.(fields{fn}){i}.IK.ddvaluesCoM(t0:tf,idxZ);
    end
    [xinterp,yinterp,zinterp,tinterp] = interpolateWide(x,y,z,t,fn);
    meanCoM.(fields{fn}).x = xinterp;
    meanCoM.(fields{fn}).y = yinterp;
    meanCoM.(fields{fn}).z = zinterp;
    meanCoM.(fields{fn}).t = tinterp;
    
    [dxinterp,dyinterp,dzinterp,~] = interpolateWide(dx,dy,dz,t,fn);
    meanCoM.(fields{fn}).dx = dxinterp;
    meanCoM.(fields{fn}).dy = dyinterp;
    meanCoM.(fields{fn}).dz = dzinterp;
    
    [ddxinterp,ddyinterp,ddzinterp,~] = interpolateWide(ddx,ddy,ddz,t,fn);
    meanCoM.(fields{fn}).ddx = ddxinterp;
    meanCoM.(fields{fn}).ddy = ddyinterp;
    meanCoM.(fields{fn}).ddz = ddzinterp;
end

% interpolate time dependent dimensions and x-y plane dimension
order = 7;
for fn = 1:length(fields)
    meanCoM.(fields{fn}).ptx = polyfit(meanCoM.(fields{fn}).t,...
                                       meanCoM.(fields{fn}).x,order);
    meanCoM.(fields{fn}).pty = polyfit(meanCoM.(fields{fn}).t,...
                                       meanCoM.(fields{fn}).y,order);
                                   
    meanCoM.(fields{fn}).ptdx = polyfit(meanCoM.(fields{fn}).t,...
                                        meanCoM.(fields{fn}).dx,order);
    meanCoM.(fields{fn}).ptdy = polyfit(meanCoM.(fields{fn}).t,...
                                        meanCoM.(fields{fn}).dy,order);
                                   
    meanCoM.(fields{fn}).ptddx = polyfit(meanCoM.(fields{fn}).t,...
                                         meanCoM.(fields{fn}).ddx,order);
    meanCoM.(fields{fn}).ptddy = polyfit(meanCoM.(fields{fn}).t,...
                                         meanCoM.(fields{fn}).ddy,order);
                                   
    meanCoM.(fields{fn}).pxy = polyfit(meanCoM.(fields{fn}).x,...
                                       meanCoM.(fields{fn}).y,order);
                                   
    meanCoM.(fields{fn}).pxdx = polyfit(meanCoM.(fields{fn}).x,...
                                        meanCoM.(fields{fn}).dx,order);
    meanCoM.(fields{fn}).pxdy = polyfit(meanCoM.(fields{fn}).x,...
                                        meanCoM.(fields{fn}).dy,order);
%     idxX = getIdxCoM(data,'center_of_mass_X');
%     idxY = getIdxCoM(data,'center_of_mass_Y');
%     zeroCrossing = data.(fields{fn}){1}.IK.zeroCrossing;
%     meanCoM.(fields{fn}).pxdx = polyfit(data.(fields{fn}){1}.IK.valuesCoM(:,idxX)-data.(fields{fn}){1}.IK.valuesCoM(zeroCrossing(1),idxX),...
%                                         data.(fields{fn}){1}.IK.dvaluesCoM(:,idxX),order);
%     meanCoM.(fields{fn}).pxdy = polyfit(data.(fields{fn}){1}.IK.valuesCoM(:,idxX)-data.(fields{fn}){1}.IK.valuesCoM(zeroCrossing(1),idxX),...
%                                         data.(fields{fn}){1}.IK.dvaluesCoM(:,idxY),order);
                                   
    meanCoM.(fields{fn}).pxddx = polyfit(meanCoM.(fields{fn}).x,...
                                         meanCoM.(fields{fn}).ddx,order);
    meanCoM.(fields{fn}).pxddy = polyfit(meanCoM.(fields{fn}).x,...
                                         meanCoM.(fields{fn}).ddy,order);
                                     
%     meanCoM.(fields{fn}).pxGRF = polyfit(data.(fields{fn}){1}.IK
end

subplot(1,3,1)
plot(meanCoM.exp00.x,meanCoM.exp00.y,'r','LineWidth',2)
xpoly = linspace(0,max(meanCoM.exp00.x));
plot(xpoly,polyval(meanCoM.exp00.pxy,xpoly),'b','LineWidth',2)
set(gca,'FontSize',15)

subplot(1,3,2)
plot(meanCoM.exp100.x,meanCoM.exp100.y,'r','LineWidth',2)
xpoly = linspace(0,max(meanCoM.exp100.x));
plot(xpoly,polyval(meanCoM.exp100.pxy,xpoly),'b','LineWidth',2)
set(gca,'FontSize',15)

subplot(1,3,3)
plot(meanCoM.unexp100.x,meanCoM.unexp100.y,'r','LineWidth',2)
xpoly = linspace(0,max(meanCoM.unexp100.x));
plot(xpoly,polyval(meanCoM.unexp100.pxy,xpoly),'b','LineWidth',2)
set(gca,'FontSize',15)

legend('run 1','run 2','run 3','run 4','run 5','run 6','run 7','run 8',...
    'mean','polyfit')

%% get cosine function of level walking
% assume function: y = B + A*cos(w*x + phi)
B0 = 0.85; A0 = 0.1; w0 = 2*pi; phi0 = 0;
yMean = [meanCoM.exp00.y(18:end); meanCoM.exp00.y(1:17)];
xMean = [meanCoM.exp00.x(18:end); meanCoM.exp00.x(1:17)+meanCoM.exp00.x(end)];
xysol = fminsearch(@(t) sum( (yMean(:) - ( t(1)+t(2)*cos(t(3)*xMean(:)+t(4))) ).^2 ),...
    [B0 A0 w0 phi0]);
xysol(4) = 0;
save('xysol','xysol')

xycosine = xysol(1) + xysol(2)*(cos(xysol(3).*xMean + xysol(4)));
subplot(1,3,1); hold on; grid on;
plot(xMean,xycosine,'g','LineWidth',2)
plot(xMean,yMean)

figure; hold on; grid on;
plot(meanCoM.exp00.t,meanCoM.exp00.y)
tMean = meanCoM.exp00.t;
tysol = fminsearch(@(t) sum( (yMean(:)-t(1)-t(2)*cos(t(3)*tMean(:)+t(4))).^2 ),...
    [B0 A0 w0 phi0]);
tycosine = tysol(1) + tysol(2)*(cos(tysol(3).*tMean + tysol(4)));
plot(tMean,tycosine,'g','LineWidth',2)

%% now fit 7th order polynomial to downsteps
fun7 = @(p) sum( (yMean(:) - (p(1)*xMean(:).^7 + p(2)*xMean(:).^6 + ...
    p(3)*xMean(:).^5 + p(4)*xMean(:).^4 + p(5)*xMean(:).^3 + ...
    p(6)*xMean(:).^2 + p(7)*xMean(:) + p(8))).^2);
nlc7 = @(p) ([p(end) - (xysol(1)+abs(xysol(2))); p(end-1)]);
for fn = 1:length(fields)
    xMean = meanCoM.(fields{fn}).x;
    yMean = meanCoM.(fields{fn}).y;
    xm = max(xMean);
    fun7 = @(p) sum( (yMean(:) - (p(1)*xMean(:).^7 + p(2)*xMean(:).^6 + ...
        p(3)*xMean(:).^5 + p(4)*xMean(:).^4 + p(5)*xMean(:).^3 + ...
        p(6)*xMean(:).^2 + p(7)*xMean(:) + p(8))).^2);
    nlc7 = @(p) deal([2*p(6)],...
        [p(8) - (xysol(1)+abs(xysol(2))); 
         p(1)*xm^7+p(2)*xm^6+p(3)*xm^5+p(4)*xm^4+p(5)*xm^3+p(6)*xm^2+p(7)*xm+p(8) - (xysol(1)+abs(xysol(2)));
         p(7);
         7*p(1)*xm^6+6*p(2)*xm^5+5*p(3)*xm^4+4*p(4)*xm^3+3*p(5)*xm^2+2*p(6)*xm+p(7)]);
    p0 = meanCoM.(fields{fn}).pxy;
    meanCoM.(fields{fn}).pxy_nlc = fmincon(fun7,p0,...
        [],[],[],[],[],[],nlc7);
end

% obtain x(t), dx(t), ddx(t), y(t), dy(t), and ddy(t) fits for initial
% conditions in optimization. Here, constraints do not really matter all
% that much

% add in the polynomial fits
figure(2)
subplot(1,3,1)
xMean = meanCoM.exp00.x;
yPoly = polyval(meanCoM.exp00.pxy_nlc,xMean);
plot(xMean,yPoly,'m','LineWidth',2)

subplot(1,3,2)
xMean = meanCoM.exp100.x;
yPoly = polyval(meanCoM.exp100.pxy_nlc,xMean);
plot(xMean,yPoly,'m','LineWidth',2)

subplot(1,3,3)
xMean = meanCoM.unexp100.x;
yPoly = polyval(meanCoM.unexp100.pxy_nlc,xMean);
plot(xMean,yPoly,'m','LineWidth',2)

linkaxes

% create a new figure of all constrained polyfits and exp00 sine
figure;
subplot(1,2,1); hold on; grid on;
xMean = meanCoM.exp00.x; %[meanCoM.exp00.x(18:end); meanCoM.exp00.x(1:17)+meanCoM.exp00.x(end)];
plot(xMean,xycosine,'LineWidth',2)
for fn = [2 3 4 5]
    xMean = meanCoM.(fields{fn}).x;
    yPoly = polyval(meanCoM.(fields{fn}).pxy_nlc,xMean);
    plot(xMean,yPoly,'LineWidth',2)
end
legend('exp00','exp25','exp50','exp75','exp100')
xlabel('x CoM position [m]')
ylabel('y CoM position [m]')
title('Expected down-step')
set(gca,'FontSize',15)

subplot(1,2,2); hold on; grid on;
xMean = meanCoM.exp00.x;
plot(xMean,xycosine,'LineWidth',2)
for fn = [6 7 8 9]
    xMean = meanCoM.(fields{fn}).x;
    yPoly = polyval(meanCoM.(fields{fn}).pxy_nlc,xMean);
    plot(xMean,yPoly,'LineWidth',2)
end
legend('exp00','unexp25','unexp50','unexp75','unexp100')
xlabel('x CoM position [m]')
ylabel('y CoM position [m]')
title('Unexpected down-step')
set(gca,'FontSize',15)

linkaxes

%% GRF plots
figure(50)
subplot(1,3,1); hold on; grid on;
idxY1 = 3;
idxY2 = 9;
for i = 1:8
    zeroCrossingT = data.exp00{i}.IK.zeroCrossingT;
    [~,t0] = min(abs(data.exp00{i}.IK.valuesCoM(:,1)-zeroCrossingT(1)));
    [~,tf] = min(abs(data.exp00{i}.IK.valuesCoM(:,1)-zeroCrossingT(2)));
    plot(data.exp00{i}.IK.valuesGRF(t0:tf,1)-data.exp00{i}.IK.valuesGRF(t0,1),...
        data.exp00{i}.IK.valuesGRF(t0:tf,idxY1))
    plot(data.exp00{i}.IK.valuesGRF(t0:tf,1)-data.exp00{i}.IK.valuesGRF(t0,1),...
        data.exp00{i}.IK.valuesGRF(t0:tf,idxY2))
end
title('Flag-ground walking')
set(gca,'FontSize',15)
ylabel('Force [N]')
xlabel('Percentage of gait [-]')
% set(gca,'XTickLabel',0:20:200)

subplot(1,3,2); hold on; grid on;
for i = 1:length(data.exp100)
    zeroCrossingT = data.exp100{i}.IK.zeroCrossingT;
    [~,t0] = min(abs(data.exp100{i}.IK.valuesCoM(:,1)-zeroCrossingT(1)));
    [~,tf] = min(abs(data.exp100{i}.IK.valuesCoM(:,1)-zeroCrossingT(2)));
    plot(data.exp100{i}.IK.valuesGRF(t0:tf,1)-data.exp100{i}.IK.valuesGRF(t0,1),...
        data.exp100{i}.IK.valuesGRF(t0:tf,idxY1))
    plot(data.exp100{i}.IK.valuesGRF(t0:tf,1)-data.exp100{i}.IK.valuesGRF(t0,1),...
        data.exp100{i}.IK.valuesGRF(t0:tf,idxY2))
end
title('Expected 10cm drop')
set(gca,'FontSize',15)
ylabel('Force [N]')
xlabel('Percentage of gait [-]')
set(gca,'XTickLabel',0:20:200)

subplot(1,3,3); hold on; grid on;
for i = 1:length(data.unexp100)
    try
    zeroCrossingT = data.unexp100{i}.IK.zeroCrossingT;
    [~,t0] = min(abs(data.unexp100{i}.IK.valuesCoM(:,1)-zeroCrossingT(1)));
    [~,tf] = min(abs(data.unexp100{i}.IK.valuesCoM(:,1)-zeroCrossingT(2)));
    plot(data.unexp100{i}.IK.valuesGRF(t0:tf,1)-data.unexp100{i}.IK.valuesGRF(t0,1),...
        data.unexp100{i}.IK.valuesGRF(t0:tf,idxY1))
    plot(data.unexp100{i}.IK.valuesGRF(t0:tf,1)-data.unexp100{i}.IK.valuesGRF(t0,1),...
        data.unexp100{i}.IK.valuesGRF(t0:tf,idxY2))
    end
end
title('Unexpected 10cm drop')
set(gca,'FontSize',15)
ylabel('Force [N]')
xlabel('Percentage of gait [-]')
set(gca,'XTickLabel',0:20:200)

sgtitle('Vertical Ground Reaction Force')
linkaxes

%% Let's do it again Pepega
figure(75)
fn = fieldnames(data);
for exp = 1:length(fn)
    subplot(2,5,exp); hold on; grid on;
    idxY1 = 3;
    idxY2 = 9;
    for i = 1:6
        zeroCrossingT = data.(fn{exp}){i}.IK.zeroCrossingT;
        [~,t0] = min(abs(data.(fn{exp}){i}.IK.valuesCoM(:,1)-zeroCrossingT(1)));
        [~,tf] = min(abs(data.(fn{exp}){i}.IK.valuesCoM(:,1)-zeroCrossingT(2)));
        plot(data.(fn{exp}){i}.IK.valuesGRF(t0:tf,1)-data.(fn{exp}){i}.IK.valuesGRF(t0,1),...
            data.(fn{exp}){i}.IK.valuesGRF(t0:tf,idxY1))
        plot(data.(fn{exp}){i}.IK.valuesGRF(t0:tf,1)-data.(fn{exp}){i}.IK.valuesGRF(t0,1),...
            data.(fn{exp}){i}.IK.valuesGRF(t0:tf,idxY2))
    end
    set(gca,'FontSize',15)
end


%% Other stuff
figure(51)
subplot(1,3,1); hold on; grid on;
plot(data.exp00{1}.IK.xGait,data.exp00{1}.IK.valuesGRFMean(:,3))
plot(data.exp00{1}.IK.xGait,data.exp00{1}.IK.valuesGRFMean(:,4))
set(gca,'FontSize',15)

subplot(1,3,2); hold on; grid on;
plot(data.exp100{1}.IK.xGait,data.exp100{1}.IK.valuesGRFMean(:,3))
plot(data.exp100{1}.IK.xGait,data.exp100{1}.IK.valuesGRFMean(:,4))
set(gca,'FontSize',15)

subplot(1,3,3); hold on; grid on;
plot(data.unexp100{1}.IK.xGait,data.unexp100{1}.IK.valuesGRFMean(:,3))
plot(data.unexp100{1}.IK.xGait,data.unexp100{1}.IK.valuesGRFMean(:,4))
set(gca,'FontSize',15)

% make some fits for the GRF mean 
figure(60);
for fn = 1:length(fields)
    subplot(1,length(fields),fn); hold on; grid on;
    
    xGait = data.(fields{fn}){1}.IK.xGait;
    stContactTMean = data.(fields{fn}){1}.IK.stContactTMean;
    swContactTMean = data.(fields{fn}){1}.IK.swContactTMean;
    
    xyz_sw = []; xyz_st = [];
    xyz_st = [xyz_st data.(fields{fn}){1}.IK.valuesGRFMean(:,1)];
    xyz_st = [xyz_st data.(fields{fn}){1}.IK.valuesGRFMean(:,3)];
    xyz_st = [xyz_st data.(fields{fn}){1}.IK.valuesGRFMean(:,5)];
    xyz_sw = [xyz_sw data.(fields{fn}){1}.IK.valuesGRFMean(:,2)];
    xyz_sw = [xyz_sw data.(fields{fn}){1}.IK.valuesGRFMean(:,4)];
    xyz_sw = [xyz_sw data.(fields{fn}){1}.IK.valuesGRFMean(:,6)];
    
    % stance legs
    for i = 1:3
        x01 = 1;
        x11 = find(abs(xyz_st(:,i)) > 1e-3,1);
        x02 = length(xyz_st(:,i)) - find(abs(flip(xyz_st(:,i))) > 1e-3,1);
        x12 = length(xyz_st);
        st_cont = xyz_st(x11:x02,i);
        
        t = linspace(0,stContactTMean,length(st_cont));
        pt = polyfit(t,st_cont,7);
        x = linspace(0,0.8196,length(st_cont));
%         x = linspace(0,100,length(st_cont));
        px = polyfit(x,st_cont,7);
        
        if i == 1
            meanGRF.(fields{fn}).pxx_st = px;
            meanGRF.(fields{fn}).ptx_st = pt;
        elseif i == 2
            meanGRF.(fields{fn}).pxy_st = px;
            meanGRF.(fields{fn}).pty_st = pt;
            plot(x,st_cont);
            plot(x,polyval(px,x));
        else
            meanGRF.(fields{fn}).pxz_st = px;
            meanGRF.(fields{fn}).ptz_st = pt;
        end
    end
    
    % for swing legs
    for i = 1:3
        x01 = find(xyz_sw(:,i) ~= 0,1);
        x11 = x01 + find(xyz_sw(x01:end,i) == 0,1);
        x02 = x11 + find(xyz_sw(x11:end,i) ~= 0,1);
        x12 = length(xyz_sw(:,i));
        
        sw_cont = [xyz_sw(x02:x12,i); xyz_sw(x01:x11,i)];
        
        t = linspace(0,swContactTMean,length(sw_cont));
        pt = polyfit(t,sw_cont,7);
        x = linspace(0,0.8196,length(sw_cont));
%         x = linspace(0,100,length(sw_cont));
        px = polyfit(x,sw_cont,7);
        
        if i == 1
            meanGRF.(fields{fn}).pxx_sw = px;
            meanGRF.(fields{fn}).ptx_sw = pt;
        elseif i == 2
            meanGRF.(fields{fn}).pxy_sw = px;
            meanGRF.(fields{fn}).pty_sw = pt;
            plot(x,sw_cont);
            plot(x,polyval(px,x));
        else
            meanGRF.(fields{fn}).pxz_sw = px;
            meanGRF.(fields{fn}).ptz_sw = pt;
        end
    end
    set(gca,'FontSize',15)
end

%% Save to file
for fn = 1:length(fields)
    fits.(fields{fn}) = meanCoM.(fields{fn}).pxy_nlc;
    
    fits_q0.(fields{fn}).ptx = meanCoM.(fields{fn}).ptx;
    fits_q0.(fields{fn}).pty = meanCoM.(fields{fn}).pty;
    fits_q0.(fields{fn}).ptdx = meanCoM.(fields{fn}).ptdx;
    fits_q0.(fields{fn}).ptdy = meanCoM.(fields{fn}).ptdy;
    fits_q0.(fields{fn}).ptddx = meanCoM.(fields{fn}).ptddx;
    fits_q0.(fields{fn}).ptddy = meanCoM.(fields{fn}).ptddy;
    
    fits_q0.(fields{fn}).pxy = meanCoM.(fields{fn}).pxy;
    fits_q0.(fields{fn}).pxdx = meanCoM.(fields{fn}).pxdx;
    fits_q0.(fields{fn}).pxdy = meanCoM.(fields{fn}).pxdy;
    fits_q0.(fields{fn}).pxddx = meanCoM.(fields{fn}).pxddx;
    fits_q0.(fields{fn}).pxddy = meanCoM.(fields{fn}).pxddy;
    
    avg_val.(fields{fn}).dx = mean(meanCoM.(fields{fn}).dx);
    avg_val.(fields{fn}).dy = mean(meanCoM.(fields{fn}).dy);
    avg_val.(fields{fn}).ddx = mean(meanCoM.(fields{fn}).ddx);
    avg_val.(fields{fn}).ddy = mean(meanCoM.(fields{fn}).ddy);
    
    % x-based
    fits_grf.(fields{fn}).pxx_sw = meanGRF.(fields{fn}).pxx_sw;
    fits_grf.(fields{fn}).pxy_sw = meanGRF.(fields{fn}).pxy_sw;
    fits_grf.(fields{fn}).pxz_sw = meanGRF.(fields{fn}).pxz_sw;
    fits_grf.(fields{fn}).pxx_st = meanGRF.(fields{fn}).pxx_st;
    fits_grf.(fields{fn}).pxy_st = meanGRF.(fields{fn}).pxy_st;
    fits_grf.(fields{fn}).pxz_st = meanGRF.(fields{fn}).pxz_st;
    % t-based
    fits_grf.(fields{fn}).ptx_sw = meanGRF.(fields{fn}).ptx_sw;
    fits_grf.(fields{fn}).pty_sw = meanGRF.(fields{fn}).pty_sw;
    fits_grf.(fields{fn}).ptz_sw = meanGRF.(fields{fn}).ptz_sw;
    fits_grf.(fields{fn}).ptx_st = meanGRF.(fields{fn}).ptx_st;
    fits_grf.(fields{fn}).pty_st = meanGRF.(fields{fn}).pty_st;
    fits_grf.(fields{fn}).ptz_st = meanGRF.(fields{fn}).ptz_st;
end
% also add the sine fit for normal walking
fits_q0.exp00.sxy = xysol;
fits_q0.exp00.sty = tysol;

save('fits.mat','fits')
save('fits_q0.mat','fits_q0')
save('avg_val.mat','avg_val')
save('fits_grf.mat','fits_grf')


%% Swing foot trajectory
figure; hold on; grid on;
for i = 1:8
    zC = data.exp00{i}.IK.zeroCrossing;
    time     = data.exp00{i}.IK.values(zC(1):zC(2),1);
    calcn_sw = data.exp00{i}.IK.valuesCoM(zC(1):zC(2),[7 9 11]);
    calcn_st = data.exp00{i}.IK.valuesCoM(zC(1):zC(2),[8 10 12]);
    
    plot(time,calcn_st(:,1))
%     plot(time,calcn_st(:,2))
%     plot(time,calcn_st(:,3))
end

zC = data.exp00{i}.IK.zeroCrossing;
calcn_st = data.exp00{1}.IK.valuesCoM(zC(1):zC(2),8);
time = data.exp00{i}.IK.values(zC(1):zC(2),1);

fun = @(p) norm( (calcn_st(:) - ((1 - p(1).*exp(-p(2).*time))./(1 + p(3)*exp(-p(4).*time)) + p(5)) ) );
p0 = [1 2 1 2 1];
p = fmincon(fun,p0);

figure; hold on; grid on;
plot(time,calcn_st)
plot(time,((1 - p(1).*exp(-p(2).*time))./(1 + p(3)*exp(-p(4).*time)) + p(5)))


% cvx_begin quiet
%     variables A B C D E
%     
%     hyptan = (1 - A*exp(-B.*time))./(1 + C*exp(-D.*time)) + E;
%     minimize( norm(hyptan - calcn_sw) )
% cvx_end

%% helper functions
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

function [xinterp,yinterp,zinterp,tinterp] = interpolateWide(x,y,z,t,run)
    % get index of run that contains takes the most time
    idx = 0;
    minVal = 10;
    for i = 1:length(t)
        if max(t{i}) < minVal
            minVal = max(t{i});
            idx = i;
        end
    end
    tinterp = t{idx};
    
    % interpolate x
    maxdiff = inf;
    considered = 1:length(x);
    while maxdiff > 0.05
        xInterp = [];
        for i = considered
            xInterp = [xInterp interp1(t{i},x{i},tinterp)];
        end
        xinterp = mean(xInterp,2,'omitnan');
        diff = abs(xInterp-xinterp);
        [valRow,~] = max(diff,[],1);
        [maxdiff,idxCol] = max(valRow);
        
        considered(idxCol) = [];
    end
    
    % interpolate y
    maxdiff = inf;
    considered = 1:length(y);
    while maxdiff > 0.05
        yInterp = [];
        for i = considered
            yInterp = [yInterp interp1(t{i},y{i},tinterp)];
        end
        yinterp = mean(yInterp,2,'omitnan');
        diff = abs(yInterp-yinterp);
        [valRow,~] = max(diff);
        [maxdiff,idxCol] = max(valRow);
        
        considered(idxCol) = [];
    end
    
    % interpolate z
    maxdiff = inf;
    considered = 1:length(z);
    while maxdiff > 0.05
        zInterp = [];
        for i = considered
            zInterp = [zInterp interp1(t{i},z{i},tinterp)];
        end
        zinterp = mean(zInterp,2,'omitnan');
        diff = abs(zInterp-zinterp);
        [valRow,~] = max(diff);
        [maxdiff,idxCol] = max(valRow);
        
        considered(idxCol) = [];
    end        
end