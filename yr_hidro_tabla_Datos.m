cd D:\trabajo\IGP\CLIM_PEZ\ADCP_temp
%% 
load('MUR_sst_hidrological_yr.mat');
load('DATABASE_yr_hidro.mat');
database=cat(2,years,temp_dia,temp_noche,temp_prom,region1_SST,region2_SST,...
    region3_SST,iq_Lisa,iq_paiche,iq_palometa,req_boquichico,req_llambina,...
    req_paiche,req_palometa,requ_Lisa,sed_chazuta,sed_requena,sed_tamshi,...
    yu_Lisa,yu_boquichico,yu_llambina,yu_paiche,yu_palometa);

T=array2table(database);
%% 
T.Properties.VariableNames{1} = 'years';
T.Properties.VariableNames{2} = 'temp_dia';
T.Properties.VariableNames{3} = 'temp_noche';
T.Properties.VariableNames{4} = 'temp_prom';
T.Properties.VariableNames{5} = 'region1_SST';
T.Properties.VariableNames{6} = 'region2_SST';
T.Properties.VariableNames{7} = 'region3_SST';
T.Properties.VariableNames{8} = 'iq_Lisa';
T.Properties.VariableNames{9} = 'iq_paiche';
T.Properties.VariableNames{10} = 'iq_palometa';
T.Properties.VariableNames{11} = 'req_boquichico';
T.Properties.VariableNames{12} = 'req_llambina';
T.Properties.VariableNames{13} = 'req_paiche';
T.Properties.VariableNames{14} = 'req_palometa';
T.Properties.VariableNames{15} = 'requ_Lisa';
T.Properties.VariableNames{16} = 'sed_chazuta';
T.Properties.VariableNames{17} = 'sed_requena';
T.Properties.VariableNames{18} = 'sed_tamshi';
T.Properties.VariableNames{19} = 'yu_Lisa';
T.Properties.VariableNames{20} = 'yu_boquichico';
T.Properties.VariableNames{21} = 'yu_llambina';
T.Properties.VariableNames{22} = 'yu_paiche';
T.Properties.VariableNames{23} = 'yu_palometa';
%% export
 writetable(T,'yr_hidrologico_basedatos.xlsx','Sheet',1);
    