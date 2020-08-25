function [] = HFSS_Variable(fileID,Vars)
% HFSS_Variable generates a script to create a list of variables in the 
% active HFSS design. 
% 
% Author : Zainulabideen Khalifa            Last Revision : 2/22/2020
% 
% 
% inputs: all inputs are to be written as strings
%     # Vars is a cell array with two colomns as {"name" "value"}
% 
% example:
% Vars = {"TRL_Lm1"     "20um"  ;...       % line 1 length
%         "TRL_Lm2"     "20um"  ;...       % line 2 length
%         "TRL_Lmo"     "20um"  }          % Stub length
% 
% function [] = HFSS_Variable(fileID,Vars)

    for idx = 1:length(Vars(:,1))
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
        fprintf(fileID,'				"NAME:NewProps",\n');
        fprintf(fileID,'				[\n');
        fprintf(fileID,'					"NAME:%s",\n',Vars{idx,1});
        fprintf(fileID,'					"PropType:="		, "VariableProp",\n');
        fprintf(fileID,'					"UserDef:="		, True,\n');
        fprintf(fileID,'					"Value:="		, "%s"\n',Vars{idx,2});
        fprintf(fileID,'				]\n');
        fprintf(fileID,'			]\n');
        fprintf(fileID,'		]\n');
        fprintf(fileID,'	])\n');
    end
end
