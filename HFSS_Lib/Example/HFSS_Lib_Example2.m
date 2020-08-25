clc 
close all
clear all

Project_name = "HFSS_Lib_Example2";
fileID = fopen(sprintf('/data/zainkh/Documents/MATLAB/HFSS_scripts/%s.py',Project_name),'w');
HFSS_Project(fileID,'/data/zainkh/Documents/HFSS',Project_name);
HFSS_Header(fileID,Project_name,'HFSSDesign1');
%%
%%
Vars = {"SPL_Ld"    "4mm"  ;...
        "SPL_dk"    "2"     ;...
        "SPL_dA"    "0.6mm"   ;...
        "HRO_Lg"    "6mm"  ;...
        "HRO_Lso"   "5mm" ;...
        "HRO_Ls"    "5mm" ;...
        "TRL_W"     "0.1mm"   ;...       % line width
        "TRL_SW"    "0.5mm"   ;...       % shielding width
        "TRL_SS"    "2.5mm"  ;...       % seperation
        "WP_h"      "10mm"  ;...       % Wave port height
        "NoS"       "0"     ;...
        };

HFSS_Variable(fileID,Vars);

Vars = {"Co_th"     "0.6mils";...
        "Dia_th"    "0.06in";...
        "Line_elv"  "Co_th+Dia_th"
        "Line_th"   "Co_th"
        "GND_elv"  "0"
        "GND_th"   "Co_th"
        };

HFSS_Variable(fileID,Vars);

ZAIN_Draw_Env(fileID);
% define your material once and the constants
[Line,Shield] = CP_Defs();
% the length is what will change in every section

%%  Start Drawing

TRL_Width = strcat("(",Shield.separation,"+2*",Shield.width,")");

idx = 10;
Line.length = "SPL_Ld";
Line.k = "SPL_dk";
Line.A = "SPL_dA";
Line.N = 30;        % N must be >> maximum anticipated k to be used
TRL_names{idx} = CP_SPL(fileID,sprintf("TRL%0.0fz",idx),Line,Shield);
HFSS_Group(fileID,TRL_names{idx});

idx = idx +1;
TRL_names{idx} = CP_SPL(fileID,sprintf("TRL%0.0fz",idx),Line,Shield);
HFSS_Group(fileID,TRL_names{idx});
vector.x = "0";
vector.y = "-" + "SPL_Ld";
vector.z = "0";
HFSS_Move(fileID,TRL_names{idx},vector);
    
idx = idx +1;
Line.length = strcat("-(2*SPL_Ld+",TRL_Width,")");
TRL_names{idx} = CP_TRL(fileID,sprintf("TRL%0.0fz",idx),Line,Shield);
HFSS_Group(fileID,TRL_names{idx});
vector.x = strcat("-(",TRL_Width,"",")");
vector.y = strcat("SPL_Ld");
vector.z = "0";
HFSS_Move(fileID,TRL_names{idx},vector);   

idx = idx +1;
TRL_names{idx} = CP_CirTRL(fileID,sprintf("TRL%0.0fz",idx),Line,Shield,"0","PI");
HFSS_Group(fileID,TRL_names{idx});
HFSS_Rotate(fileID,TRL_names{idx},"-PI/2");
vector.x = strcat("-(",TRL_Width,"","-",TRL_Width,"/2)");
vector.y = strcat("SPL_Ld");
vector.z = "0";
HFSS_Move(fileID,TRL_names{idx},vector);

idx = idx +1;
Line.length = strcat("(2*SPL_Ld+",TRL_Width,")");
TRL_names{idx} = CP_TRL(fileID,sprintf("TRL%0.0fz",idx),Line,Shield);
HFSS_Group(fileID,TRL_names{idx});
vector.x = strcat("(",TRL_Width,"",")");
vector.y = strcat("-SPL_Ld");
vector.z = "0";
HFSS_Move(fileID,TRL_names{idx},vector);   

idx = idx +1;
TRL_names{idx} = CP_CirTRL(fileID,sprintf("TRL%0.0fz",idx),Line,Shield,"0","PI");
HFSS_Group(fileID,TRL_names{idx});
HFSS_Rotate(fileID,TRL_names{idx},"PI/2");
vector.x = strcat("(",TRL_Width,"","-",TRL_Width,"/2)");
vector.y = strcat("-SPL_Ld");
vector.z = "0";
HFSS_Move(fileID,TRL_names{idx},vector);

idx = idx +1;
TRL_names{idx} = CP_3PJunction(fileID,sprintf("TRL%0.0fz",idx),Line,Shield);
HFSS_Group(fileID,TRL_names{idx});
HFSS_Rotate(fileID,TRL_names{idx},"PI");
vector.x = strcat("-(",TRL_Width,")");
vector.y = strcat("-2*SPL_Ld+TRL_SW");
vector.z = "0";
HFSS_Move(fileID,TRL_names{idx},vector);

idx = idx +1;
TRL_names{idx} = CP_3PJunction(fileID,sprintf("TRL%0.0fz",idx),Line,Shield);
HFSS_Group(fileID,TRL_names{idx});
HFSS_Rotate(fileID,TRL_names{idx},"0");
vector.x = strcat("(",TRL_Width,")");
vector.y = strcat("2*SPL_Ld-TRL_SW");
vector.z = "0";
HFSS_Move(fileID,TRL_names{idx},vector);

idx = idx +1;
r = strcat("(",TRL_Width,"",")");
TRL_names{idx} = CP_CirTRL(fileID,sprintf("TRL%0.0fz",idx),Line,Shield,r,"PI/2");
HFSS_Group(fileID,TRL_names{idx});
HFSS_Rotate(fileID,TRL_names{idx},"-PI/2");
vector.x = strcat("-(",TRL_Width,"","-",TRL_Width,"/2)");
vector.y = strcat("SPL_Ld");
vector.z = "0";
HFSS_Move(fileID,TRL_names{idx},vector);

idx = idx +1;
r = strcat("(",TRL_Width,"",")");
TRL_names{idx} = CP_CirTRL(fileID,sprintf("TRL%0.0fz",idx),Line,Shield,r,"PI/2");
HFSS_Group(fileID,TRL_names{idx});
HFSS_Rotate(fileID,TRL_names{idx},"PI/2");
vector.x = strcat("(",TRL_Width,"","-",TRL_Width,"/2)");
vector.y = strcat("-SPL_Ld");
vector.z = "0";
HFSS_Move(fileID,TRL_names{idx},vector);

idx = idx +1;
Line.length = strcat("(",TRL_Width,")");
TRL_names{idx} = CP_TRL(fileID,sprintf("TRL%0.0fz",idx),Line,Shield);
HFSS_Group(fileID,TRL_names{idx});
HFSS_Rotate(fileID,TRL_names{idx},"PI/2");
vector.x = strcat("(",TRL_Width,"/2",")");
vector.y = strcat("-(SPL_Ld+1.5*",TRL_Width,")");
vector.z = "0";
HFSS_Move(fileID,TRL_names{idx},vector);   

idx = idx +1;
Line.length = strcat("(",TRL_Width,")");
TRL_names{idx} = CP_TRL(fileID,sprintf("TRL%0.0fz",idx),Line,Shield);
HFSS_Group(fileID,TRL_names{idx});
HFSS_Rotate(fileID,TRL_names{idx},"-PI/2");
vector.x = strcat("-(",TRL_Width,"/2",")");
vector.y = strcat("(SPL_Ld+1.5*",TRL_Width,")");
vector.z = "0";
HFSS_Move(fileID,TRL_names{idx},vector);   
 

%% Draw the ports
p_idx = 1;
Shield.width = "TRL_SW";
port_names{p_idx} = CP_Portsheet(fileID,"Port1",Line,Shield);
HFSS_Rotate(fileID,port_names{p_idx},"PI");
vector.x = strcat("-(2*",TRL_Width,")");
vector.y = strcat("(","SPL_Ld",")");
vector.z = "0";
HFSS_Move(fileID,port_names{p_idx},vector); 

p_idx = 2;
Shield.width = "TRL_SW";
port_names{p_idx} = CP_Portsheet(fileID,"Port2",Line,Shield);
HFSS_Rotate(fileID,port_names{p_idx},"0");
vector.x = strcat("(2*",TRL_Width,")");
vector.y = strcat("-(","SPL_Ld",")");
vector.z = "0";
HFSS_Move(fileID,port_names{p_idx},vector); 

%% Configure the Setup
HFSS_Setup(fileID,"Setup1",2.4);
HFSS_Setup_Sweep(fileID,"Setup1","Sweep1",2.3,2.5,0.01,"d");

% you need to draw the port ansd assign the boundaries

fclose(fileID);
fprintf("DONE !\n");


%%
function [] = ZAIN_Draw_Env(fileID)
% this will change the "Allow Material Override" to true
    fprintf(fileID,'oDesign.SetDesignSettings(\n');
    fprintf(fileID,'	[\n');
    fprintf(fileID,'		"NAME:Design Settings Data",\n');
    fprintf(fileID,'		"Use Advanced DC Extrapolation:=", False,\n');
    fprintf(fileID,'		"Use Power S:="		, False,\n');
    fprintf(fileID,'		"Export After Simulation:=", False,\n');
    fprintf(fileID,'		"Allow Material Override:=", True,\n');
    fprintf(fileID,'		"Calculate Lossy Dielectrics:=", False,\n');
    fprintf(fileID,'		"EnabledObjects:="	, []\n');
    fprintf(fileID,'	])\n');
    
    fprintf(fileID,'oEditor.SetModelUnits(\n');
	fprintf(fileID,'[\n');
	fprintf(fileID,'	"NAME:Units Parameter",\n');
	fprintf(fileID,'	"Units:="		, "mm",\n');
	fprintf(fileID,'	"Rescale:="		, False\n');
	fprintf(fileID,'])\n');
    
% Draw the Environment
    Attrib.name = "Air";
    Attrib.color = "255 255 255";
    Attrib.material = "air";
    Pars.x = "-200mm";
    Pars.y = "-200mm";
    Pars.z = "-250mm";
    Pars.dx = "400mm";
    Pars.dy = "400mm";
    Pars.dz = "500mm";
    HFSS_Box(fileID,Pars,Attrib,1);
 
    Attrib.name = "Substrate";
    Attrib.color = "255 255 128";
    Attrib.material = "FR4_epoxy";
    Pars.x = "-20mm";
    Pars.y = "-20mm";
    Pars.z = "GND_elv+GND_th";
    Pars.dx = "40mm";
    Pars.dy = "40mm";
    Pars.dz = "Dia_th";
    HFSS_Box(fileID,Pars,Attrib,1);
    
    fprintf(fileID,'oModule = oDesign.GetModule("BoundarySetup")\n');
    fprintf(fileID,'oModule.AssignRadiation(\n');
    fprintf(fileID,'	[\n');
    fprintf(fileID,'		"NAME:Rad1",\n');
    fprintf(fileID,'		"Objects:="		, ["Air"],\n');
    fprintf(fileID,'		"IsFssReference:="	, False,\n');
    fprintf(fileID,'		"IsForPML:="		, False\n');
    fprintf(fileID,'	])\n');
    
    
end
function [Line,Shield] = CP_Defs()
% define your material once and the constants
    Line.color = "0 0 255";
    Line.material = "copper";
    Shield.color = "0 255 0";
    Shield.material = "copper";
    Shield.g_material = "copper";

    Line.thickness = "Line_th";
    Line.elevation = "Line_elv";
    Line.width = "TRL_W";
    Shield.separation = "TRL_SS";
    Shield.width = "TRL_SW";
    Shield.elevation = "Line_elv";
    Shield.thickness = "Line_th";
    Shield.g_elevation = "GND_elv";
    Shield.g_thickness = "GND_th";
end

        



