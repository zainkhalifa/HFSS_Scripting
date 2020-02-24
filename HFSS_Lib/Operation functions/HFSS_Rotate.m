function [] = HFSS_Rotate(fileID,name,angle)
% HFSS_Rotate generates a script to rotate an object in HFSS. 
% 
% Author : Zainulabideen Khalifa            Last Revision : 2/22/2020
% 
% inputs: all inputs are to be written as strings
%     # angle --> the angle of rotation in radians
%     # name is the label of that element like "Box1"


    fprintf(fileID,'oEditor = oDesign.SetActiveEditor("3D Modeler")\n');
    fprintf(fileID,'oEditor.Rotate(\n');
    fprintf(fileID,'	[\n');
    fprintf(fileID,'		"NAME:Selections",\n');
    fprintf(fileID,'		"Selections:="		, "%s",\n',name);
    fprintf(fileID,'		"NewPartsModelFlag:="	, "Model"\n');
    fprintf(fileID,'	], \n');
    fprintf(fileID,'	[\n');
    fprintf(fileID,'		"NAME:RotateParameters",\n');
    fprintf(fileID,'		"RotateAxis:="		, "Z",\n');
    fprintf(fileID,'		"RotateAngle:="		, "%s"\n',angle);
    fprintf(fileID,'	])\n');
end
