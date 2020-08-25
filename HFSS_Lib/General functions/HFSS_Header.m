function [] = HFSS_Header(fileID,Project_name, Design_name)
% HFSS_Header generates a script to create a script file to initiate 
% modifications on an HFSS project with active design as "HFSSDesign1".
% HFSS_Header must be called at the beginning once after creating the
% project and before calling any other functions. 
% 
% Author : Zainulabideen Khalifa            Last Revision : 8/13/2020
% 
% inputs: all inputs are to be written as strings
%     # Project_name
%
% function [] = HFSS_Header(fileID,Project_name, Design_name)

    fprintf(fileID,'import ScriptEnv\n');
    fprintf(fileID,'ScriptEnv.Initialize("Ansoft.ElectronicsDesktop")\n');
    fprintf(fileID,'oDesktop.RestoreWindow()\n');
    fprintf(fileID,'oProject = oDesktop.SetActiveProject("%s")\n',Project_name);
    fprintf(fileID,'oDesign = oProject.SetActiveDesign("%s")\n',Design_name);
    fprintf(fileID,'oEditor = oDesign.SetActiveEditor("3D Modeler")\n');
end
