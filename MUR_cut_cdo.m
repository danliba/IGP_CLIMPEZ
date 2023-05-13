%% Crear el codigo en CDO para cortar MUR 
%primero leemos mur
cd D:\trabajo\IGP\CLIM_PEZ\temp_agua_oceancolor\MUR

%% leemos las variables
fid = fopen('cutMUR_IGP.sh','wt');

path1='D:\trabajo\IGP\CLIM_PEZ\temp_agua_oceancolor\MUR';
hdir=dir(fullfile(path1,'20*.nc'));

%cdo -sellonlatbox,-79,-70,-7,-3 20110316090000-JPL-L4_GHRSST-SSTfnd-MUR-GLOB-v02.0-fv04.1.nc c-2011031609.nc

for iMUR=1:1:size(hdir,1)
    fns=hdir(iMUR).name;
    out=['c-',fns(1:10),'.nc'];
    cdo_code=['cdo -sellonlatbox,-75,-72,-6,-3 ',fns,' ',out,';'];
    out2=['rm ',fns,';'];
    disp(cdo_code)
    disp(out2)
    fprintf(fid,'%s\n',cdo_code);
    fprintf(fid,'%s\n',out2);
end
fclose(fid);

%% ahora borramos con shell los ncs que ya no utilizaremos

% fid = fopen('delMUR_IGP.sh','wt');
% 
% %cdo -sellonlatbox,-79,-70,-7,-3 20030131090000-JPL-L4_GHRSST-SSTfnd-MUR-GLOB-v02.0-fv04.1.nc aa.nc
% %hdir2=dir('m*2*.nc');
% fns2=hdir2(1).name;
% for iMUR=1:1:size(hdir,1)
%     fns=hdir(iMUR).name;
%     out=['rm ',fns,';'];
%     %cdo_code=['cdo -sellonlatbox, -75,72,-6,-3 ',fns,' ',out];
%     disp(out)
%     fprintf(fid,'%s\n',out);
% end
% %outmerged=['m-',fns(1:6),'.nc',';'];
% %merge=['cdo mergetime c*.nc',' ',outmerged];
% %fprintf(fid,'%s\n',merge);
% %%cortamos el area que queremos especificamente
% % out2=['cm-',fns(1:10),'.nc'];
% % cutmerge=['cdo -sellonlatbox, -73,72.85,-3.5,-3.1 ',fns,' ',out2,';'];
% % fprintf(fid,'%s\n',cutmerge);
% fclose(fid);

%%

