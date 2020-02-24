% % functions for HFSS scrips generation
% % Author : Zainulabideen Khalifa            Last Revision : 2/22/2020
% %-----------------------General Functions-------------------------------
% function [] = HFSS_Variable(fileID,Vars)
% function [] = HFSS_Header(fileID,Project_name)
% function [] = HFSS_Project(fileID,Project_location,Project_name)
% function [Vars] = ST55_Vars()
% function [] = ST55_Draw_Env(fileID)
% %-----------------------Drawing Functions--------------------------------
% function [] = HFSS_Cylinder(fileID,Pars,Attrib)
% function [] = HFSS_Ring(fileID,Pars,Attrib)
% function [] = HFSS_Arc(fileID,Pars,Attrib)
% function [] = HFSS_Box(fileID,Pars,Attrib,S)
% function [] = HFSS_Port(fileID,Pars,name)
% function [] = HFSS_Spline(fileID,Pars,Attrib)
% %-----------------------Operation Functions------------------------------
% function [] = HFSS_Unite(fileID,names)
% function [] = HFSS_Subtract(fileID,name1,name2)
% function [] = HFSS_Rotate(fileID,name,angle)
% function [] = HFSS_Property(fileID, Property, Value)
% function [] = HFSS_Move(fileID,name,vector)
% %-----------------------Setup Functions----------------------------------
% function [no_of_pts] = HFSS_Setup(fileID,freq,sfreq,efreq,fstep,Type)
% function [] = HFSS_DeleteSetup(filename,freq)
% function [] = ExportData(fileID,filename,setup_label)
% function [] = CombineCMD(setups, filename, line_no,ext)
