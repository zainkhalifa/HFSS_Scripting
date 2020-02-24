function [] = HFSS_Property(fileID, Property, Value)
% HFSS_Property generates a script to change a property or a variable in HFSS. 
% 
% Author : Zainulabideen Khalifa            Last Revision : 2/22/2020
% 
% inputs: all inputs are to be written as strings
%     # Property --> name of that variable
%     # Value

    fprintf(fileID,'oDesign.ChangeProperty(\n');
    fprintf(fileID,'	[\n');
    fprintf(fileID,'		"NAME:AllTabs",\n');
    fprintf(fileID,'		[\n');
    fprintf(fileID,'			"NAME:LocalVariableTab",\n');
    fprintf(fileID,'			[\n');
    fprintf(fileID,'				"NAME:PropServers", \n');
    fprintf(fileID,'				"LocalVariables"\n');
    fprintf(fileID,'			],\n');
    fprintf(fileID,'			[\n');
    fprintf(fileID,'				"NAME:ChangedProps",\n');
    fprintf(fileID,'				[\n');
    fprintf(fileID,'					"NAME:%s",\n',Property);
    fprintf(fileID,'					"Value:="		, "%s"\n',Value);
    fprintf(fileID,'				]\n');
    fprintf(fileID,'			]\n');
    fprintf(fileID,'		]\n');
    fprintf(fileID,'	])\n');
end
