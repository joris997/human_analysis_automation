%% IK joint kinematics
idxStr = {'pelvis_tilt','pelvis_tilt';
          'pelvis_list','pelvis_list';
          'pelvis_rotation','pelvis_rotation';
          'pelvis_tx','pelvis_tx';
          'pelvis_ty','pelvis_ty';
          'pelvis_tz','pelvis_tz';
          
          'hip_flexion_l','hip_flexion_r';
          'hip_flexion_r','hip_flexion_l';
          'hip_adduction_l','hip_adduction_r';
          'hip_adduction_r','hip_adduction_l';
          'hip_rotation_l','hip_rotation_r';
          'hip_rotation_r','hip_rotation_l';
          'knee_angle_l','knee_angle_r';
          'knee_angle_r','knee_angle_l';
          'ankle_angle_l','ankle_angle_r';
          'ankle_angle_r','ankle_angle_l';
          'subtalar_angle_l','subtalar_angle_r';
          'subtalar_angle_r','subtalar_angle_l';
          'mtp_angle_l','mtp_angle_r';
          'mtp_angle_r','mtp_angle_l';
          
          'lumbar_extension','lumbar_extension';
          'lumbar_bending','lumbar_bending';
          'lumbar_rotation','lumbar_rotation'};

idxStrAdd = {'pelvis_tilt','pelvis_list','pelvis_rotation',...
             'pelvis_tx','pelvis_ty','pelvis_tz',...
             'hip_flexion_sw','hip_flexion_st','hip_adduction_sw','hip_adduction_st',...
             'hip_rotation_sw','hip_rotation_st','knee_angle_sw','knee_angle_st',...
             'ankle_angle_sw','ankle_angle_st','subtalar_angle_sw','subtalar_angle_st',...
             'mtp_angle_sw','mtp_angle_st',...
             'lumbar_extension','lumbar_bending','lumbar_rotation'};


%% CoM
idxStrCoM = {'pelvis_X','pelvis_X';
            'pelvis_Y','pelvis_Y';
            'pelvis_Z','pelvis_Z';
            'pelvis_Ox','pelvis_Ox';
            'pelvis_Oy','pelvis_Oy';
            'pelvis_Oz','pelvis_Oz';
            'calcn_l_X','calcn_r_X';
            'calcn_r_X','calcn_l_X';
            'calcn_l_Y','calcn_r_Y';
            'calcn_r_Y','calcn_l_Y';
            'calcn_l_Z','calcn_r_Z';
            'calcn_r_Z','calcn_l_Z';
            'calcn_l_Ox','calcn_r_Ox';
            'calcn_r_Ox','calcn_l_Ox';
            'calcn_l_Oy','calcn_r_Oy';
            'calcn_r_Oy','calcn_l_Oy';
            'calcn_l_Oz','calcn_r_Oz';
            'calcn_r_Oz','calcn_l_Oz';
            'center_of_mass_X','center_of_mass_X';
            'center_of_mass_Y','center_of_mass_Y';
            'center_of_mass_Z','center_of_mass_Z'};

idxStrCoMAdd = {'pelvis_X','pelvis_Y','pelvis_Z','pelvis_Ox','pelvis_Oy','pelvis_Oz',...
                'calcn_sw_X','calcn_st_X','calcn_sw_Y','calcn_st_Y','calcn_sw_Z','calcn_st_Z',...
                'calcn_sw_Ox','calcn_st_Ox','calcn_sw_Oy','calcn_st_Oy','calcn_sw_Oz','calcn_st_Oz',...
                'center_of_mass_X','center_of_mass_Y','center_of_mass_Z'};

%% GRF
idxStrGRF = {'l_ground_force_vx','ground_force_vx';
             'ground_force_vx','l_ground_force_vx';
             'l_ground_force_vy','ground_force_vy';
             'ground_force_vy','l_ground_force_vy';
             'l_ground_force_vz','ground_force_vz';
             'ground_force_vz','l_ground_force_vz'};
         
idxStrGRFAdd = {'ground_force_sw_vx','ground_force_st_vx',...
                'ground_force_sw_vy','ground_force_st_vy',...
                'ground_force_sw_vz','ground_force_st_vz'};

%% Angular momentum
idxStrH = {'Lx','Rx';
           'Rx','Lx';
           'Ly','Ry';
           'Ry','Ly';
           'Lz','Rz';
           'Rz','Lz'};

idxStrHAdd = {'x_sw','x_st',...
              'y_sw','y_st',...
              'z_sw','z_st'};

% %% IK joint kinematics
% idxStr = {'pelvis_tilt','pelvis_tilt';
%           'pelvis_list','pelvis_list';
%           'pelvis_rotation','pelvis_rotation';
%           'pelvis_tx','pelvis_tx';
%           'pelvis_ty','pelvis_ty';
%           'pelvis_tz','pelvis_tz';
%           
%           'hip_flexion_r','hip_flexion_l';
%           'hip_flexion_l','hip_flexion_r';
%           'hip_adduction_r','hip_adduction_l';
%           'hip_adduction_l','hip_adduction_r';
%           'hip_rotation_r','hip_rotation_l';
%           'hip_rotation_l','hip_rotation_r';
%           'knee_angle_r','knee_angle_l';
%           'knee_angle_l','knee_angle_r';
%           'ankle_angle_r','ankle_angle_l';
%           'ankle_angle_l','ankle_angle_r';
%           'subtalar_angle_r','subtalar_angle_l';
%           'subtalar_angle_l','subtalar_angle_r';
%           'mtp_angle_r','mtp_angle_l';
%           'mtp_angle_l','mtp_angle_r';
%           
%           'lumbar_extension','lumbar_extension';
%           'lumbar_bending','lumbar_bending';
%           'lumbar_rotation','lumbar_rotation'};
% 
% idxStrAdd = {'pelvis_tilt','pelvis_list','pelvis_rotation',...
%              'pelvis_tx','pelvis_ty','pelvis_tz',...
%              'hip_flexion_sw','hip_flexion_st','hip_adduction_sw','hip_adduction_st',...
%              'hip_rotation_sw','hip_rotation_st','knee_angle_sw','knee_angle_st',...
%              'ankle_angle_sw','ankle_angle_st','subtalar_angle_sw','subtalar_angle_st',...
%              'mtp_angle_sw','mtp_angle_st',...
%              'lumbar_extension','lumbar_bending','lumbar_rotation'};
% 
% 
% %% CoM
% idxStrCoM = {'pelvis_X','pelvis_X';
%             'pelvis_Y','pelvis_Y';
%             'pelvis_Z','pelvis_Z';
%             'pelvis_Ox','pelvis_Ox';
%             'pelvis_Oy','pelvis_Oy';
%             'pelvis_Oz','pelvis_Oz';
%             'calcn_r_X','calcn_l_X';
%             'calcn_l_X','calcn_r_X';
%             'calcn_r_Y','calcn_l_Y';
%             'calcn_l_Y','calcn_r_Y';
%             'calcn_r_Z','calcn_l_Z';
%             'calcn_l_Z','calcn_r_Z';
%             'calcn_r_Ox','calcn_l_Ox';
%             'calcn_l_Ox','calcn_r_Ox';
%             'calcn_r_Oy','calcn_l_Oy';
%             'calcn_l_Oy','calcn_r_Oy';
%             'calcn_r_Oz','calcn_l_Oz';
%             'calcn_l_Oz','calcn_r_Oz';
%             'center_of_mass_X','center_of_mass_X';
%             'center_of_mass_Y','center_of_mass_Y';
%             'center_of_mass_Z','center_of_mass_Z'};
% 
% idxStrCoMAdd = {'pelvis_X','pelvis_Y','pelvis_Z','pelvis_Ox','pelvis_Oy','pelvis_Oz',...
%                 'calcn_sw_X','calcn_st_X','calcn_sw_Y','calcn_st_Y','calcn_sw_Z','calcn_st_Z',...
%                 'calcn_sw_Ox','calcn_st_Ox','calcn_sw_Oy','calcn_st_Oy','calcn_sw_Oz','calcn_st_Oz',...
%                 'center_of_mass_X','center_of_mass_Y','center_of_mass_Z'};
%             
% %% GRF
% idxStrGRF = {'ground_force_vx','l_ground_force_vx';
%              'l_ground_force_vx','ground_force_vx';
%              'ground_force_vy','l_ground_force_vy';
%              'l_ground_force_vy','ground_force_vy';
%              'ground_force_vz','l_ground_force_vz';
%              'l_ground_force_vz','ground_force_vz'};
%          
% idxStrGRFAdd = {'ground_force_sw_vx','ground_force_st_vx',...
%                 'ground_force_sw_vy','ground_force_st_vy',...
%                 'ground_force_sw_vz','ground_force_st_vz'};
% 
% %% Angular momentum
% idxStrH = {'Rx','Lx';
%            'Lx','Rx';
%            'Ry','Ly';
%            'Ly','Ry';
%            'Rz','Lz';
%            'Lz','Rz'};
% 
% idxStrHAdd = {'x_sw','x_st',...
%               'y_sw','y_st',...
%               'z_sw','z_st'};
            
%% CMC controls
% idxStrCMCControlsAdd = {'glut_med1_r','glut_med2_r','glut_med3_r','glut_min1_r','glut_min2_r','glut_min3_r','semimem_r','semiten_r','bifemlh_r','bifemsh_r','sar_r','add_long_r','add_brev_r','add_mag1_r','add_mag2_r','add_mag3_r','tfl_r','pect_r','grac_r','glut_max1_r','glut_max2_r','glut_max3_r','iliacus_r','psoas_r','quad_fem_r','gem_r','peri_r','rect_fem_r','vas_med_r','vas_int_r','vas_lat_r','med_gas_r','lat_gas_r','soleus_r','tib_post_r','flex_dig_r','flex_hal_r','tib_ant_r','per_brev_r','per_long_r','per_tert_r','ext_dig_r','ext_hal_r','glut_med1_l','glut_med2_l','glut_med3_l','glut_min1_l','glut_min2_l','glut_min3_l','semimem_l','semiten_l','bifemlh_l','bifemsh_l','sar_l','add_long_l','add_brev_l','add_mag1_l','add_mag2_l','add_mag3_l','tfl_l','pect_l','grac_l','glut_max1_l','glut_max2_l','glut_max3_l','iliacus_l','psoas_l','quad_fem_l','gem_l','peri_l','rect_fem_l','vas_med_l','vas_int_l','vas_lat_l','med_gas_l','lat_gas_l','soleus_l','tib_post_l','flex_dig_l','flex_hal_l','tib_ant_l','per_brev_l','per_long_l','per_tert_l','ext_dig_l','ext_hal_l','ercspn_r','ercspn_l','intobl_r','intobl_l','extobl_r','extobl_l','FX','FY','FZ','MX','MY','MZ','hip_flexion_r_reserve','hip_adduction_r_reserve','hip_rotation_r_reserve','knee_angle_r_reserve','ankle_angle_r_reserve','hip_flexion_l_reserve','hip_adduction_l_reserve','hip_rotation_l_reserve','knee_angle_l_reserve','ankle_angle_l_reserve','lumbar_extension_reserve','lumbar_bending_reserve','lumbar_rotation_reserve','arm_flex_r_reserve','arm_add_r_reserve','arm_rot_r_reserve','arm_flex_l_reserve','arm_add_l_reserve','arm_rot_l_reserve','elbow_flex_r_reserve','elbow_flex_l_reserve','pro_sup_r_reserve','pro_sup_l_reserve'};
if doCMC
    already_added = {};
    idxStrCMCControlsCell = dataCMC.exp00{1}.CMC.headersControls(2:end);
    cnt = 0;
    cnt2 = 0;
    for i = 1:length(idxStrCMCControlsCell)
        c = idxStrCMCControlsCell{i};

        if (contains(c(end-1:end),'_l') || contains(c(end-1:end),'_r')) && ~any(strcmp(replace(c,{'_l','_r'},''),already_added))
            cnt = cnt + 1;
            cnt2 = cnt2 + 2;

            cph = [c, ' '];
            cph(end-2:end) = '_sw';
            idxStrCMCControlsAdd{cnt2-1} = cph; 
            cph(end-2:end) = '_st';
            idxStrCMCControlsAdd{cnt2} = cph;

            cl = c; cr = c;
            cl(end-1:end) = '_l';
            cr(end-1:end) = '_r';

            idxStrCMCControls{cnt2-1,1} = cr;
            idxStrCMCControls{cnt2-1,2} = cl;
            idxStrCMCControls{cnt2,1} = cl;
            idxStrCMCControls{cnt2,2} = cr;

            already_added{cnt} = replace(c,{'_l','_r'},'');
        end

        if (contains(c,'_l_') || contains(c,'_r_')) && ~any(strcmp(replace(c,{'_l_','_r_'},''),already_added))
            cnt = cnt + 1;
            cnt2 = cnt2 + 2;
            idxStrCMCControlsAdd{cnt2-1} = replace(c,{'_l_','_r_'},'_sw_'); 
            idxStrCMCControlsAdd{cnt2} = replace(c,{'_l_','_r_'},'_st_');

            idxStrCMCControls{cnt2-1,1} = replace(c,{'_l_','_r_'},'_r_');
            idxStrCMCControls{cnt2-1,2} = replace(c,{'_l_','_r_'},'_l_');
            idxStrCMCControls{cnt2,1} = replace(c,{'_l_','_r_'},'_l_');
            idxStrCMCControls{cnt2,2} = replace(c,{'_l_','_r_'},'_r_');

            already_added{cnt} = replace(c,{'_l_','_r_'},'');
        end

        if ~contains(c,'_l_') && ~contains(c,'_r_') && ~contains(c(end-1:end),'_l') && ~contains(c(end-1:end),'_r')
            cnt = cnt + 1;
            cnt2 = cnt2 + 1;

            idxStrCMCControlsAdd{cnt2} = c;

            idxStrCMCControls{cnt2,1} = c;
            idxStrCMCControls{cnt2,2} = c;
        end
    end



    already_added = {};
    idxStrCMCForceCell = dataCMC.exp00{1}.CMC.headersForce(2:end);
    cnt = 0;
    cnt2 = 0;
    for i = 1:length(idxStrCMCForceCell)
        c = idxStrCMCForceCell{i};

        if (contains(c(end-1:end),'_l') || contains(c(end-1:end),'_r')) && ~any(strcmp(replace(c,{'_l','_r'},''),already_added))
            cnt = cnt + 1;
            cnt2 = cnt2 + 2;

            cph = [c, ' '];
            cph(end-2:end) = '_sw';
            idxStrCMCForceAdd{cnt2-1} = cph; 
            cph(end-2:end) = '_st';
            idxStrCMCForceAdd{cnt2} = cph;

            cl = c; cr = c;
            cl(end-1:end) = '_l';
            cr(end-1:end) = '_r';

            idxStrCMCForce{cnt2-1,1} = cr;
            idxStrCMCForce{cnt2-1,2} = cl;
            idxStrCMCForce{cnt2,1} = cl;
            idxStrCMCForce{cnt2,2} = cr;

            already_added{cnt} = replace(c,{'_l','_r'},'');
        end

        if (contains(c,'_l_') || contains(c,'_r_')) && ~any(strcmp(replace(c,{'_l_','_r_'},''),already_added))
            cnt = cnt + 1;
            cnt2 = cnt2 + 2;
            idxStrCMCForceAdd{cnt2-1} = replace(c,{'_l_','_r_'},'_sw_'); 
            idxStrCMCForceAdd{cnt2} = replace(c,{'_l_','_r_'},'_st_');

            idxStrCMCForce{cnt2-1,1} = replace(c,{'_l_','_r_'},'_r_');
            idxStrCMCForce{cnt2-1,2} = replace(c,{'_l_','_r_'},'_l_');
            idxStrCMCForce{cnt2,1} = replace(c,{'_l_','_r_'},'_l_');
            idxStrCMCForce{cnt2,2} = replace(c,{'_l_','_r_'},'_r_');

            already_added{cnt} = replace(c,{'_l_','_r_'},'');
        end

        if ~contains(c,'_l_') && ~contains(c,'_r_') && ~contains(c(end-1:end),'_l') && ~contains(c(end-1:end),'_r')
            cnt = cnt + 1;
            cnt2 = cnt2 + 1;

            idxStrCMCForceAdd{cnt2} = c;

            idxStrCMCForce{cnt2,1} = c;
            idxStrCMCForce{cnt2,2} = c;
        end
    end



    already_added = {};
    idxStrCMCPowerCell = dataCMC.exp00{1}.CMC.headersPower(2:end);
    cnt = 0;
    cnt2 = 0;
    for i = 1:length(idxStrCMCPowerCell)
        c = idxStrCMCPowerCell{i};

        if (contains(c(end-1:end),'_l') || contains(c(end-1:end),'_r')) && ~any(strcmp(replace(c,{'_l','_r'},''),already_added))
            cnt = cnt + 1;
            cnt2 = cnt2 + 2;

            cph = [c, ' '];
            cph(end-2:end) = '_sw';
            idxStrCMCPowerAdd{cnt2-1} = cph; 
            cph(end-2:end) = '_st';
            idxStrCMCPowerAdd{cnt2} = cph;

            cl = c; cr = c;
            cl(end-1:end) = '_l';
            cr(end-1:end) = '_r';

            idxStrCMCPower{cnt2-1,1} = cr;
            idxStrCMCPower{cnt2-1,2} = cl;
            idxStrCMCPower{cnt2,1} = cl;
            idxStrCMCPower{cnt2,2} = cr;

            already_added{cnt} = replace(c,{'_l','_r'},'');
        end

        if (contains(c,'_l_') || contains(c,'_r_')) && ~any(strcmp(replace(c,{'_l_','_r_'},''),already_added))
            cnt = cnt + 1;
            cnt2 = cnt2 + 2;
            idxStrCMCPowerAdd{cnt2-1} = replace(c,{'_l_','_r_'},'_sw_'); 
            idxStrCMCPowerAdd{cnt2} = replace(c,{'_l_','_r_'},'_st_');

            idxStrCMCPower{cnt2-1,1} = replace(c,{'_l_','_r_'},'_r_');
            idxStrCMCPower{cnt2-1,2} = replace(c,{'_l_','_r_'},'_l_');
            idxStrCMCPower{cnt2,1} = replace(c,{'_l_','_r_'},'_l_');
            idxStrCMCPower{cnt2,2} = replace(c,{'_l_','_r_'},'_r_');

            already_added{cnt} = replace(c,{'_l_','_r_'},'');
        end

        if ~contains(c,'_l_') && ~contains(c,'_r_') && ~contains(c(end-1:end),'_l') && ~contains(c(end-1:end),'_r')
            cnt = cnt + 1;
            cnt2 = cnt2 + 1;

            idxStrCMCPowerAdd{cnt2} = c;

            idxStrCMCPower{cnt2,1} = c;
            idxStrCMCPower{cnt2,2} = c;
        end
    end


    %% Headers Actuation speed
    already_added = {};
    idxStrCMCSpeedCell = dataCMC.exp00{1}.CMC.headersSpeed(2:end);
    cnt = 0;
    cnt2 = 0;
    for i = 1:length(idxStrCMCSpeedCell)
        c = idxStrCMCSpeedCell{i};

        if (contains(c(end-1:end),'_l') || contains(c(end-1:end),'_r')) && ~any(strcmp(replace(c,{'_l','_r'},''),already_added))
            cnt = cnt + 1;
            cnt2 = cnt2 + 2;

            cph = [c, ' '];
            cph(end-2:end) = '_sw';
            idxStrCMCSpeedAdd{cnt2-1} = cph; 
            cph(end-2:end) = '_st';
            idxStrCMCSpeedAdd{cnt2} = cph;

            cl = c; cr = c;
            cl(end-1:end) = '_l';
            cr(end-1:end) = '_r';

            idxStrCMCSpeed{cnt2-1,1} = cr;
            idxStrCMCSpeed{cnt2-1,2} = cl;
            idxStrCMCSpeed{cnt2,1} = cl;
            idxStrCMCSpeed{cnt2,2} = cr;

            already_added{cnt} = replace(c,{'_l','_r'},'');
        end

        if (contains(c,'_l_') || contains(c,'_r_')) && ~any(strcmp(replace(c,{'_l_','_r_'},''),already_added))
            cnt = cnt + 1;
            cnt2 = cnt2 + 2;
            idxStrCMCSpeedAdd{cnt2-1} = replace(c,{'_l_','_r_'},'_sw_'); 
            idxStrCMCSpeedAdd{cnt2} = replace(c,{'_l_','_r_'},'_st_');

            idxStrCMCSpeed{cnt2-1,1} = replace(c,{'_l_','_r_'},'_r_');
            idxStrCMCSpeed{cnt2-1,2} = replace(c,{'_l_','_r_'},'_l_');
            idxStrCMCSpeed{cnt2,1} = replace(c,{'_l_','_r_'},'_l_');
            idxStrCMCSpeed{cnt2,2} = replace(c,{'_l_','_r_'},'_r_');

            already_added{cnt} = replace(c,{'_l_','_r_'},'');
        end

        if ~contains(c,'_l_') && ~contains(c,'_r_') && ~contains(c(end-1:end),'_l') && ~contains(c(end-1:end),'_r')
            cnt = cnt + 1;
            cnt2 = cnt2 + 1;

            idxStrCMCSpeedAdd{cnt2} = c;

            idxStrCMCSpeed{cnt2,1} = c;
            idxStrCMCSpeed{cnt2,2} = c;
        end
    end



    %% Header CMC States
    already_added = {};
    idxStrCMCStatesCell = dataCMC.exp00{1}.CMC.headersStates(2:end);
    cnt = 0;
    cnt2 = 0;
    for i = 1:length(idxStrCMCStatesCell)
        c = idxStrCMCStatesCell{i};

        if (contains(c,'_l/') || contains(c,'_r/')) && ~any(strcmp(replace(c,{'_l/','_r/'},'/'),already_added))
            cnt = cnt + 1;
            cnt2 = cnt2 + 2;

            idxStrCMCStatesAdd{cnt2-1} = replace(c,{'_l/','_r/'},'_sw/'); 
            idxStrCMCStatesAdd{cnt2} = replace(c,{'_l/','_r/'},'_st/');

            idxStrCMCStates{cnt2-1,1} = replace(c,{'_l/','_r/'},'_r/');
            idxStrCMCStates{cnt2-1,2} = replace(c,{'_l/','_r/'},'_l/');
            idxStrCMCStates{cnt2,1} = replace(c,{'_l/','_r/'},'_l/');
            idxStrCMCStates{cnt2,2} = replace(c,{'_l/','_r/'},'_r/');

            already_added{cnt} = replace(c,{'_l/','_r/'},'/');
        end

        if (contains(c,'_l_') || contains(c,'_r_')) && ~any(strcmp(replace(c,{'_l_','_r_'},''),already_added))
            cnt = cnt + 1;
            cnt2 = cnt2 + 2;
            idxStrCMCStatesAdd{cnt2-1} = replace(c,{'_l_','_r_'},'_sw_'); 
            idxStrCMCStatesAdd{cnt2} = replace(c,{'_l_','_r_'},'_st_');

            idxStrCMCStates{cnt2-1,1} = replace(c,{'_l_','_r_'},'_r_');
            idxStrCMCStates{cnt2-1,2} = replace(c,{'_l_','_r_'},'_l_');
            idxStrCMCStates{cnt2,1} = replace(c,{'_l_','_r_'},'_l_');
            idxStrCMCStates{cnt2,2} = replace(c,{'_l_','_r_'},'_r_');

            already_added{cnt} = replace(c,{'_l_','_r_'},'');
        end

        if ~contains(c,'_l_') && ~contains(c,'_r_') && ~contains(c,'_l/') && ~contains(c,'_r/')
            cnt = cnt + 1;
            cnt2 = cnt2 + 1;

            idxStrCMCStatesAdd{cnt2} = c;

            idxStrCMCStates{cnt2,1} = c;
            idxStrCMCStates{cnt2,2} = c;
        end
    end
end