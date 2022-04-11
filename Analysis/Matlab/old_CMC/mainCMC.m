clear; close all;

load('allDataProcessedVLOCoM.mat')
%% Create arrays of muscle groups
allm = false;
allg = false;
loadGroupsAndMuscles;

%% Through ground, knee flexion, hip flexion muscle activation
swst = {'sw','st'};
leg = swst{1};

colors = {'r','b','c','k','y','m'};
for i = 1:length(groups)
    if groups{i} == "hip_flexion" || groups{i} == "knee_flexion"
        figure
        subplot(1,3,1); hold on; grid on;
        for ii = 1:8
            for m = 1:length(muscles{i})
                idx = getIdxStates(data,strcat('/forceset/',muscles{i}{m},leg,'/activation'));
                belowGround = data.exp25{ii}.CMC.belowGround;
                xGait = 0:1:length(data.exp25{ii}.CMC.valuesStates)-1;
                
                plot(xGait-belowGround,data.exp25{ii}.CMC.valuesStates(:,idx),colors{m})
            end
        end
        xline(0)
        title('flat-ground')
        legend(muscles{i},'Interpreter','none')
        set(gca,'FontSize',15)
        
        subplot(1,3,2); hold on; grid on;
        for ii = 1:8
            for m = 1:length(muscles{i})
                idx = getIdxStates(data,strcat('/forceset/',muscles{i}{m},leg,'/activation'));
                belowGround = data.exp100{ii}.CMC.belowGround;
                xGait = 0:1:length(data.exp100{ii}.CMC.valuesStates)-1;
                
                plot(xGait-belowGround,data.exp100{ii}.CMC.valuesStates(:,idx),colors{m})
            end
        end
        xline(0)
        title('expected 100mm')
        legend(muscles{i},'Interpreter','none')
        set(gca,'FontSize',15)
        
        subplot(1,3,3); hold on; grid on;
        for ii = 1:6
            for m = 1:length(muscles{i})
                idx = getIdxStates(data,strcat('/forceset/',muscles{i}{m},leg,'/activation'));
                belowGround = data.unexp100{ii}.CMC.belowGround;
                xGait = 0:1:length(data.unexp100{ii}.CMC.valuesStates)-1;
                
                plot(xGait-belowGround,data.unexp100{ii}.CMC.valuesStates(:,idx),colors{m})
            end
        end
        xline(0)
        title('unexpected 100mm')
        legend(muscles{i},'Interpreter','none')
        set(gca,'FontSize',15)
        
        
        linkaxes
        sgtitle(strcat("Muscle activation ",groups{i}," swing"), 'Interpreter', 'none')
        pause(0.5);
    end
end

%% individual runs
swst = {'sw','st'};
leg = swst{2};

colors = {'r','b','c','k','y','m'};
for i = 1:length(groups)
    figure
    subplot(1,3,1); hold on; grid on;
    for ii = 1:8
        zeroCrossing = data.exp00{ii}.CMC.zeroCrossing;
        for m = 1:length(muscles{i})
            idx = getIdxStates(data,strcat('/forceset/',muscles{i}{m},leg,'/activation'));
            plot(data.exp00{ii}.CMC.valuesStates(zeroCrossing(1):zeroCrossing(2),idx),colors{m})
        end
        title('flat-ground','Interpreter','none')
        legend(muscles{i},'Interpreter','none')
        set(gca,'FontSize',15)
    end
    
    subplot(1,3,2); hold on; grid on;
    for ii = 1:8
        zeroCrossing = data.exp100{ii}.CMC.zeroCrossing;
        for m = 1:length(muscles{i})
            idx = getIdxStates(data,strcat('/forceset/',muscles{i}{m},leg,'/activation'));
            plot(data.exp100{ii}.CMC.valuesStates(zeroCrossing(1):zeroCrossing(2),idx),colors{m})
        end
        title('expected 100mm','Interpreter','none')
        legend(muscles{i},'Interpreter','none')
        set(gca,'FontSize',15)
    end
    
    subplot(1,3,3); hold on; grid on;
    for ii = 1:6
        zeroCrossing = data.unexp100{ii}.CMC.zeroCrossing;
        for m = 1:length(muscles{i})
            idx = getIdxStates(data,strcat('/forceset/',muscles{i}{m},leg,'/activation'));
            plot(data.unexp100{ii}.CMC.valuesStates(zeroCrossing(1):zeroCrossing(2),idx),colors{m})
        end
        title('unexpected 100mm','Interpreter','none')
        legend(muscles{i},'Interpreter','none')
        set(gca,'FontSize',15)
    end
    
    
    linkaxes
    sgtitle(strcat("Muscle activation ",groups{i}," ",leg), 'Interpreter', 'none')
    pause(0.5);
end

%% some preliminary plotting ACTIVATION
swst = {'sw','st'};

leg = swst{1};
for i = 1:length(groups)
    figure
    subplot(1,3,1); hold on; grid on;
    xGait = data.exp00{1}.CMC.xGait;
    zeroCrossingT = data.exp00{1}.IK.zeroCrossingT;
    Td_percentage = (data.exp00{1}.IK.touchDownT - zeroCrossingT(1))/(zeroCrossingT(2)-zeroCrossingT(1))*100;
    for m = 1:length(muscles{i})
        idx = getIdxStates(data,strcat('/forceset/',muscles{i}{m},leg,'/activation'));
        plot(xGait,data.exp00{1}.CMC.valuesStatesMean(:,idx),'b')
        plot(xGait,data.exp00{1}.CMC.valuesStatesMean(:,idx)+data.exp00{1}.CMC.valuesStatesMean(:,idx),'r')
        plot(xGait,data.exp00{1}.CMC.valuesStatesMean(:,idx)-data.exp00{1}.CMC.valuesStatesMean(:,idx),'r')
    end
    xline(Td_percentage)
    title('flat-ground','Interpreter','none')
    legend(muscles{i},'Interpreter','none')
    set(gca,'FontSize',15)
    
    subplot(1,3,2); hold on; grid on;
    xGait = data.exp100{1}.CMC.xGait;
    zeroCrossingT = data.exp100{1}.IK.zeroCrossingT;
    Td_percentage = (data.exp100{1}.IK.touchDownT - zeroCrossingT(1))/(zeroCrossingT(2)-zeroCrossingT(1))*100;
    for m = 1:length(muscles{i})
        idx = getIdxStates(data,strcat('/forceset/',muscles{i}{m},leg,'/activation'));
        plot(xGait,data.exp100{1}.CMC.valuesStatesMean(:,idx),'b')
        plot(xGait,data.exp100{1}.CMC.valuesStatesMean(:,idx)+data.exp100{1}.CMC.valuesStatesMean(:,idx),'r')
        plot(xGait,data.exp100{1}.CMC.valuesStatesMean(:,idx)-data.exp100{1}.CMC.valuesStatesMean(:,idx),'r')
    end
    xline(Td_percentage)
    title('expected 10cm','Interpreter','none')
    legend(muscles{i},'Interpreter','none')
    set(gca,'FontSize',15)
    
    subplot(1,3,3); hold on; grid on;
    xGait = data.unexp100{1}.CMC.xGait;
    zeroCrossingT = data.unexp100{1}.IK.zeroCrossingT;
    Td_percentage = (data.unexp100{1}.IK.touchDownT - zeroCrossingT(1))/(zeroCrossingT(2)-zeroCrossingT(1))*100;
    for m = 1:length(muscles{i})
        idx = getIdxStates(data,strcat('/forceset/',muscles{i}{m},leg,'/activation'));
        plot(xGait,data.unexp100{1}.CMC.valuesStatesMean(:,idx),'b')
        plot(xGait,data.unexp100{1}.CMC.valuesStatesMean(:,idx)+data.unexp100{1}.CMC.valuesStatesMean(:,idx),'r')
        plot(xGait,data.unexp100{1}.CMC.valuesStatesMean(:,idx)-data.unexp100{1}.CMC.valuesStatesMean(:,idx),'r')
    end
    xline(Td_percentage)
    title('unexpected 10cm','Interpreter','none')
    legend(muscles{i},'Interpreter','none')
    set(gca,'FontSize',15)
    
    
    linkaxes
    sgtitle(strcat("Muscle activation ",groups{i}," swing"), 'Interpreter', 'none')
    pause(0.5);
end



leg = swst{2};
for i = 1:length(groups)
    figure
    subplot(1,3,1); hold on; grid on;
    xGait = data.exp00{1}.CMC.xGait;
    zeroCrossingT = data.exp00{1}.IK.zeroCrossingT;
    Td_percentage = (data.exp00{1}.IK.touchDownT - zeroCrossingT(1))/(zeroCrossingT(2)-zeroCrossingT(1))*100;
    for m = 1:length(muscles{i})
        idx = getIdxStates(data,strcat('/forceset/',muscles{i}{m},leg,'/activation'));
        plot(xGait,data.exp00{1}.CMC.valuesStatesMean(:,idx))
    end
    xline(Td_percentage)
    title('flat-ground','Interpreter','none')
    legend(muscles{i},'Interpreter','none')
    set(gca,'FontSize',15)
    
    subplot(1,3,2); hold on; grid on;
    xGait = data.exp100{1}.CMC.xGait;
    zeroCrossingT = data.exp100{1}.IK.zeroCrossingT;
    Td_percentage = (data.exp100{1}.IK.touchDownT - zeroCrossingT(1))/(zeroCrossingT(2)-zeroCrossingT(1))*100;
    for m = 1:length(muscles{i})
        idx = getIdxStates(data,strcat('/forceset/',muscles{i}{m},leg,'/activation'));
        plot(xGait,data.exp100{1}.CMC.valuesStatesMean(:,idx))
    end
    xline(Td_percentage)
    title('expected 10cm','Interpreter','none')
    legend(muscles{i},'Interpreter','none')
    set(gca,'FontSize',15)
    
    subplot(1,3,3); hold on; grid on;
    xGait = data.unexp100{1}.CMC.xGait;
    zeroCrossingT = data.unexp100{1}.IK.zeroCrossingT;
    Td_percentage = (data.unexp100{1}.IK.touchDownT - zeroCrossingT(1))/(zeroCrossingT(2)-zeroCrossingT(1))*100;
    for m = 1:length(muscles{i})
        idx = getIdxStates(data,strcat('/forceset/',muscles{i}{m},leg,'/activation'));
        plot(xGait,data.unexp100{1}.CMC.valuesStatesMean(:,idx))
    end
    xline(Td_percentage)
    title('unexpected 10cm','Interpreter','none')
    legend(muscles{i},'Interpreter','none')
    set(gca,'FontSize',15)
    
    linkaxes
    sgtitle(strcat("Muscle activation ",groups{i}," stance"), 'Interpreter', 'none')
end







% %% some preliminary plotting EXCITATION
% for i = 1:length(groups)
%     figure
%     subplot(1,3,1); hold on; grid on;
%     xGait = data.exp00{1}.CMC.xGait;
%     for m = 1:length(muscles{i})
%         idx = getIdxControls(data,strcat(muscles{i}{m},leg));
%         plot(xGait,data.exp00{1}.CMC.valuesControlsMean(:,idx))
%     end
%     title(groups{i},'Interpreter','none')
%     legend(muscles{i},'Interpreter','none')
%     
%     subplot(1,3,2); hold on; grid on;
%     xGait = data.exp100{1}.CMC.xGait;
%     for m = 1:length(muscles{i})
%         idx = getIdxControls(data,strcat(muscles{i}{m},leg));
%         plot(xGait,data.exp100{1}.CMC.valuesControlsMean(:,idx))
%     end
%     title(groups{i},'Interpreter','none')
%     legend(muscles{i},'Interpreter','none')
%     
%     subplot(1,3,3); hold on; grid on;
%     xGait = data.unexp100{1}.CMC.xGait;
%     for m = 1:length(muscles{i})
%         idx = getIdxControls(data,strcat(muscles{i}{m},leg));
%         plot(xGait,data.unexp100{1}.CMC.valuesControlsMean(:,idx))
%     end
%     title(groups{i},'Interpreter','none')
%     legend(muscles{i},'Interpreter','none')
%     linkaxes
% end
% 
% %% force and power per group EXCITATION
% for i = 1:length(groups)
%     figure
%     subplot(1,3,1); hold on; grid on;
%     xGait = data.exp00{1}.CMC.xGait;
%     force = 0; power = 0;
%     for m = 1:length(muscles{i})
%         idx = getIdxForce(data,strcat(muscles{i}{m},leg));
%         force = force + data.exp00{1}.CMC.valuesForceMean(:,idx);
%         idx = getIdxPower(data,strcat(muscles{i}{m},leg));
%         power = power + data.exp00{1}.CMC.valuesPowerMean(:,idx);
%     end
%     yyaxis left
%     plot(xGait,force)
%     yyaxis right
%     plot(xGait,power)
%     title('exp00')
%     legend({'total force','total power'}, 'Interpreter', 'none')
%     
%     subplot(1,3,2); hold on; grid on;
%     xGait = data.exp100{1}.CMC.xGait;
%     force = 0; power = 0;
%     for m = 1:length(muscles{i})
%         idx = getIdxForce(data,strcat(muscles{i}{m},leg));
%         force = force + data.exp100{1}.CMC.valuesForceMean(:,idx);
%         idx = getIdxPower(data,strcat(muscles{i}{m},leg));
%         power = power + data.exp100{1}.CMC.valuesPowerMean(:,idx);
%     end
%     yyaxis left
%     plot(xGait,force)
%     yyaxis right
%     plot(xGait,power)
%     title('exp100')
%     legend({'total force','total power'}, 'Interpreter', 'none')
%     
%     subplot(1,3,3); hold on; grid on;
%     xGait = data.unexp100{1}.CMC.xGait;
%     force = 0; power = 0;
%     for m = 1:length(muscles{i})
%         idx = getIdxForce(data,strcat(muscles{i}{m},leg));
%         force = force + data.unexp100{1}.CMC.valuesForceMean(:,idx);
%         idx = getIdxPower(data,strcat(muscles{i}{m},leg));
%         power = power + data.unexp100{1}.CMC.valuesPowerMean(:,idx);
%     end
%     yyaxis left
%     plot(xGait,force)
%     yyaxis right
%     plot(xGait,power)
%     title('unexp100')
%     legend({'total force','total power'}, 'Interpreter', 'none')
%     
%     linkaxes
%     sgtitle(groups{i},'Interpreter','none')
% end

% Plot residuals
figure
for i = 100:122
    subplot(1,3,1); hold on; grid on;
    plot(data.exp00{1}.CMC.valuesForce(:,i))
    title('exp00')
    ylabel('Residual force [N/nM]')
    
    subplot(1,3,2); hold on; grid on;
    plot(data.exp100{1}.CMC.valuesForce(:,i))
    title('exp100')
    ylabel('Residual force [N/nM]')
    
    subplot(1,3,3); hold on; grid on;
    plot(data.unexp100{1}.CMC.valuesForce(:,i))
    title('unexp100')
    ylabel('Residual force [N/nM]')

end
legend(data.unexp100{1}.CMC.headersForce(:,100:122),'Interpreter', 'none')

linkaxes
sgtitle('Residuals', 'Interpreter', 'none')

%% Function
function idx = getIdxControls(data,name)
    idx = find(contains(data.exp00{1}.CMC.headersControlsMean,name));
end

function idx = getIdxStates(data,name)
    idx = find(contains(data.exp00{1}.CMC.headersStatesMean,name));
end

function idx = getIdxForce(data,name)
    idx = find(contains(data.exp00{1}.CMC.headersForceMean,name));
end

function idx = getIdxPower(data,name)
    idx = find(contains(data.exp00{1}.CMC.headersPowerMean,name));
end
