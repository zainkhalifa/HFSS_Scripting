function [] = HFSS_Project(fileID,Project_location,Project_name,Design_name)
% HFSS_Project generates a script to create a script file to create 
% a project in HFSS. It will assign the active design as "HFSSDesign1"
% as Modal.  
% 
% Author : Zainulabideen Khalifa            Last Revision : 9/24/2020
% 
% inputs: all inputs are to be written as strings
%     # Project_location --> like '/data/zainkh/Documents/HFSS'
%     # Project_name
%
% function [] = HFSS_Project(fileID,Project_location,Project_name)

    fprintf(fileID,'import ScriptEnv\n');
    fprintf(fileID,'ScriptEnv.Initialize("Ansoft.ElectronicsDesktop")\n');
    fprintf(fileID,'oDesktop.RestoreWindow()\n');
    fprintf(fileID,'oProject = oDesktop.NewProject("%s/%s.aedt")\n',Project_location,Project_name);
    fprintf(fileID,'oProject.InsertDesign("HFSS", "%s", "DrivenModal", "")\n',Design_name);

end
