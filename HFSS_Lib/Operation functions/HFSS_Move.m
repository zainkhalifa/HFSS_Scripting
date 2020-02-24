function [] = HFSS_Move(fileID,name,vector)
% HFSS_Move generates a script to move an object in HFSS. 
% 
% Author : Zainulabideen Khalifa            Last Revision : 2/22/2020
% 
% vector is of type struct with the following as elements. 
% All elements must be filled before calling the function. 
% 
% inputs: all inputs are to be written as strings
%     # vector --> x,y,z
%     # name is the label of that element like "Box1"

    fprintf(fileID,'oEditor = oDesign.SetActiveEditor("3D Modeler")\n');
    fprintf(fileID,'oEditor.Move(\n');
    fprintf(fileID,'	[\n');
    fprintf(fileID,'		"NAME:Selections",\n');
    fprintf(fileID,'		"Selections:="		, "%s",\n',name);
    fprintf(fileID,'		"NewPartsModelFlag:="	, "Model"\n');
    fprintf(fileID,'	], \n');
    fprintf(fileID,'	[\n');
    fprintf(fileID,'		"NAME:TranslateParameters",\n');
    fprintf(fileID,'		"TranslateVectorX:="	, "%s",\n',vector.x);
    fprintf(fileID,'		"TranslateVectorY:="	, "%s",\n',vector.y);
    fprintf(fileID,'		"TranslateVectorZ:="	, "%s"\n',vector.z);
    fprintf(fileID,'	])\n');

end
