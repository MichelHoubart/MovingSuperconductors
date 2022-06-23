function [xexport,Bexport] = Plot_Cutalongx_Simu(Dir,step)
%% Load and formatting the data
FileB = [Dir '/Cut_B_alongx_3Bulks_05away' step '.txt'];
FileJx = [Dir '/Cut_jx_alongz_3Bulks_Quarterfromcentre' step '.txt'];
ResultsB = load(FileB);
% ResultsJx = load(FileJx);
% Jx = ResultsJx(2:2:end,6);
% xforJ = ResultsJx(2:2:end,5);
[t,x,By] = Data_Formatting_Simu(ResultsB,2);

%% Plot the Cut (and the smoothing)
col = {'r' 'g' 'k' 'm' 'y' 'r-.' 'g-.' 'k-.' 'm-.' 'y-.' 'r.' 'g.' 'k.' 'm.' 'y.'};
% for(i=2:length(By(:,1)))
    plot(x*1000,By(end,:)*1000,'b','linewidth',2)
%     hold on

    nb_point_in_spline = 500;
    xx = linspace(x(1),x(end),nb_point_in_spline);
    pspline = 0.999999999;
    Bspline = csaps(x,By(end,:),pspline,xx);

%     Bexport = By(end,:)*1000;
%      xexport = x;
    Bexport = Bspline*1000;
    xexport = xx;
    
%     plot(xx*1000,Bspline*1000,col{1},'linewidth',2)
% end
% axis([-80 80 -100 275]);
axis([-80 80 -200 500]);
xlabel('x [mm]')
ylabel('Bz [mT]')

% close all

%% Plot the current density along the line
% figure
% plot(xforJ*1000,Jx*0.00000001,'b','linewidth',2);
% xlabel('x [mm]');
% ylabel('Jxe-8 [A/m2]')
end