function [Names] = CP_Portsheet(fileID,label,Line,Shield)
% CP_Portsheet generates a script to draws a port for the coplaner 
% transmission line in the y-direction then you can move and rotate.
% 
% Author : Zainulabideen Khalifa            Last Revision : 07/08/2020
% 
% Line and Shield are of type struct with the following as elements. 
% All elements must be filled before calling the function. 
% 
% inputs: all inputs are to be written as strings
%     # label : is the basic name of the collection
%     # Line -->  width
%     # Shield --> width, separation, g_elevation
% 
% function [Names] = CP_Portsheet(fileID,label,Line,Shield)


Attrib.name = sprintf("%sBox",label); 
Attrib.color = "128 128 128";
Attrib.material = "pec";
Pars.x = strcat("-(",Shield.separation,"/2+",Shield.width,"/4)");
Pars.y = strcat("0");
Pars.z = Shield.g_elevation;
Pars.dx = strcat("(",Shield.separation,"+",Shield.width,"/2)");
Pars.dy = strcat("(","1um",")");
Pars.dz = "WP_h";
HFSS_Box(fileID,Pars,Attrib,0);
Pars.h = Pars.dz;
Pars.w = Pars.dx;
Pars.axis = "Y";
HFSS_Port(fileID,Pars,label); 

Names{1} = Attrib.name;
Names{2} = label;
end
