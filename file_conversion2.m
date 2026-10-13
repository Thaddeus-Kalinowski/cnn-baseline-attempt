% The purpose of this file is to take the original dataset and then instead
% of 2900-ish folders, it splits everything into 2 folders, HAB and nonHAB.

% This makes it so that the CNN can use the 2 folder names as labels for
% correctness. It also makes it so that we can use the original dataset
% instead of my dataset where i combined 12 multispectral images into 1
% image. Oops

filepath = "C:\Users\thad5\Documents\MATLAB\rearranged_data\data";

folders = dir(filepath)

for i = 1:height(folders)
    if folders(i).name == "." || folders(i).name == ".." || folders(i).name == "HAB" || folders(i).name == "nonHAB"
        continue
    end

    dirFiles = dir(fullfile(filepath,folders(i).name))

    

    if contains(folders(i).name, "_HAB")
        % Move all the files within this folder to the data\HAB folder
        % Like "data\HAB\<folders(i).name>-AOT_raw.tif"
        for j = 3:height(dirFiles)
            oldLoc = fullfile(filepath,folders(i).name,dirFiles(j).name);
            newLoc = fullfile(filepath,"HAB",folders(i).name + "-" + dirFiles(j).name);
            movefile(oldLoc,newLoc)
        end
    else
        for j = 3:height(dirFiles)
            oldLoc = fullfile(filepath,folders(i).name,dirFiles(j).name);
            newLoc = fullfile(filepath,"nonHAB",folders(i).name + "-" + dirFiles(j).name);
            movefile(oldLoc,newLoc)
        end
    end
end