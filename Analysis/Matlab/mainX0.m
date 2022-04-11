load('processedIKID.mat')
data = dataIKID;

t = data.exp00{1}.IK.valuesCoM(:,1);
x = data.exp00{1}.IK.valuesCoM(:,122);
dx = data.exp00{1}.IK.dvaluesCoM(:,122);
z = data.exp00{1}.IK.valuesCoM(:,123);
dz = data.exp00{1}.IK.dvaluesCoM(:,123);

figure; 
subplot(2,1,1); hold on; grid on;
plot(t,z)
subplot(2,1,2); hold on; grid on;
plot(t,dx)
