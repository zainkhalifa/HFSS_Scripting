function [] = HFSS_Port(fileID,Pars,name)
% HFSS_Port generates a script to draws a rectangle sheet in HFSS. 
% 
% Author : Zainulabideen Khalifa            Last Revision : 2/22/2020
% 
% Pars is of type struct with the following as elements. 
% All elements must be filled before calling the function. 
% 
% Note that HFSS_Port does not define the excitation. 
%
% inputs: all inputs are to be written as strings
%     # Pars --> x,y,z,w,h,axis
%         - the center is x,y with elevation z
%         - w for width and h for hight. It will depend on the axis. 
%         - axis is either "X", "Y" or "Z"
%     # name is the label of that element like "Box1"
% 
% function [] = HFSS_Port(fileID,Pars,name)

    fprintf(fileID,'oEditor = oDesign.SetActiveEditor("3D Modeler")\n');
    fprintf(fileID,'oEditor.CreateRectangle(\n');
    fprintf(fileID,'	[\n');
    fprintf(fileID,'		"NAME:RectangleParameters",\n');
    fprintf(fileID,'		"IsCovered:="		, True,\n');
    fprintf(fileID,'		"XStart:="		, "%s",\n',Pars.x);
    fprintf(fileID,'		"YStart:="		, "%s",\n',Pars.y);
    fprintf(fileID,'		"ZStart:="		, "%s",\n',Pars.z);
    fprintf(fileID,'		"Width:="		, "%s",\n',Pars.h);
    fprintf(fileID,'		"Height:="		, "%s",\n',Pars.w);
    fprintf(fileID,'		"WhichAxis:="		, "%s"\n',Pars.axis);
    fprintf(fileID,'	], \n');
    fprintf(fileID,'	[\n');
    fprintf(fileID,'		"NAME:Attributes",\n');
    fprintf(fileID,'		"Name:="		, "%s",\n',name);
    fprintf(fileID,'		"Flags:="		, "",\n');
    fprintf(fileID,'		"Color:="		, "(255 255 255)",\n');
    fprintf(fileID,'		"Transparency:="	, 0.75,\n');
    fprintf(fileID,'		"PartCoordinateSystem:=", "Global",\n');
    fprintf(fileID,'		"UDMId:="		, "",\n');
    fprintf(fileID,'		"MaterialValue:="	, "\\"vacuum\\"",\n');
    fprintf(fileID,'		"SolveInside:="		, True\n');
    fprintf(fileID,'	])\n');
end
