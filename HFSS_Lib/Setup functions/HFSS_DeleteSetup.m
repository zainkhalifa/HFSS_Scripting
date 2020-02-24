function [] = HFSS_DeleteSetup(filename,freq)
% HFSS_DeleteSetup generates a script to delete the setups labeled as 
% ("Setup%0.0f",freq(idx)). 
%
% Author : Zainulabideen Khalifa            Last Revision : 2/22/2020
% 
% inputs: 
%     # freq --> is an array with the frequencies in the setup labels 
%       assuming the name of the setups as "Setup123" for 
%       freq=123;. freq is numeric 

fileID = fopen(filename,'w');
fprintf(fileID,'import ScriptEnv\n');
fprintf(fileID,'ScriptEnv.Initialize("Ansoft.ElectronicsDesktop")\n');
fprintf(fileID,'oDesktop.RestoreWindow()\n');
fprintf(fileID,'oProject = oDesktop.SetActiveProject("BTWA_N20_a010")\n');
fprintf(fileID,'oDesign = oProject.SetActiveDesign("HFSSDesign1")\n');
fprintf(fileID,'oModule = oDesign.GetModule("AnalysisSetup")\n');

for idx = 1:length(freq)
    fprintf(fileID,'oModule.DeleteSetups(["Setup%0.0f"])\n',freq(idx));
end
fclose(fileID);
fprintf("DONE !\n");
end
