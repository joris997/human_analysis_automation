clear all; close all;

load('processedIKID.mat')
data = dataIKID;

%% Plot human walker and GRF direction (VPP)
fieldnames = fields(data);
for fn = 1:length(fieldnames)
    field = fieldnames{fn};
    for ii = 1:8

        if fn == 9 && ii == 2
            datai = data.(field){ii}.IK;
            for it = 1:size(datai.valuesCoM,1)-1
                GRFR = datai.valuesGRF(it,[2 3 4]);
                GRFL = datai.valuesGRF(it,[8 9 10]);

%                 figure; hold on; grid on;
%                 plot(datai.valuesGRF(:,[2 3 4]));
%                 plot(datai.valuesGRF(:,[8 9 10]));
%                 legend('rx','ry','rz','lx','ly','lz')
                
                headerBodies = datai.headersCoM;
                posBodies    = datai.valuesCoM(it,:);
                plotSkeleton(posBodies,headerBodies,GRFL,GRFR)
            end
        end
    end
end

% %% Main functions
function plotSkeleton(posBodies,headerBodies,GRFL, GRFR)
    pelvis = getBodyCoord(posBodies,headerBodies,"pelvis");
    femur_r = getBodyCoord(posBodies,headerBodies,"femur_r");
    femur_l = getBodyCoord(posBodies,headerBodies,"femur_l");
    tibia_r = getBodyCoord(posBodies,headerBodies,"tibia_r");
    tibia_l = getBodyCoord(posBodies,headerBodies,"tibia_l");
    calcn_r = getBodyCoord(posBodies,headerBodies,"calcn_r");
    calcn_l = getBodyCoord(posBodies,headerBodies,"calcn_l");
    toes_r = getBodyCoord(posBodies,headerBodies,"toes_r");
    toes_l = getBodyCoord(posBodies,headerBodies,"toes_l");
    com = getBodyCoord(posBodies,headerBodies,"center_of_mass");
    
%     figure(9); hold on; grid on;
%     plot(com(1),GRFL(2),'r*');
%     plot(com(1),GRFR(2),'b*');
%     plot(com(1),GRFR(3),'g*');
    dsL = 0.00; dsR = 0.00;
    if com(1) > -0.4 && com(1) < 0.5
        dsL = -0.10;
    else
        dsL = 0.00;
    end

    figure(10)
%     clf
    hold on; grid on;
    plot(com(1),com(2),'bo')
    if GRFR(2) > 25
        GRFR = 0.0015.*GRFR;
        plot([calcn_r(1) calcn_r(1)+GRFR(1)], ...
             [dsR dsR+GRFR(2)],'r')
    end
    if GRFL(2) > 25
        GRFL = 0.0015.*GRFL;
        plot([calcn_l(1) calcn_l(1)+GRFL(1)], ...
             [dsL dsL+GRFL(2)],'r')
    end
     
%     xlim([-1 2])
%     ylim([0 1.5])
    
%     figure(11)
%     hold on; grid on;
%     plot(com(1),com(3),'*')
%     plot(calcn_r(1),calcn_r(3),'*')
%     plot(calcn_l(1),calcn_l(3),'*')
end

function xyz = getBodyCoord(posBodies,headerBodies,string)
    xyz(1) = posBodies(getIdxCoMi(headerBodies,string+"_X"));
    xyz(2) = posBodies(getIdxCoMi(headerBodies,string+"_Y"));
    xyz(3) = posBodies(getIdxCoMi(headerBodies,string+"_Z"));
end

%% helper functions
function idx = getIdxCoMi(header,name)
    idx = find(contains(header,name));
end

function idx = getIdxIK(data,name)
    idx = find(contains(data.alen.fast00ca.alen0052.IK.headers,name));
end

function idx = getIdxIKCoM(data,name)
    idx = find(contains(data.alen.fast00ca.alen0052.IK.headersCoM,name));
end

function idx = getIdxIKH(data,name)
    idx = find(contains(data.alen.fast00ca.alen0052.IK.headersH,name));
end

function idx = getIdxIKGRF(data,name)
    idx = find(contains(data.alen.fast00ca.alen0052.IK.headersGRF,name));
end