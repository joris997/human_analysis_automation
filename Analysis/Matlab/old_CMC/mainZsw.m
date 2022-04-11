clear all; close all;

load('zsw.mat')

figure; 
subplot(1,2,1); hold on; grid on;
plot(zswt,zsw)
plot(zswt,flip(zsw))

idx0 = find(zsw>0.07,1);
idxf = length(zsw) - find(flip(zsw)>0.06,1);

plot(zswt(idx0:idxf),zsw(idx0:idxf))

zsw = zsw(idx0:idxf);
zsw(1) = 0.07;
zsw(end) = 0.06;
zsw = zsw - 0.07;
zswt = zswt(idx0:idxf) - zswt(idx0);

subplot(1,2,2); hold on; grid on;
plot(zswt,zsw)

zswt_norm = zswt/zswt(end);
plot(zswt_norm,zsw)

%% Fit the spline


