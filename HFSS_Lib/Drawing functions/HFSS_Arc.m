function [] = HFSS_Arc(fileID,Pars,Attrib)
% HFSS_Arc generates a script to draws a rectangular Arc in HFSS by 
% creating a 3-point arc with center at origien then moving it internally 
% using the function HFSS_Move. 
% 
% Author : Zainulabideen Khalifa            Last Revision : 08/07/2020
% 
% Pars and Attrib are of type struct with the following as elements. 
% All elements must be filled before calling the function. 
% 
% Note that Pars.r is the center radius of the Arc and Pars.z is the bottom
% face elevation.
% 
% inputs: all inputs are to be written as strings
%     # Pars --> x,y,z,r,w,h,theta,dtheta
%         - the center is x,y,z
%         - r is the radius, w for width and h for hight
%         - theta is the start angle and dtheta is the arc length 
%     # Attrib --> name, color, material
%         - name is the label of that element like "Box1"
%         - color is a string with RGB like (0 0 255) for blue
%         - material is the string name of the material defined in your
%           HFSS design like "pec" or "vacuum".
%     # "NoS" is a variable that must be predefined in HFSS which is the 
%       number of sections. make zero for the default in HFSS. 
% 
% function [] = HFSS_Arc(fileID,Pars,Attrib)


    Pars.z = strcat(Pars.z,"+","(",Pars.h,")/2");
    fprintf(fileID,'oEditor = oDesign.SetActiveEditor("3D Modeler")\n');
    fprintf(fileID,'oEditor.CreatePolyline(\n');
    fprintf(fileID,'	[\n');
    fprintf(fileID,'		"NAME:PolylineParameters",\n');
    fprintf(fileID,'		"IsPolylineCovered:="	, True,\n');
    fprintf(fileID,'		"IsPolylineClosed:="	, False,\n');
    fprintf(fileID,'		[\n');
    fprintf(fileID,'			"NAME:PolylinePoints",\n');
    fprintf(fileID,'			[\n');
    fprintf(fileID,'				"NAME:PLPoint",\n');
    fprintf(fileID,'				"X:="			, "(%s)*sin(%s)",\n',Pars.r,Pars.theta);
    fprintf(fileID,'				"Y:="			, "(%s)*cos(%s)",\n',Pars.r,Pars.theta);
    fprintf(fileID,'				"Z:="			, "%s"\n',Pars.z);
    fprintf(fileID,'			],\n');
    fprintf(fileID,'		],\n');
    fprintf(fileID,'		[\n');
    fprintf(fileID,'			"NAME:PolylineSegments",\n');
    fprintf(fileID,'			[\n');
    fprintf(fileID,'				"NAME:PLSegment",\n');
    fprintf(fileID,'				"SegmentType:="		, "AngularArc",\n');
    fprintf(fileID,'				"StartIndex:="		, 0,\n');
    fprintf(fileID,'				"NoOfPoints:="		, 3,\n');
    fprintf(fileID,'				"NoOfSegments:="	, "NoS",\n');
    fprintf(fileID,'				"ArcAngle:="		, "%s",\n',Pars.dtheta);
    fprintf(fileID,'				"ArcCenterX:="		, "0",\n');
    fprintf(fileID,'				"ArcCenterY:="		, "0",\n');
    fprintf(fileID,'				"ArcCenterZ:="		, "%s",\n',Pars.z);
    fprintf(fileID,'				"ArcPlane:="		, "XY"\n');
    fprintf(fileID,'			]\n');
    fprintf(fileID,'		],\n');
    fprintf(fileID,'		[\n');
    fprintf(fileID,'			"NAME:PolylineXSection",\n');
    fprintf(fileID,'			"XSectionType:="	, "Rectangle",\n');
    fprintf(fileID,'			"XSectionOrient:="	, "Auto",\n');
    fprintf(fileID,'			"XSectionWidth:="	, "%s",\n',Pars.w);
    fprintf(fileID,'			"XSectionTopWidth:="	, "0mm",\n');
    fprintf(fileID,'			"XSectionHeight:="	, "%s",\n',Pars.h);
    fprintf(fileID,'			"XSectionNumSegments:="	, "0",\n');
    fprintf(fileID,'			"XSectionBendType:="	, "Corner"\n');
    fprintf(fileID,'		]\n');
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
    Pars.z = "0";
    HFSS_Move(fileID,Attrib.name,Pars)
end
