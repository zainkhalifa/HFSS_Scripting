function [Names] = CP_CirTRL(fileID,label,Line,Shield, radius, angle)
% CP_CirTRL generates a script to draw a circular shaped coplaner 
% transmission line then you can move and rotate.
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
% function [Names] = CP_CirTRL(fileID,label,Line,Shield, radius, angle)

    Names = {};

    Attrib.name = label;Names(1+end) = {Attrib.name};
    Attrib.color = Line.color;
    Attrib.material = Line.material;
    Pars.x = "0";
    Pars.y = "0";
    Pars.z = Line.elevation;
    Pars.r = strcat(Shield.separation,"/2+",Shield.width,"+(",radius,")");
    Pars.w = Line.width;
    Pars.h = Line.thickness;
    Pars.theta = sprintf("PI+(%s)",angle);
    Pars.dtheta = sprintf("(%s)",angle);
    HFSS_Arc(fileID,Pars,Attrib);  

    Attrib.name = strcat(label,"Sa");Names(1+end) = {Attrib.name};
    Attrib.color = Shield.color ;
    Attrib.material = Shield.material;
    Pars.z = Shield.elevation;
    Pars.r = strcat(Shield.width,"/2","+(",radius,")");
    Pars.w = Shield.width;
    Pars.h = Shield.thickness;
    HFSS_Arc(fileID,Pars,Attrib);  
    
    Attrib.name = strcat(label,"Sb");Names(1+end) = {Attrib.name};
    Pars.r = strcat("1.5*",Shield.width,"+",Shield.separation,"+(",radius,")");
    HFSS_Arc(fileID,Pars,Attrib);  
 
    Attrib.name = strcat(label,"Sg");Names(1+end) = {Attrib.name};
    Attrib.material = Shield.g_material;
    Pars.r = strcat(Shield.separation,"/2+",Shield.width,"+(",radius,")");
    Pars.w = strcat(Shield.separation,"+2*",Shield.width,"-0.1um");
    Pars.z = Shield.g_elevation;
    Pars.h = Shield.g_thickness;
    HFSS_Arc(fileID,Pars,Attrib);  
        

end
