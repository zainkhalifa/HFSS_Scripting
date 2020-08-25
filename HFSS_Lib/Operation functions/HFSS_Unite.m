function [] = HFSS_Unite(fileID,names)
% HFSS_Unite generates a script to unite a set of objects in HFSS. 
% 
% Author : Zainulabideen Khalifa            Last Revision : 2/22/2020
% 
% inputs: all inputs are to be written as strings
%     # names are the labels of the elements as a cell array
%       like {"Box1" "Box123" "ring1"}
%
% function [] = HFSS_Unite(fileID,names)


    N = length(names);
    if N<2
        error('HFSS_Unite: number of names is less then 2')
    end
    fprintf(fileID,'oEditor = oDesign.SetActiveEditor("3D Modeler")\n');
    fprintf(fileID,'oEditor.Unite(\n');
    fprintf(fileID,'	[\n');
    fprintf(fileID,'		"NAME:Selections",\n');
    fprintf(fileID,'		"Selections:="		,\n"');
    for i=1:N-1
        fprintf(fileID,'%s,',names{i});
    end
    fprintf(fileID,'%s',names{end});
    fprintf(fileID,'"\n');
    fprintf(fileID,'	], \n');
    fprintf(fileID,'	[\n');
    fprintf(fileID,'		"NAME:UniteParameters",\n');
    fprintf(fileID,'		"KeepOriginals:="	, False\n');
    fprintf(fileID,'	])\n');
end
