clear; close all;

load('processedIKID.mat')
data = dataIKID;

%% Fits to be saved
fits_WCB = struct;

%% Nominal walking
B0 = 0.85; A0 = 0.1; w0 = 2*pi; phi0 = 0;
% figure
for i = 1:8
    time = data.exp00{i}.IK.valuesCoM(:,1);
    xcom = data.exp00{i}.IK.valuesCoM(:,2);
    zcom = data.exp00{i}.IK.valuesCoM(:,3);
    
    xysol = fminsearch(@(t) sum( (zcom(:) - ( t(1)+t(2)*cos(t(3)*xcom(:)+t(4))) ).^2 ),...
                       [B0 A0 w0 phi0]);
    tysol = fminsearch(@(t) sum( (zcom(:) - ( t(1)+t(2)*cos(t(3)*time(:)+t(4))) ).^2 ),...
                       [B0 A0 w0 phi0]);
    
%     subplot(1,2,1); hold on; grid on;
    xycosine = xysol(1) + xysol(2)*(cos(xysol(3).*xcom + xysol(4)));
%     plot(xcom,xycosine,'r','LineWidth',2)
%     
%     subplot(1,2,2); hold on; grid on;
    tycosine = tysol(1) + tysol(2)*(cos(tysol(3).*xcom + tysol(4)));
%     plot(time,tycosine,'r','LineWidth',2)
    
    fits_WCB.exp00{i}.xycosine = xycosine;
    fits_WCB.exp00{i}.tycosine = tycosine;
end

% Others
fn = fieldnames(data);
figure; hold on; grid on;
for i = 1:length(fn)
    for ii = 1:8
        time = data.(fn{i}){ii}.IK.valuesCoM(:,1);
        xcom = data.(fn{i}){ii}.IK.valuesCoM(:,2);
        zcom = data.(fn{i}){ii}.IK.valuesCoM(:,3);
        dxcom = data.(fn{i}){ii}.IK.dvaluesCoM(:,2);
        dzcom = data.(fn{i}){ii}.IK.dvaluesCoM(:,3);
        
        % filter to start and end at VLO and start at x=0.0
        [~,pk1Idx] = max(zcom(65:137));
        pk1Idx = pk1Idx + 65;
        [~,pk3Idx] = max(zcom(317:396));
        pk3Idx = pk3Idx + 317;

        time = time(pk1Idx:pk3Idx) - time(pk1Idx);
        xcom = xcom(pk1Idx:pk3Idx) - xcom(pk1Idx);
        zcom = zcom(pk1Idx:pk3Idx);
        dxcom = dxcom(pk1Idx:pk3Idx);
        dzcom = dzcom(pk1Idx:pk3Idx);
        
        xm = max(xcom);
        
        % xy 
        fun7 = @(p) sum( (zcom(:) - (p(1)*xcom(:).^7 + p(2)*xcom(:).^6 + ...
                                     p(3)*xcom(:).^5 + p(4)*xcom(:).^4 + ...
                                     p(5)*xcom(:).^3 + p(6)*xcom(:).^2 + ...
                                     p(7)*xcom(:)    + p(8))).^2);
        nlc7 = @(p) deal([2*p(6)],...
            [p(8) - (xysol(1)+abs(xysol(2))); 
             p(1)*xm^7+p(2)*xm^6+p(3)*xm^5+p(4)*xm^4+p(5)*xm^3+p(6)*xm^2+p(7)*xm+p(8) - (xysol(1)+abs(xysol(2)));
             p(7);
             7*p(1)*xm^6+6*p(2)*xm^5+5*p(3)*xm^4+4*p(4)*xm^3+3*p(5)*xm^2+2*p(6)*xm+p(7)]);

         
        p0 = [-2.2276,11.4571,-21.8807,18.5214,-6.0196,0.0205,0.1379,0.8813];
        xypoly = fmincon(fun7,p0,[],[],[],[],[],[],nlc7);
        
        % x dx
        fun7 = @(p) sum( (dxcom(:) - (p(1)*xcom(:).^7 + p(2)*xcom(:).^6 + ...
                                     p(3)*xcom(:).^5 + p(4)*xcom(:).^4 + ...
                                     p(5)*xcom(:).^3 + p(6)*xcom(:).^2 + ...
                                     p(7)*xcom(:)    + p(8))).^2);

        p0 = [-2.2276,11.4571,-21.8807,18.5214,-6.0196,0.0205,0.1379,0.8813];
        xdxpoly = fmincon(fun7,p0);
        
        % x dz
        fun7 = @(p) sum( (dzcom(:) - (p(1)*xcom(:).^7 + p(2)*xcom(:).^6 + ...
                                     p(3)*xcom(:).^5 + p(4)*xcom(:).^4 + ...
                                     p(5)*xcom(:).^3 + p(6)*xcom(:).^2 + ...
                                     p(7)*xcom(:)    + p(8))).^2);
         
        p0 = [-2.2276,11.4571,-21.8807,18.5214,-6.0196,0.0205,0.1379,0.8813];
        xdypoly = fmincon(fun7,p0);
        
        plot(xcom,polyval(xypoly,xcom))
        
        fits_WCB.(fn{i}){ii}.xy = xypoly;
        fits_WCB.(fn{i}){ii}.xdx = xdxpoly;
        fits_WCB.(fn{i}){ii}.xdy = xdypoly;
        fits_WCB.(fn{i}){ii}.t = time(end);
        fits_WCB.(fn{i}){ii}.xcom_end = xcom(end);
    end
end

%% GRF
figure; hold on; grid on;

p0x = 1.0e+05*[0.5280   -0.0684   -2.8290    3.9802   -1.8224    0.1559    0.0540    0.0014];
p0t = 1.0e+05*[0.5280   -0.0684   -2.8290    3.9802   -1.8224    0.1559    0.0540    0.0014];
for i = 1:length(fn)
    for ii = 1:8
        rightLeg = data.(fn{i}){ii}.IK.rightLegVLO;
        if rightLeg
            idx_sw = 9;
            idx_st = 3;
        else
            idx_sw = 3;
            idx_st = 9;
        end
        try
            time = data.(fn{i}){ii}.IK.valuesGRF(:,1);
            zgrf_sw = data.(fn{i}){ii}.IK.valuesGRF(:,idx_sw);
            zgrf_st = data.(fn{i}){ii}.IK.valuesGRF(:,idx_st);
            xcom = data.(fn{i}){ii}.IK.valuesCoM(:,2);
            
            idxSSP1_start = find(zgrf_st>0,1);
            idxDSP1_start = find(zgrf_sw>0,1);
            idxSSP2_start = find(zgrf_st(idxSSP1_start:end)==0,1)+idxSSP1_start;
            idxDSP2_start = find(zgrf_st(idxSSP2_start:end)>0,1)+idxSSP2_start;
            idxSSP3_start = find(zgrf_sw(idxDSP1_start:end)==0,1)+idxDSP1_start;
            idxSSP1_start = round((idxSSP1_start + idxDSP1_start)/2);
            idx_end = find(zgrf_st(idxDSP2_start:end)==0,1)+idxDSP2_start;
            idx_end = round((idxDSP2_start + idx_end)/2);
            
            idxs = find(zgrf_sw>0);
            time_total = time(idx_end) - time(idxSSP1_start);
            time_swing = time(idxs);
            xcom_swing = xcom(idxs);
            zgrf_sw = zgrf_sw(idxs);            
        catch
            continue;
        end
        
        % swing grf poly
        xcom_swing = (xcom_swing - xcom_swing(1))/(xcom_swing(end) - xcom_swing(1));
        xs = 0;
        xm = xcom_swing(end);
        fun7 = @(p) sum( (zgrf_sw(:) - (p(1)*xcom_swing(:).^7 + p(2)*xcom_swing(:).^6 + ...
                                        p(3)*xcom_swing(:).^5 + p(4)*xcom_swing(:).^4 + ...
                                        p(5)*xcom_swing(:).^3 + p(6)*xcom_swing(:).^2 + ...
                                        p(7)*xcom_swing(:)    + p(8))).^2);
        nlc7 = @(p) deal([0],...
            [p(1)*xs^7+p(2)*xs^6+p(3)*xs^5+p(4)*xs^4+p(5)*xs^3+p(6)*xs^2+p(7)*xs+p(8) - 0.0; 
             p(1)*xm^7+p(2)*xm^6+p(3)*xm^5+p(4)*xm^4+p(5)*xm^3+p(6)*xm^2+p(7)*xm+p(8) - 0.0]);
        xzgrfpoly = fmincon(fun7,p0x,[],[],[],[],[],[],nlc7);
        p0x = xzgrfpoly;
        
        % swing grf poly
        time_swing = (time_swing - time_swing(1))/(time_swing(end) - time_swing(1));
        xm = 1.0;
        fun7 = @(p) sum( (zgrf_sw(:) - (p(1)*time_swing(:).^7 + p(2)*time_swing(:).^6 + ...
                                        p(3)*time_swing(:).^5 + p(4)*time_swing(:).^4 + ...
                                        p(5)*time_swing(:).^3 + p(6)*time_swing(:).^2 + ...
                                        p(7)*time_swing(:)    + p(8))).^2);
        nlc7 = @(p) deal([0],...
            [p(8) - 0.0; 
             p(1)*xm^7+p(2)*xm^6+p(3)*xm^5+p(4)*xm^4+p(5)*xm^3+p(6)*xm^2+p(7)*xm+p(8) - 0.0]);
        tzgrfpoly = fmincon(fun7,p0t,[],[],[],[],[],[],nlc7);
        p0t = tzgrfpoly;
        
        subplot(2,length(fn),i); hold on; grid on;
        plot(time_swing,zgrf_sw,'r')
        plot(time_swing,polyval(tzgrfpoly,time_swing),'b')
         
        subplot(2,length(fn),i+length(fn)); hold on; grid on;
        plot(xcom_swing,zgrf_sw,'r')
        plot(xcom_swing,polyval(xzgrfpoly,xcom_swing),'b')
        
        
        fits_WCB.(fn{i}){ii}.tzgrfpoly = tzgrfpoly;
        fits_WCB.(fn{i}){ii}.xzgrfpoly = xzgrfpoly;
        fits_WCB.(fn{i}){ii}.zgrf_sw = zgrf_sw;
        fits_WCB.(fn{i}){ii}.zgrf_st = zgrf_st;
        fits_WCB.(fn{i}){ii}.t_total = time_total;
        
        fits_WCB.(fn{i}){ii}.tSSP1 = time(idxDSP1_start) - time(idxSSP1_start);
        fits_WCB.(fn{i}){ii}.tDSP1 = time(idxSSP2_start) - time(idxDSP1_start);
        fits_WCB.(fn{i}){ii}.tSSP2 = time(idxDSP2_start) - time(idxSSP2_start);
        fits_WCB.(fn{i}){ii}.tDSP2 = time(idxSSP3_start) - time(idxDSP2_start);
        fits_WCB.(fn{i}){ii}.tSSP3 = time(idx_end) - time(idxSSP3_start);
    end
end

%% Save data
save('fits_WCB.mat','fits_WCB')



