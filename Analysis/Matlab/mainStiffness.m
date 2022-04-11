clear; close all;

load('processedIKID.mat')
data = dataIKID;

%% GRF over L for all experiments
colors = {'r','b','g','c','k'};
fields = fieldnames(data);

GRFMeanExp = [];
LLegMeanExp = [];

cnt = 1;
for fn = [1 2 3 4 5]
    KAll = []; KHeelStrike = []; KFlat = []; KToeOff = [];
    for i = 1:8
        try
            if data.(fields{fn}){i}.IK.rightLegVLO
                idxsGRF = [8 9 10];
                idxsFoot = [56 57 58];
                idxsFootRot = 61;
            else
                idxsGRF = [2 3 4];
                idxsFoot = [26 27 28];
                idxsFootRot = 31;
            end
            idxsPelvis = [2 3 4];

            posPelvis = data.(fields{fn}){i}.IK.valuesCoM(:,idxsPelvis);
            posFoot   = data.(fields{fn}){i}.IK.valuesCoM(:,idxsFoot);
            rotFoot   = data.(fields{fn}){i}.IK.valuesCoM(:,idxsFootRot);
            GRF = data.(fields{fn}){i}.IK.valuesGRF(:,idxsGRF);
            
            FGRF = zeros(length(posPelvis),1);
            LLeg = zeros(length(posPelvis),1);
            for row = 1:length(posPelvis)
                FGRF(row,:) = norm(GRF(row,:));
                LLeg(row,:) = norm(posPelvis(row,:) - posFoot(row,:));
            end

            idxs0 = find(FGRF ~= 0);
            LLeg  = LLeg(idxs0);
            FGRF  = FGRF(idxs0);
            RFoot = rotFoot(idxs0);
            
            idxsFlat       = find(RFoot < 5 & RFoot > -5);
            idxsHeelStrike = 1:idxsFlat(1)-1;
            idxsToeOff     = idxsFlat(end)+1:length(RFoot);
            
            figure(1)
            subplot(2,5,cnt); hold on; grid on;
            plot(LLeg,FGRF,colors{cnt})
            Kp = polyfit(LLeg,FGRF,1);
            K = Kp(1);
            KAll = [KAll; K];
            xmini = 0.78:0.001:0.86;
            ymini = polyval(Kp,xmini);
            plot(xmini,ymini)
            
            figure(2)
            subplot(2,15,1+3*(cnt-1)); hold on; grid on;
            plot(LLeg(idxsHeelStrike),FGRF(idxsHeelStrike),colors{cnt})
            Kp = polyfit(LLeg(idxsHeelStrike),FGRF(idxsHeelStrike),1);
            K = Kp(1);
            KHeelStrike = [KHeelStrike; K];
            xmini = 0.78:0.001:0.86;
            ymini = polyval(Kp,xmini);
            plot(xmini,ymini)
            
            subplot(2,15,1+3*(cnt-1)+1); hold on; grid on;
            plot(LLeg(idxsFlat),FGRF(idxsFlat),colors{cnt})
            Kp = polyfit(LLeg(idxsFlat),FGRF(idxsFlat),1);
            K = Kp(1);
            KFlat = [KFlat; K];
            xmini = 0.78:0.001:0.86;
            ymini = polyval(Kp,xmini);
            plot(xmini,ymini)
            
            subplot(2,15,1+3*(cnt-1)+2); hold on; grid on;
            plot(LLeg(idxsToeOff),FGRF(idxsToeOff),colors{cnt})
            Kp = polyfit(LLeg(idxsToeOff),FGRF(idxsToeOff),1);
            K = Kp(1);
            KToeOff = [KToeOff; K];
            xmini = 0.78:0.001:0.86;
            ymini = polyval(Kp,xmini);
            plot(xmini,ymini)
        end
        stiffnesses.(fields{fn}).All = KAll;
        stiffnesses.(fields{fn}).HeelStrike = KHeelStrike;
        stiffnesses.(fields{fn}).Flat = KFlat;
        stiffnesses.(fields{fn}).ToeOff = KToeOff;
    end
    stiffnesses.(fields{fn}+"mean").All = mean(KAll);
    stiffnesses.(fields{fn}+"mean").HeelStrike = mean(KHeelStrike);
    stiffnesses.(fields{fn}+"mean").Flat = mean(KFlat);
    stiffnesses.(fields{fn}+"mean").ToeOff = mean(KToeOff);
    
    xlabel('Leg length [m]')
    ylabel('|GRF| [N]')
    title(fields{fn})
    cnt = cnt + 1;
end
% linkaxes

% subplot(1,2,2); hold on; grid on;
cnt = 1;
for fn = [1 6 7 8 9]
    % for all experiments, get the proper indices
    KAll = []; KHeelStrike = []; KFlat = []; KToeOff = [];
    for i = 1:8
        try
            if data.(fields{fn}){i}.IK.rightLegVLO
                idxsGRF = [8 9 10];
                idxsFoot = [56 57 58];
                idxsFootRot = 61;
            else
                idxsGRF = [2 3 4];
                idxsFoot = [26 27 28];
                idxsFootRot = 31;
            end
            idxsPelvis = [2 3 4];

            % foot and pelvis position of this 
            posPelvis = data.(fields{fn}){i}.IK.valuesCoM(:,idxsPelvis);
            posFoot   = data.(fields{fn}){i}.IK.valuesCoM(:,idxsFoot);
            rotFoot   = data.(fields{fn}){i}.IK.valuesCoM(:,idxsFootRot);
            GRF = data.(fields{fn}){i}.IK.valuesGRF(:,idxsGRF);
            
            % Get the norm of Force and leg, need to do this in a for loop :(
            FGRF = zeros(length(posPelvis),1);
            LLeg = zeros(length(posPelvis),1);
            for row = 1:length(posPelvis)
                FGRF(row,:) = norm(GRF(row,:));
                LLeg(row,:) = norm(posPelvis(row,:) - posFoot(row,:));
            end
            
            idxs0 = find(FGRF ~= 0);
            LLeg = LLeg(idxs0);
            FGRF = FGRF(idxs0);
            RFoot = rotFoot(idxs0);
            
            idxsFlat       = find(RFoot < 2 & RFoot > -2);
            idxsHeelStrike = 1:idxsFlat(1)-1;
            idxsToeOff     = idxsFlat(end)+1:length(RFoot);
            
            figure(1)
            subplot(2,5,cnt+5); hold on; grid on;
            plot(LLeg,FGRF,colors{cnt})
            Kp = polyfit(LLeg,FGRF,1);
            K = Kp(1);
            KAll = [KAll; K];
            xmini = 0.78:0.001:0.86;
            ymini = polyval(Kp,xmini);
            plot(xmini,ymini)
            
            figure(2)
            subplot(2,15,1+3*(cnt-1)+15); hold on; grid on;
            plot(LLeg(idxsHeelStrike),FGRF(idxsHeelStrike),colors{cnt})
            Kp = polyfit(LLeg(idxsHeelStrike),FGRF(idxsHeelStrike),1);
            K = Kp(1);
            KHeelStrike = [KHeelStrike; K];
            xmini = 0.78:0.001:0.86;
            ymini = polyval(Kp,xmini);
            plot(xmini,ymini)
            
            subplot(2,15,1+3*(cnt-1)+1+15); hold on; grid on;
            plot(LLeg(idxsFlat),FGRF(idxsFlat),colors{cnt})
            Kp = polyfit(LLeg(idxsFlat),FGRF(idxsFlat),1);
            K = Kp(1);
            KFlat = [KFlat; K];
            xmini = 0.78:0.001:0.86;
            ymini = polyval(Kp,xmini);
            plot(xmini,ymini)
            
            subplot(2,15,1+3*(cnt-1)+2+15); hold on; grid on;
            plot(LLeg(idxsToeOff),FGRF(idxsToeOff),colors{cnt})
            Kp = polyfit(LLeg(idxsToeOff),FGRF(idxsToeOff),1);
            K = Kp(1);
            KToeOff = [KToeOff; K];
            xmini = 0.78:0.001:0.86;
            ymini = polyval(Kp,xmini);
            plot(xmini,ymini)
        end
        stiffnesses.(fields{fn}).All = KAll;
        stiffnesses.(fields{fn}).HeelStrike = KHeelStrike;
        stiffnesses.(fields{fn}).Flat = KFlat;
        stiffnesses.(fields{fn}).ToeOff = KToeOff;
    end
    stiffnesses.(fields{fn}+"mean").All = mean(KAll);
    stiffnesses.(fields{fn}+"mean").HeelStrike = mean(KHeelStrike);
    stiffnesses.(fields{fn}+"mean").Flat = mean(KFlat);
    stiffnesses.(fields{fn}+"mean").ToeOff = mean(KToeOff);
    
    xlabel('Leg length [m]')
    ylabel('|GRF| [N]')
    title(fields{fn})
    cnt = cnt + 1;
end
% linkaxes

%% Plot stiffnesses for different trials
colors = {'r','b','g','c','k'};
fields = fieldnames(data);

cnt = 1;
for fn = [1 2 3 4 5]
    figure(10); 
    subplot(1,2,1); hold on; grid on;
    plot(1,stiffnesses.(fields{fn}+"mean").HeelStrike,colors{cnt}+"o",'DisplayName',fields{fn})
    plot(2,stiffnesses.(fields{fn}+"mean").Flat,colors{cnt}+"o",'DisplayName','')
    plot(3,stiffnesses.(fields{fn}+"mean").ToeOff,colors{cnt}+"o",'DisplayName','')
    
    title('Exp00 vs. Exp--')
    ylabel('Stiffness [N/m]')
    xlim([0 4])
    xticks([1 2 3])
    xticklabels({'Heelstrike','Flat','ToeOff'})
    legend(gca,'show')
    
    cnt = cnt + 1;
end

cnt = 1;
for fn = [1 6 7 8 9]
    figure(10); 
    subplot(1,2,2); hold on; grid on;
    plot(1,stiffnesses.(fields{fn}+"mean").HeelStrike,colors{cnt}+"o",'DisplayName',fields{fn})
    plot(2,stiffnesses.(fields{fn}+"mean").Flat,colors{cnt}+"o",'DisplayName','')
    plot(3,stiffnesses.(fields{fn}+"mean").ToeOff,colors{cnt}+"o",'DisplayName','')
    
    title('Exp00 vs. UnExp--')
    ylabel('Stiffness [N/m]')
    xlim([0 4])
    xticks([1 2 3])
    xticklabels({'Heelstrike','Flat','ToeOff'})
    legend(gca,'show')

    cnt = cnt + 1;
end
linkaxes

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
    idx = find(contains(data.exp00{1}.IK.headersCoM,name));
end

function idx = getIdxDyn(data,name)
    idx = find(contains(data.exp00{1}.ID.headersDyn,name));
end

function idx = getIdxGRF(data,name)
    idx = find(contains(data.exp00{1}.IK.headersGRF,name));
end


%% Compare individual and mean results of GRF
% figure
% fields = fieldnames(data);
% trials = [1 2 3 4 5 1 6 7 8 9];
% 
% figure
% cnt = 1;
% for fn = trials
%     % normal walking
%     subplot(2,length(trials)/2,cnt); hold on; grid on;
%     for i = 1:6
%             if data.(fields{fn}){i}.IK.rightLegVLO
%                 idxsGRF = [8 9 10];
%                 idxsFoot = [56 57 58];
%             else
%                 idxsGRF = [2 3 4];
%                 idxsFoot = [26 27 28];
%             end
%             idxsPelvis = [2 3 4];
% 
%             posPelvis = data.(fields{fn}){i}.IK.valuesCoM(:,idxsPelvis);
%             posFoot   = data.(fields{fn}){i}.IK.valuesCoM(:,idxsFoot);
%     
%             for row = 1:length(posPelvis)
%                 LLeg(row,:) = norm(posPelvis(row,:));
%             end
% %             plot(LLeg,'r')
%             plot(posPelvis(:,1),'r')
%             plot(posPelvis(:,2),'b')
%             plot(posPelvis(:,3),'c')
%     end
%     
%     idxsGRFMean = [2 4 6];
%     idxsFootMean = [7 9 11];
%     idxsPelvisMean = [1 2 3];
% 
% %     for row = 1:length(data.(fields{fn}){1}.IK.valuesGRFMean)
%     posPelvis = data.(fields{fn}){i}.IK.valuesCoM(:,idxsPelvisMean);
%     posFoot   = data.(fields{fn}){i}.IK.valuesCoM(:,idxsFootMean);
%     for row = 1:230
%         LLeg(row,:) = norm(posPelvis(row,:));
%     end
%     plot(LLeg,'b')
%         
%     plot(posPelvis(:,1),'r--')
%     plot(posPelvis(:,2),'b--')
%     plot(posPelvis(:,3),'c--')
%     
%     title(fields{fn})
%     xlabel('idx [-]')
%     ylabel('leg length [m]')
%     
%     cnt = cnt + 1;
% end
% linkaxes
% 
% figure
% cnt = 1;
% for fn = trials
%     % normal walking
%     subplot(2,length(trials)/2,cnt); hold on; grid on;
%     for i = 1:6
%             if data.(fields{fn}){i}.IK.rightLegVLO
%                 idxsGRF = [8 9 10];
%                 idxsFoot = [56 57 58];
%             else
%                 idxsGRF = [2 3 4];
%                 idxsFoot = [26 27 28];
%             end
%             idxsPelvis = [2 3 4];
% 
%             posPelvis = data.(fields{fn}){i}.IK.valuesCoM(:,idxsPelvis);
%             posFoot   = data.(fields{fn}){i}.IK.valuesCoM(:,idxsFoot);
%     
%             for row = 1:length(posFoot)
%                 LLeg(row,:) = norm(posFoot(row,:));
%             end
% %             plot(LLeg,'r')
%             plot(posFoot(:,1),'r')
%             plot(posFoot(:,2),'b')
%             plot(posFoot(:,3),'c')
%     end
%     
%     idxsGRFMean = [2 4 6];
%     idxsFootMean = [7 9 11];
%     idxsPelvisMean = [1 2 3];
% 
% %     for row = 1:length(data.(fields{fn}){1}.IK.valuesGRFMean)
%     posPelvis = data.(fields{fn}){i}.IK.valuesCoM(:,idxsPelvisMean);
%     posFoot   = data.(fields{fn}){i}.IK.valuesCoM(:,idxsFootMean);
%     for row = 1:230
%         LLeg(row,:) = norm(posFoot(row,:));
%     end
% %     plot(LLeg,'b')
%     plot(posFoot(:,1),'r--')
%     plot(posFoot(:,2),'b--')
%     plot(posFoot(:,3),'c--')
%             
%     title(fields{fn})
%     xlabel('idx [-]')
%     ylabel('leg length [m]')
%     
%     cnt = cnt + 1;
% end
% linkaxes


% %% GRF over L for Mean
% colors = {'r','b','g','c','p'};
% figure
% fields = fieldnames(data);
% 
% subplot(1,2,1); hold on; grid on;
% cnt = 1;
% trials = [1 2 3 4 5];
% for fn = trials
%     idxsGRF = [2 4 6];
%     idxsFoot = [7 9 11];
%     idxsPelvis = [1 2 3];
% 
%     posPelvis = data.(fields{fn}){1}.IK.valuesCoMMean(:,idxsPelvis);
%     posFoot   = data.(fields{fn}){1}.IK.valuesCoMMean(:,idxsFoot);
% 
%     FGRF = zeros(length(posPelvis),1);
%     LLeg = zeros(length(posPelvis),1);
%     for row = 1:length(posPelvis)
%         FGRF(row,:) = norm(data.(fields{fn}){1}.IK.valuesGRFMean(row,idxsGRF));
%         LLeg(row,:) = norm(posPelvis(row,:) - posFoot(row,:));
%     end
%     plot(LLeg(1:230),FGRF(1:230))
% %     plot(FGRF(1:230))
% %     plot(LLeg(1:230))
%     
%     xlabel('Leg length [m]')
%     ylabel('|GRF| [N]')
%     cnt = cnt + 1;
% end
% legend(fields(trials))
% 
% subplot(1,2,2); hold on; grid on;
% cnt = 1;    % a count for the colors
% trials = [1 6 7 8 9];
% for fn = trials
%     idxsGRF = [2 4 6];
%     idxsFoot = [7 9 11];
%     idxsPelvis = [1 2 3];
% 
%     posPelvis = data.(fields{fn}){1}.IK.valuesCoMMean(:,idxsPelvis);
%     posFoot   = data.(fields{fn}){1}.IK.valuesCoMMean(:,idxsFoot);
% 
%     FGRF = zeros(length(posPelvis),1);
%     LLeg = zeros(length(posPelvis),1);
%     for row = 1:length(posPelvis)
%         FGRF(row,:) = norm(data.(fields{fn}){1}.IK.valuesGRFMean(row,idxsGRF));
%         LLeg(row,:) = norm(posPelvis(row,:) - posFoot(row,:));
%     end
%     plot(LLeg(1:230),FGRF(1:230))
%     startIdx = find(FGRF>0,1);
%     endIdx = find(FGRF(startIdx:230)==0,1)+startIdx;
%     plot(LLeg(startIdx),FGRF(startIdx),'go')
%     plot(LLeg(endIdx),FGRF(endIdx),'ro')
% %     plot(FGRF(1:230))
% %     plot(LLeg(1:230))
%     
%     xlabel('Leg length [m]')
%     ylabel('|GRF| [N]')
%     cnt = cnt + 1;
% end
% legend(fields(trials))