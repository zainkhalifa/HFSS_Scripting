function [no_of_pts] = HFSS_Setup(fileID,freq,sfreq,efreq,fstep,Type)
% HFSS_Setup generates a script to generate a setup with selected sweep 
% type. It will create the setup with the following configurations:
% Maximum Number of Passes = 20
% Maximum Delta S = 0.02
% Minimum Number of Passes = 2
% Minimum Converged Passes = 2
% everything else will be to the default of HFSS. 
%
% Author : Zainulabideen Khalifa            Last Revision : 2/22/2020
% Note that HFSS_Setup type only accept "Fast" for now... >_>
% 
% inputs: 
%     # freq --> is the freqeuncy at which the solutions will be simulated 
%       in GHz. It will be also the name of the setup as "Setup123" for 
%       freq=123;. freq is numeric 
%     # sfreq --> the start frequency in GHz. sfreq is numeric 
%     # efreq --> the end frequency in GHz. efreq is numeric 
%     # fstep --> the step frequency in GHz. fstep is numeric 
%     # Type --> is a string with the type of sweep like "Fast", "Discrete"
%     of Interpolating".

if Type ~= "Fast"
    error("sorry only fast for now")
end

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
