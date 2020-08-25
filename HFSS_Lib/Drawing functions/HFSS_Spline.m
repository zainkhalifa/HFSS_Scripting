function [] = HFSS_Spline(fileID,Pars,Attrib)
% HFSS_Spline generates a script to draws a rectangular Spline in HFSS 
% which is cubic function connecting the points entered. 
% Refere to HFSS help "Spline". 
% 
% Author : Zainulabideen Khalifa            Last Revision : 2/22/2020
% 
% Pars and Attrib are of type struct with the following as elements. 
% All elements must be filled before calling the function. 
% 
% Note: the function will assume the number of points is length(Pars.x(:))
%
% inputs: all inputs are to be written as strings
%     # Pars --> x,y,z,w,h,NoS
%         - Pars.x{1:n} --> point in x
%         - Pars.y{1:n}
%         - Pars.z{1:n}
%         - Pars.NoS --> number of segments
%     # Attrib --> name, color, material
%         - name is the label of that element like "Box1"
%         - color is a string with RGB like (0 0 255) for blue
%         - material is the string name of the material defined in your
%           HFSS design like "pec" or "vacuum".
% 
% function [] = HFSS_Spline(fileID,Pars,Attrib)

% Notes for me!
% if a is the length from start to the mid of the first peak, 
% d is the eleveation of that peak, then
% Arc_length = ((a^2 + d^2)/(2*d))*(2*asin((a)/(((a^2 + d^2)/(2*d)))));

    fprintf(fileID,'oEditor.CreatePolyline(\n');
    fprintf(fileID,'	[\n');
    fprintf(fileID,'		"NAME:PolylineParameters",\n');
    fprintf(fileID,'		"IsPolylineCovered:="	, True,\n');
    fprintf(fileID,'		"IsPolylineClosed:="	, False,\n');
    fprintf(fileID,'		[\n');
    fprintf(fileID,'			"NAME:PolylinePoints",\n');
    for n_idx = 1:length(Pars.x(:))
        if n_idx ~= length(Pars.x(:))
            fprintf(fileID,'			[\n');
            fprintf(fileID,'				"NAME:PLPoint",\n');
            fprintf(fileID,'				"X:="			, "%s",\n',Pars.x{n_idx});
            fprintf(fileID,'				"Y:="			, "%s",\n',Pars.y{n_idx});
            fprintf(fileID,'				"Z:="			, "%s"\n',Pars.z{n_idx});
            fprintf(fileID,'			],\n');
        else
            fprintf(fileID,'			[\n');
            fprintf(fileID,'				"NAME:PLPoint",\n');
            fprintf(fileID,'				"X:="			, "%s",\n',Pars.x{n_idx});
            fprintf(fileID,'				"Y:="			, "%s",\n',Pars.y{n_idx});
            fprintf(fileID,'				"Z:="			, "%s"\n',Pars.z{n_idx});
            fprintf(fileID,'			]\n');
        end
            
    end

    fprintf(fileID,'		],\n');
    fprintf(fileID,'		[\n');
    fprintf(fileID,'			"NAME:PolylineSegments",\n');
    fprintf(fileID,'			[\n');
    fprintf(fileID,'				"NAME:PLSegment",\n');
    fprintf(fileID,'				"SegmentType:="		, "Spline",\n');
    fprintf(fileID,'				"StartIndex:="		, 0,\n');
    fprintf(fileID,'				"NoOfPoints:="		, %0.0f,\n',length(Pars.x(:)));
    fprintf(fileID,'				"NoOfSegments:="	, "%0.0f"\n',length(Pars.x(:))*10);
    fprintf(fileID,'			]\n');
    fprintf(fileID,'		],\n');
    fprintf(fileID,'		[\n');
    fprintf(fileID,'			"NAME:PolylineXSection",\n');
    fprintf(fileID,'			"XSectionType:="	, "Rectangle",\n');
    fprintf(fileID,'			"XSectionOrient:="	, "Auto",\n');
    fprintf(fileID,'			"XSectionWidth:="	, "%s",\n',Pars.w);
    fprintf(fileID,'			"XSectionTopWidth:="	, "0um",\n');
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
    fprintf(fileID,'		"SurfaceMaterialValue:=", "\\"\\"",\n');
    fprintf(fileID,'		"SolveInside:="		, False,\n');
    fprintf(fileID,'		"IsMaterialEditable:="	, True,\n');
    fprintf(fileID,'		"UseMaterialAppearance:=", False,\n');
    fprintf(fileID,'		"IsLightweight:="	, False\n');
    fprintf(fileID,'	])\n');

end
