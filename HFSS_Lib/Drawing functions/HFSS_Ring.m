function [] = HFSS_Ring(fileID,Pars,Attrib)
% HFSS_Ring generates a script to draws a rectangular ring in HFSS by
% creating two cylinders and subtracting them.
% 
% Author : Zainulabideen Khalifa            Last Revision : 2/22/2020
% 
% Pars and Attrib are of type struct with the following as elements. 
% All elements must be filled before calling the function. 
% 
% inputs: all inputs are to be written as strings
%     # Pars --> x,y,z,r,w,h
%         - the center is x,y with mid-elevation z
%         - r is the radius, w for width and h for hight
%     # Attrib --> name, color, material
%         - name is the label of that element like "Box1"
%         - color is a string with RGB like (0 0 255) for blue
%         - material is the string name of the material defined in your
%           HFSS design like "pec" or "vacuum".
%     # "NoS" is a variable that must be predefined in HFSS which is the 
%       number of sections. make zero for the default in HFSS. 

    Pars1.x = Pars.x;
    Pars1.y = Pars.y;
    Pars1.z = Pars.z;
    Pars1.r = strcat(Pars.r,"+",Pars.w,"/2");
    Pars1.h = Pars.h;
    Pars2.x = Pars.x;
    Pars2.y = Pars.y;
    Pars2.z = Pars.z;
    Pars2.r = strcat(Pars.r,"-",Pars.w,"/2");
    Pars2.h = Pars.h;
    Attrib1 = Attrib;
    Attrib2 = Attrib;
    Attrib1.name = strcat(Attrib1.name,"1");
    Attrib2.name = strcat(Attrib2.name,"2");
    Create_Cylinder(fileID,Pars1,Attrib1);
    Create_Cylinder(fileID,Pars2,Attrib2);
    Subtract(fileID,Attrib1.name,Attrib2.name);
end
