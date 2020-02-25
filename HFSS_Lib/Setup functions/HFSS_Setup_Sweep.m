function [no_of_pts] = HFSS_Setup_Sweep(fileID,setup_label,sweep_label,sfreq,efreq,fstep,Type)
% HFSS_Setup_Sweep generates a script to insert a frequency sweep with 
% selected sweep type as "Fast","Discrete" or "Interpolating". 
%
% Author : Zainulabideen Khalifa            Last Revision : 2/24/2020
% Note that HFSS_Setup type only accept "Fast" for now... >_>
% 
% inputs: 
%     # setup_label --> the string name of the predefined setup for the
%                       sweep to be added to it.  
%     # sweep_label --> string with the name of the sweep
%     # sfreq --> the start frequency in GHz. sfreq is numeric %0.2f
%     # efreq --> the end frequency in GHz. efreq is numeric %0.0f
%     # fstep --> the step frequency in GHz. fstep is numeric %0.2f
%     # Type --> is a case-insensitive string with the type of sweep like
%               "Fast", "Discrete" or "Interpolating".
% 
% function [no_of_pts] = HFSS_Setup_Sweep(fileID,setup_label,sweep_label,sfreq,efreq,fstep,Type)


no_of_pts = ((efreq-sfreq)/fstep)+1;
fprintf("Setup(%s) Sweep(%s): (%0.2f,%0.0f,%0.2f) \t#pts = %0.0f\n"...
    ,setup_label,sweep_label,sfreq,efreq,fstep,no_of_pts)
    
Type = char(lower(Type));
switch Type(1)
    case 'f'        % for Fast
        fprintf(fileID,'oModule = oDesign.GetModule("AnalysisSetup")\n');
        fprintf(fileID,'oModule.InsertFrequencySweep("%s", \n',setup_label);
        fprintf(fileID,'	[\n');
        fprintf(fileID,'		"NAME:%s",\n',sweep_label);
        fprintf(fileID,'		"IsEnabled:="		, True,\n');
        fprintf(fileID,'		"RangeType:="		, "LinearStep",\n');
        fprintf(fileID,'		"RangeStart:="		, "%0.2fGHz",\n',sfreq);
        fprintf(fileID,'		"RangeEnd:="		, "%0.0fGHz",\n',efreq);
        fprintf(fileID,'		"RangeStep:="		, "%0.2fGHz",\n',fstep);
        fprintf(fileID,'		"Type:="		, "Fast",\n');
        fprintf(fileID,'		"SaveFields:="		, True,\n');
        fprintf(fileID,'		"SaveRadFields:="	, False,\n');
        fprintf(fileID,'		"GenerateFieldsForAllFreqs:=", False,\n');
        fprintf(fileID,'		"ExtrapToDC:="		, False\n');
        fprintf(fileID,'	])\n');
    case 'd'        % for Discrete
        fprintf(fileID,'oModule = oDesign.GetModule("AnalysisSetup")\n');
        fprintf(fileID,'oModule.InsertFrequencySweep("%s", \n',setup_label);
        fprintf(fileID,'	[\n');
        fprintf(fileID,'		"NAME:%s",\n',sweep_label);
        fprintf(fileID,'		"IsEnabled:="		, True,\n');
        fprintf(fileID,'		"RangeType:="		, "LinearStep",\n');
        fprintf(fileID,'		"RangeStart:="		, "%0.2fGHz",\n',sfreq);
        fprintf(fileID,'		"RangeEnd:="		, "%0.0fGHz",\n',efreq);
        fprintf(fileID,'		"RangeStep:="		, "%0.2fGHz",\n',fstep);
        fprintf(fileID,'		"Type:="		, "Discrete",\n');
        fprintf(fileID,'		"SaveFields:="		, True,\n');
        fprintf(fileID,'		"SaveRadFields:="	, False,\n');
        fprintf(fileID,'		"ExtrapToDC:="		, False\n');
        fprintf(fileID,'	])\n');
    case 'i'        % for Interpolating
        fprintf(fileID,'oModule = oDesign.GetModule("AnalysisSetup")\n');
        fprintf(fileID,'oModule.InsertFrequencySweep("%s", \n',setup_label);
        fprintf(fileID,'	[\n');
        fprintf(fileID,'		"NAME:%s",\n',sweep_label);
        fprintf(fileID,'		"IsEnabled:="		, True,\n');
        fprintf(fileID,'		"RangeType:="		, "LinearStep",\n');
        fprintf(fileID,'		"RangeStart:="		, "%0.2fGHz",\n',sfreq);
        fprintf(fileID,'		"RangeEnd:="		, "%0.0fGHz",\n',efreq);
        fprintf(fileID,'		"RangeStep:="		, "%0.2fGHz",\n',fstep);
        fprintf(fileID,'		"Type:="		, "Interpolating",\n');
        fprintf(fileID,'		"SaveFields:="		, True,\n');
        fprintf(fileID,'		"SaveRadFields:="	, False,\n');
        fprintf(fileID,'		"InterpTolerance:="	, 0.5,\n');
        fprintf(fileID,'		"InterpMaxSolns:="	, 250,\n');
        fprintf(fileID,'		"InterpMinSolns:="	, 0,\n');
        fprintf(fileID,'		"InterpMinSubranges:="	, 1,\n');
        fprintf(fileID,'		"ExtrapToDC:="		, False,\n');
        fprintf(fileID,'		"InterpUseS:="		, True,\n');
        fprintf(fileID,'		"InterpUsePortImped:="	, False,\n');
        fprintf(fileID,'		"InterpUsePropConst:="	, True,\n');
        fprintf(fileID,'		"UseDerivativeConvergence:=", False,\n');
        fprintf(fileID,'		"InterpDerivTolerance:=", 0.2,\n');
        fprintf(fileID,'		"UseFullBasis:="	, True,\n');
        fprintf(fileID,'		"EnforcePassivity:="	, True,\n');
        fprintf(fileID,'		"PassivityErrorTolerance:=", 0.0001\n');
        fprintf(fileID,'	])\n');
    otherwise
        error("The Type entered must be Fast, Discrete or Interpolating.")
end



end