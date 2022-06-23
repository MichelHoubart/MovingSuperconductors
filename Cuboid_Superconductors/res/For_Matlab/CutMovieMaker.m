function CutMovieMaker(Dir,NbStep)
for(i=1:NbStep)
    [x,B] = Plot_Cutalongx_Simu(Dir,num2str(i));
    save([Dir '\ForMovie\Step' num2str(i)],'x','B');
    clear x;
    clear B;
    pause(0.5);
end
end