clc 
close all
clear all

N = 25;

Project_name = sprintf("HFSS_bjtBTWA_cir%0.0fnew",N);
fileID = fopen(sprintf('/data/zainkh/Documents/MATLAB/HFSS_scripts/%s.py',Project_name),'w');
HFSS_Project(fileID,'/data/zainkh/Documents/HFSS',Project_name);
HFSS_Header(fileID,Project_name);

%%
Vars = {"TRL_L"  "40um"  ;...    % line length
        "TRL_Lr" "70um"  ;...    % transformer line length
        "TRL_LW" "2um"   ;...    % line width
        "TRL_SW" "4um"   ;...    % shielding width
        "TRL_S"  "12um"  ;...    % seperation
        "TRL_Si" "9um"  ;...
        "xo"     "0um"   ;...    % origin x
        "yo"     "0um"   ;...    % origin y
        "NoS"    "0"     ;...
        "th_tot" sprintf("max(min(%0.0f*(TRL_L-(TRL_LW+TRL_SW+2*TRL_Si))/TRL_Lr,3.1416*1.75),3.1416)",N);...
        "th_o"   "(2*3.1416 - th_tot)/2-3.1416/2"     ;...
        "th"     sprintf("th_tot/%0.0f",N);...
        "r_L"    "TRL_L/th" ;...
        "r_i"    "r_L-TRL_Lr"};
    
HFSS_Variable(fileID,Vars);

%%
n=1;
    % Draw TRL_L
    Attrib.name = "TRL_L";
    Attrib.color = "0 0 255";
    Attrib.material = "ST55_M8";
    Pars.x = "xo";
    Pars.y = "yo";
    Pars.z = "M8elv+M8th/2";
    Pars.r = "r_L";
    Pars.w = "TRL_LW";
    Pars.h = "M8th";
    Pars.theta = sprintf("-(th_o+%0.0f*th)",n-1);
    Pars.dtheta = "th_tot";
    HFSS_Arc(fileID,Pars,Attrib)
        
    % Draw outer shield line
    Attrib.name = "TRL_OS";
    Attrib.color = "0 255 0";
    Attrib.material = "ST55_M1_M8";
    Pars.x = "xo";
    Pars.y = "yo";
    Pars.z = "M1elv+M1M5th+(M1M8th-M1M5th)/2";
    Pars.r = "r_L+TRL_LW/2+TRL_S+TRL_SW/2";
    Pars.w = "TRL_SW";
    Pars.h = "M1M8th-M1M5th";
    Pars.theta = sprintf("-(th_o+%0.0f*th)",n-1);
    Pars.dtheta = "th_tot";
    HFSS_Arc(fileID,Pars,Attrib)
    
    % Draw inner shield line
    Attrib.name = "TRL_IS";
    Attrib.color = "0 255 0";
    Attrib.material = "ST55_M1_M8";
    Pars.x = "xo";
    Pars.y = "yo";
    Pars.z = "M1elv+M1M5th+(M1M8th-M1M5th)/2";
    Pars.r = "r_i-2*TRL_S -TRL_LW/2+TRL_SW/2";
    Pars.w = "TRL_SW";
    Pars.h = "M1M8th-M1M5th";
    Pars.theta = sprintf("-(th_o+%0.0f*th)",n-1);
    Pars.dtheta = "th_tot";
    HFSS_Arc(fileID,Pars,Attrib)
    
    % draw the bottom shileding
    Attrib.name = "TRL_sur";
    Attrib.color = "0 255 0";
    Attrib.material = "ST55_M1_M5";
    Pars.x = "xo";
    Pars.y = "yo";
    Pars.z = "M1elv+M1M5th/2";
    Pars.r = "(2*r_L + TRL_SW/2 -TRL_Lr - TRL_S )/2";
    Pars.w = "2*((r_L+TRL_LW/2+TRL_S+TRL_SW/2) - ((2*r_L + TRL_SW/2 -TRL_Lr - TRL_S )/2))";
    Pars.h = "M1M5th";
    Pars.theta = sprintf("-(th_o+%0.0f*th)",n-1);
    Pars.dtheta = "th_tot";
    HFSS_Arc(fileID,Pars,Attrib)
    
for n = 1:N
    
    % Draw TRL_Lr
    Attrib.name = sprintf("TRL_Lr%0.0f",n);
    Attrib.color = "0 0 255";
    Attrib.material = "ST55_M8";
    Pars.x = "xo - TRL_LW/2";
    Pars.y = "yo + r_i";
    Pars.z = "M8elv";
    Pars.dx = "TRL_LW";
    Pars.dy = "TRL_Lr";
    Pars.dz = "M8th";
    HFSS_Box(fileID,Pars,Attrib,0);
    HFSS_Rotate(fileID,sprintf("TRL_Lr%0.0f",n),sprintf("th_o+th/2+%0.0f*th",n-1));

    % Draw the slide shieldings
    Attrib.color = "0 255 0";
    Attrib.material = "ST55_M1_M8";
    Pars.x = "xo-TRL_SW/2";
    Pars.y = "r_i-2*TRL_S -TRL_LW/2";
    Pars.z = "M1elv+M1M5th";
    Pars.dx = "TRL_SW";
    Pars.dy = "TRL_Lr+TRL_S";
    Pars.dz = "M1M8th-M1M5th";
    Attrib.name = sprintf("TRL_S%0.0fa",n);
    HFSS_Box(fileID,Pars,Attrib,0);
    HFSS_Rotate(fileID,sprintf("TRL_S%0.0fa",n),sprintf("th_o+%0.0f*th",n-1));
    Attrib.name = sprintf("TRL_S%0.0fb",n);
    HFSS_Box(fileID,Pars,Attrib,0);
    HFSS_Rotate(fileID,sprintf("TRL_S%0.0fb",n),sprintf("th_o+%0.0f*th",n));
    
%     % Draw the ports rectangles
%     Pars.x = "xo - TRL_LW/2";
%     Pars.y = "yo + r_i";
%     Pars.z = "M1elv+M1M5th/2";
%     Pars.w = "TRL_LW";
%     Pars.h = "M1M8th-M1M5th/2-M8th/2";
%     Pars.axis = "Y";
%     HFSS_Port(fileID,Pars,sprintf("Rect%0.0f",n+1))
%     HFSS_Rotate(fileID,sprintf("Rect%0.0f",n+1),sprintf("th_o+th/2+%0.0f*th",n-1));
end
    
% % Draw the end ports rectangles

% Pars.x = "xo";
% Pars.y = "yo + r_L-TRL_LW/2";
% Pars.z = "M1elv+M1M5th/2";
% Pars.h = "TRL_LW";
% Pars.w = "M1M8th-M1M5th/2-M8th/2";
% Pars.axis = "X";
% HFSS_Port(fileID,Pars,"Rect1");
% HFSS_Rotate(fileID,"Rect1","th_o");
% HFSS_Port(fileID,Pars,sprintf("Rect%0.0f",N+2));
% HFSS_Rotate(fileID,sprintf("Rect%0.0f",N+2),"th_o+th_tot");


%%
% [no_of_pts] = HFSS_Setup(fileID,250,100,300,10,"Fast");

%%
% file_location = "/data/zainkh/Desktop/Results/M8_TRL/";
% file_name = "";
% file_ext = ".s2p";
% L = 25:25:125;
% 
% setups = 1;
% for idx=1:length(L)
%     HFSS_Property(fileID, 'TRL_L'  , sprintf('%0.0fum',L(idx)));
%     filename = sprintf('%s%s%0.0f%s',file_location,file_name,L(idx),file_ext);
%     ExportData(fileID,filename,sprintf('Setup200'));
% end


%%

fclose(fileID);
fprintf("DONE !\n");


