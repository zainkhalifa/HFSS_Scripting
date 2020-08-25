% This code will generate a script to extract all the sp files and naming
% them in a logical manner based on their variable names as listed in the
% ParametricSetup1_Result.csv file. 

clear all
clc
close all

fileID = fopen('/data/zainkh/Documents/MATLAB/HFSS_scripts/Export_SP.py','w');
Project_name = 'z_HRO_V5';
SPfiles_location = "/data/zainkh/Documents/HFSS_SP/z_HRO_HFSS";
Parameters_files = "/data/zainkh/Documents/Temp/ParametricSetup1_Result.csv";
file_name_prefix = "";
file_ext = ".s14p";

HFSS_Header(fileID,Project_name);
T = readtable(Parameters_files,'ReadRowNames',1);
%% treating noncell values
Table = {};
for i = 1:length(T.Properties.VariableNames)
    if isnumeric(T{:,i})
        for j=1:length(T{:,i})
            Table{j,i} = num2str(T{j,i});
        end
    else
       Table(:,1+end) = T{:,i};
    end
end

%%
Variable.Names = T.Properties.VariableNames;
Variable.Num = length(Variable.Names);
% Variable.Data = T.Variables;
% Variable.length = length(Variable.Data(:,1));
Variable.Data = Table;
Variable.length = length(Variable.Data(:,1));


for data_idx=1:Variable.length
    filename = '';
    for var_idx = 1:Variable.Num
        HFSS_Property(fileID, Variable.Names{var_idx} ,Variable.Data{data_idx,var_idx});
        filename = strcat(filename, sprintf('%s%s',Variable.Names{var_idx} ,Variable.Data{data_idx,var_idx}));
    end
    Fullfilename = sprintf('%s/%s%s%s',SPfiles_location,file_name_prefix,filename,file_ext);
    HFSS_ExportData(fileID,Fullfilename,'Setup250');
end
T
fclose(fileID);
fprintf("DONE !\n");
