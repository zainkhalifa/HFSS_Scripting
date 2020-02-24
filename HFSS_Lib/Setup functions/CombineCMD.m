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
