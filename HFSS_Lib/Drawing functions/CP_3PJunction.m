function [Names] = CP_3PJunction(fileID,label,Line,Shield)
% CP_3PJunction generates a script to draws a coplaner T-Junction then you 
% can move and rotate. 
% 
% Author : Zainulabideen Khalifa            Last Revision : 07/08/2020
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
% function [Names] = CP_3PJunction(fileID,label,Line,Shield)
	
    Names = {};
    Line.length = strcat(Shield.separation,"/2");

    Attrib.name = strcat(label,"a"); Names{1+end} = Attrib.name;
    Attrib.color = Line.color;
    Attrib.material = Line.material;
    Pars.x = strcat("(-",Line.width,"/2)");
    Pars.y = "0";
    Pars.z = Line.elevation;
    Pars.dx = Line.width;
    Pars.dy = strcat(Shield.width,"+",Line.length ,"+", Line.width,"/2");
    Pars.dz = Line.thickness;
    HFSS_Box(fileID,Pars,Attrib,0);
    
    Attrib.name = strcat(label,"b"); Names{1+end} = Attrib.name;
    Pars.x = strcat("-(",Line.length,"+",Shield.width,")");
    Pars.y = strcat(Shield.width,"+",Shield.separation,"/2-",Line.width,"/2");
    Pars.dx = strcat("2*(",Line.length,"+",Shield.width,")");
    Pars.dy = Line.width;
    HFSS_Box(fileID,Pars,Attrib,0);

    Attrib.name = strcat(label,"Sa"); Names{1+end} = Attrib.name;
    Attrib.color = Shield.color ;
    Attrib.material = Shield.material;
    Pars.x = strcat("-(",Line.length,"+",Shield.width,")");
    Pars.y = strcat(Shield.width,"+",Shield.separation);
    Pars.z = Shield.elevation;
    Pars.dx = strcat("2*(",Line.length,"+",Shield.width,")");
    Pars.dy = Shield.width;
    Pars.dz = Shield.thickness;
    HFSS_Box(fileID,Pars,Attrib,0);

    Attrib.name = strcat(label,"Sb"); Names{1+end} = Attrib.name;
    Pars.x = strcat("-(",Line.length,"+",Shield.width,")");
    Pars.y = "0";
    Pars.z = Shield.elevation;
    Pars.dx = Shield.width;
    Pars.dy = Shield.width;
    Pars.dz = Shield.thickness;
    HFSS_Box(fileID,Pars,Attrib,0);
    
    Attrib.name = strcat(label,"Sc"); Names{1+end} = Attrib.name;
    Pars.x = strcat("(",Line.length,")");
    Pars.y = "0";
    Pars.z = Shield.elevation;
    Pars.dx = Shield.width;
    Pars.dy = Shield.width;
    Pars.dz = Shield.thickness;
    HFSS_Box(fileID,Pars,Attrib,0);
    
    Attrib.name = strcat(label,"Sg"); Names{1+end} = Attrib.name;
    Attrib.color = Shield.color ;
    Attrib.material = Shield.g_material;
    Pars.x = strcat("-(",Line.length,"+",Shield.width,")");
    Pars.y = "0";
    Pars.z = Shield.g_elevation;
    Pars.dx = strcat("2*(",Line.length,"+",Shield.width,")");
    Pars.dy = strcat("2*(",Shield.width,"+",Line.length,")");
    Pars.dz = Shield.g_thickness;
    HFSS_Box(fileID,Pars,Attrib,0);
    
end
