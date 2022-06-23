function [t,x,By] = Plot_Cut_singleech(Results,dir)
%% Formatting the data
nb_step = max(Results(:,1))+1;
t = Results(1:nb_step,2);
x = Results(1:nb_step:length(Results-(nb_step-1)),3+dir);
k = 1;
j = 1;
while(k<=length(Results(:,1)))
for(i=1:nb_step)
Bz(i,j) = Results(k+(i-1),8);
end
j = j+1;
k = k+nb_step;
end
plot(x*1000,Bz(end,:)*1000,'b','linewidth',2)
hold on

nb_point_in_spline = 500;
xx = linspace(x(1),x(end),nb_point_in_spline);
pspline = 0.999999999;
Bspline = csaps(x,Bz(end,:),pspline,xx);
plot(xx*1000,Bspline*1000,'k','linewidth',2)
end
