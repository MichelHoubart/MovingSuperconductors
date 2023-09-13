%% Chose Temperature to consider 
Temperature = 59;
% Applied field
bmin_m = [50 100 150 200 300 400 500]*0.001;
nbSudyval = length(bmin_m);

% Geometry --> don't change
ax = ones(1,nbSudyval)*0.006;
ay = ones(1,nbSudyval)*0.006;
az = ones(1,nbSudyval)*0.006;

% Law jcB
Flag_JcB = 2;
FittedJcBLaw;
for i = 1:nbSudyval
    Str_ReadDir = strcat('D:\Michel\CuboidSuperConductorsWP1\Rotating\BatchRotation\ExtendedKim\FC\Batch',...
                         sprintf('%gKFrom0mTTo%gmT',Temperature,bmin_m(end)*1000),...
                         '\',sprintf('Background%g',bmin_m(i)*1000),'\');
    Str_SaveDir = strcat('res\For_Matlab\BatchRotation\ExtendedKim\FC\Batch',...
                         sprintf('%gKFrom0mTTo%gmT',Temperature,bmin_m(end)*1000),...
                         '\',sprintf('Background%g',bmin_m(i)),'\');
    mkdir(Str_SaveDir);
    ReadAndConiditionRes(Str_ReadDir,Str_SaveDir)
    copyfile(strcat(Str_ReadDir,'Param.txt'),Str_SaveDir)
end

function ReadAndConiditionRes(dir1,dir2)
% Conditionning
fid = fopen(strcat(dir1,'BLineCentre_Step.txt'),'r');
txt = textscan(fid,'%s','delimiter','\n');
idDelete = 0;
for(i = 1:length(txt{1,1}))
    if(strcmp(txt{1,1}{i}(4),'0'))
        idDelete = [idDelete;i];
    end    
end
idDelete(1) = [];
txtnew = txt;
txtnew{1,1}(idDelete) = [];

% Writing
fid = fopen(strcat(dir2,'BLineCentreConditionned.txt'),'w');
for(i = 1:length(txtnew{1,1}))
  fprintf(fid,'%s \n',txtnew{1,1}{i});
end
fclose('all');
end