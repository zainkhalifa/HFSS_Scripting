function [] = HFSS_ExportData(fileID,filename,setup_label)
% HFSS_ExportData generates a script to  export the s-parameters of 
% a certain setup with sweep. It will set the resistance to 50 and the
% number of digits to 15. 
% 
% Author : Zainulabideen Khalifa            Last Revision : 2/22/2020
% 
% Pars and Attrib are of type struct with the following as elements. 
% All elements must be filled before calling the function. 
% 
% inputs: all inputs are to be written as strings
%     # filename --> is the output file name with the location and
%     extension.
%     # setup_label --> is the the name of hte setup
% 
% example:
%     file_location = "/data/zainkh/Documents/HFSS_SP/Slotting_test";
%     file_name = "";
%     file_ext = ".s2p";
% 
%     var = 0.5:1:15.5;
%     setups = 250;
%     for idx=1:length(var)
%         HFSS_Property(fileID, 'slot_len'  , sprintf('%0.2fum',var(idx)));
% 
%         for sidx=1:length(setups)
%             Setup_no = setups(sidx);
%             filename = sprintf('%s/%s%0.0f%s',file_location,file_name,var(idx)*1000,file_ext);
%             HFSS_ExportData(fileID,filename,sprintf('Setup%0.0f',Setup_no));
%         end
%     end



    fprintf(fileID,'oModule = oDesign.GetModule("Solutions")\n');
    fprintf(fileID,'oModule.ExportNetworkData("", ["%s:Sweep"], 3, ',setup_label);
    fprintf(fileID,'"%s", \n',filename);
    fprintf(fileID,'	[\n');
    fprintf(fileID,'"All"\n');
    fprintf(fileID,'	], True, 50, "S", -1, 0, 15, True, False, False)\n'); 
end
