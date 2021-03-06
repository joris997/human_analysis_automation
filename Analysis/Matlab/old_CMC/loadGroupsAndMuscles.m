%% all groups
if allg && allm
    groups = {'hip_abduction','hip_flexion','hip_inrotation',...
        'hip_exorotation','hip_extension','hip_adduction',...
        'knee_flexion','knee_extension','ankle_plantarflexion',...
        'ankle_inverter','ankle_dorsiflexion','ankle_everter'};
    
    muscles = {
    {'glut_max1_','glut_med1_','glut_med2_','glut_med3_',...
    'glut_min1_','glut_min2_','glut_min3_','peri_','sar_','tfl_'},...
    {'add_long_','add_brev_','glut_med1_','glut_min1_',...
    'grac_','iliacus_','pect_','psoas_','rect_fem_','sar_','tfl_'},...
    {'glut_med1_','glut_min1_','iliacus_','psoas_','tfl_'},...
    {'gem_','glut_med3_','glut_min3_','peri_','quad_fem_'},...
    {'add_long_','add_mag1_','add_mag2_','add_mag3_','bifemlh_',...
    'glut_max1_','glut_max2_','glut_max3_','glut_med3_','glut_min3_',...
    'semimem_','semiten_'},...
    {'add_long_','add_brev_','add_mag1_','add_mag2_','add_mag3_',...
    'bifemlh_','grac_','pect_','semimem_','semiten_'},...
    {'bifemlh_','bifemsh_','grac_','lat_gas_','med_gas_','sar_',...
    'semimem_','semiten_'},...
    {'rect_fem_','vas_med_','vas_int_','vas_lat_'},...
    {'flex_dig_','flex_hal_','lat_gas_','med_gas_','per_brev_',...
    'per_long_','soleus_','tib_post_'},...
    {'ext_hal_','flex_dig_','flex_hal_','tib_ant_','tib_post_'},...
    {'ext_dig_','ext_hal_','per_tert_','tib_ant_'},...
    {'ext_dig_','per_brev_','per_long_','per_tert_'}
    };
elseif ~allg && allm
    groups = {'hip_abduction','hip_flexion',...
        'hip_extension',...
        'knee_flexion','knee_extension','ankle_plantarflexion',...
        'ankle_dorsiflexion'};
    
    muscles = {
    {'glut_max1_','glut_med1_','glut_med2_','glut_med3_',...
    'glut_min1_','glut_min2_','glut_min3_','peri_','sar_','tfl_'},...
    {'add_long_','add_brev_','glut_med1_','glut_min1_',...
    'grac_','iliacus_','pect_','psoas_','rect_fem_','sar_','tfl_'},...
    {'add_long_','add_mag1_','add_mag2_','add_mag3_','bifemlh_',...
    'glut_max1_','glut_max2_','glut_max3_','glut_med3_','glut_min3_',...
    'semimem_','semiten_'},...
    {'bifemlh_','bifemsh_','grac_','lat_gas_','med_gas_','sar_',...
    'semimem_','semiten_'},...
    {'rect_fem_','vas_med_','vas_int_','vas_lat_'},...
    {'flex_dig_','flex_hal_','lat_gas_','med_gas_','per_brev_',...
    'per_long_','soleus_','tib_post_'},...
    {'ext_dig_','ext_hal_','per_tert_','tib_ant_'}
    };
elseif allg && ~allm
    groups = {'hip_abduction','hip_flexion','hip_inrotation',...
        'hip_exorotation','hip_extension','hip_adduction',...
        'knee_flexion','knee_extension','ankle_plantarflexion',...
        'ankle_inverter','ankle_dorsiflexion','ankle_everter'};
    
    muscles = {
    {'glut_max1_','glut_med1_','glut_med2_',...
    'glut_min1_','glut_min2_'},...
    {'add_long_','add_brev_','glut_med1_','glut_min1_',...
    'grac_','iliacus_'},...
    {'glut_med1_','glut_min1_'},...
    {'gem_','glut_med3_','glut_min3_','quad_fem_'},...
    {'add_long_','add_mag1_','add_mag2_','bifemlh_',...
    'glut_max1_','glut_max2_',...
    'semimem_','semiten_'},...
    {'add_long_','add_brev_','add_mag1_','add_mag2_',...
    'bifemlh_','semimem_','semiten_'},...
    {'bifemlh_','bifemsh_','lat_gas_','med_gas_','semiten_'},...
    {'rect_fem_','vas_med_','vas_int_','vas_lat_'},...
    {'flex_dig_','flex_hal_','lat_gas_','med_gas_','per_brev_'},...
    {'ext_hal_','flex_dig_','flex_hal_','tib_ant_','tib_post_'},...
    {'ext_dig_','ext_hal_','per_tert_','tib_ant_'},...
    {'ext_dig_','per_brev_','per_long_','per_tert_'}
    };
elseif ~allg && ~allm
    groups = {'hip_flexion',...
        'hip_extension',...
        'knee_flexion','knee_extension','ankle_plantarflexion',...
        'ankle_dorsiflexion'};
    
    muscles = {
    {'add_long_','add_brev_','glut_med1_','glut_min1_',...
    'grac_','iliacus_'},...
    {'add_long_','add_mag1_','add_mag2_','bifemlh_',...
    'glut_max1_','glut_max2_'},...
    {'bifemlh_','bifemsh_','lat_gas_','med_gas_',...
    'semimem_'},...
    {'rect_fem_','vas_med_','vas_int_','vas_lat_'},...
    {'flex_dig_','flex_hal_','lat_gas_','med_gas_','per_brev_'},...
    {'ext_dig_','ext_hal_','per_tert_','tib_ant_'}
    };
end
% 
% groups = {'knee_flexion'};
% muscles = {{'bifemlh_','semiten_','grac_'}};
