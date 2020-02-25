function [] = HFSS_Setup(fileID,Setup_label,freq)
% HFSS_Setup generates a script to generate a setup
% 
% It will create the setup with the following configurations:
% Maximum Number of Passes = 20
% Maximum Delta S = 0.02
% Minimum Number of Passes = 2
% Minimum Converged Passes = 2
% everything else will be to the default of HFSS. 
% 
% Author : Zainulabideen Khalifa            Last Revision : 2/24/2020
% 
% inputs: 
%     # Setup_label --> the string name of the defined setup.
%     # freq --> is the freqeuncy at which the solutions will be simulated 
%       in GHz. freq is numeric %0.2f
%
% function [] = HFSS_Setup(fileID,Setup_label,freq)
% 
% see also, HFSS_Setup_Sweep

    fprintf(fileID,'oModule = oDesign.GetModule("AnalysisSetup")\n');
    fprintf(fileID,'oModule.InsertSetup("HfssDriven", \n');
    fprintf(fileID,'	[\n');
    fprintf(fileID,'		"NAME:%s",\n',Setup_label);
    fprintf(fileID,'		"AdaptMultipleFreqs:="	, False,\n');
    fprintf(fileID,'		"Frequency:="		, "%0.2fGHz",\n',freq);
    fprintf(fileID,'		"MaxDeltaS:="		, 0.02,\n');
    fprintf(fileID,'		"MaxDeltaE:="		, 0.02,\n');
    fprintf(fileID,'		"PortsOnly:="		, False,\n');
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

    
   
end
