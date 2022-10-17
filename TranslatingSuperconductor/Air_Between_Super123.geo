newL_Air = 1111; // Dummy index
newCl_Air = 2222; // Dummy index
newPs_Air = 3333; // Dummy index
newSl_Air = 4444; // Dummy index
newV_Air = 5555; // Dummy index
// ******************* Air Between sample 1 et 2 ******************* //
// Lines
Line ( newL_Air ) = { 8+1, 16+2 };
Line ( newL_Air+1 ) = { 8+3 , 16+4  };
Line ( newL_Air+2 ) = { 8+5 , 16+6  };
Line ( newL_Air+3 ) = { 8+7 , 16+8 };

// Curve loops and surfaces (2 surfaces are already defined by the superconductor)
Curve Loop ( newCl_Air ) = { -(newL_Air+2), -(24+8), (newL_Air+3), (12+6)}; Plane Surface ( newPs_Air ) = { newCl_Air };
Curve Loop ( newCl_Air+1 ) = { newL_Air, 24+4, -(newL_Air+1), -(12+2)}; Plane Surface ( newPs_Air+1 ) = { newCl_Air+1 };
Curve Loop ( newCl_Air+2 ) = { newL_Air+2, -(24+9), -(newL_Air), (12+10)}; Plane Surface ( newPs_Air+2 ) = { newCl_Air+2 };
Curve Loop ( newCl_Air+3 ) = { newL_Air+1, (24+11), -(newL_Air+3), -(12+12)}; Plane Surface ( newPs_Air+3 ) = { newCl_Air+3 };

// Surface loop and volume
Surface Loop ( newSl_Air ) = {newPs_Air,newPs_Air+1,newPs_Air+2,newPs_Air+3,(6+6),(12+5) }; Volume ( newV_Air ) = { newSl_Air }; AirBetweenSuper() += {newV_Air};

// Quad Mesh in Air between superconductors
// Transfinite Surface(newPs_Air);
// Transfinite Surface(newPs_Air+1);
// Transfinite Surface(newPs_Air+2);
// Transfinite Surface(newPs_Air+3);
// Transfinite Surface(6+6);
// Transfinite Surface(12+5);
// Transfinite Volume(newV_Air);

// Recombine Surface(newPs_Air);
// Recombine Surface(newPs_Air+1);
// Recombine Surface(newPs_Air+2);
// Recombine Surface(newPs_Air+3);
// Recombine Surface(6+6);
// Recombine Surface(12+5);

// ******************* Air Between sample 2 et 3 ******************* //
// Lines
Line ( newL_Air+4 ) = { 16+1, 24+2 };
Line ( newL_Air+5 ) = { 16+3 , 24+4  };
Line ( newL_Air+6 ) = { 16+5 , 24+6  };
Line ( newL_Air+7 ) = { 16+7 , 24+8 };

// Curve loops and surfaces (2 surfaces are already defined by the superconductor)
Curve Loop ( newCl_Air+4 ) = { -(newL_Air+2+4), -(36+8), (newL_Air+3+4), (24+6)}; Plane Surface ( newPs_Air+4 ) = { newCl_Air+4 };
Curve Loop ( newCl_Air+5 ) = { newL_Air+4, 36+4, -(newL_Air+4+1), -(24+2)}; Plane Surface ( newPs_Air+1+4 ) = { newCl_Air+5 };
Curve Loop ( newCl_Air+6 ) = { newL_Air+4+2, -(36+9), -(newL_Air+4), (24+10)}; Plane Surface ( newPs_Air+2+4 ) = { newCl_Air+6 };
Curve Loop ( newCl_Air+7 ) = { newL_Air+4+1, (36+11), -(newL_Air+4+3), -(24+12)}; Plane Surface ( newPs_Air+3+4 ) = { newCl_Air+7 };

// Surface loop and volume
Surface Loop ( newSl_Air+1 ) = {newPs_Air+4,newPs_Air+4+1,newPs_Air+4+2,newPs_Air+4+3,(12+6),(18+5) }; Volume ( newV_Air+1 ) = { newSl_Air+1 }; AirBetweenSuper() += {newV_Air+1};

// Quad Mesh in Air between superconductors
// Transfinite Surface(newPs_Air+4);
// Transfinite Surface(newPs_Air+1+4);
// Transfinite Surface(newPs_Air+2+4);
// Transfinite Surface(newPs_Air+3+4);
// Transfinite Surface(12+6);
// Transfinite Surface(18+5);
// Transfinite Volume(newV_Air+1);

// Recombine Surface(newPs_Air+4);
// Recombine Surface(newPs_Air+1+4);
// Recombine Surface(newPs_Air+2+4);
// Recombine Surface(newPs_Air+3+4);
// Recombine Surface(12+6);
// Recombine Surface(18+5);