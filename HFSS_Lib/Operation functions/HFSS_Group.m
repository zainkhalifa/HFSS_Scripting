function [] = HFSS_Group(fileID,Names)
% HFSS_Group generates a script to group a set of objects in HFSS. 
% 
% Author : Zainulabideen Khalifa            Last Revision : 2/24/2020
% 
% inputs: all inputs are to be written as strings
%     # names are the labels of the elements as a cell array
%       like {"Box1" "Box123" "ring1"}



    N = length(Names);
    if N<2
        error('HFSS_Group: number of names is less then 2')
    end
    fprintf(fileID,'oEditor = oDesign.SetActiveEditor("3D Modeler")\n');
    fprintf(fileID,'oEditor.CreateGroup(\n');
    fprintf(fileID,'	[\n');
    fprintf(fileID,'		"NAME:GroupParameter",\n');
    fprintf(fileID,'		"ParentGroupID:="	, "Model",\n');
    
    fprintf(fileID,'		"Parts:="		, "');
    for i=1:N-1
        fprintf(fileID,'%s,',Names{i});
    end
    fprintf(fileID,'%s",\n',Names{N});
    fprintf(fileID,'		"SubmodelInstances:="	, "",\n');
    fprintf(fileID,'		"Groups:="		, ""\n');
    fprintf(fileID,'	])\n');
end


