% functions for HFSS scrips generation
%-----------------------General Functions-------------------------------
function [] = HFSS_Variable(fileID,Vars)
% Vars = {"name" "value"}
    for idx = 1:length(Vars(:,1))
        fprintf(fileID,'oDesign.ChangeProperty(\n');
        fprintf(fileID,'	[\n');
        fprintf(fileID,'		"NAME:AllTabs",\n');
        fprintf(fileID,'		[\n');
        fprintf(fileID,'			"NAME:LocalVariableTab",\n');
        fprintf(fileID,'			[\n');
        fprintf(fileID,'				"NAME:PropServers", \n');
        fprintf(fileID,'				"LocalVariables"\n');
        fprintf(fileID,'			],\n');
        fprintf(fileID,'			[\n');
        fprintf(fileID,'				"NAME:NewProps",\n');
        fprintf(fileID,'				[\n');
        fprintf(fileID,'					"NAME:%s",\n',Vars{idx,1});
        fprintf(fileID,'					"PropType:="		, "VariableProp",\n');
        fprintf(fileID,'					"UserDef:="		, True,\n');
        fprintf(fileID,'					"Value:="		, "%s"\n',Vars{idx,2});
        fprintf(fileID,'				]\n');
        fprintf(fileID,'			]\n');
        fprintf(fileID,'		]\n');
        fprintf(fileID,'	])\n');
    end
end
function [] = HFSS_Header(fileID,Project_name)
    fprintf(fileID,'import ScriptEnv\n');
    fprintf(fileID,'ScriptEnv.Initialize("Ansoft.ElectronicsDesktop")\n');
    fprintf(fileID,'oDesktop.RestoreWindow()\n');
    fprintf(fileID,'oProject = oDesktop.SetActiveProject("%s")\n',Project_name);
    fprintf(fileID,'oDesign = oProject.SetActiveDesign("HFSSDesign1")\n');
    fprintf(fileID,'oEditor = oDesign.SetActiveEditor("3D Modeler")\n');
end
function [] = HFSS_Project(fileID,Project_location,Project_name)
    fprintf(fileID,'import ScriptEnv\n');
    fprintf(fileID,'ScriptEnv.Initialize("Ansoft.ElectronicsDesktop")\n');
    fprintf(fileID,'oDesktop.RestoreWindow()\n');
    fprintf(fileID,'oProject = oDesktop.NewProject()\n');
    fprintf(fileID,'oProject = oDesktop.SetActiveProject("Project1")\n');
    fprintf(fileID,'oProject.Rename("%s/%s.aedt", True)\n',Project_location,Project_name);
    fprintf(fileID,'oProject.InsertDesign("HFSS", "HFSSDesign1", "DrivenModal", "")\n');

end

%-----------------------Drawing Functions--------------------------------
function [] = HFSS_Cylinder(fileID,Pars,Attrib)
% Pars --> x,y,z,r,h
% the center is x,y,z
% r is the radius and h for hight
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
function [] = HFSS_Ring(fileID,Pars,Attrib)
% Pars --> x,y,z,r,w,h
% the center is x,y,z
% r is the radius, w for width and h for hight
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
function [] = HFSS_Arc(fileID,Pars,Attrib)
% Pars --> x,y,z,r,w,h,theta,dtheta
% the center is x,y,z
% r is the radius, w for width and h for hight
% theta is the start angle and dtheta is the arc length 


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
    fprintf(fileID,'				"ArcCenterX:="		, "%s",\n',Pars.x);
    fprintf(fileID,'				"ArcCenterY:="		, "%s",\n',Pars.y);
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
end
function [] = HFSS_Box(fileID,Pars,Attrib,S)
% Pars --> x,y,z,dx,dy,dz
% the start is x,y,z
% S : for solve inside or not (1 or 0)
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
function [] = HFSS_Port(fileID,Pars,name)
% Pars --> x,y,z,w,h,axis
% the start is x,y,z
    fprintf(fileID,'oEditor = oDesign.SetActiveEditor("3D Modeler")\n');
    fprintf(fileID,'oEditor.CreateRectangle(\n');
    fprintf(fileID,'	[\n');
    fprintf(fileID,'		"NAME:RectangleParameters",\n');
    fprintf(fileID,'		"IsCovered:="		, True,\n');
    fprintf(fileID,'		"XStart:="		, "%s",\n',Pars.x);
    fprintf(fileID,'		"YStart:="		, "%s",\n',Pars.y);
    fprintf(fileID,'		"ZStart:="		, "%s",\n',Pars.z);
    fprintf(fileID,'		"Width:="		, "%s",\n',Pars.h);
    fprintf(fileID,'		"Height:="		, "%s",\n',Pars.w);
    fprintf(fileID,'		"WhichAxis:="		, "%s"\n',Pars.axis);
    fprintf(fileID,'	], \n');
    fprintf(fileID,'	[\n');
    fprintf(fileID,'		"NAME:Attributes",\n');
    fprintf(fileID,'		"Name:="		, "%s",\n',name);
    fprintf(fileID,'		"Flags:="		, "",\n');
    fprintf(fileID,'		"Color:="		, "(255 255 255)",\n');
    fprintf(fileID,'		"Transparency:="	, 0.75,\n');
    fprintf(fileID,'		"PartCoordinateSystem:=", "Global",\n');
    fprintf(fileID,'		"UDMId:="		, "",\n');
    fprintf(fileID,'		"MaterialValue:="	, "\\"vacuum\\"",\n');
    fprintf(fileID,'		"SolveInside:="		, True\n');
    fprintf(fileID,'	])\n');
end
%-----------------------Operation Functions------------------------------
function [] = HFSS_Unite(fileID,names)
% names is a cell array
    N = length(names);
    if N<2
        error('HFSS_Unite: number of names is less then 2')
    end
    fprintf(fileID,'oEditor = oDesign.SetActiveEditor("3D Modeler")\n');
    fprintf(fileID,'oEditor.Unite(\n');
    fprintf(fileID,'	[\n');
    fprintf(fileID,'		"NAME:Selections",\n');
    fprintf(fileID,'		"Selections:="		,\n"');
    for i=1:N-1
        fprintf(fileID,'%s,',names{i});
    end
    fprintf(fileID,'%s',names{end});
    fprintf(fileID,'"\n');
    fprintf(fileID,'	], \n');
    fprintf(fileID,'	[\n');
    fprintf(fileID,'		"NAME:UniteParameters",\n');
    fprintf(fileID,'		"KeepOriginals:="	, False\n');
    fprintf(fileID,'	])\n');
end
function [] = HFSS_Subtract(fileID,name1,name2)
    fprintf(fileID,'oEditor = oDesign.SetActiveEditor("3D Modeler")\n');
    fprintf(fileID,'oEditor.Subtract(\n');
    fprintf(fileID,'	[\n');
    fprintf(fileID,'		"NAME:Selections",\n');
    fprintf(fileID,'		"Blank Parts:="		, "%s",\n',name1);
    fprintf(fileID,'		"Tool Parts:="		, "%s"\n',name2);
    fprintf(fileID,'	], \n');
    fprintf(fileID,'	[\n');
    fprintf(fileID,'		"NAME:SubtractParameters",\n');
    fprintf(fileID,'		"KeepOriginals:="	, False\n');
    fprintf(fileID,'	])\n');
end
function [] = HFSS_Rotate(fileID,name,angle)
    fprintf(fileID,'oEditor = oDesign.SetActiveEditor("3D Modeler")\n');
    fprintf(fileID,'oEditor.Rotate(\n');
    fprintf(fileID,'	[\n');
    fprintf(fileID,'		"NAME:Selections",\n');
    fprintf(fileID,'		"Selections:="		, "%s",\n',name);
    fprintf(fileID,'		"NewPartsModelFlag:="	, "Model"\n');
    fprintf(fileID,'	], \n');
    fprintf(fileID,'	[\n');
    fprintf(fileID,'		"NAME:RotateParameters",\n');
    fprintf(fileID,'		"RotateAxis:="		, "Z",\n');
    fprintf(fileID,'		"RotateAngle:="		, "%s"\n',angle);
    fprintf(fileID,'	])\n');
end
function [] = HFSS_Property(fileID, Property, Value)
% Property is a string
% value is the value with two significant digits

    fprintf(fileID,'oDesign.ChangeProperty(\n');
    fprintf(fileID,'	[\n');
    fprintf(fileID,'		"NAME:AllTabs",\n');
    fprintf(fileID,'		[\n');
    fprintf(fileID,'			"NAME:LocalVariableTab",\n');
    fprintf(fileID,'			[\n');
    fprintf(fileID,'				"NAME:PropServers", \n');
    fprintf(fileID,'				"LocalVariables"\n');
    fprintf(fileID,'			],\n');
    fprintf(fileID,'			[\n');
    fprintf(fileID,'				"NAME:ChangedProps",\n');
    fprintf(fileID,'				[\n');
    fprintf(fileID,'					"NAME:%s",\n',Property);
    fprintf(fileID,'					"Value:="		, "%s"\n',Value);
    fprintf(fileID,'				]\n');
    fprintf(fileID,'			]\n');
    fprintf(fileID,'		]\n');
    fprintf(fileID,'	])\n');
end
function [] = HFSS_Move(fileID,name,vector)
% vector.x
% vector.y
% vector.z

    fprintf(fileID,'oEditor = oDesign.SetActiveEditor("3D Modeler")\n');
    fprintf(fileID,'oEditor.Move(\n');
    fprintf(fileID,'	[\n');
    fprintf(fileID,'		"NAME:Selections",\n');
    fprintf(fileID,'		"Selections:="		, "%s",\n',name);
    fprintf(fileID,'		"NewPartsModelFlag:="	, "Model"\n');
    fprintf(fileID,'	], \n');
    fprintf(fileID,'	[\n');
    fprintf(fileID,'		"NAME:TranslateParameters",\n');
    fprintf(fileID,'		"TranslateVectorX:="	, "%s",\n',vector.x);
    fprintf(fileID,'		"TranslateVectorY:="	, "%s",\n',vector.y);
    fprintf(fileID,'		"TranslateVectorZ:="	, "%s"\n',vector.z);
    fprintf(fileID,'	])\n');

end

%-----------------------Setup Functions----------------------------------
function [no_of_pts] = HFSS_Setup(fileID,freq,sfreq,efreq,fstep,Type)
% Type is "Fast" or "Discrete"
% all numbers are in GHz

    no_of_pts = ((efreq-sfreq)/fstep)+1;
    fprintf("Setup: (%0.0f, %0.2f,%0.0f,%0.2f) \t#pts = %0.0f\n",freq,sfreq,efreq,fstep,((efreq-sfreq)/fstep)+1)
    fprintf(fileID,'oModule = oDesign.GetModule("AnalysisSetup")\n');
    fprintf(fileID,'oModule.InsertSetup("HfssDriven", \n');
    fprintf(fileID,'	[\n');
    fprintf(fileID,'		"NAME:Setup%0.0f",\n',freq);
    fprintf(fileID,'		"Frequency:="		, "%0.0fGHz",\n',freq);
    fprintf(fileID,'		"PortsOnly:="		, False,\n');
    fprintf(fileID,'		"MaxDeltaS:="		, 0.05,\n');
    fprintf(fileID,'		"UseMatrixConv:="	, False,\n');
    fprintf(fileID,'		"MaximumPasses:="	, 20,\n');
    fprintf(fileID,'		"MinimumPasses:="	, 2,\n');
    fprintf(fileID,'		"MinimumConvergedPasses:=", 2,\n');
    fprintf(fileID,'		"PercentRefinement:="	, 30,\n');
    fprintf(fileID,'		"IsEnabled:="		, True,\n');
    fprintf(fileID,'		"BasisOrder:="		, 1,\n');
    fprintf(fileID,'		"DoLambdaRefine:="	, True,\n');
    fprintf(fileID,'		"DoMaterialLambda:="	, True,\n');
    fprintf(fileID,'		"SetLambdaTarget:="	, False,\n');
    fprintf(fileID,'		"Target:="		, 0.3333,\n');
    fprintf(fileID,'		"UseMaxTetIncrease:="	, False,\n');
    fprintf(fileID,'		"PortAccuracy:="	, 2,\n');
    fprintf(fileID,'		"UseABCOnPort:="	, False,\n');
    fprintf(fileID,'		"SetPortMinMaxTri:="	, False,\n');
    fprintf(fileID,'		"UseDomains:="		, False,\n');
    fprintf(fileID,'		"UseIterativeSolver:="	, False,\n');
    fprintf(fileID,'		"SaveRadFieldsOnly:="	, False,\n');
    fprintf(fileID,'		"SaveAnyFields:="	, True,\n');
    fprintf(fileID,'		"IESolverType:="	, "Auto",\n');
    fprintf(fileID,'		"LambdaTargetForIESolver:=", 0.15,\n');
    fprintf(fileID,'		"UseDefaultLambdaTgtForIESolver:=", True\n');
    fprintf(fileID,'	])\n');
    fprintf(fileID,'oModule.InsertFrequencySweep("Setup%0.0f", \n',freq);
    fprintf(fileID,'	[\n');
    fprintf(fileID,'		"NAME:Sweep",\n');
    fprintf(fileID,'		"IsEnabled:="		, True,\n');
    fprintf(fileID,'		"RangeType:="		, "LinearStep",\n');
    fprintf(fileID,'		"RangeStart:="		, "%0.2fGHz",\n',sfreq);
    fprintf(fileID,'		"RangeEnd:="		, "%0.0fGHz",\n',efreq);
    fprintf(fileID,'		"RangeStep:="		, "%0.2fGHz",\n',fstep);
    fprintf(fileID,'		"Type:="		, "%s",\n',Type);
    fprintf(fileID,'		"SaveFields:="		, False,\n');
    fprintf(fileID,'		"SaveRadFields:="	, False,\n');
    fprintf(fileID,'		"ExtrapToDC:="		, False\n');
    fprintf(fileID,'	])\n');
end
function [] = HFSS_DeleteSetup(filename,freq)
fileID = fopen(filename,'w');
fprintf(fileID,'import ScriptEnv\n');
fprintf(fileID,'ScriptEnv.Initialize("Ansoft.ElectronicsDesktop")\n');
fprintf(fileID,'oDesktop.RestoreWindow()\n');
fprintf(fileID,'oProject = oDesktop.SetActiveProject("BTWA_N20_a010")\n');
fprintf(fileID,'oDesign = oProject.SetActiveDesign("HFSSDesign1")\n');
fprintf(fileID,'oModule = oDesign.GetModule("AnalysisSetup")\n');

for idx = 1:length(freq)
    fprintf(fileID,'oModule.DeleteSetups(["Setup%0.0f"])\n',freq(idx));
end
fclose(fileID);
fprintf("DONE !\n");
end
function [] = ExportData(fileID,filename,setup_label)
    fprintf(fileID,'oModule = oDesign.GetModule("Solutions")\n');
    fprintf(fileID,'oModule.ExportNetworkData("", ["%s:Sweep"], 3, ',setup_label);
    fprintf(fileID,'"%s", \n',filename);
    fprintf(fileID,'	[\n');
    fprintf(fileID,'"All"\n');
    fprintf(fileID,'	], True, 50, "S", -1, 0, 10, True, False, False)\n'); 
end
function [] = CombineCMD(setups, filename, line_no,ext)
% line_no = 33 for s2p
% line_no = 44 for s23p

    for i=2:length(setups)
        fprintf("sed -i '1,%0.0fd' ",line_no)
        fprintf("%s%0.0f%s\n",filename,setups(i),ext)
    end
    
    fprintf("\ncat ")
    for i=1:length(setups)
        fprintf("%s%0.0f%s ",filename,setups(i),ext)
    end
    
    fprintf("> %s_Combined%s\n",filename,ext)
    fprintf("\nrm ")
    for i=1:length(setups)
        fprintf("%s%0.0f%s ",filename,setups(i),ext)
    end
    fprintf("\n\n")
end
