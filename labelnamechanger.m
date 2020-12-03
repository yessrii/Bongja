clc, clear
%%
% Get Directory
Rootdir = fileparts(mfilename('fullpath'));

cd(Rootdir)
%%
folderlist = dir;
for i=5:length(folderlist)
   if isfolder(folderlist(i).name)
       cd(folderlist(i).name)
       targetlist = dir('*-*');
       for j=1:length(targetlist)
           idx = strfind(targetlist(j).name,'-');
           reName = targetlist(j).name(idx+1:end);
            movefile(targetlist(j).name, reName);
       end
   end 
   cd(Rootdir)
end