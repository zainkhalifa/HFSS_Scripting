function [] = HFSS_Move(fileID,Names,vector)
% HFSS_Move generates a script to move an object or many objects in HFSS. 
% 
% Author : Zainulabideen Khalifa            Last Revision : 07/08/2020
% 
% vector is of type struct with the following as elements. 
% All elements must be filled before calling the function. 
% 
% inputs: all inputs are to be written as strings
%     # vector --> x,y,z
%     # Names is a cell array with the label of those elements like "Box1"
%
% function [] = HFSS_Move(fileID,Names,vector)

    N = length(Names);
    fprintf(fileID,'oEditor = oDesign.SetActiveEditor("3D Modeler")\n');
    fprintf(fileID,'oEditor.Move(\n');
    fprintf(fileID,'	[\n');
    fprintf(fileID,'		"NAME:Selections",\n');
    fprintf(fileID,'		"Selections:="		, "');
    for i=1:N-1,fprintf(fileID,'%s,',Names{i});end
    fprintf(fileID,'%s",\n',Names{N});
    fprintf(fileID,'		"NewPartsModelFlag:="	, "Model"\n');
    fprintf(fileID,'	], \n');
    fprintf(fileID,'	[\n');
    fprintf(fileID,'		"NAME:TranslateParameters",\n');
    fprintf(fileID,'		"TranslateVectorX:="	, "%s",\n',vector.x);
    fprintf(fileID,'		"TranslateVectorY:="	, "%s",\n',vector.y);
    fprintf(fileID,'		"TranslateVectorZ:="	, "%s"\n',vector.z);
    fprintf(fileID,'	])\n');

end
