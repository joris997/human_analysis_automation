clear; 
% close all;

load('processedIKID.mat')
data = dataIKID;

fs = 18;
lw = 3;

idxX = getIdxCoM(data,'center_of_mass_X');
idxY = getIdxCoM(data,'center_of_mass_Y');
idxZ = getIdxCoM(data,'center_of_mass_Z');

%% get the approximated mean of all the trials for each experiment
idxs.exp00  = [1 3;  1 4;  1 3;  1 4;  3 5;  1 3;  2 6;  1 4];
idxs.exp25  = [1 3;  1 3;  1 4;  1 3;  1 4;  1 4;  1 3;  1 3];
idxs.exp50  = [3 6;  1 3;  2 4;  2 4;  2 5;  2 4;  2 5;  4 6];
idxs.exp75  = [2 4;  1 4;  2 4;  1 3;  1 3;  2 5;  3 5;  1 3];
idxs.exp100 = [1 3;  2 4;  3 6;  2 5;  1 3;  1 3;  2 4;  2 4];

idxs.unexp25  = [2 6;  2 6;  1 4;  1 4;  1 4;  2 6;  1 4;  1 4];
idxs.unexp50  = [1 3;  1 3;  1 3;  2 4;  1 3;  2 5;  1 5;  1 3];
idxs.unexp75  = [1 5;  2 4;  1 4;  1 4;  1 6;  2 7;  2 4;  1 4];
idxs.unexp100 = [2 5;  1 3;  1 4;  2 5;  1 4;  1 4;  1 4;  1 3];


clearvars x y z t dx dy dz ddx ddy ddz
fields = fieldnames(data);
for fn = 1:length(fields)
    numFields = length(data.(fields{fn}));
    
%     figure; hold on; grid on;
    for i = 1:numFields
        zeroCrossingT = data.(fields{fn}){i}.IK.zeroCrossingT;
        [pkv,pki] = findpeaks(data.(fields{fn}){i}.IK.valuesCoM(:,idxY),...
                              'MinPeakHeight',0.5);
        
        idx0 = idxs.(fields{fn})(i,1);
        idxf = idxs.(fields{fn})(i,2);
        
        t0 = pki(idx0);
        tf = pki(idxf);

%         clf
%         hold on; grid on;
%         plot(data.(fields{fn}){i}.IK.valuesCoM(:,idxY))
%         plot(pki,0.87*ones(size(pki)),'ro');

        x{i} = data.(fields{fn}){i}.IK.valuesCoM(t0:tf,idxX)-data.(fields{fn}){i}.IK.valuesCoM(t0,idxX);
        y{i} = data.(fields{fn}){i}.IK.valuesCoM(t0:tf,idxY);%-data.(fields{fn}){i}.IK.valuesCoM(t0,idxY);
        z{i} = data.(fields{fn}){i}.IK.valuesCoM(t0:tf,idxZ);%-data.(fields{fn}){i}.IK.valuesCoM(t0,idxZ);
        t{i} = data.(fields{fn}){i}.IK.values(t0:tf,1)-data.(fields{fn}){i}.IK.values(t0,1);
        
        dx{i} = data.(fields{fn}){i}.IK.dvaluesCoM(t0:tf,idxX);
        dy{i} = data.(fields{fn}){i}.IK.dvaluesCoM(t0:tf,idxY);
        dz{i} = data.(fields{fn}){i}.IK.dvaluesCoM(t0:tf,idxZ);
        
        ddx{i} = data.(fields{fn}){i}.IK.ddvaluesCoM(t0:tf,idxX);
        ddy{i} = data.(fields{fn}){i}.IK.ddvaluesCoM(t0:tf,idxY);
        ddz{i} = data.(fields{fn}){i}.IK.ddvaluesCoM(t0:tf,idxZ);
%         plot(y{i})
    end
%     title(fields{fn})

    
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

    meanCoM.(fields{fn}).pxddx = polyfit(meanCoM.(fields{fn}).x,...
                                         meanCoM.(fields{fn}).ddx,order);
    meanCoM.(fields{fn}).pxddy = polyfit(meanCoM.(fields{fn}).x,...
                                         meanCoM.(fields{fn}).ddy,order);
end

%% IROS FIGURES
% colors = [0 0.4470 0.7410;
%           0.8500 0.3250 0.0980;
%           0.9290 0.6940 0.1250;
%           0.4940 0.1840 0.5560;
%           0.4660 0.6740 0.1880;
%           0.3010 0.7450 0.9330;
%           0.6350 0.0780 0.1840];
colors = [0 0 1;
          0 0 1;
          0 0 1;
          0 0 1;
          0 0 1;
          0 0 1;
          0 0 1];
alphas = [1.0 0.8 0.6 0.4 0.2];

bodyMass = 66.135;
bodyWeight = 9.81*bodyMass;
meanHeight = 0.8933;
           
figure
subplot(2,2,1); hold on; grid on;
cnt = 1;
for fn = [1 2 3 4 5]
    plot(meanCoM.(fields{fn}).t,meanCoM.(fields{fn}).y./meanHeight,'Color',[colors(cnt,:) alphas(cnt)],'LineWidth',lw);
    cnt = cnt + 1;
end
ylim([0.8 1.05])
ylabel('$z_{CoM}/\bar{z}_{CoM}$ (-)','interpreter','latex')
title('Expected','interpreter','latex')
set(gca,'FontSize',fs)

subplot(2,2,2); hold on; grid on;
cnt = 1;
for fn = [1 6 7 8 9]
    s = plot(meanCoM.(fields{fn}).t,meanCoM.(fields{fn}).y./meanHeight,'Color',[colors(cnt,:) alphas(cnt)],'LineWidth',lw);
%     alpha(s,alphas(cnt))
    cnt = cnt + 1;
end
ylim([0.8 1.05])
title('Unexpected','interpreter','latex')
set(gca,'FontSize',fs)


load('processedIKID.mat')
data = dataIKID;
subplot(2,2,3); hold on; grid on;
cnt = 1;
for fn = [1 2 3 4 5]
    xData = linspace(0,meanCoM.(fields{fn}).t(end),length(data.(fields{fn}){1}.IK.valuesGRFMean(:,3)));
    plot(xData,data.(fields{fn}){1}.IK.valuesGRFMean(:,3)./bodyWeight,'Color',[colors(cnt,:) alphas(cnt)],'LineWidth',lw)
    plot(xData,data.(fields{fn}){1}.IK.valuesGRFMean(:,4)./bodyWeight,'Color',[colors(cnt,:) alphas(cnt)],'LineWidth',lw)
    cnt = cnt + 1;
end
ylim([0 3])
xlabel('t(s)','interpreter','latex')
ylabel('$F_z/BW$ (-)','interpreter','latex')
set(gca,'FontSize',fs)

subplot(2,2,4); hold on; grid on;
cnt = 1;
for fn = [1 6 7 8 9]
    xData = linspace(0,meanCoM.(fields{fn}).t(end),length(data.(fields{fn}){1}.IK.valuesGRFMean(:,3)));
    plot(xData,data.(fields{fn}){1}.IK.valuesGRFMean(:,3)./bodyWeight,'Color',[colors(cnt,:) alphas(cnt)],'LineWidth',lw)
    plot(xData,data.(fields{fn}){1}.IK.valuesGRFMean(:,4)./bodyWeight,'Color',[colors(cnt,:) alphas(cnt)],'LineWidth',lw)
    cnt = cnt + 1;
end
ylim([0 3])
xlabel('t(s)','interpreter','latex')
lgnd = legend('0.0','2.5','5.0','7.5','10.0','Interpreter','latex');
lgnd.Orientation = 'horizontal';
set(gca,'FontSize',fs)


%% ANGULAR MOMENTUM AROUND STANCE
f = figure;
f.Position = [100 100 1800 500];

subplot(1,3,1); hold on; grid on;
zC = data.exp00{1}.IK.zeroCrossing;
zCT = data.exp00{1}.IK.zeroCrossingT;
ev = data.exp00{1}.IK.eventArray;
evT = data.exp00{1}.IK.eventArrayT;
ang_R_x = data.exp00{1}.IK.valuesHMean(:,1)./bodyMass;
ang_L_x = data.exp00{1}.IK.valuesHMean(:,2)./bodyMass;
time = data.exp00{1}.IK.values(zC(1):zC(2),1);
xline(evT(1))
xline(evT(2))
xline(evT(3))
xline(evT(4))
xline(evT(5))
xline(evT(6))
% stance leg: VLO -> TD
plot(time(1:ev(2)-zC(1)),ang_R_x(1:ev(2)-zC(1)),'b','LineWidth',lw)
% DSP: TD -> LO
plot(time(ev(2)-zC(1):ev(3)-zC(1)),ang_R_x(ev(2)-zC(1):ev(3)-zC(1)),'b','LineWidth',lw)
plot(time(ev(2)-zC(1):ev(3)-zC(1)),ang_L_x(ev(2)-zC(1):ev(3)-zC(1)),'r','LineWidth',lw)
% stance leg: LO -> TD
plot(time(ev(3)-zC(1):ev(4)-zC(1)),ang_L_x(ev(3)-zC(1):ev(4)-zC(1)),'r','LineWidth',lw)
% DSP: TD -> LO
plot(time(ev(4)-zC(1):ev(5)-zC(1)),ang_R_x(ev(4)-zC(1):ev(5)-zC(1)),'b','LineWidth',lw)
plot(time(ev(4)-zC(1):ev(5)-zC(1)),ang_L_x(ev(4)-zC(1):ev(5)-zC(1)),'r','LineWidth',lw)
% stance leg: LO -> VLO
plot(time(ev(5)-zC(1):end),ang_R_x(ev(5)-zC(1):end),'b','LineWidth',lw)
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
% ylim([30 55])
ylim([0.5 0.8])
xlabel('t (s)','interpreter','latex')
% ylabel('L (kg m/s)','interpreter','latex')
ylabel('$\bar{L}$ (m/s)','interpreter','latex')
title('Flat-ground','interpreter','latex')
set(gca,'FontSize',fs)

subplot(1,3,2); hold on; grid on;
zC = data.exp100{1}.IK.zeroCrossing;
zCT = data.exp100{1}.IK.zeroCrossingT;
ev = data.exp100{1}.IK.eventArray;
evT = data.exp100{1}.IK.eventArrayT;
ang_R_x = data.exp100{1}.IK.valuesHMean(:,1)./bodyMass;
ang_L_x = data.exp100{1}.IK.valuesHMean(:,2)./bodyMass;
time = data.exp00{1}.IK.values(zC(1):zC(2),1);
xline(evT(1))
xline(evT(2))
xline(evT(3))
xline(evT(4))
xline(evT(5))
xline(evT(6))
% stance leg: VLO -> TD
plot(time(1:ev(2)-zC(1)),ang_R_x(1:ev(2)-zC(1)),'b','LineWidth',lw)
% DSP: TD -> LO
plot(time(ev(2)-zC(1):ev(3)-zC(1)),ang_R_x(ev(2)-zC(1):ev(3)-zC(1)),'b','LineWidth',lw)
plot(time(ev(2)-zC(1):ev(3)-zC(1)),ang_L_x(ev(2)-zC(1):ev(3)-zC(1)),'r','LineWidth',lw)
% stance leg: LO -> TD
plot(time(ev(3)-zC(1):ev(4)-zC(1)),ang_L_x(ev(3)-zC(1):ev(4)-zC(1)),'r','LineWidth',lw)
% DSP: TD -> LO
plot(time(ev(4)-zC(1):ev(5)-zC(1)),ang_R_x(ev(4)-zC(1):ev(5)-zC(1)),'b','LineWidth',lw)
plot(time(ev(4)-zC(1):ev(5)-zC(1)),ang_L_x(ev(4)-zC(1):ev(5)-zC(1)),'r','LineWidth',lw)
% stance leg: LO -> VLO
plot(time(ev(5)-zC(1):end),ang_R_x(ev(5)-zC(1):end),'b','LineWidth',lw)
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
% ylim([30 55])
ylim([0.5 0.8])
xlabel('t (s)','interpreter','latex')
% ylabel('L (kg m/s)','interpreter','latex')
ylabel('$\bar{L}$ (m/s)','interpreter','latex')
title('Expected 10cm','interpreter','latex')
set(gca,'FontSize',fs)

subplot(1,3,3); hold on; grid on;
zC = data.unexp100{1}.IK.zeroCrossing;
zCT = data.unexp100{1}.IK.zeroCrossingT;
ev = data.unexp100{1}.IK.eventArray;
evT = data.unexp100{1}.IK.eventArrayT;
ang_R_x = data.unexp100{1}.IK.valuesHMean(:,1)./bodyMass;
ang_L_x = data.unexp100{1}.IK.valuesHMean(:,2)./bodyMass;
time = data.exp00{1}.IK.values(zC(1):zC(2),1);
xline(evT(1))
xline(evT(2))
xline(evT(3))
xline(evT(4))
xline(evT(5))
xline(evT(6))
% stance leg: VLO -> TD
plot(time(1:ev(2)-zC(1)),ang_R_x(1:ev(2)-zC(1)),'b','LineWidth',lw)
% DSP: TD -> LO
plot(time(ev(2)-zC(1):ev(3)-zC(1)),ang_R_x(ev(2)-zC(1):ev(3)-zC(1)),'b','LineWidth',lw)
plot(time(ev(2)-zC(1):ev(3)-zC(1)),ang_L_x(ev(2)-zC(1):ev(3)-zC(1)),'r','LineWidth',lw)
% stance leg: LO -> TD
plot(time(ev(3)-zC(1):ev(4)-zC(1)),ang_L_x(ev(3)-zC(1):ev(4)-zC(1)),'r','LineWidth',lw)
% DSP: TD -> LO
plot(time(ev(4)-zC(1):ev(5)-zC(1)),ang_R_x(ev(4)-zC(1):ev(5)-zC(1)),'b','LineWidth',lw)
plot(time(ev(4)-zC(1):ev(5)-zC(1)),ang_L_x(ev(4)-zC(1):ev(5)-zC(1)),'r','LineWidth',lw)
% stance leg: LO -> VLO
plot(time(ev(5)-zC(1):end),ang_R_x(ev(5)-zC(1):end),'b','LineWidth',lw)
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
% ylim([30 55])
ylim([0.5 0.8])
xlabel('t (s)','interpreter','latex')
% ylabel('L (kg m/s)','interpreter','latex')
ylabel('$\bar{L}$ (m/s)','interpreter','latex')
title('Unexpected 10cm','interpreter','latex')
set(gca,'FontSize',fs)

linkaxes

ax = gca;

exportgraphics(ax,'angular_momentum.eps')

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