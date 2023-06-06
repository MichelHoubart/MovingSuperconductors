function [Btot] = B_1_Supercondsurf_notcentered(Surface_Normal, Surface_Centre, Surface_Dimension, k,Number_Of_Spire,P,Kc)
close all
   Horizontal_axis = mod(Surface_Normal,3) + 1;
   Vertical_axis = mod(Horizontal_axis,3) + 1;
   
   Kc1 = Kc*((Surface_Dimension(Horizontal_axis))/(2*(Surface_Dimension(Horizontal_axis) - k(Horizontal_axis))));
   Kc2 = Kc*((Surface_Dimension(Vertical_axis))/(2*(Surface_Dimension(Vertical_axis) - k(Vertical_axis))));
   Kc3 = Kc*((Surface_Dimension(Horizontal_axis))/(2*(k(Horizontal_axis))));
   Kc4 = Kc*((Surface_Dimension(Vertical_axis))/(2*(k(Vertical_axis))));   
   Btot = [0 0 0];
   
   for i = 1:Number_Of_Spire
      Vertmini = -(Surface_Dimension(Vertical_axis)/2) + i*(k(Vertical_axis)/(Number_Of_Spire + 1));
      Vertmaxi = (Surface_Dimension(Vertical_axis)/2) - i*(abs(Surface_Dimension(Vertical_axis)-k(Vertical_axis))/(Number_Of_Spire + 1));
      Horizmini = (-Surface_Dimension(Horizontal_axis)/2) + i*(k(1)/(Number_Of_Spire + 1));
      Horizmaxi =  (Surface_Dimension(Horizontal_axis)/2) - i*(abs(Surface_Dimension(Horizontal_axis)-k(Horizontal_axis))/(Number_Of_Spire + 1));
      
      % Zone 1  
      Centre_zone1 = Surface_Centre;
      Centre_zone1(Horizontal_axis) = Centre_zone1(Horizontal_axis) + Horizmaxi;
      Centre_zone1(Vertical_axis) = Centre_zone1(Vertical_axis) + (Vertmini + Vertmaxi)/2;
      [Bx By Bz] = B_1_wire(Vertical_axis,Centre_zone1,(abs(Vertmaxi-Vertmini)),P,((Kc1*(Surface_Dimension(Horizontal_axis) - k(Horizontal_axis)))/(Number_Of_Spire)));
      Btot = Btot + [Bx By Bz];

      hold on;
      
      % Zone 2   
      Centre_zone2 = Surface_Centre;
      Centre_zone2(Horizontal_axis) = Centre_zone2(Horizontal_axis) + (Horizmini+Horizmaxi)/2;
      Centre_zone2(Vertical_axis) = Centre_zone2(Vertical_axis) + Vertmaxi;
      [Bx By Bz] = B_1_wire(Horizontal_axis,Centre_zone2,abs(Horizmaxi - Horizmini),P,-Kc2 * ((Surface_Dimension(Vertical_axis)-k(Vertical_axis))/(Number_Of_Spire)));
      Btot = Btot + [Bx By Bz];
      
      % Zone 3
      Centre_zone3 = Surface_Centre;
      Centre_zone3(Horizontal_axis) = Centre_zone3(Horizontal_axis) + Horizmini;
      Centre_zone3(Vertical_axis) = Centre_zone3(Vertical_axis) + (Vertmini + Vertmaxi)/2;
      [Bx By Bz] = B_1_wire(Vertical_axis,Centre_zone3,(abs(Vertmaxi-Vertmini)),P,-((Kc3*(k(Horizontal_axis)))/(Number_Of_Spire)));
      Btot = Btot + [Bx By Bz];
     
      % Zone 4 
      Centre_zone4 = Surface_Centre;
      Centre_zone4(Horizontal_axis) = Centre_zone4(Horizontal_axis) + (Horizmini+Horizmaxi)/2;
      Centre_zone4(Vertical_axis) = Centre_zone4(Vertical_axis) + Vertmini;
      [Bx By Bz] = B_1_wire(Horizontal_axis,Centre_zone4,abs(Horizmaxi - Horizmini),P,Kc4 * (k(Vertical_axis)/(Number_Of_Spire)));
      Btot = Btot + [Bx By Bz];
      
      % DEBUG : Plot the spires
%       plot([Surface_Centre(Horizontal_axis)+Horizmaxi Surface_Centre(Horizontal_axis)+Horizmaxi],[Surface_Centre(Vertical_axis)+Vertmini Surface_Centre(Vertical_axis)+Vertmaxi],'b');
%       hold on;
%       plot([Surface_Centre(Horizontal_axis)+Horizmini Surface_Centre(Horizontal_axis)+Horizmaxi],[Surface_Centre(Vertical_axis)+Vertmaxi Surface_Centre(Vertical_axis)+Vertmaxi],'b');
%       plot([Surface_Centre(Horizontal_axis)+Horizmini Surface_Centre(Horizontal_axis)+Horizmini],[Surface_Centre(Vertical_axis)+Vertmini Surface_Centre(Vertical_axis)+Vertmaxi],'b');
%       plot([Surface_Centre(Horizontal_axis)+Horizmini Surface_Centre(Horizontal_axis)+Horizmaxi],[Surface_Centre(Vertical_axis)+Vertmini Surface_Centre(Vertical_axis)+Vertmini],'b');
%       plot(Surface_Centre(Horizontal_axis)-Surface_Dimension(Horizontal_axis)/2+k(Horizontal_axis),Surface_Centre(Vertical_axis)-Surface_Dimension(Vertical_axis)/2+k(Vertical_axis),'k.','Markersize',20);
      
   end 
   % DEBUG : Plot the frame
%    plot([Surface_Centre(Horizontal_axis)+Surface_Dimension(Horizontal_axis)/2 Surface_Centre(Horizontal_axis)+Surface_Dimension(Horizontal_axis)/2],[Surface_Centre(Vertical_axis)-Surface_Dimension(Vertical_axis)/2 Surface_Centre(Vertical_axis)+Surface_Dimension(Vertical_axis)/2],'k');
%    plot([Surface_Centre(Horizontal_axis)-Surface_Dimension(Horizontal_axis)/2 Surface_Centre(Horizontal_axis)+Surface_Dimension(Horizontal_axis)/2],[Surface_Centre(Vertical_axis)+Surface_Dimension(Vertical_axis)/2 Surface_Centre(Vertical_axis)+Surface_Dimension(Vertical_axis)/2],'k');
%    plot([Surface_Centre(Horizontal_axis)-Surface_Dimension(Horizontal_axis)/2 Surface_Centre(Horizontal_axis)-Surface_Dimension(Horizontal_axis)/2],[Surface_Centre(Vertical_axis)-Surface_Dimension(Vertical_axis)/2 Surface_Centre(Vertical_axis)+Surface_Dimension(Vertical_axis)/2],'k');
%    plot([Surface_Centre(Horizontal_axis)-Surface_Dimension(Horizontal_axis)/2 Surface_Centre(Horizontal_axis)+Surface_Dimension(Horizontal_axis)/2],[Surface_Centre(Vertical_axis)-Surface_Dimension(Vertical_axis)/2 Surface_Centre(Vertical_axis)-Surface_Dimension(Vertical_axis)/2],'k');
end