function [] = HFSS_Copy(fileID,name)
% HFSS_Copy generates a script to copy an object in HFSS. 
% 
% Author : Zainulabideen Khalifa            Last Revision : 2/22/2020
% 
% inputs: all inputs are to be written as strings
%     # name is the label of the element like "Box1"
%       the copies object will have the same name then a number starting
%       from 1.

    fprintf(fileID,'oEditor = oDesign.SetActiveEditor("3D Modeler")\n');
    fprintf(fileID,'oEditor.Copy(\n');
    fprintf(fileID,'	[\n');
    fprintf(fileID,'		"NAME:Selections",\n');
    fprintf(fileID,'		"Selections:="		, "%s"\n',name);
    fprintf(fileID,'	])\n');
    fprintf(fileID,'oEditor.Paste()\n');
end