clc 
close all
clear all

Project_name = "HFSS_Lib_Example1";
fileID = fopen(sprintf('/data/zainkh/Documents/MATLAB/HFSS_scripts/%s.py',Project_name),'w');
HFSS_Project(fileID,'/data/zainkh/Documents/HFSS',Project_name);
HFSS_Header(fileID,Project_name,'HFSSDesign1');

%%
Vars = {"TRL_L1"    "40um"  ;...       % line length
        "TRL_Lo1"   "40um"  ;...       % line length
        "TRL_W"     "2um"   ;...       % line width
        "TRL_th"    "1um"   ;...       % line hight
        "TRL_elv"   "3um"   ;...       % line elevation
        "TRL_SW"    "2um"   ;...       % shielding width
        "TRL_Sh"    "4um"   ;...       % shielding hight
        "TRL_gh"    "0.1um" ;...       % ground hight
        "TRL_S"     "4um"  ;...       % seperation
        "Ring_r"    "50um"  ;...        % ring radius
        "Ring_LL"    "10um"  ;...        % ring lines length
        "NoS"       "0"     };
    
HFSS_Variable(fileID,Vars);
ZAIN_Draw_Env(fileID);
%%
% define your material once and the constants
Line.color = "0 0 255";
Line.material = "aluminum";
Shield.color = "0 255 0";
Shield.material = "aluminum";

Line.h = "TRL_th";
Line.e = "TRL_elv";
Line.W = "TRL_W";
Shield.S = "TRL_S";
Shield.W = "TRL_SW";
Shield.h = "TRL_Sh";
Shield.g = "TRL_gh";

% the length is what will change in every section
Line.L = "TRL_L1";

% Start Drawing

% Draw the 90 Deg corner
Names = ZAIN_90_CPW(fileID,"Line1_",Line,Shield);
HFSS_Group(fileID,Names);

% Draw the first coplaner line then rotate it and move it
Names = ZAIN_Line_CPW(fileID,"Line2_",Line,Shield); 
ZAIN_Rotate(fileID,Names,"PI/2");
shift = strcat("(",Line.W,"/2+",Shield.S,"+",Shield.W,")");
vector.x = "0";
vector.y = strcat("-",shift);
vector.z = "0";
ZAIN_Move(fileID,Names,vector);
HFSS_Group(fileID,Names);

% Draw the open stub as a coplaner line then rotate it and move it
Line.L = "TRL_Lo1";
Names = ZAIN_Line_CPW(fileID,"OpenStub1_",Line,Shield);
ZAIN_Rotate(fileID,Names,"PI");
vector.x = strcat("-(","TRL_L1+",shift,")");
vector.y = strcat("-2*",shift);
vector.z = "0";
ZAIN_Move(fileID,Names,vector);
HFSS_Group(fileID,Names);

% Draw the T-junction and move it
Names = ZAIN_T_CPW(fileID,"T1_",Line,Shield);
vector.x = strcat("-(","TRL_L1+",shift,")");
vector.y = strcat("-2*",shift);
vector.z = "0";
ZAIN_Move(fileID,Names,vector);
HFSS_Group(fileID,Names);


% Creating the ring and the stubs
center.x = strcat("-(TRL_L1","+","2*",shift,"+",Shield.S,"+","Ring_r","+",Line.W,"/2)");
center.y = strcat("-",shift);
Names = {};

% Draw the connecting line
    Attrib.name = "ring_line_0"; 
    Attrib.color = Line.color;
    Attrib.material = Line.material;
    Pars.x = strcat("-(TRL_L1","+","2*",shift,"+",Shield.S,"+TRL_W/2)");
    Pars.y = strcat("-(",shift,"+",Line.W,"/2)");
    Pars.z = Line.e;
    Pars.dx = strcat(Shield.S,"+",Line.W,"/2");
    Pars.dy = Line.W;
    Pars.dz = Line.h;
    HFSS_Box(fileID,Pars,Attrib,0);
    
% Draw the ring at center (0,0)
    Pars.x = "0";
    Pars.y = "0";
    Pars.z = Line.e;
    Pars.r = "Ring_r";
    Pars.h = Line.h;
    Pars.w = Line.W;
    Attrib.name = "Ring1"; Names{1+end} = Attrib.name;
    Attrib.color = Line.color;
    Attrib.material = Line.material;
    HFSS_Ring(fileID,Pars,Attrib);

% Draw the lines on the ring
% Draw only one then copy and rotate in a loop
    Attrib.name = sprintf("Ring_line_1"); Names{1+end} = Attrib.name;
    Pars.x = strcat("(-",Line.W,"/2)");
    Pars.y = "Ring_r";
    Pars.z = Line.e;
    Pars.dx = Line.W;
    Pars.dy = "Ring_LL";
    Pars.dz = Line.h;
    HFSS_Box(fileID,Pars,Attrib,0);
        
    N_of_L = 12;
    for idx = 2:N_of_L
        HFSS_Copy(fileID,Attrib.name);
        HFSS_Rotate(fileID,sprintf("%s%0.0f","Ring_line_",idx),sprintf("%0.0f*PI/%0.0f",idx-1,N_of_L-1));
        Names{1+end} = sprintf("%s%0.0f","Ring_line_",idx);
    end
    
    
% Draw the ground plane
    Attrib.name = "Ring_sg";  Names{1+end} = Attrib.name;
    Attrib.color = Shield.color;
    Attrib.material = Shield.material;
    Pars.x = "-(Ring_r+Ring_LL)";
    Pars.y = "-(Ring_r+Ring_LL)";
    Pars.z = "0";
    Pars.dx = "2*Ring_r+Ring_LL+TRL_S+TRL_W/2";
    Pars.dy = "2*(Ring_r+Ring_LL)";
    Pars.dz = Shield.g;
    HFSS_Box(fileID,Pars,Attrib,0);

    
% move everything to its right place
    vector.x = center.x ;
    vector.y = center.y;
    vector.z = "0";
    ZAIN_Move(fileID,Names,vector);
HFSS_Group(fileID,Names);


% Configure the Setup
HFSS_Setup(fileID,"Setup250",250);
HFSS_Setup_Sweep(fileID,"Setup250","Sweep1",100,200,1,"d");

% you need to draw the port ansd assign the boundaries

fclose(fileID);
fprintf("DONE !\n");


%%
function [Names] = ZAIN_Line_CPW(fileID,label,Line,Shield)
% This function will draw a coplaner line in the y-direction then you can
% move and rotate.

    Attrib.name = label;
    Attrib.color = Line.color;
    Attrib.material = Line.material;
    Pars.x = strcat("(-",Line.W,"/2)");
    Pars.y = "0";
    Pars.z = Line.e;
    Pars.dx = Line.W;
    Pars.dy = Line.L;
    Pars.dz = Line.h;
    HFSS_Box(fileID,Pars,Attrib,0);

    Attrib.name = strcat(label,"Sa");
    Attrib.color = Shield.color ;
    Attrib.material = Shield.material;
    Pars.x = strcat("-(",Line.W,"/2+",Shield.S,"+",Shield.W,")");
    Pars.y = "0";
    Pars.z = "0";
    Pars.dx = Shield.W;
    Pars.dy = Line.L;
    Pars.dz = Shield.h;
    HFSS_Box(fileID,Pars,Attrib,0);

    Attrib.name = strcat(label,"Sb");
    Pars.x = strcat("(",Line.W,"/2+",Shield.S,")");
    HFSS_Box(fileID,Pars,Attrib,0);
    
    Attrib.name = strcat(label,"Sg");
    Attrib.color = Shield.color ;
    Attrib.material = Shield.material;
    Pars.x = strcat("-(",Line.W,"/2+",Shield.S,")");
    Pars.y = "0";
    Pars.z = "0";
    Pars.dx = strcat("2*",Shield.S,"+",Line.W);
    Pars.dy = Line.L;
    Pars.dz = Shield.g;
    HFSS_Box(fileID,Pars,Attrib,0);
    
    Names = {label strcat(label,"Sa") strcat(label,"Sb") strcat(label,"Sg")};
end
function [Names] = ZAIN_T_CPW(fileID,label,Line,Shield)
% This function will draw a coplaner T-Junction then you can move and rotate.
Names = {};

    Attrib.name = strcat(label,"a"); Names{1+end} = Attrib.name;
    Attrib.color = Line.color;
    Attrib.material = Line.material;
    Pars.x = strcat("(-",Line.W,"/2)");
    Pars.y = "0";
    Pars.z = Line.e;
    Pars.dx = Line.W;
    Pars.dy = strcat(Shield.W,"+",Shield.S ,"+", Line.W,"/2");
    Pars.dz = Line.h;
    HFSS_Box(fileID,Pars,Attrib,0);
    
    Attrib.name = strcat(label,"b"); Names{1+end} = Attrib.name;
    Pars.x = strcat("-(",Line.W,"/2+",Shield.S,"+",Shield.W,")");
    Pars.y = strcat(Shield.W,"+",Shield.S);
    Pars.dx = strcat("2*(",Line.W,"/2+",Shield.S,"+",Shield.W,")");
    Pars.dy = Line.W;
    HFSS_Box(fileID,Pars,Attrib,0);

    Attrib.name = strcat(label,"Sa"); Names{1+end} = Attrib.name;
    Attrib.color = Shield.color ;
    Attrib.material = Shield.material;
    Pars.x = strcat("-(",Line.W,"/2+",Shield.S,"+",Shield.W,")");
    Pars.y = strcat(Shield.W,"+2*",Shield.S,"+",Line.W);
    Pars.z = "0";
    Pars.dx = strcat("2*(",Line.W,"/2+",Shield.S,"+",Shield.W,")");
    Pars.dy = Shield.W;
    Pars.dz = Shield.h;
    HFSS_Box(fileID,Pars,Attrib,0);

    Attrib.name = strcat(label,"Sb"); Names{1+end} = Attrib.name;
    Pars.x = strcat("-(",Line.W,"/2+",Shield.S,"+",Shield.W,")");
    Pars.y = "0";
    Pars.z = "0";
    Pars.dx = Shield.W;
    Pars.dy = Shield.W;
    Pars.dz = Shield.h;
    HFSS_Box(fileID,Pars,Attrib,0);
    
    Attrib.name = strcat(label,"Sc"); Names{1+end} = Attrib.name;
    Pars.x = strcat("(",Line.W,"/2+",Shield.S,")");
    Pars.y = "0";
    Pars.z = "0";
    Pars.dx = Shield.W;
    Pars.dy = Shield.W;
    Pars.dz = Shield.h;
    HFSS_Box(fileID,Pars,Attrib,0);
    
    Attrib.name = strcat(label,"Sg"); Names{1+end} = Attrib.name;
    Attrib.color = Shield.color ;
    Attrib.material = Shield.material;
    Pars.x = strcat("-(",Line.W,"/2+",Shield.S,"+",Shield.W,")");
    Pars.y = "0";
    Pars.z = "0";
    Pars.dx = strcat("2*(",Line.W,"/2+",Shield.S,"+",Shield.W,")");
    Pars.dy = strcat("2*(",Shield.W,"+",Shield.S ,"+", Line.W,"/2)");
    Pars.dz = Shield.g;
    HFSS_Box(fileID,Pars,Attrib,0);
    
end
function [Names] = ZAIN_90_CPW(fileID,label,Line,Shield)
% This function will draw a coplaner 90deg shaped line then you can
% move and rotate.

    Attrib.name = label;
    Attrib.color = Line.color;
    Attrib.material = Line.material;
    Pars.x = "0";
    Pars.y = "0";
    Pars.z = Line.e;
    Pars.r = strcat(Line.W,"/2+",Shield.S,"+",Shield.W);
    Pars.w = Line.W;
    Pars.h = Line.h;
    Pars.theta = "-PI*3/2";
    Pars.dtheta = "-PI/2";
    HFSS_Arc(fileID,Pars,Attrib);  

    Attrib.name = strcat(label,"Sa");
    Attrib.color = Shield.color ;
    Attrib.material = Shield.material;
    Pars.z = "0";
    Pars.r = strcat(Shield.W,"/2");
    Pars.w = Shield.W;
    Pars.h = Shield.h;
    HFSS_Arc(fileID,Pars,Attrib);  
    
    Attrib.name = strcat(label,"Sb");
    Pars.r = strcat("1.5*",Shield.W,"+",Line.W,"+2*",Shield.S);
    HFSS_Arc(fileID,Pars,Attrib);  
 
    Attrib.name = strcat(label,"Sg");
    Pars.r = strcat(Line.W,"/2+",Shield.S,"+",Shield.W);
    Pars.w = strcat(Line.W,"+2*",Shield.S);
    Pars.h = Shield.g;
    HFSS_Arc(fileID,Pars,Attrib);  
        
    Names = {label strcat(label,"Sa") strcat(label,"Sb") strcat(label,"Sg")};
end
function [] = ZAIN_Move(fileID,Names,vector)
    for idx = 1:length(Names(:))
        HFSS_Move(fileID,Names{idx},vector);
    end
end
function [] = ZAIN_Rotate(fileID,Names,angle)
    for idx = 1:length(Names(:))
        HFSS_Rotate(fileID,Names{idx},angle);
    end
end
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
	fprintf(fileID,'	"Units:="		, "um",\n');
	fprintf(fileID,'	"Rescale:="		, False\n');
	fprintf(fileID,'])\n');
    
% Draw the Environment
    Attrib.name = "Air";
    Attrib.color = "255 255 255";
    Attrib.material = "air";
    Pars.x = "-1mm";
    Pars.y = "-1mm";
    Pars.z = "-250000nm";
    Pars.dx = "2mm";
    Pars.dy = "2mm";
    Pars.dz = "1250000nm";
    HFSS_Box(fileID,Pars,Attrib,1);
    
    Attrib.name = "Oxide";
    Attrib.color = "0 255 255";
    Attrib.material = "silicon_dioxide";
    Pars.x = "-1mm";
    Pars.y = "-1mm";
    Pars.z = "0um";
    Pars.dx = "2mm";
    Pars.dy = "2mm";
    Pars.dz = "2um";
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




