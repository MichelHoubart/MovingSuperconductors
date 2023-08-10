Rotation_Speed= 0; // There is a fight with the rotating super code, because they share the same source definition... should fix thix
// ---- Domain Dimensions ----
R_air = 0.08; // Inner shell radius [m]

// ---- Mesh parameters ----
DefineConstant [meshMult = 3]; // Multiplier [-] of a default mesh size distribution
/* DefineConstant [NbElemCube = 12];
DefineConstant [LcAir = meshMult*0.001]; // Mesh size away from superconductors [m] next : 0.0016 */

DefineConstant [NbElemCube = 20];
DefineConstant [LcAir = meshMult*0.0022]; // Mesh size away from superconductors [m] next : 0.002

// ---- Formulation definitions (dummy values) ----
h_formulation = 2;
a_formulation = 6;
coupled_formulation = 5;

// Save directory
DefineConstant[ Str_SaveDir = {"res\For_Matlab\", Highlight "LightYellow", Name "1Input/1Save Directory"}];

// Sample Dimensions
Num_Super = 1;
DefineConstant[ ax = {0.00154, Highlight "LightYellow", Name "1Input/1Bulk Dimensions/1Side x [m]"}];
DefineConstant[ ay = {0.00175, Highlight "LightYellow", Name "1Input/1Bulk Dimensions/2Side y [m]"}];
DefineConstant[ az = {0.00503, Highlight "LightYellow", Name "1Input/1Bulk Dimensions/3Side z [m]"}];

// Applied field parameters
DefineConstant[ bmax_m = {3, Highlight "LightYellow", Name "1Input/1Applied Field/1Max [T]"}];
DefineConstant[ bmin_m = {-3, Highlight "LightYellow", Name "1Input/1Applied Field/2Min [T]"}];
DefineConstant[ rate = {0.001, Highlight "LightYellow", Name "1Input/1Applied Field/3Rate [Ts-1]"}];

DefineConstant[ Save_later = {1, Highlight "LightGreen", Name "1Input/5Save for Matlab?", Visible 1 }];
// Air volume
Air_Lx = R_air;
Air_Ly = R_air;
Air_Lz = R_air;


// ---- Constant definition for regions ----
AIR = 2000;
SUPERCONDUCTING_REGION = 3000;
BND_MATERIAL = 4000;
SURF_OUT = 5000;
For i In {1:1}
	BULK~{i} = 10000*i;
	Boundary_BULK~{i} = 11111*i;
EndFor
ARBITRARY_POINT = 11000;
AP = 123456789;

//*********************************** THE REST IS JUST THERE TO USE THE SAME .lib AS BEFORE ***********************************//

// Different Flag
DefineConstant[
  Active_approach = {0, Highlight "LightYellow", Choices{
        0="0 : No approach: Initial condition",
        1="1 : Approach + Retract",
        2="2 : Approach + Flux creep"}
		, Name "3Bulks Motion/Input/0Model approach?", Visible 1}
];
DefineConstant[ Flag_Test_projection = {0, Highlight "LightYellow", Name "3Bulks Motion/Input/99Test Projection"}];
DefineConstant [Flag_JcB = {1, Highlight "LightGreen", Name "1Input/3Material Properties/91Jc(B) dependence?"}];	// Superconductor exponent (n) value [-]
DefineConstant [FlagFCNoCurrent = {0, Highlight "LightGreen", Name "1Input/3Material Properties/7Model FC without current?"}];

// Parameter for resolution files
DefineConstant [timeStart = {0, Highlight "LightGreen", Name "1Input/3Material Properties/92Initial time"}];
DefineConstant[ Time_step = {1, Min 1, Max 1, Step 1, Loop  2, Name "3Bulks Motion/Real time information/1Time step number", Visible Active_approach}];	// If 4 supercond, only compute assembly, not the retract mvt
DefineConstant[ Time_step_per_cycle = {26, Highlight "LightYellow", Name "3Bulks Motion/Input/7Time step per cycle", Visible Active_approach }];
Str_step = "1";
