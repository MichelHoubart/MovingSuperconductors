newL_Air = 1111; // Dummy index
newCl_Air = 2222; // Dummy index
newPs_Air = 3333; // Dummy index
newSl_Air = 4444; // Dummy index
newV_Air = 5555; // Dummy index

// ******************* Air Between sample 2 et 4 ******************* //
// Lines
Line ( newL_Air+8 ) = { 16+8, 32+6 };
Line ( newL_Air+9 ) = { 16+4 , 32+2  };
Line ( newL_Air+10 ) = { 16+3 , 32+1  };
Line ( newL_Air+11  ) = { 16+7 , 32+5 };

// Curve loops and surfaces (2 surfaces are already defined by the superconductor)
Curve Loop ( newCl_Air+4+4 ) = { (newL_Air+8+1),48+9,-(newL_Air+8),-(24+11)}; Plane Surface ( newPs_Air+4+4 ) = { newCl_Air+4+4 };
Curve Loop ( newCl_Air+5+4 ) = {(newL_Air+8+2),48+1,-(newL_Air+8+1),-(24+3) }; Plane Surface ( newPs_Air+1+4+4 ) = { newCl_Air+5+4 };
Curve Loop ( newCl_Air+6+4 ) = {(newL_Air+8+3),-(48+10),-(newL_Air+8+2),(24+12) }; Plane Surface ( newPs_Air+2+4+4 ) = { newCl_Air+6+4 };
Curve Loop ( newCl_Air+7+4 ) = {(newL_Air+8),-(48+5),-(newL_Air+8+3),-(24+7) }; Plane Surface ( newPs_Air+3+4+4 ) = { newCl_Air+7+4 };

// Surface loop and volume
Surface Loop ( newSl_Air+2 ) = {newPs_Air+4+4,newPs_Air+4+4+1,newPs_Air+4+4+2,newPs_Air+4+4+3,(12+4),(24+3) }; Volume ( newV_Air+2 ) = { newSl_Air+2 }; AirBetweenSuper() += {newV_Air+2};

// Quad Mesh in Air between superconductors
// Transfinite Surface(newPs_Air+4+4);
// Transfinite Surface(newPs_Air+1+4+4);
// Transfinite Surface(newPs_Air+2+4+4);
// Transfinite Surface(newPs_Air+3+4+4);
// Transfinite Surface(12+4);
// Transfinite Surface(24+3);
// Transfinite Volume(newV_Air+2);

// Recombine Surface(newPs_Air+4+4);
// Recombine Surface(newPs_Air+1+4+4);
// Recombine Surface(newPs_Air+2+4+4);
// Recombine Surface(newPs_Air+3+4+4);
// Recombine Surface(12+4);
// Recombine Surface(24+3);	
