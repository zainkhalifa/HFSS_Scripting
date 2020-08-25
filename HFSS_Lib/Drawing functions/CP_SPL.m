function [Names] = CP_SPL(fileID,label,Line,Shield)
% CP_SPL generates a script to draw a coplaner transmission line in the 
% y-direction as an (HFSS) spline then you can move and rotate.
% 
% Author : Zainulabideen Khalifa            Last Revision : 07/13/2020
% 
% Line and Shield are of type struct with the following as elements. 
% All elements must be filled before calling the function. 
% 
% inputs: all inputs are to be written as strings
%     # label : is the basic name of the collection
%     # Line --> color, material,length, width, thickness, elevation,
%               k,A,N
%               where k is the frequency, A is amplitude, and N+1 is the 
%               total number of points
%     # Shield --> color, material, width, thickness, elevation, separation
%                  g_material, g_elevation, g_thickness
% 
% function [Names] = CP_SPL(fileID,label,Line,Shield)

    Names = {};
    
    Attrib.name = label; Names(1+end) = {Attrib.name};
    Attrib.color = Line.color;
    Attrib.material = Line.material;
    Pars.x = {};
    Pars.y = {};
    Pars.z = {};
    Line.dy = strcat("(",Line.length,sprintf("/%0.0f",Line.N),")");
    
    for idx = 1:Line.N+1
        Pars.x(idx) = {sprintf("%s*sin(%s*%0.0f*2*PI/%0.0f)"...
            ,Line.A,Line.k,idx-1, Line.N)};
        Pars.y(idx) = {sprintf("%0.0f*%s",idx-1,Line.dy)};
        Pars.z(idx) = {strcat(Line.elevation,"+",Line.thickness,"/2")};        
    end
    Pars.w = Line.width;
    Pars.h = Line.thickness;
    Pars.NoS = "NoS";
    HFSS_Spline(fileID,Pars,Attrib);
    
    Attrib.name = strcat(label,"Ca");Names(1+end) = {Attrib.name};
    CPars.x = Pars.x{1};
    CPars.y = Pars.y{1};
    CPars.z = Line.elevation;
    CPars.h = Pars.h;
    CPars.r = Pars.w + "/2";
    HFSS_Cylinder(fileID,CPars,Attrib);
    
    Attrib.name = strcat(label,"Cb");Names(1+end) = {Attrib.name};
    CPars.x = Pars.x{end};
    CPars.y = Pars.y{end};
    CPars.z = Line.elevation;
    CPars.h = Pars.h;
    CPars.r = Pars.w + "/2";
    HFSS_Cylinder(fileID,CPars,Attrib);
    
    Attrib.name = strcat(label,"Sa");Names(1+end) = {Attrib.name};
    Attrib.color = Shield.color ;
    Attrib.material = Shield.material;
    Pars.x = strcat("-(",Shield.separation,"/2+",Shield.width,")");
    Pars.y = "0";
    Pars.z = Shield.elevation;
    Pars.dx = Shield.width;
    Pars.dy = Line.length;
    Pars.dz = Shield.thickness;
    HFSS_Box(fileID,Pars,Attrib,0);

    Attrib.name = strcat(label,"Sb");Names(1+end) = {Attrib.name};
    Pars.x = strcat("(",Shield.separation,"/2)");
    HFSS_Box(fileID,Pars,Attrib,0);
    
    Attrib.name = strcat(label,"Sg");Names(1+end) = {Attrib.name};
    Attrib.color = Shield.color ;
    Attrib.material = Shield.g_material;
    Pars.x = strcat("-(",Shield.separation,"/2+",Shield.width,")");
    Pars.y = "0";
    Pars.z = Shield.g_elevation;
    Pars.dx = strcat(Shield.separation,"+2*",Shield.width);
    Pars.dy = Line.length;
    Pars.dz = Shield.g_thickness;
    HFSS_Box(fileID,Pars,Attrib,0);
    
end

%     sign = 1;
%     for n_idx = 1:11
%         switch mod(n_idx,2)
%             case 1
%                 Pars.x(n_idx) = {sprintf("0")};
%                 Pars.y(n_idx) = {sprintf("%0.0f*SPL_dy",n_idx-1)};
%             otherwise
%                 Pars.x(n_idx) = {sprintf("%0.0f*SPL_dx",sign)};sign = (-1)*sign;
%                 Pars.y(n_idx) = {sprintf("%0.0f*SPL_dy",n_idx-1)};
%         end
%     Pars.z(n_idx) = {"M8elv+M8th/2"};        
%     end
%     
%     Pars.x = cat(2,{"0"},Pars.x);
%     Pars.y = cat(2,Pars.y{1}+"-0.5um",Pars.y);
%     Pars.z = cat(2,Pars.z{1},Pars.z); 
%     Pars.x = cat(2,Pars.x,{"0"});
%     Pars.y = cat(2,Pars.y,Pars.y{end}+"+0.5um");
%     Pars.z = cat(2,Pars.z,Pars.z{1}); 
