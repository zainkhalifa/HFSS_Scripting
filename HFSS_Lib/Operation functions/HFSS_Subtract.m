function [] = HFSS_Subtract(fileID,name1,name2)
% HFSS_Subtract generates a script to subtracts two objects in HFSS without
% keeping the original. 
% Note that ...
% HFSS_Subtract(fileID,name1,name2) ~= HFSS_Subtract(fileID,name2,name1) 
% 
% Author : Zainulabideen Khalifa            Last Revision : 2/22/2020
% 
% inputs: all inputs are to be written as strings
%     # name is the label of that element like "Box1"
%
% function [] = HFSS_Subtract(fileID,name1,name2)

    fprintf(fileID,'oEditor = oDesign.SetActiveEditor("3D Modeler")\n');
    fprintf(fileID,'oEditor.Subtract(\n');
    fprintf(fileID,'	[\n');
    fprintf(fileID,'		"NAME:Selections",\n');
    fprintf(fileID,'		"Blank Parts:="		, "%s",\n',name1);
    fprintf(fileID,'		"Tool Parts:="		, "%s"\n',name2);
    fprintf(fileID,'	], \n');
    fprintf(fileID,'	[\n');
    fprintf(fileID,'		"NAME:SubtractParameters",\n');
    fprintf(fileID,'		"KeepOriginals:="	, False\n');
    fprintf(fileID,'	])\n');
end
