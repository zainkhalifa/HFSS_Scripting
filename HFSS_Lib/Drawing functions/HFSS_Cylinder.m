function [] = HFSS_Cylinder(fileID,Pars,Attrib)
% HFSS_Cylinder generates a script to draws a Cylinder in HFSS. 
% 
% Author : Zainulabideen Khalifa            Last Revision : 2/22/2020
% 
% Pars and Attrib are of type struct with the following as elements. 
% All elements must be filled before calling the function. 
% 
% inputs: all inputs are to be written as strings
%     # Pars --> x,y,z,r,h
%         - the center is x,y with elevation z
%         - r is the radius and h for hight
%     # Attrib --> name, color, material
%         - name is the label of that element like "Box1"
%         - color is a string with RGB like (0 0 255) for blue
%         - material is the string name of the material defined in your
%           HFSS design like "pec" or "vacuum".
%     # "NoS" is a variable that must be predefined in HFSS which is the 
%       number of sections. make zero for the default in HFSS. 
% 
% function [] = HFSS_Cylinder(fileID,Pars,Attrib)

    fprintf(fileID,'oEditor = oDesign.SetActiveEditor("3D Modeler")\n');
    fprintf(fileID,'oEditor.CreateCylinder(\n');
    fprintf(fileID,'	[\n');
    fprintf(fileID,'		"NAME:CylinderParameters",\n');
    fprintf(fileID,'		"XCenter:="		, "%s",\n',Pars.x);
    fprintf(fileID,'		"YCenter:="		, "%s",\n',Pars.y);
    fprintf(fileID,'		"ZCenter:="		, "%s",\n',Pars.z);
    fprintf(fileID,'		"Radius:="		, "%s",\n',Pars.r);
    fprintf(fileID,'		"Height:="		, "%s",\n',Pars.h);
    fprintf(fileID,'		"WhichAxis:="		, "Z",\n');
    fprintf(fileID,'		"NumSides:="		, "NoS"\n');
    fprintf(fileID,'	], \n');
    fprintf(fileID,'	[\n');
    fprintf(fileID,'		"NAME:Attributes",\n');
    fprintf(fileID,'		"Name:="		, "%s",\n',Attrib.name);
    fprintf(fileID,'		"Flags:="		, "",\n');
    fprintf(fileID,'		"Color:="		, "(%s)",\n',Attrib.color);
    fprintf(fileID,'		"Transparency:="	, 0,\n');
    fprintf(fileID,'		"PartCoordinateSystem:=", "Global",\n');
    fprintf(fileID,'		"UDMId:="		, "",\n');
    fprintf(fileID,'		"MaterialValue:="	, "\\"%s\\"",\n',Attrib.material);
    fprintf(fileID,'		"SolveInside:="		, False\n');
    fprintf(fileID,'	])\n');
    
end
