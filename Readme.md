# HFSS_Lib 

This is a simple MATLAB library to generate a script file for HFSS. It is useful when you have a complex design or a design with many repetition. You need to be familiar with HFSS before you use this tool. 
I needed to a tool to help me draw in one of my projects so I built this library. It is not profissional ly written. I wrote it along the way as I needed. So always be aware if I missed anything in my descriptions. Make sure that it is doing what you want to do and don't count on me taking care of everything for you !

## How to use

1. Start in HFSS and add your materials file in PersonalLib folder if needed. 
2. you can do everything else in MATLAB or you can mix the steps between MATLAB and HFSS but you without repetition otherwise you will get an error in HFSS. 
3. after generating the script file, go to 'HFSS -> Tools -> Run Script -> select your script file' then wait until it finishs. 
4. The library allows you to draw and configure your setup but you need to do the excitation and boundaries manually. (for now)
5. Use MATLAB to store key positions then you can use 'strcat' to every parameter. Dont forget to add the operation "+" or "-". This way you can segment your big structure and let HFSS deals with the many many variables' strings. This makes you get the most out of using this library. 


## Suggested Code Flow

1. open a file to write in MATLAB with your script file name and location to be generated.
	example,
	> fileID = fopen(sprintf('/data/zainkh/Documents/MATLAB/HFSS_scripts/%s.py',Project_name),'w');
2. Create a project using 'HFSS_Project' (skip if you already created it).
3. Make your design active using 'HFSS_Header' (you need this before you modify anything in that design).
4. Define your properties or variables using 'HFSS_Variable'.
5. Draw the environment.
6. Draw your design, boxes and whatever. Always fill the struct inputs like 'Pars' and 'Attrib' before calling any drawing functions. 
7. Add the setup configurations using 'HFSS_Setup'. 
8. 'fclose(fileID);'

After you run the script, do the bounderies and excitations. 
Then analyse your design. 

if you are using parametric set in your design, you can use this code to extract all s-parameter files with your custom file naming. 
1. open a file to write in MATLAB with your script file name and location to be generated.
	example,
	> fileID = fopen(sprintf('/data/zainkh/Documents/MATLAB/HFSS_scripts/%s.py',Project_name),'w');
2. Make your design active using 'HFSS_Header' (you need this before you modify anything in that design).
3. in a loop, change your parameter using 'HFSS_Property'. 'help HFSS_ExportData' for an example.
4. Export your data to your desired location and file name. 
5. 'fclose(fileID);'


## Example Codes
Please refere to the example files. 

## To modify or to do more
You can refere to HFSS Scriping Help in HFSS but I found that it is not that useful unless your project is mainly building this tool. They give you all possible configuration and senarios. The way I built it was by recording a script while doing a single operation then getting that script and making it MATLAB friendly. You can record a script from 'Tools -> Record Script To File...'. 


