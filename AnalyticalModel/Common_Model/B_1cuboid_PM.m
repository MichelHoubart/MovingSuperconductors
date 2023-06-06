%% This function computes the magnetic flux density computed by a cuboid 
%% permanent magnet.
function [Btot,mtot] = B_1cuboid_PM(Caxis, Bulk_Centre, Bulk_Dimension, P, Kc, Nb_Slice)
Surface_Dimension = Bulk_Dimension;
Surface_Dimension(Caxis) = 0;
Surface_Centre = Bulk_Centre;
I = Kc * ((Bulk_Dimension(Caxis))/(Nb_Slice));
Btot = [0 0 0];
mtot = 0;
temp(1) = Btot(3);

for i = 1 : Nb_Slice
    Surface_Centre(Caxis) = Bulk_Centre(Caxis) - ((Bulk_Dimension(Caxis))/(2)) + ((Bulk_Dimension(Caxis))/(2*Nb_Slice)) + (i-1)*((Bulk_Dimension(Caxis))/(Nb_Slice));
    [Btemp,mtemp] = B_1_square_spire(Caxis, Surface_Centre, Surface_Dimension, P, I);
    Btot = Btot + Btemp;
    mtot = mtot + mtemp;
    temp(i+1) = Btot(3);
end

% Just to observe the impact of each slice on the total field (only work for Caxis == 3)
% plot(0:Nb_Slice,temp)
end