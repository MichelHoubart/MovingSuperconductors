// Include cross data
Include "Sample_Characteristics.pro";

// ---- Domain Dimensions ----
R_air = 0.08; // Inner shell radius [m]
R_inf = 0.1; // Outer shell radius [m]

// ---- Mesh parameters ----
DefineConstant [meshMult = 3]; // Multiplier [-] of a default mesh size distribution
DefineConstant [LcCube = meshMult*0.00035]; // Mesh size in superconductors [m]
DefineConstant [LcAir = meshMult*0.001]; // Mesh size away from superconductors [m]

// ---- Formulation definitions (dummy values) ----
h_formulation = 2;
a_formulation = 6;
coupled_formulation = 5;

// ---- Parameters of the array ----

DefineConstant[
  Modelled_Samples = {1, Choices{
        1="1 : Qualitative bulk",
        2="2 : Real Bulks",
        3="3 : Stacked Tapes"}
		, Name "Parameters of the array/1Type of sample to consider"}
];
DefineConstant[
  Num_Super = {3, Choices{
        1="1 : Computing the initial condition",
        3="3 : Partial Halbach array",
        5="5 : Complete Halbach array",
		2="Initial condition for FCZFC",
		4="Model FCZFC"}
		, Name "Parameters of the array/2Number of superconductors"}
];
If(Num_Super == 1 ||Num_Super == 2)
	Rotation_1 = Pi;
	DefineConstant[ Sample_1 = {666, Choices{
        1216,
        1218,
        1219,
		1220,
		1222,
		1215,
		1217,
		1221,
		1223,
		123456789, // Stacked tapes
		666  }, // Qualitative bulks
	Name "Parameters of the array/3Sample1 Number", Visible (Num_Super == 1)}];
	DefineConstant [Stationnary_Sample = {Sample_1, Name "Parameters of the array/4Stationnary Sample", Visible 0}];
	Sample_2 = 6664; // Supplementary sample
	Rotation_2 = 0;
ElseIf(Num_Super == 3 || Num_Super == 4)
	If(Modelled_Samples == 1)
		// Qualitative bulks
		Config_Base_1 = 666;
		Config_Base_2 = 666;
		Config_Base_3 = 666;
		Config_Base_4 = 6664;
	ElseIf(Modelled_Samples == 2)
		// Real Bulks
		Config_Base_1 = 1219;
		Config_Base_2 = 1218;
		Config_Base_3 = 1220;
	ElseIf(Modelled_Samples == 3)
		// Model Stacked tapes
		Config_Base_1 = 123456789;
		Config_Base_2 = 123456789;
		Config_Base_3 = 123456789;
		Config_Base_4 = 6664;
	EndIf
	Rotation_1 = 0;
	Rotation_2 = Pi/2;
	Rotation_3 = Pi;
	Rotation_4 = 0;
	For i In {1:Num_Super}
		DefineConstant[ Sample~{i} = {Config_Base~{i}, Choices{
        1216,
        1218,
        1219,
		1220,
		1222,
		1215,
		1217,
		1221,
		1223,
		123456789,
		666},
	Name Sprintf("Parameters of the array/5Sample%g Number", i), Visible (Num_Super == 3)||(Num_Super == 4)}];
	EndFor
	DefineConstant [Stationnary_Sample = {Sample_2, Name "Parameters of the array/6Stationnary Sample", Visible 0}];
Else
	Config_Base_1 = 1222;
	Config_Base_2 = 1219;
	Config_Base_3 = 1218;
	Config_Base_4 = 1220;
	Config_Base_5 = 1216;

	Rotation_1 = -Pi/2;
	Rotation_2 = 0;
	Rotation_3 = Pi/2;
	Rotation_4 = Pi;
	Rotation_5 = -Pi/2;
	For i In {1:Num_Super}
		DefineConstant[ Sample~{i} = {Config_Base~{i}, Choices{
        1216,
        1218,
        1219,
		1220,
		1222,
		1215,
		1217,
		1221,
		1223},
	Name Sprintf("Parameters of the array/7Sample%g Number", i), Visible (Num_Super == 5)}];
	EndFor
	DefineConstant [Stationnary_Sample = {Sample_5, Name "Parameters of the array/8Stationnary Sample", Visible 0}];
EndIf		
		
// ---- Displacement of the bulk ----
//Inputs
DefineConstant[
  Active_approach = {1, Choices{
        0="0 : No approach: Initial condition",
        1="1 : Approach + Retract",
        2="2 : Approach + Flux creep"}
		, Name "zBulks Motion/Input/0Model approach?", Visible 1}
];
DefineConstant[
  Approach_Type = {1, Choices{
        1="1 : Parallel to main axis",
        2="2 : Perpendicular to main axis",
        3="3 : Rotation"}
		, Name "zBulks Motion/Input/1Assembly process to compute", Visible Active_approach}
];
DefineConstant[
  Bulk_Disposition = {1, Choices{
        1="1 : Aligned (only possibility for different bulks)",
        2="2 : Half misaligned",
        3="3 : Fully misaligned",
		4="4 : User defined misalignement"}
		, Name "zBulks Motion/Input/1Bulk disposition in the array", Visible (Approach_Type==1)}
];
DefineConstant[ Maximal_separating_distance = {0.041, Name "zBulks Motion/Input/3Distance max between superconductors", Visible Active_approach}];
Str_Maxdist = Sprintf("%g", Maximal_separating_distance);
Str_LcCube = Sprintf("%g", (LcCube/meshMult)*100000);
DefineConstant[ Minimal_separating_distance = {0.0015, Name "zBulks Motion/Input/4Distance min between superconductors", Visible Active_approach}]; //FCZFC: 0.0014 (For Full 4th supercond)
If(Approach_Type == 2 && ((Num_Super==3)||(Num_Super==5)) )
	Minimal_separating_distance = 0;
EndIf
ContactDist_TransverseApproach = Minimal_separating_distance;
DefineConstant[ Initial_Dist_Sample_Sup = {0.0015, Name "zBulks Motion/Input/5Transverse initial distance", Visible (Approach_Type == 2)}];
DefineConstant[ Approach_cycle_nb = {1, Name "zBulks Motion/Input/6Number of approach cycles", Visible Active_approach }];
DefineConstant[ Time_step_per_cycle = {26, Name "zBulks Motion/Input/7Time step per cycle", Visible Active_approach }];
DefineConstant[ Approach_speed = {0.00001, Name "zBulks Motion/Input/8Vitesse d'approche [ms^-1]", Visible Active_approach }];
DefineConstant[ Time_step_amplitude = {(Approach_speed == 0) ? 180 : ((Maximal_separating_distance-Minimal_separating_distance)*2)/((Time_step_per_cycle)*(Approach_speed)), Name "zBulks Motion/Input/9Time step duration during motion[s]", Visible Active_approach }];
DefineConstant[ Flag_Test_projection = {0, Name "zBulks Motion/Input/99Test Projection"}];
DefineConstant[ Flag_Mvt_hformulation = {0, Name "zBulks Motion/Input/999Mouvement_hformulation"}];
DefineConstant [Flag_JcB = {0, Name "Input/3Material Properties/9Jc(B) dependence?"}];	// Superconductor exponent (n) value [-]

// Informations for the user
DefineConstant[ Time_step = {12, Min 12, Max ((Active_approach == 0) ? 1 : (Num_Super == 4) ? Time_step_per_cycle/2 : Time_step_per_cycle), Step 1, Loop  2, Name "zBulks Motion/Real time information/1Time step number", Visible Active_approach}];	// If 4 supercond, only compute assembly, not the retract mvt
DefineConstant[ Cycle = {1, Min 1, Max ((Active_approach == 0) ? 1 : Approach_cycle_nb), Step 1, Loop  1, Name "zBulks Motion/Real time information/2Current cycle ", Visible Active_approach}];
// Bulks position definition
If(Active_approach == 0 )
	Distance_between_super = Maximal_separating_distance;
ElseIf((Num_Super == 4)&&(Approach_Type == 2)) // FCZFC Step 2
	Distance_between_super = Initial_Dist_Sample_Sup + Time_step*(Approach_speed*Time_step_amplitude);
ElseIf(((Active_approach == 1) && ((Approach_Type == 1)||(Approach_Type == 2))) || (Active_approach == 2))
	If(Time_step<=(Time_step_per_cycle/2))
		Distance_between_super = Maximal_separating_distance - Time_step*(Approach_speed*Time_step_amplitude);
		// Distance_between_super = Maximal_separating_distance;
	Else
		If(Active_approach == 1)
			Distance_between_super = Maximal_separating_distance - (Time_step_per_cycle/2)*(Approach_speed*Time_step_amplitude) + (Time_step-Time_step_per_cycle/2)*(Approach_speed*Time_step_amplitude);
		Else
			Distance_between_super = Maximal_separating_distance - (Time_step_per_cycle/2)*(Approach_speed*Time_step_amplitude);
		EndIf
	EndIf
EndIf
If(Modelled_Samples == 1 ||Modelled_Samples == 2)
	DFromSurf = 0.001;
Else
	DFromSurf = 0.0015;
EndIf
// ---- Saving Files for Matlab post-processing? ----
DefineConstant[ Save_later = {1, Name "Input/5Save for Matlab?", Visible 1 }];


// Rotation of the bulks according to their position in the Halabch array
For i In {1:Num_Super}
	If((Rotation~{i} == Pi/2) || (Rotation~{i} == -Pi/2))
		temp = az~{Sample~{i}};
		az~{Sample~{i}} = ay~{Sample~{i}};
		ay~{Sample~{i}} = temp;
	EndIf
EndFor

// Air volume
Air_Lx = 0;
Air_Ly = 0;
Air_Lz = 0;
For i In {1:Num_Super}
	If(Air_Lx < ax~{Sample~{i}})
		Air_Lx = ax~{Sample~{i}};
	EndIf
	If(Air_Ly < ay~{Sample~{i}})
		Air_Ly = ay~{Sample~{i}};
	EndIf
	Air_Lz = Air_Lz + az~{Sample~{i}};
EndFor

If(Num_Super==2)
	Air_Lz = az~{Sample~{1}};
	Air_Ly = ay~{Sample~{1}}+ay~{Sample~{2}};
ElseIf(Num_Super==4)
	Air_Lz = Air_Lz - az~{Sample~{4}};
	Air_Ly = ay~{Sample~{1}}+ay~{Sample~{4}};
EndIf

If(Approach_Type == 1)
	If(Num_Super==3 || Num_Super==5)
		Air_Lz = Air_Lz + (Num_Super-1)*Maximal_separating_distance;
	ElseIf(Num_Super==4)
		Air_Lz = Air_Lz + (Num_Super-2)*Maximal_separating_distance;
	EndIf
ElseIf(Approach_Type == 2)
	Air_Ly = Air_Ly + 3*Maximal_separating_distance;
EndIf

Air_Lx = Air_Lx + 0.05;
Air_Ly = Air_Ly + 0.05;
Air_Lz = Air_Lz + 0.05;



// ---- Constant definition for regions ----
AIR = 2000;
SUPERCONDUCTING_REGION = 3000;
BND_MATERIAL = 4000;
SURF_OUT = 5000;
For i In {1:Num_Super}
	BULK~{i} = 10000*i;
	Boundary_BULK~{i} = 11111*i;
EndFor
ARBITRARY_POINT = 11000;
AP = 123456789;