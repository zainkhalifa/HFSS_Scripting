function [Names] = CP_LumpedEND(fileID,label,Line,Shield)
% CP_LumpedEND generates a script to draw a coplaner transmission line 
% with a lumped connection in the y-direction then you can move and rotate.
% 
% Author : Zainulabideen Khalifa            Last Revision : 08/04/2020
% 
% Line and Shield are of type struct with the following as elements. 
% All elements must be filled before calling the function. 
% 
% inputs: all inputs are to be written as strings
%     # label : is the basic name of the collection
%     # Line --> color, material, length, width, thickness, elevation
%     # Shield --> color, material, width, thickness, elevation, separation
%                  g_material, g_elevation, g_thickness
% 
% function [Names] = CP_LumpedEND(fileID,label,Line,Shield)

    Names = {};
%     Line.length = strcat(Shield.separation,"/2"); up to the user
     
    Attrib.name = label; Names(1+end) = {Attrib.name};
    Attrib.color = Line.color;
    Attrib.material = Line.material;
    Pars.x = strcat("(-",Line.width,"/2)");
    Pars.y = "0";
    Pars.z = Line.elevation;
    Pars.dx = Line.width;
    Pars.dy = strcat("5um+",Line.length);
    Pars.dz = Line.thickness;
    HFSS_Box(fileID,Pars,Attrib,0);

    Attrib.name = strcat(label,"Sa"); Names(1+end) = {Attrib.name};
    Attrib.color = Shield.color ;
    Attrib.material = Shield.material;
    Pars.x = strcat("-(",Shield.separation,"/2+",Shield.width,")");
    Pars.y = "0";
    Pars.z = Shield.elevation;
    Pars.dx = Shield.width;
    Pars.dy = strcat("5um+",Line.length,"+",Shield.separation,"/2");
    Pars.dz = Shield.thickness;
    HFSS_Box(fileID,Pars,Attrib,0);

    Attrib.name = strcat(label,"Sb"); Names(1+end) = {Attrib.name};
    Pars.x = strcat("(",Shield.separation,"/2)");
    HFSS_Box(fileID,Pars,Attrib,0);

    Attrib.name = strcat(label,"Sc"); Names(1+end) = {Attrib.name};
    Attrib.color = Shield.color ;
    Attrib.material = Shield.material;
    Pars.x = strcat("-(",Shield.separation,"/2+",Shield.width,")");
    Pars.y = strcat("5um+",Line.length,"+",Shield.separation,"/2");
    Pars.z = Shield.elevation;
    Pars.dx = strcat(Shield.separation,"+2*",Shield.width);
    Pars.dy = Shield.width;
    Pars.dz = Shield.thickness;
    HFSS_Box(fileID,Pars,Attrib,0);

    Attrib.name = strcat(label,"Sg"); Names(1+end) = {Attrib.name};
    Attrib.color = Shield.color ;
    Attrib.material = Shield.g_material;
    Pars.x = strcat("-(",Shield.separation,"/2+",Shield.width,")");
    Pars.y = "0";
    Pars.z = Shield.g_elevation;
    Pars.dx = strcat(Shield.separation,"+2*",Shield.width);
    Pars.dy = strcat("5um+",Line.length,"+",Shield.separation,"/2","+",Shield.width);
    Pars.dz = Shield.g_thickness;
    HFSS_Box(fileID,Pars,Attrib,0);
    
% adding the extra materials
     
    Attrib.name = strcat(label,"V"); Names(1+end) = {Attrib.name};
    Attrib.color = Line.color;
    Attrib.material = "ST55_viaz";
    Pars.x = strcat("(-",Line.width,"/2)");
    Pars.y = strcat("3um+",Line.length);
    Pars.z = "M5elv+M5th";
    Pars.dx = Line.width;
    Pars.dy = strcat("2um");
    Pars.dz = "M1M8th-(M5elv+M5th)+M1elv-M8th";
    HFSS_Box(fileID,Pars,Attrib,0);
    
    Attrib.name = sprintf("%sPort",label); Names(1+end) = {Attrib.name};
    Attrib.color = "128 128 128";
    Pars.x = strcat("-(",Shield.separation,"/4)");
    Pars.y = strcat("3um+1um+",Line.length);
    Pars.z = Shield.g_elevation;
    Pars.h = "M1M6th";
    Pars.w = strcat("(",Shield.separation,"/2)");
    Pars.axis = "Y";
    HFSS_Port(fileID,Pars,Attrib.name); 

    Attrib.name = strcat(label,"Sgbox");
    Attrib.color = "255 255 255";
    Attrib.material = "";
    Pars.x = strcat("-(",Shield.separation,"/2",")");
    Pars.y = strcat(Line.length);
    Pars.z = "M2elv+M2th";
    Pars.dx = strcat(Shield.separation);
    Pars.dy = strcat(Shield.separation,"/2+5um");
    Pars.dz = "M1M5th-M1M2th";
    HFSS_Box(fileID,Pars,Attrib,0);
    HFSS_Subtract(fileID,strcat(label,"Sg"),strcat(label,"Sgbox"));
end
