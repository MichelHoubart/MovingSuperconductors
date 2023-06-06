function [Btot] = B_1_Altered_Slice(Surface_Normal, Bulk_Centre, Bulk_Dimension, k, P, Jc, Nb_Slice, Nb_Spire)
Surface_Dimension = Bulk_Dimension;
Surface_Dimension(Surface_Normal) = 0;
Surface_Centre = Bulk_Centre;
Kc = Jc * ((Bulk_Dimension(Surface_Normal))/(Nb_Slice));
Btot = [0 0 0];
temp(1) = Btot(3);
% Only constant Jc for the moment
for i = 1 : Nb_Slice
    Surface_Centre(Surface_Normal) = Bulk_Centre(Surface_Normal) -...
                                    ((Bulk_Dimension(Surface_Normal))/(2))+...
                                    ((Bulk_Dimension(Surface_Normal))/(2*Nb_Slice))+...
                                    (i-1)*((Bulk_Dimension(Surface_Normal))/(Nb_Slice));
    Btot = Btot +...
           B_1_Supercondsurf_notcentered(Surface_Normal, Surface_Centre,...
                                         Surface_Dimension, k,Nb_Spire,P,Kc);
    temp(i+1) = Btot(3);
end

% Just to observe the impact of each slice on the total field
% plot(0:Nb_Slice,temp)
end