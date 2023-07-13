// Include cross data
Include "Sample_Characteristics.pro";
Rotation_Speed= 0; // There is a fight with the rotating super code, because they share the same source definition... should fix thix
// ---- Domain Dimensions ----
R_air = 0.08; // Inner shell radius [m]
R_inf = 0.1; // Outer shell radius [m]

// ---- Mesh parameters ----
DefineConstant [meshMult = 3]; // Multiplier [-] of a default mesh size distribution
/* DefineConstant [NbElemCube = 12];
DefineConstant [LcAir = meshMult*0.001]; // Mesh size away from superconductors [m] next : 0.0016 */

DefineConstant [NbElemCube = 13];
DefineConstant [NbElemHalfCube = 13];
DefineConstant [LcAir = meshMult*0.0012]; // Mesh size away from superconductors [m] next : 0.002

// ---- Formulation definitions (dummy values) ----
h_formulation = 2;
a_formulation = 6;
coupled_formulation = 5;

// ---- Parameters of the array ----
/* Str_SaveDir = StrCat["res\For_Matlab\ResultsApproach\12elem\THA\"]; */
Str_SaveDir = StrCat["res\For_Matlab\ResultsApproach\12elem\HA_misaligned\"];
DefineConstant[
  Modelled_Samples = {1, Highlight "Red", Choices{
        1="1 : Qualitative bulk",
        2="2 : Real Bulks", // Not implemented, and this is very very sad
        3="3 : Stacked Tapes",
        4="4 : Samples ATZ"}
		, Name "2Parameters of the configuration/1Type of sample to consider"}
]; // COUCOU
DefineConstant[
  Num_Super = {3, Highlight "Red", Choices{
        1="1 : Computing the initial condition",
        3="3 : Partial Halbach array",
        5="5 : Complete Halbach array",
		    2="Initial condition for FCZFC",
		    4="Model FCZFC"}
		, Name "2Parameters of the configuration/2Number of superconductors"}
];
DefineConstant [Flag_THAV2 = {0, Name "2Parameters of the configuration/5THA periph Sample shifted?", Visible 1}];
If(Num_Super == 1 ||Num_Super == 2)
  If(Modelled_Samples == 1)
  	DefineConstant[ Sample_1 = {666, Highlight "Red", Choices{
  		123456789, // Stacked tapes
  		666  }, // Qualitative bulks
  	Name "2Parameters of the configuration/3Sample1 Number", Visible (Num_Super == 1)}];
  	DefineConstant [Stationnary_Sample = {Sample_1, Highlight "Red", Name "2Parameters of the configuration/4Stationnary Sample", Visible 0}];
  	Sample_2 = 6664; // Supplementary sample
  ElseIf(Modelled_Samples == 2)
  		// Real Bulks
  ElseIf(Modelled_Samples == 3)
  		// Model Stacked tapes
      DefineConstant[ Sample_1 = {123456789, Highlight "Red", Choices{
    		123456789, // Stacked tapes
    		666  }, // Qualitative bulks
    	Name "2Parameters of the configuration/3Sample1 Number", Visible (Num_Super == 1)}];
    	DefineConstant [Stationnary_Sample = {Sample_1, Highlight "Red", Name "2Parameters of the configuration/4Stationnary Sample", Visible 0}];
    	Sample_2 = 6665; // Supplementary sample
  ElseIf(Modelled_Samples == 4)// ATZ samples
      DefineConstant[ Sample_1 = {42, Highlight "Red", Choices{
        41,    // Truncated cube left
        42,    // Full cube
        43  }, // Truncated cube right
      Name "2Parameters of the configuration/3Sample1 Number", Visible (Num_Super == 1)}];
      DefineConstant [Stationnary_Sample = {Sample_1, Highlight "Red", Name "2Parameters of the configuration/4Stationnary Sample", Visible 1}];
      Sample_2 = 6664; // Supplementary sample
  EndIf
ElseIf(Num_Super == 3 || Num_Super == 4)
	If(Modelled_Samples == 1)
		// Qualitative bulks
		Config_Base_1 = 666;
		Config_Base_2 = 666;
		Config_Base_3 = 666;
		Config_Base_4 = 6664;
	ElseIf(Modelled_Samples == 2)
		// Real Bulks
	ElseIf(Modelled_Samples == 3)
		// Model Stacked tapes
		Config_Base_1 = 123456789;
		Config_Base_2 = 123456789;
		Config_Base_3 = 123456789;
		Config_Base_4 = 6665;
  ElseIf(Modelled_Samples == 4)
  		// Truncated HA
  		Config_Base_1 = 41;
  		Config_Base_2 = 42;
  		Config_Base_3 = 43;
  		Config_Base_4 = 42;
	EndIf
	For i In {1:Num_Super}
		DefineConstant[ Sample~{i} = {Config_Base~{i}, Highlight "Red", Choices{
		123456789,
		666,
    6664,
    41,
    42,
    43},
	Name Sprintf("2Parameters of the configuration/3Sample%g Number", i), Visible (Num_Super == 3)||(Num_Super == 4)}];
	EndFor
	DefineConstant [Stationnary_Sample = {Sample_2, Name "2Parameters of the configuration/4Stationnary Sample", Visible 1}];
Else
	// 5 Samples, Not implemented
EndIf

// ---- Displacement of the bulk ----
//Inputs
DefineConstant[
  Active_approach = {1, Highlight "LightYellow", Choices{
        0="0 : No approach: Initial condition",
        1="1 : Approach + Retract",
        2="2 : Approach + Flux creep"}
		, Name "3Bulks Motion/Input/0Model approach?", Visible 1}
];
DefineConstant[
  Approach_Type = {1, Highlight "LightYellow", Choices{
        1="1 : Parallel to main axis",
        2="2 : Perpendicular to main axis",
        3="3 : Rotation"}
		, Name "3Bulks Motion/Input/1Assembly process to compute", Visible Active_approach}
];
DefineConstant[
  Bulk_Disposition = {3, Highlight "LightYellow", Choices{
        1="1 : Aligned",
        2="2 : Half misaligned",
        3="3 : Fully misaligned",
		    4="4 : User defined misalignement"}
		, Name "3Bulks Motion/Input/1Bulk disposition in the array", Visible (Approach_Type==1)}
];
DefineConstant[ Maximal_separating_distance = {0.041, Highlight "LightYellow", Name "3Bulks Motion/Input/3Distance max between superconductors", Visible Active_approach}];
Str_Maxdist = Sprintf("%g", Maximal_separating_distance);
/* Str_LcCube = Sprintf("%g", (LcCube/meshMult)*100000); */
DefineConstant[ Minimal_separating_distance = {0.0015, Highlight "LightYellow", Name "3Bulks Motion/Input/4Distance min between superconductors", Visible Active_approach}]; //FCZFC: 0.0014 (For Full 4th supercond)
If(Approach_Type == 2 && ((Num_Super==3)||(Num_Super==5)) )
	Minimal_separating_distance = 0;
EndIf
ContactDist_TransverseApproach = Minimal_separating_distance;
DefineConstant[ Initial_Dist_Sample_Sup = {0.0015, Highlight "LightYellow", Name "3Bulks Motion/Input/5Transverse initial distance", Visible (Approach_Type == 2)}];
DefineConstant[ Approach_cycle_nb = {1, Name "3Bulks Motion/Input/6Number of approach cycles", Visible Active_approach }];
DefineConstant[ Time_step_per_cycle = {26, Highlight "LightYellow", Name "3Bulks Motion/Input/7Time step per cycle", Visible Active_approach }];
DefineConstant[ Approach_speed = {0.00001, Highlight "LightYellow", Name "3Bulks Motion/Input/8Vitesse d'approche [ms^-1]", Visible Active_approach }];
DefineConstant[ Time_step_amplitude = {(Approach_speed == 0) ? 180 : ((Maximal_separating_distance-Minimal_separating_distance)*2)/((Time_step_per_cycle)*(Approach_speed)), Highlight "LightYellow", Name "3Bulks Motion/Input/9Time step duration during motion[s]", Visible Active_approach }];
DefineConstant [timeStart = {0, Highlight "LightGreen", Name "1Input/3Material Properties/92Initial time"}]; // Initial time [s]
DefineConstant[ Flag_Test_projection = {0, Highlight "LightYellow", Name "3Bulks Motion/Input/99Test Projection"}];
DefineConstant [Flag_JcB = {0, Highlight "LightGreen", Name "1Input/3Material Properties/91Jc(B) dependence?"}];	// Superconductor exponent (n) value [-]
DefineConstant [FlagFCNoCurrent = {0, Highlight "LightGreen", Name "1Input/3Material Properties/7Model FC without current?"}];
DefineConstant[ Flag_Skip1Step = {0, Highlight "LightYellow", Name "3Bulks Motion/Input/98Skip 1 Step"}];
// Informations for the user
DefineConstant[ Time_step = {13, Min 13, Max ((Active_approach == 0) ? 1 : (Num_Super == 4) ? Time_step_per_cycle/2 : Time_step_per_cycle), Step 1, Loop  2, Name "3Bulks Motion/Real time information/1Time step number", Visible Active_approach}];	// If 4 supercond, only compute assembly, not the retract mvt
DefineConstant[ Cycle = {1, Min 1, Max ((Active_approach == 0) ? 1 : Approach_cycle_nb), Step 1, Loop  1, Name "3Bulks Motion/Real time information/2Current cycle ", Visible Active_approach}];
// Bulks position definition
If(Active_approach == 0)
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
	DFromSurf = 0.001; // Distance between measuring point and sample surface
Else
	DFromSurf = 0.0015;  // Distance between measuring point and sample surface
EndIf
// ---- Saving Files for Matlab post-processing? ----
DefineConstant[ Save_later = {1, Highlight "LightGreen", Name "1Input/5Save for Matlab?", Visible 1 }];

// ----  Cheat to help convergence if 1 particular position is problematic ----
If(Flag_Skip1Step == 1)
  Time_step_amplitude = 2*Time_step_amplitude;
EndIf

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
If(Flag_THAV2)
  Air_Ly = 2*Air_Ly;
EndIf

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
