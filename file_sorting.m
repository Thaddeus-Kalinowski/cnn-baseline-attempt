filepath = "C:\Users\thad5\Desktop\sentinel2";
images = dir(filepath);

for i = 1:2988
   if contains(img(i).name, "_HAB")
        movefile(fullfile(filepath,img(i).name), fullfile(filepath,"HAB"))
   elseif contains(img(i).name, "_nonHAB")
        movefile(fullfile(filepath,img(i).name), fullfile(filepath,"nonHAB"))
   elseif contains(img(i).name, "_clouds")
        movefile(fullfile(filepath,img(i).name), fullfile(filepath,"clouds"))
   elseif contains(img(i).name, "_land")
        movefile(fullfile(filepath,img(i).name), fullfile(filepath,"land"))
   end
end