function FCZFC_CompareBalongx(Dir)
Epaisseur = {'0mm' '3mm' '4mm' '5mm' '6mm' '7mm' '14mm'};
nb_point_in_spline = 500;

for(i=1:length(Epaisseur))
    FileB = [Dir Epaisseur{i} '.txt'];
    ResultsB = load(FileB);
    [t,x,BFormating] = Data_Formatting_Simu(ResultsB,2);
    for(j=2:length(BFormating(:,1)))
        xB{i} = x*1000;
        By{i} = BFormating(j,:)*1000;  
        
        xx{i} = linspace(xB{i}(1),xB{i}(end),nb_point_in_spline);
        pspline = 0.9;
        Bspline{i} = csaps(xB{i},By{i}((j-1),:),pspline,xx{i});        
    end
    
    clear BFormating;
end

%% ************ Plot B brut ************ %%
col = {'r' 'g' 'k' 'm' 'y' 'r-.' 'g-.' 'k-.' 'm-.' 'y-.' 'r.' 'g.' 'k.' 'm.' 'y.'};
figure;
for(i=1:length(Epaisseur))
    hold on;
    plot(xB{i},By{i},col{i},'linewidth',2)
    Epaisseur{i} = ['h = ' Epaisseur{i}];
end
xlabel('x [mm]')
ylabel('Bz [mT]')
legend(Epaisseur)
%% ************ Plot smoothed B ************ %%
figure;
for(i=1:length(Epaisseur))
    hold on;
    plot(xx{i},Bspline{i},col{i},'linewidth',2)
end
xlabel('x [mm]')
ylabel('Bz [mT]')
legend(Epaisseur)

end