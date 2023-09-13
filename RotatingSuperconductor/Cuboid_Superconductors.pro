// Include cross data
Include "Cuboid_Superconductors_data.pro";
Include "Sample_Characteristics.pro";

Group {
    // Preset choice of formulation
    DefineConstant[preset = {4, Highlight "Blue",
        Choices{
          1="h-formulation",
          2="a-formulation (large steps)",
          3="a-formulation (small steps)",
  		    4="coupled-formulation "},
        Name "1Input/5Method/0Preset formulation" },
        expMode = {0, Choices{0,1}, Name "1Input/5Method/1Allow changes?"}];
    // Output choice
    DefineConstant[onelabInterface = {0, Choices{0,1}, Name "1Input/6Problem/2Get solution during simulation?"}]; // Set to 0 for launching in terminal (faster)
    realTimeInfo = 1;
    realTimeSolution = onelabInterface;

    // ------- PROBLEM DEFINITION -------
    // Dimension of the problem
    Dim = 3;
    // Material type of region MATERIAL, 0: air, 1: super, 2: copper, 3: soft ferro
    MaterialType = 1;
    // Axisymmetry of the problem, 0: no, 1: yes
    Axisymmetry = 0;
    // Other constants
    nonlinferro = 0;
    Flag_CTI = 1;
    Flag_MB = 0;
    Flag_rotating = Flag_MB;
    // Test name - for output files
    name = "Cuboid_Superconductors";
    // (directory name for .txt files, not .pos files)
    DefineConstant [testname = "Cuboid_model"];

    // ------- WEAK FORMULATION -------
    // Choice of the formulation
    DefineConstant [formulation = (preset==1) ? h_formulation : (preset==2 || preset==3) ? a_formulation : coupled_formulation];
    // Iterative methods. Always N-R for the coupled formulation (whatever the values below)
    DefineConstant [Flag_NR_Super = (preset==1) ? 1 : 0]; // 1: N-R, 0: Picard
    DefineConstant [Flag_NR_Ferro = 1]; // 1: N-R, 0: Picard

    // ------- Definition of the physical regions -------
    // Regions that must be properly completed (can be empty)
    DefineGroup[LinOmegaC, NonLinOmegaC, OmegaC, OmegaCC, Omega];
    DefineGroup[Cuts, BndOmegaC, BndOmegaC_side, Electrodes];
    DefineGroup[MagnLinDomain, MagnAnhyDomain, MagnHystDomain];
    DefineGroup[Gamma_e, Gamma_h, GammaAll];

    // Filling the regions
    Air = Region[AIR];
	// Air += Region[ BULK~{1}];
    DefineGroup [Super, Copper, Cond1, Cond2, Cut1, Cut2, Electrode1, Electrode2, Cond];
    DefineGroup [Ferro, FerroAnhy, FerroHyst];
    IsThereFerro = 0; // Will be updated below if necessary
    IsThereSuper = 0; // Will be updated below if necessary
    Flag_Hysteresis = 0; // Will be updated below if necessary
    Flag_LinearProblem = 1; // Will be updated below if necessary
    If(MaterialType == 0) // Define the superconducting zones, but not treated as superconductor
        Air += Region[ BULK_1 ];
        For i In {1:Num_Super}
      			DefineGroup [Cuboid_Superconductor~{i}];
      			/* Super += Region[ BULK~{i} ];
      			Cond += Region[{ BULK~{i} }]; */
      			// Copper += Region[ BULK~{i} ];
      			Cuboid_Superconductor~{i} = Region[ BULK~{i} ];
      			Surface_Cuboid_Superconductor~{i} = Region[ Boundary_BULK~{i} ];
      			Surface_Superconductors += Region[ Boundary_BULK~{i} ];
      			/* BndOmegaC += Region[ Boundary_BULK~{i} ]; */
            Layer~{i} =  Region[Air, OnOneSideOf Boundary_BULK~{i}];
            Vol_Layer += Region[Layer~{i}];
    		EndFor
        Vol_Force = Region [ Vol_Layer ];
    ElseIf(MaterialType == 1)
    		For i In {1:Num_Super}
      			DefineGroup [Cuboid_Superconductor~{i}];
      			Super += Region[ BULK~{i} ];
      			Cond += Region[{ BULK~{i} }];
      			// Copper += Region[ BULK~{i} ];
      			Cuboid_Superconductor~{i} = Region[ BULK~{i} ];
      			Surface_Cuboid_Superconductor~{i} = Region[ Boundary_BULK~{i} ];
      			Surface_Superconductors += Region[ Boundary_BULK~{i} ];
      			BndOmegaC += Region[ Boundary_BULK~{i} ];
            Layer~{i} =  Region[Air, OnOneSideOf Boundary_BULK~{i}];
            Vol_Layer += Region[Layer~{i}];
    		EndFor
        Vol_Force = Region [ Vol_Layer ];
        IsThereSuper = 1;
        Flag_LinearProblem = 0;
    ElseIf(MaterialType == 2)
    // Define the superconducting zones, but not treated as superconductor
    For i In {1:Num_Super}
  			DefineGroup [Cuboid_Superconductor~{i}];
  			/* Super += Region[ BULK~{i} ];
  			Cond += Region[{ BULK~{i} }]; */
  			// Copper += Region[ BULK~{i} ];
  			Cuboid_Superconductor~{i} = Region[ BULK~{i} ];
  			Surface_Cuboid_Superconductor~{i} = Region[ Boundary_BULK~{i} ];
  			Surface_Superconductors += Region[ Boundary_BULK~{i} ];
        Layer~{i} =  Region[Air, OnOneSideOf Boundary_BULK~{i}];
        Vol_Layer += Region[Layer~{i}];
  			/* BndOmegaC += Region[ Boundary_BULK~{i} ]; */
		EndFor
    Vol_Force = Region [ Vol_Layer ];
    Copper += Region[ BULK_1 ];
		/* Copper += Region[ MATERIAL2 ]; */
		Bulk1 += Region[ BULK_1 ];
		/* Bulk2 += Region[ MATERIAL2 ]; */
    Cond1 += Region[ BULK_1 ];
		/* Cond2 += Region[ MATERIAL2 ]; */
    BndOmegaC += Region[ Boundary_BULK_1 ];
    ElseIf(MaterialType == 3)
        FerroAnhy += Region[ MATERIAL ];
        IsThereFerro = 1;
        Flag_LinearProblem = 0;
    EndIf
    Ferro = Region[ {FerroAnhy, FerroHyst} ];
    SurfOut = Region[ SURF_OUT ];
    // ArbitraryPoint = Region[ AP ];
    // Remaining regions
    LinOmegaC = Region[ {Copper} ];
    NonLinOmegaC = Region[ {Super} ];
    OmegaC = Region[ {LinOmegaC, NonLinOmegaC} ];
    Cuts = Region[ {Cut1} ];
    Electrodes = Region[ {Electrode1} ];
    OmegaCC = Region[ {Air, Ferro} ];
    Omega = Region[ {OmegaC, OmegaCC} ];
    MagnLinDomain = Region[ {Air, Super, Copper} ];
    MagnAnhyDomain = Region[ {FerroAnhy} ];
    MagnHystDomain = Region[ {FerroHyst} ];
    Gamma_h = Region[{SurfOut}];
    Gamma_e = Region[{}];

    GammaAll = Region[ {Gamma_h, Gamma_e} ];
    OmegaGamma = Region[ {Omega, GammaAll} ];
}


Function{
    // ------- Constants -------
    MatRot[] = Tensor[1,0,0,0,Cos[$1],-Sin[$1],0,Sin[$1],Cos[$1]];
    mu0 = 4*Pi*1e-7; // [H/m]
    nu0 = 1.0/mu0; // [m/H]
    // ------- PARAMETERS -------
    // Superconductor parameters
    DefineConstant [ec = 1e-4]; // Critical electric field [V/m]
    If(Modelled_Samples==1)
        jc_Base_1 = 2.2977*1.2051*0.9438*1e8;
        jc_Base_2 = 2.2977*1.2051*0.9438*1e8;
    ElseIf(Modelled_Samples == 3)
        jc_Base_1 = 1.5312*1.0833*1.05*1e8;
        jc_Base_2 = (1.5312*1.0833*1.05)*1e8;
    ElseIf(Modelled_Samples == 4)
        jc_Base_1 = 2*1e8;
        jc_Base_2 = 2*1e8;
    EndIf
    n_Base_1 = 20;
    n_Base_2 = 20;
  	For i In {1:Num_Super} // Full real Bulk: 2.2977 Stacked Tapes : 1.5312*1.0833*1.05*1e8 (Adjusted after Bobine Zoubir) Qualitative Bulk(2.2977*1.2051*0.9438*1e8) ||| Cutted Sample: 3.1786*1e8
    		DefineConstant[ jc~{i} = {jc_Base~{i}, Highlight "LightGreen", Name Sprintf("1Input/3Material Properties/2jc Sample%g (Am⁻²)",i), Visible 1}]; // Critical current density [A/m2]
    		DefineConstant [n~{i} = {n_Base~{i}, Highlight "LightGreen", Name Sprintf("1Input/3Material Properties/1n Sample%g(-)",i)}];	// Superconductor exponent (n) value [-]
    		jc[Cuboid_Superconductor~{i}] = jc~{i};
    		n[Cuboid_Superconductor~{i}] = n~{i};

        // Kim's model for B dependance : Jc(B) = Jc0/(1+(||B||/B0)); n(B) = n1 + (n0-n1)/(1+(||B||/B0))
        // Kim's extended : Jc(B) = Jc0/(1+(||B||/B0)) + Jc0*aFE/((1+||B||/B1FE)^2 - B2FE^2)
    		DefineConstant[ jc0~{i} = {4.5061*1e8, Highlight "LightGreen", Name Sprintf("1Input/3Material Properties/5jc Sample%g (Am⁻²) (Kim's model)",i), Visible Flag_JcB}]; // Critical current density [A/m2] QUALITATIVE BULKS : 2.2977*1e8, STACK TAPES : 1.3037*1e8
    		DefineConstant [n0~{i} = {20, Highlight "LightGreen", Name Sprintf("1Input/3Material Properties/6n0 Sample%g(-) (Kim's model)",i), Visible Flag_JcB}];
    		DefineConstant [n1~{i} = {20, Highlight "LightGreen", Name Sprintf("1Input/3Material Properties/7n1 Sample%g(-) (Kim's model)",i), Visible Flag_JcB}];
    		DefineConstant [B0~{i} = {0.5, Highlight "LightGreen", Name Sprintf("1Input/3Material Properties/8B0 Sample%g(-) (Kim's model)",i), Visible Flag_JcB}];
        DefineConstant [aFE~{i} = {1000, Highlight "LightGreen", Name Sprintf("1Input/3Material Properties/8aFE Sample%g(-) (Kim's model FE)",i), Visible Flag_JcB}];
        DefineConstant [B1FE~{i} = {25, Highlight "LightGreen", Name Sprintf("1Input/3Material Properties/8B1 Sample%g(-) (Kim's model FE)",i), Visible Flag_JcB}];
        DefineConstant [B2FE~{i} = {25, Highlight "LightGreen", Name Sprintf("1Input/3Material Properties/8BFE Sample%g(-) (Kim's model FE)",i), Visible Flag_JcB}];

        jc0[Cuboid_Superconductor~{i}] = jc0~{i};
    		n0[Cuboid_Superconductor~{i}] = n0~{i};
    		n1[Cuboid_Superconductor~{i}] = n1~{i};
    		B0[Cuboid_Superconductor~{i}] = B0~{i};
        aFE[Cuboid_Superconductor~{i}] = aFE~{i};
        B1FE[Cuboid_Superconductor~{i}] = B1FE~{i};
        B2FE[Cuboid_Superconductor~{i}] = B2FE~{i};
  	EndFor

	// Anisotropy
  	If(Num_Super == 1)
      	DefineConstant[ C_Axis_1 = {3, Highlight "LightGreen", Choices{
      				1="1 : x",
      				2="2 : y",  // Central sample
      				3="3 : z"}, // Peripheral sample
      			  Name Sprintf("1Input/3Material Properties/3C-axis Sample1 Number"), Visible 1}];
  	Else
    		C_Axis_Base_1 = 3;
    		C_Axis_Base_2 = 3;
    		For i In {1:Num_Super}
      			DefineConstant[ C_Axis~{i} = {C_Axis_Base~{i}, Highlight "LightGreen", Choices{
      				1="1 : x",
      				2="2 : y",
      				3="3 : z",
      				0="No Anisotropy"},
      			  Name Sprintf("1Input/3Material Properties/3C-axis Sample%g Number", i), Visible 1}];
    		EndFor
  	EndIf

  	// Note: Rhosup qui fonctionne : 0.00000001
  	DefineConstant [ RhoSupCaxis = {0.0000000, Highlight "LightGreen", Name "1Input/3Material Properties/9999Artificial supplementary resistivity along c-axis (used in h formulation)"}];
  	DefineConstant[ Anisotropy_Factor = {1, Highlight "LightGreen",
  			Name Sprintf("1Input/3Material Properties/4Anisostropy Factor(used in a formulation)"), Visible 1}];

  	For i In {1:Num_Super}
    		If(C_Axis~{i}==1)
      			SQRTAN[Cuboid_Superconductor~{i}] = TensorDiag[Sqrt[Anisotropy_Factor^n[]], 1, 1]; 		// For h-formulation
      			AddRho[Cuboid_Superconductor~{i}] =  MatRot[MyTheta~{i}]*TensorDiag[RhoSupCaxis, 0, 0]; 					   	// For h-formulation
      			Anys_Matrix[Cuboid_Superconductor~{i}] = TensorDiag[1/Anisotropy_Factor, 1, 1];	   		// For a-formulation
    		ElseIf(C_Axis~{i}==2)
      			SQRTAN[Cuboid_Superconductor~{i}] = TensorDiag[1, Sqrt[Anisotropy_Factor^n[]], 1]; 		// For h-formulation
      			AddRho[Cuboid_Superconductor~{i}] =  MatRot[MyTheta~{i}]*TensorDiag[0, RhoSupCaxis, 0]; 					   	// For h-formulation
      			Anys_Matrix[Cuboid_Superconductor~{i}] = TensorDiag[1,1/Anisotropy_Factor, 1];	   		// For a-formulation
    		ElseIf(C_Axis~{i}==3)
      			SQRTAN[Cuboid_Superconductor~{i}] = TensorDiag[1, 1, Sqrt[Anisotropy_Factor^n[]]]; 		// For h-formulation
      			AddRho[Cuboid_Superconductor~{i}] = MatRot[MyTheta~{i}]*TensorDiag[0, 0, RhoSupCaxis]; 					   	// For h-formulation
      			Anys_Matrix[Cuboid_Superconductor~{i}] = TensorDiag[1, 1, 1/Anisotropy_Factor];	   		// For a-formulation
    		Else
      			SQRTAN[Cuboid_Superconductor~{i}] = TensorDiag[1, 1, 1]; 								// For h-formulation
      			AddRho[Cuboid_Superconductor~{i}] = TensorDiag[0, 0, 0]; 					   			// For h-formulation
      			Anys_Matrix[Cuboid_Superconductor~{i}] = TensorDiag[1, 1, 1];	  						// For a-formulation
    		EndIf
  	EndFor

	 // For numerical method
    DefineConstant [epsSigma = 1e-8]; // Importance of the linear part for a-formulation [-]
    DefineConstant [epsSigma2 = 1e-15]; // To prevent division by 0 in sigma [-]

    // Ferromagnetic material parameters
    DefineConstant [mur0 = 1700.0]; // Relative permeability at low fields [-]
    DefineConstant [m0 = 1.04e6]; // Magnetic field at saturation [A/m]
    DefineConstant [mur = 1000.0]; // Relative permeability for linear material [-]
    DefineConstant [epsMu = 1e-15]; // To prevent division by 0 in mu [A/m]
    DefineConstant [epsNu = 1e-10]; // To prevent division by 0 in nu [T]

    // ------- Constants -------
  	If(Active_approach==0)
    		DefineConstant [Flag_Source = {6, Highlight "yellow", Choices{
    			1="Ramp up and down",
    			2="Ramp up, down and flux creep",
    			3="No source => For modelling motion",
          4="Constant background field",
          5="Ramp Down",
          6="Rotating field"}, Name "1Input/4Source/0Source field type" }];
  	Else
    		DefineConstant [Flag_Source = {4, Visible 0, Highlight "yellow", Choices{
          1="Ramp up and down",
    			2="Ramp up, down and flux creep",
    			3="No source => For modelling motion",
          4="Constant background field",
          5="Ramp Down",
          6="Rotating field"}, Name "1Input/4Source/0Source field type" }];
  	EndIf
}
Include "../lib/SourceDefinition.pro";
Function{
    DefineConstant [f = {0.1, Visible (Flag_Source ==0), Name "1Input/4Source/1Frequency (Hz)"}]; // Frequency of imposed current intensity [Hz]
    DefineConstant [bmax = {1, Visible (Active_approach==0 || Active_approach==2) , Name "Input/4Source/2Field amplitude (T)"}]; // Maximum applied magnetic induction [T]
    DefineConstant [partLength = {5, Visible (Flag_Source != 0 && (Active_approach==0 || Active_approach==2)), Name "Input/4Source/1Ramp duration (s)"}];
    DefineConstant [timeFinal = {(Flag_Source == 1) ? ((2*bmax_m)-bmin_m)/rate : ((Flag_Source == 2)||(Flag_Source == 7)) ? ((((2*bmax_m)-bmin_m)/rate)+ RotationPeriod + MagRelaxPeriod+MagRelaxPeriod2) : (Flag_Source == 3) ? 2700 : (Active_approach == 2) ? 2700 : (Flag_Source == 5) ? (ConstantlvlDurantion + ((bmax_m-bmin_m)/rate)) : (Flag_Source == 6) ? (ThetaMax/Rotation_Speed) :3*partLength, Highlight "LightBlue", Name "1Input/5Method/Final Time"}]; // Final time for source definition [s]
    DefineConstant [timeFinalSimu = timeFinal]; // Final time of simulation [s]
    DefineConstant [stepTime = 0.01]; // Initiation of the step [s]
    DefineConstant [stepSharpness = 0.001]; // Duration of the step [s]
      // ------- NUMERICAL PARAMETERS -------
  	If(Active_approach == 0)
    		DefineConstant [dt = { (preset==1 || preset == 3) ? timeFinal/15 : (Flag_Source == 6) ? Time_step_amplitude:25, Highlight "LightBlue",
    			ReadOnly !expMode, Name "1Input/5Method/Time step (s)"}]; // Time step (initial if adaptive)[s]
  	Else
    		DefineConstant [dt = {Time_step_amplitude, Highlight "LightBlue",
    			ReadOnly !expMode, Name "1Input/5Method/Time step (s)"}]; // Time step (initial if adaptive)[s]
  	EndIf
    DefineConstant [adaptive = 1]; // Allow adaptive time step increase (case 0 not implemented yet)
    DefineConstant [dt_max = dt]; // Maximum allowed time step [s]
    DefineConstant [iter_max = {(Flag_NR_Super==1) ? 30 : 600, Highlight "LightBlue",
        ReadOnly !expMode, Name "1Input/5Method/Max number of iteration (-)"}]; // Maximum number of nonlinear iterations
    DefineConstant [extrapolationOrder = (preset==1) ? 1 : 2]; // Extrapolation order
      // Use relaxation factors?
    tryrelaxationfactors = 0;
      // Convergence criterion
      // 0: energy estimate
      // 1: absolute/relative residual (do not use)
      // 2: relative increment (do not use either)
    DefineConstant [convergenceCriterion = 0];
    DefineConstant [tol_energy = {(preset == 1) ? 1e-6 : 1e-4, Highlight "LightBlue",
        ReadOnly !expMode, Name "1Input/5Method/Relative tolerance (-)"}]; // Relative tolerance on the energy estimates
    DefineConstant [tol_abs = 1e-12]; //Absolute tolerance on nonlinear residual
    DefineConstant [tol_rel = 1e-6]; // Relative tolerance on nonlinear residual
    DefineConstant [tol_incr = 5e-3]; // Relative tolerance on the solution increment
    multFix = 1e0;
      // Output information
    DefineConstant [economPos = 0]; // 0: Saves all fields. 1: Does not save fields (.pos)
    DefineConstant [economInfo = 1]; // 0: Saves all iteration/residual info. 1: Does not save them
    // Parameters
    DefineConstant [saveAll = 0];  // Save all the iterations? (pay attention to memory! heavy files)
    DefineConstant [writeInterval = (Flag_Source == 6)? 20 : 200]; // Time interval between two successive output file saves [s]
    DefineConstant [saveAllSteps = 0];
    DefineConstant [saveAllStepsSeparately = 1];
    DefineConstant [savedPoints = 2000]; // Resolution of the line saving postprocessing

    // Control points
    controlPoint1 = {1e-5,0, 0}; // CP1
    controlPoint2 = {ax~{Sample_1}/2-1e-5, 0, 0}; // CP2
    controlPoint3 = {0, ay~{Sample_1}/2+2e-3, 0}; // CP3
    controlPoint4 = {ax~{Sample_1}/2, ay~{Sample_1}/2+2e-3, 0}; // CP4

  	// Hall sensor position
  	Hall_sensor3 = {1e-5, 0 ,az~{Sample_1}/2 + 0.0005};
  	Hall_sensor5 = {0.01, 0 ,az~{Sample_1}/2 + 0.0005};

    DefineFunction [I, js, hsVal];

   // ------- PROJECTION PARAMETERS -------
  	Str_Directory_Code = "C:\Users\Administrator\Desktop\Michel\WP1\Test_Moving_Super\RotatingSuperconductors";
    Velocity[] = Vector[0,0,0];

    For i In {1:Num_Super}
        CentreSuperconductor~{i}[] = Vector[CentreXSuperconductor~{i},CentreYSuperconductor~{i},CentreZSuperconductor~{i}];
    EndFor

  	If(Time_step==1) // First step
  		  // For projection
  			//************ Initial condition File Depending on the considered modelled samples ****************//
        /* DefineConstant [initialConditionFile_a1 = StrCat[Str_Directory_Code,"\IniCond_coupled_formulation\Bulk6mm\FC_JinBulk\2Bulks_45minFC\24elem\a_2_7max_03min.pos"]];	// Central
        DefineConstant [initialConditionFile_h1 = StrCat[Str_Directory_Code,"\IniCond_coupled_formulation\Bulk6mm\FC_JinBulk\2Bulks_45minFC\24elem\h_2_7max_03min.pos"]];	// Central */

        DefineConstant [initialConditionFile_a1 = StrCat["D:\Michel\CuboidSuperConductorsWP1\Rotating\BatchRotation\NotMagIniCond\Batch77KFrom0mTTo500mT\Background",Str_Background,"\Last_computed_a.pos"]];	// Central
        DefineConstant [initialConditionFile_h1 = StrCat["D:\Michel\CuboidSuperConductorsWP1\Rotating\BatchRotation\NotMagIniCond\Batch77KFrom0mTTo500mT\Background",Str_Background,"\Last_computed_h.pos"]];	// Central
  			// Read a from File
  			GmshRead[ initialConditionFile_a1,1];

  			// Read h from file
  			GmshRead[ initialConditionFile_h1,4];

        // Rotate back to go to the right coordinate in the file at previous step, but the field rotate forward
        If(FlagFCNoCurrent == 1)
            a_fromFile[Surface_Cuboid_Superconductor_1] = VectorField[MatRot[-dTheta_1]*(XYZ[]-CentreSuperconductor_1[])]{1};
            h_fromFile[Cuboid_Superconductor_1] = MatRot[dTheta_1]*Vector[0,0,bmin_m/mu0];
        ElseIf(FlagFCNoCurrent == 2)
            a_fromFile[Surface_Cuboid_Superconductor_1] = VectorField[(XYZ[])]{1};
            h_fromFile[Cuboid_Superconductor_1] = Vector[0,0,bmin_m/mu0];
        Else
            For i In {1:Num_Super}
                a_fromFile[Surface_Cuboid_Superconductor~{i}] = MatRot[dTheta~{i}]*VectorField[MatRot[-dTheta~{i}]*(XYZ[]-CentreSuperconductor~{i}[])+CentreSuperconductor~{i}[]]{1};
                h_fromFile[Cuboid_Superconductor~{i}] = MatRot[dTheta~{i}]*VectorField[MatRot[-dTheta~{i}]*(XYZ[]-CentreSuperconductor~{i}[])+CentreSuperconductor~{i}[]]{4};
            EndFor
        EndIf
  	Else	// All other steps
          //************ Initial condition File Depending on the considered modelled samples ****************//
        DefineConstant [initialConditionFile_a1 = StrCat[Str_Directory_Code,"\Last_computed_a.pos"]];	// Central
        DefineConstant [initialConditionFile_h1 = StrCat[Str_Directory_Code,"\Last_computed_h.pos"]];	// Central

        // Read a from File
  			GmshRead[ initialConditionFile_a1,1];

  			// Read h from file
  			GmshRead[ initialConditionFile_h1,4];

        For i In {1:Num_Super}
            // Rotate back to go to the right coordinate in the file at previous step, but the field rotate forward
            a_fromFile[Surface_Cuboid_Superconductor~{i}] = MatRot[dTheta~{i}]*VectorField[MatRot[-dTheta~{i}]*(XYZ[]-CentreSuperconductor~{i}[])+CentreSuperconductor~{i}[]]{1};
      			h_fromFile[Cuboid_Superconductor~{i}] = MatRot[dTheta~{i}]*VectorField[MatRot[-dTheta~{i}]*(XYZ[]-CentreSuperconductor~{i}[])+CentreSuperconductor~{i}[]]{4};
        EndFor
    EndIf
}

// Only external field is implemented
Constraint {
    { Name a ;
        Case {
			If(Active_approach == 1 && Flag_Source == 3)
				{Region SurfOut ; Value 0; } // Comp normal de B à 0 (je crois)
			EndIf
			If(((formulation == a_formulation)&& (Active_approach==1|| Active_approach == 2)))
				{ Region Omega ; Type InitFromResolution ; NameOfResolution ProjectionInit ; }
			EndIf
        }
    }
    { Name phi ;
        Case {
            {Region SurfOut ; Value XYZ[]*directionApplied[] ; TimeFunction hsVal[] ;}
			If((Active_approach==1|| Active_approach == 2) || Flag_Test_projection == 1)
				 /* { Region Omega ; Type InitFromResolution ; NameOfResolution ProjectionInit ; } */
			EndIf
        }
    }
    { Name h ;
        Case {
			If((Active_approach==1|| Active_approach == 2) || Flag_Test_projection == 1)
					 /* { Region Omega ; Type InitFromResolution ; NameOfResolution ProjectionInit ; } */
			EndIf
        }
    }
    { Name Current ;
        Case {
        }
    }
    { Name Voltage ;
        Case {
            If(formulation == h_formulation || formulation == coupled_formulation)
                // No cut in this geometry
            Else
                // a-formulation and BF_RegionZ
                // { Region Cond; Value 0.0; }
				// { Region Cond2; Value 0.0; }
            EndIf
        }
    }
}

Include "../lib/formulations.pro";
Include "../lib/resolution.pro";
ExtGmsh     = ".pos" ;
Str_step = Sprintf("%g", (((Cycle-1)*Time_step_per_cycle)+Time_step));


PostOperation {
    { Name MagDyn; LastTimeStepOnly realTimeSolution ;
        If(formulation == h_formulation)
            NameOfPostProcessing MagDyn_htot;
        ElseIf(formulation == a_formulation)
            NameOfPostProcessing MagDyn_avtot;
        ElseIf(formulation == coupled_formulation)
            NameOfPostProcessing MagDyn_coupled;
        EndIf
        Operation {
            If(economPos == 0)
      				  If(formulation == coupled_formulation)
          					Print[ h, OnElementsOf Omega_h, File StrCat["Last_computed_h", ExtGmsh], Format Gmsh,
          					OverrideTimeStepValue 0, LastTimeStepOnly, SendToServer "No"] ;
          					Print[ a, OnElementsOf Omega_a, File StrCat["Last_computed_a", ExtGmsh],Format Gmsh,
          					OverrideTimeStepValue 0, LastTimeStepOnly, SendToServer "No"] ;
                    Print[ b, OnElementsOf Omega , File StrCat[Str_SaveDir,"b_",Str_step,".pos"], Format Gmsh, OverrideTimeStepValue Time_step, LastTimeStepOnly];
                    Print[ j, OnElementsOf Omega, File StrCat[Str_SaveDir,"j_wholedomain",Str_step,".pos"], Format Gmsh, OverrideTimeStepValue Time_step, LastTimeStepOnly];
                    Print[ b, OnElementsOf Omega , File StrCat[Str_SaveDir,"b_",Str_step,"allstep.pos"]];
                    Print[ j, OnElementsOf Omega, File StrCat[Str_SaveDir,"j_wholedomain",Str_step,"allstep.pos"]];
                    p1 = {0,0,-0.025};
                    p2 = {0,0,0.025};
                    Print[ b,  OnLine{{List[p1]}{List[p2]}} {601}, Format Table , File StrCat[Str_SaveDir,"BLineCentre",".txt"], TimeValue 1000]; // Half rotation hard coded
                    Print[ b,  OnLine{{List[p1]}{List[p2]}} {601}, Format Table , File StrCat[Str_SaveDir,"BLineCentre_Step",".txt"], TimeStep 100];
                    // Magnetic moment and force of each sample
                    For i In {1:Num_Super}
                        Str_Sample = Sprintf("%g", i);
                        Print[ mSample~{i}, OnRegion Cuboid_Superconductor~{i}, Format Table , File StrCat[Str_SaveDir,"m_Step",Str_step,"_Sample",Str_Sample,".txt"]];
                        Print[ f~{i}[Air], OnGlobal, Format Table, File StrCat[Str_SaveDir,"F_Step",Str_step,"_OnSample",Str_Sample,".txt"]  ];
                        Print[ t~{i}[Air], OnGlobal, Format Table, File StrCat[Str_SaveDir,"T_Step",Str_step,"_OnSample",Str_Sample,".txt"]  ];
                    EndFor
                    If(Active_approach==1)
                        Print[ a, OnElementsOf Omega_a, File StrCat[Str_SaveDir,"Save_afield_",Str_step,".pos"],Format Gmsh, OverrideTimeStepValue 0, LastTimeStepOnly, SendToServer "No"] ;
              					Print[ h, OnElementsOf Omega_h, File StrCat[Str_SaveDir,"Save_hfield_",Str_step,".pos"],Format Gmsh, OverrideTimeStepValue 0, LastTimeStepOnly, SendToServer "No"] ;
                    EndIf
                EndIf
      					Print[ j, OnElementsOf OmegaC , File "res/j.pos", Name "j [A/m2]" ];
      					Print[ e, OnElementsOf OmegaC , File "res/e.pos", Name "e [V/m]" ];
      					Print[ b, OnElementsOf Omega , File "res/b.pos", Name "b [T]" ];
                If(formulation == coupled_formulation)
      					     Print[ a, OnElementsOf Omega_a , File "res/a.pos", Name "a" ];
                EndIf
            EndIf
        }
    }
}

PostOperation {
    { Name ExportSingleStep; LastTimeStepOnly realTimeSolution ;
      If(formulation == coupled_formulation)
          NameOfPostProcessing MagDyn_coupled;
      EndIf
      Operation {
          Print[ j, OnElementsOf Omega, File StrCat[Str_SaveDir,"j_wholedomain",Str_step,"allstep.pos"]];
          p1 = {0,0,-0.025};
          p2 = {0,0,0.025};
          Print[ b,  OnLine{{List[p1]}{List[p2]}} {601}, Format TimeTable , File StrCat[Str_SaveDir,"BLineCentre",".txt"], TimeStep 10];
      }
    }
  }

DefineConstant[
  R_ = {"MagDyn", Name "GetDP/1ResolutionChoices", Visible 0},
  C_ = {"-solve -pos -bin -v 3 -v2", Name "GetDP/9ComputeCommand", Visible 0},
  P_ = { "MagDyn", Name "GetDP/2PostOperationChoices", Visible 0}
];
