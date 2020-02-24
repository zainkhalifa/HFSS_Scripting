function [] = HFSS_Box(fileID,Pars,Attrib,S)
% HFSS_Box generates a script to draws a box in HFSS. 
% 
% Author : Zainulabideen Khalifa            Last Revision : 2/22/2020
% 
% Pars and Attrib are of type struct with the following as elements. 
% All elements must be filled before calling the function. 
% 
% inputs: all inputs are to be written as strings
%     # Pars --> x,y,z,dx,dy,dz
%           the start is x,y,z
%     # Attrib --> name, color, material
%         - name is the label of that element like "Box1"
%         - color is a string with RGB like (0 0 255) for blue
%         - material is the string name of the material defined in your
%           HFSS design like "pec" or "vacuum".
%     # S : for solve inside or not (1 or 0)


if S
    S_lbl = "True";
else 
    S_lbl = "False";
end

    fprintf(fileID,'oEditor = oDesign.SetActiveEditor("3D Modeler")\n');
    fprintf(fileID,'oEditor.CreateBox(\n');
    fprintf(fileID,'	[\n');
    fprintf(fileID,'		"NAME:BoxParameters",\n');
    fprintf(fileID,'		"XPosition:="		, "%s",\n',Pars.x);
    fprintf(fileID,'		"YPosition:="		, "%s",\n',Pars.y);
    fprintf(fileID,'		"ZPosition:="		, "%s",\n',Pars.z);
    fprintf(fileID,'		"XSize:="		, "%s",\n',Pars.dx);
    fprintf(fileID,'		"YSize:="		, "%s",\n',Pars.dy);
    fprintf(fileID,'		"ZSize:="		, "%s"\n',Pars.dz);
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
    fprintf(fileID,'		"SolveInside:="		, %s\n',S_lbl);
    fprintf(fileID,'	])\n');

end
