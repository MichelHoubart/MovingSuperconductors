Function{
MagRelaxPeriod = 2700; // Useful only for Ramp Up, Down and Flux creep.
ConstantlvlDurantion = 30;  // Useful only for Ramp down.
If(Flag_Source == 1)
      // Ramp Up and Down
      bmax_m = 2.4;
      bmin_m = 0;
      rate = 0.001;
      controlTimeInstants = {(bmax_m)/rate, ((2*bmax_m)-bmin_m)/rate};
      qttMax = bmax_m / mu0;
      qttMin = bmin_m / mu0;
      hsVal[] =  (($Time * rate  <= bmax_m) ? ($Time * rate)/mu0 : qttMax - (($Time - (bmax_m/rate))) * rate/mu0 );
      hsVal_prev[] = ((($Time-$DTime) * rate  <= bmax_m) ? (($Time-$DTime) * rate)/mu0 : qttMax - ((($Time-$DTime) - (bmax_m/rate)) * rate)/mu0 );
ElseIf(Flag_Source == 2)
      // Ramp Up, Down and Flux creep
      rate = 0.001;
      bmax_m = 2.7;
      bmin_m = 0.3;
      controlTimeInstants = {(bmax_m)/rate, ((2*bmax_m)-bmin_m)/rate, (((2*bmax_m)-bmin_m)/rate) + MagRelaxPeriod};
      qttMax = bmax_m / mu0;
      qttMin = bmin_m / mu0;
      hsVal[] =  (($Time * rate  <= bmax_m) ? ($Time * rate)/mu0 : ($Time * rate <= (2*bmax_m)-bmin_m) ? qttMax - (($Time - (bmax_m/rate)) * rate)/mu0 : bmin_m/ mu0);
      hsVal_prev[] = ((($Time-$DTime) * rate  <= bmax_m) ? (($Time-$DTime) * rate)/mu0 : (($Time-$DTime) * rate <= (2*bmax_m)-bmin_m) ? qttMax - ((($Time-$DTime) - (bmax_m/rate)) * rate)/mu0 : bmin_m/mu0);
ElseIf(Flag_Source == 3)
      // No source --> For movement
      controlTimeInstants = {999999,99999999}; // dummy
      bmax_m = 0;
      bmin_m = bmax_m;
      rate = 0;
      qttMax = 0;
      hsVal[] = 0;
      hsVal_prev[] = 0;
ElseIf(Flag_Source == 4)
    // Constant Field Background field
    controlTimeInstants = {999999,99999999}; // dummy
    bmax_m = 0.3;
    bmin_m = bmax_m;
    rate = 0;
    qttMax = 0;
    hsVal[] = bmax_m/ mu0;
    hsVal_prev[] = bmax_m/ mu0;
ElseIf(Flag_Source == 5)
    // Constant + Ramp Down
    bmax_m = 1.5;
    bmin_m = 0.3;
    rate = 0.001;
    controlTimeInstants = {ConstantlvlDurantion/2,ConstantlvlDurantion+((bmax_m-bmin_m)/rate)};
    qttMax = bmax_m / mu0;
    hsVal[] = ($Time < ConstantlvlDurantion) ? qttMax : qttMax - ((($Time - ConstantlvlDurantion) * rate)/mu0);
    hsVal_prev[] = (($Time-$DTime) < ConstantlvlDurantion) ? qttMax : qttMax - (((($Time-$DTime) - ConstantlvlDurantion) * rate)/mu0);
ElseIf(Flag_Source == 6)
    // Rotating field    /!\ Flag_Test_projection should be 1 and proper IC required for convergence.
    controlTimeInstants = {(ThetaMax/Rotation_Speed)/2,(ThetaMax/Rotation_Speed)};
    bmax_m = 0.3;
    bmin_m = bmax_m;
    rate = 0;
    qttMax = 0;
    hsVal[] = bmax_m/ mu0;
    hsVal_prev[] = bmax_m/ mu0;
ElseIf(Flag_Source == 7)
    // Ramp Up, Down and Rotate Field
    rate = 0.001;
    bmax_m = 2.7;
    bmin_m = 0.3;
    controlTimeInstants = {(bmax_m)/rate, ((2*bmax_m)-bmin_m)/rate, (((2*bmax_m)-bmin_m)/rate) + MagRelaxPeriod};
    qttMax = bmax_m / mu0;
    qttMin = bmin_m / mu0;
    hsVal[] =  (($Time * rate  <= bmax_m) ? ($Time * rate)/mu0 : ($Time * rate <= (2*bmax_m)-bmin_m) ? qttMax - (($Time - (bmax_m/rate)) * rate)/mu0 : bmin_m/ mu0);
    hsVal_prev[] = ((($Time-$DTime) * rate  <= bmax_m) ? (($Time-$DTime) * rate)/mu0 : (($Time-$DTime) * rate <= (2*bmax_m)-bmin_m) ? qttMax - ((($Time-$DTime) - (bmax_m/rate)) * rate)/mu0 : bmin_m/mu0);
EndIf
// Direction of applied field
If(Flag_Source == 6)
    directionApplied[] = MatRot[($Time)*Rotation_Speed]*Vector[0., 0., 1.];
ElseIf(Flag_Source == 7)
    directionApplied[] = ($Time * rate <= (2*bmax_m)-bmin_m) ? Vector[0., 0., 1.]: MatRot[(($Time-((2*bmax_m)-bmin_m)/rate))*(Rotation_Speed/40)]*Vector[0., 0., 1.];
Else
    directionApplied[] = Vector[0., 0., 1.];
EndIf
}
