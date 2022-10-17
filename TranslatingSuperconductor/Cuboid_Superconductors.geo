SetFactory("OpenCASCADE");
// Include cross data
Include "Cuboid_Superconductors_data.pro";
Include "Sample_Characteristics.pro";

// Definition of the air volume
airVol = 1234;
Block(airVol) = {-Air_Lx/2, -Air_Ly/2, -Air_Lz/2, Air_Lx, Air_Ly, Air_Lz};


//****************** Definition of the bulk superconductors ******************//

// Dummy numbering, change this in a clean code (This odd numbering is caused by the fact that the sample numbering change when we add more bulks...
// The "True_numbering" variable labels each position in the array with a single nunmber whatever the number of sample in the array).
If(Num_Super == 1||Num_Super == 2)
	True_Numbering_1 = 3;
	True_Numbering_2 = 6;
ElseIf(Num_Super == 3 || Num_Super == 4)
	True_Numbering_1 = 2;
	True_Numbering_2 = 3;
	True_Numbering_3 = 4;
	True_Numbering_4 = 6;
ElseIf(Num_Super == 5)
	True_Numbering_1 = 1;
	True_Numbering_2 = 2;
	True_Numbering_3 = 3;
	True_Numbering_4 = 4;
	True_Numbering_5 = 5;
EndIf

// Starting point of the first cuboid (x and y dir --> same whatever the type of displacement, z --> Depend the 3 displacement type considered)
// x Bottom
x_Bottom_Super = -ax~{Stationnary_Sample}/2;
// y Bottom
If(Num_Super == 2 || Num_Super == 4)
	y_Bottom_Super = -ay~{Stationnary_Sample};
Else
	y_Bottom_Super = -ay~{Stationnary_Sample}/2;
EndIf
// z Bottom
If(Approach_Type == 1)
	If(Num_Super == 1|| Num_Super == 2)
		z_Bottom_Super = -az~{Stationnary_Sample}/2;
	ElseIf(Num_Super == 3|| Num_Super == 4)
		z_Bottom_Super = -az~{Stationnary_Sample}/2-Distance_between_super - az~{Sample~{1}};
		z_Bottom_Super_6 = -az~{Stationnary_Sample}/2;
	Else
		z_Bottom_Super = -az~{Stationnary_Sample}/2-2*Distance_between_super - az~{Sample~{1}} - az~{Sample~{2}};
	EndIf
ElseIf(Approach_Type == 2)
	If(Num_Super == 1|| Num_Super == 2)
		z_Bottom_Super = -az~{Stationnary_Sample}/2;
	ElseIf(Num_Super == 3 || Num_Super == 4)
		z_Bottom_Super = -az~{Stationnary_Sample}/2-ContactDist_TransverseApproach - az~{Sample~{1}};
		z_Bottom_Super_6 = -az~{Stationnary_Sample}/2;
	Else
		z_Bottom_Super = -az~{Stationnary_Sample}/2-2*ContactDist_TransverseApproach - az~{Sample~{1}} - az~{Sample~{2}};
	EndIf
EndIf

// Creation of the 3 Bulk, their initial positions depend both on the chosen displacement type and on the disposition chosen.
If(Num_Super == 2)
	// Initial condition for FCZFC
	Include "FCZFC_Initialcondition.geo";
ElseIf(Num_Super == 4)
	// Displacement of FCZFC
	Include "FCZFC.geo";
Else
	// Assembly of a classical HA (Single sample is handled here as well)
	Include "ClassicHA.geo";
EndIf


//****************** Volume and Physical definition ******************//
If((Num_Super == 3)||(Num_Super == 4))
	Include "Air_Between_Super123.geo"; // Regular mesh between super
	If((Num_Super==4))
		Include "Air_Between_Super24.geo";
	EndIf
	volAir = BooleanDifference{ Volume{airVol}; Delete; }{ Volume{MaterialVol_Tot()};Volume{AirBetweenSuper()};};
	Physical Volume("Air", AIR) = {volAir,AirBetweenSuper()};
Else
	volAir = BooleanDifference{ Volume{airVol}; Delete; }{ Volume{MaterialVol_Tot()};};
	Physical Volume("Air", AIR) = {volAir};
EndIf

Physical Surface("Boundary material", BND_MATERIAL) = {f_c_Tot()};
f_s() = Boundary{Volume{volAir};};
l_s() = Boundary{Surface{f_s(0),f_s(1),f_s(2),f_s(3),f_s(4),f_s(5)};};
p_s() = PointsOf{Line{l_s()};};
Characteristic Length{p_s()} = LcAir;
Physical Surface("Boundary air", SURF_OUT) = {f_s(0),f_s(1),f_s(2),f_s(3),f_s(4),f_s(5)};
For i In {1:Num_Super}
	Physical Volume(Sprintf("Bulk %g", i), BULK~{i}) = {materialVol~{i}()};
	Physical Surface(Sprintf("Boundary Bulk %g", i), Boundary_BULK~{i}) = {f_c~{i}()};
EndFor

//****************** Some colors ******************//
// test() = Boundary{Volume{AirBetweenSuper()};};
// Color Red{Surface{test()};} // Air + Air inf
// Color Red{Volume{volAir,AirBetweenSuper()};} // Air + Air inf
// Color Red{Surface{f_c_Tot()};} // Air + Air inf
// Color Green {Surface{f_c_Tot()};} // Cylinder
// Color SkyBlue {Surface{f_c_Tot(5),f_c_Tot(11),f_c_Tot(17)};}
