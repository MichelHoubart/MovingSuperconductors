function [t,x,By] = Data_Formatting_Simu(Results,dir)
%% Formatting the data
nb_step = max(Results(:,1))+1;
t = Results(1:nb_step,2);
x = Results(1:nb_step:length(Results-(nb_step-1)),3+dir);
k = 1;
j = 1;
while(k<=length(Results(:,1)))
for(i=1:nb_step)
By(i,j) = Results(k+(i-1),7);
end
j = j+1;
k = k+nb_step;
end
end
