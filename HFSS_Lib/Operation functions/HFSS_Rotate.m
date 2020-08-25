function [] = HFSS_Rotate(fileID,Names,angle)
% HFSS_Rotate generates a script to rotate an object or many objects in HFSS. 
% 
% Author : Zainulabideen Khalifa            Last Revision : 07/08/2020
% 
% inputs: all inputs are to be written as strings
%     # angle --> the angle of rotation in radians
%     # Names is a cell array with the label of those elements like "Box1"
%
% function [] = HFSS_Rotate(fileID,Names,angle)


    N = length(Names);
    fprintf(fileID,'oEditor = oDesign.SetActiveEditor("3D Modeler")\n');
    fprintf(fileID,'oEditor.Rotate(\n');
    fprintf(fileID,'	[\n');
    fprintf(fileID,'		"NAME:Selections",\n');
    fprintf(fileID,'		"Selections:="		, "');
    for i=1:N-1,fprintf(fileID,'%s,',Names{i});end
    fprintf(fileID,'%s",\n',Names{N});
    fprintf(fileID,'		"NewPartsModelFlag:="	, "Model"\n');
    fprintf(fileID,'	], \n');
    fprintf(fileID,'	[\n');
    fprintf(fileID,'		"NAME:RotateParameters",\n');
    fprintf(fileID,'		"RotateAxis:="		, "Z",\n');
    fprintf(fileID,'		"RotateAngle:="		, "%s"\n',angle);
    fprintf(fileID,'	])\n');
end
