load('processedIKID.mat')
data = dataIKID;

%% Let's go
fields = fieldnames(data);
meanStepSizes = zeros(1,length(fields));
SDStepSizes   = zeros(1,length(fields));

for fn = 1:length(fields)
    stanceLegPosArray = zeros(1,8);
    swingLegPosArray  = zeros(1,8);
    for ii = 1:length(data.(fields{fn}))
        datai = data.(fields{fn}){ii}.IK;
        % Get the CoM index of the stance and the swing leg. This is
        % dependent on the initial stance leg (at VLO)
        if datai.rightLegVLO
            stanceLeg = getIdxCoM(datai,'toes_r_X');
            swingLeg = getIdxCoM(datai,'toes_l_X');
        else
            stanceLeg = getIdxCoM(datai,'toes_l_X');
            swingLeg = getIdxCoM(datai,'toes_r_X');
        end
        
        % Then use the eventArray to detect the mean x-position of the feet
        % in succession
        try
            eA = datai.eventArray;
            stanceLegPosArray(ii) = datai.valuesCoM(eA(1),stanceLeg);
            swingLegPosArray(ii)  = mean(datai.valuesCoM(eA(2):eA(4),swingLeg));
        catch
            stanceLegPosArray(ii) = 0;
            swingLegPosArray(ii) = 0;
        end
    end
    stanceLegPosArray = nonzeros(stanceLegPosArray);
    swingLegPosArray  = nonzeros(swingLegPosArray);
    
    meanStepSizes(fn) = mean(swingLegPosArray - stanceLegPosArray);
    SDStepSizes(fn) = std(swingLegPosArray - stanceLegPosArray);
end

figure; 
subplot(1,2,1); hold on; grid on;
b = bar(meanStepSizes([1,2:5]));
b.FaceColor = 'flat';
b.CData(1,:) = [.5 0 .2];
ylim([0.70 0.95])
ylabel('Step-size [m]')
set(gca,'FontSize',13,...
        'XTickLabels',{'flat','exp25','exp50','exp75','exp100'},...
        'XTickLabelRotation',45);
for k1 = 1:5
    errorbar(k1,meanStepSizes(k1),SDStepSizes(k1),'.k','LineWidth',2)
end
title('Expected down-steps')

subplot(1,2,2); hold on; grid on;
b = bar(meanStepSizes([1,6:9]));
b.FaceColor = 'flat';
b.CData(1,:) = [.5 0 .2];
ylim([0.70 0.95])
% ax = gca;
ylabel('Step-size [m]')
set(gca,'FontSize',13,...
        'XTickLabels',{'flat','unexp25','unexp50','unexp75','unexp100'},...
        'XTickLabelRotation',45);
title('Unexpected down-steps')

errorbar(1,meanStepSizes(1),SDStepSizes(1),'.k','LineWidth',2)
for k1 = 6:9
    errorbar(k1-4,meanStepSizes(k1),SDStepSizes(k1),'.k','LineWidth',2)
end

%% Helper functions
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
    idx = find(contains(data.headersCoM,name));
end

function idx = getIdxDyn(data,name)
    idx = find(contains(data.exp00{1}.ID.headersDyn,name));
end