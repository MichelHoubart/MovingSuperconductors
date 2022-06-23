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
      Name "Input/5Method/0Preset formulation" },
      expMode = {0, Choices{0,1}, Name "Input/5Method/1Allow changes?"}];
    // Output choice
    DefineConstant[onelabInterface = {0, Choices{0,1}, Name "Input/3Problem/2Get solution during simulation?"}]; // Set to 0 for launching in terminal (faster)
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
    Flag_CTI = 0;
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
    If(MaterialType == 0)
        Air += Region[ MATERIAL ];
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
		EndFor
        IsThereSuper = 1;
        Flag_LinearProblem = 0;
    ElseIf(MaterialType == 2)
        Copper += Region[ MATERIAL1 ];
		Copper += Region[ MATERIAL2 ];
		Bulk1 += Region[ MATERIAL1 ];
		Bulk2 += Region[ MATERIAL2 ];
        Cond1 += Region[ MATERIAL1 ];
		Cond2 += Region[ MATERIAL2 ];
        BndOmegaC += Region[ BND_MATERIAL ];
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
    MatRot[] = Tensor[1,0,0,0,Cos[$1],-Sin[$1],0,Sin[$1],Cos[$1]];
    // ------- PARAMETERS -------
    // Superconductor parameters
    DefineConstant [ec = 1e-4]; // Critical electric field [V/m]
	For i In {1:Num_Super} // Full real Bulk: 2.2977 Stacked Tapes : 1.5312*1.0833*1.05*1e8 (Adjusted after Bobine Zoubir) Qualitative Bulk(2.2977*1.2051*0.9438*1e8) ||| Cutted Sample: 3.1786*1e8
		If(Modelled_Samples==1)
			jc_Base_1 = 2.2977*1.2051*0.9438*1e8;
			jc_Base_2 = 2.2977*1.2051*0.9438*1e8;
			jc_Base_3 = 2.2977*1.2051*0.9438*1e8;
			jc_Base_4 = 2.2977*1.2051*0.9438*1e8;
			jc_Base_5 = 2.2977*1.2051 *0.9438*1e8;
			jc_Base_6 = 3.1786*1e8;
		ElseIf(Modelled_Samples == 3)
			jc_Base_1 = 1.5312*1.0833*1.05*1e8;
			jc_Base_2 = (1.5312*1.0833*1.05)*1e8;
			jc_Base_3 = 1.5312*1.0833*1.05*1e8;
			jc_Base_4 = 3.1786*1e8;
			jc_Base_5 = 2.2977*1e8;
			jc_Base_6 = 3.1786*1e8;
		EndIf
		n_Base_1 = 20;
		n_Base_2 = 20;
		n_Base_3 = 20;
		n_Base_4 = 20;
		n_Base_5 = 20;
		n_Base_6 = 20;
		DefineConstant[ jc~{i} = {jc_Base~{i}, Name Sprintf("Input/3Material Properties/2jc Sample%g (Am⁻²)",i), Visible 1}]; // Critical current density [A/m2]
		DefineConstant [n~{i} = {n_Base~{i}, Name Sprintf("Input/3Material Properties/1n Sample%g(-)",i)}];	// Superconductor exponent (n) value [-]
		jc[Cuboid_Superconductor~{i}] = jc~{i};
		n[Cuboid_Superconductor~{i}] = n~{i};

		// Kim's model for anisotropy : Jc(B) = Jc0/(1+(||B||/B0)); n(B) = n1 + (n0-n1)/(1+(||B||/B0)) ---> Adjust the parameters!
		DefineConstant[ jc0~{i} = {4.5061*1e8, Name Sprintf("Input/3Material Properties/5jc Sample%g (Am⁻²) (Kim's model)",i), Visible 1}]; // Critical current density [A/m2] QUALITATIVE BULKS : 2.2977*1e8, STACK TAPES : 1.3037*1e8
		DefineConstant [n0~{i} = {20, Name Sprintf("Input/3Material Properties/6n0 Sample%g(-) (Kim's model)",i)}];
		DefineConstant [n1~{i} = {20, Name Sprintf("Input/3Material Properties/7n1 Sample%g(-) (Kim's model)",i)}];
		DefineConstant [B0~{i} = {0.5, Name Sprintf("Input/3Material Properties/8B0 Sample%g(-) (Kim's model)",i)}];
		jc0[Cuboid_Superconductor~{i}] = jc0~{i};
		n0[Cuboid_Superconductor~{i}] = n0~{i};
		n1[Cuboid_Superconductor~{i}] = n1~{i};
		B0[Cuboid_Superconductor~{i}] = B0~{i};
	EndFor

	// Parameters for anisotropy
	If(Num_Super == 1)
	DefineConstant[ C_Axis_1 = {3, Choices{
				1="1 : x",
				2="2 : y",  // Central sample
				3="3 : z"}, // Peripheral sample
			Name Sprintf("Input/3Material Properties/3C-axis Sample1 Number"), Visible 1}];
	ElseIf(Num_Super == 2)
		C_Axis_Base_1 = 2;
		C_Axis_Base_2 = 0;
		For i In {1:Num_Super}
			DefineConstant[ C_Axis~{i} = {C_Axis_Base~{i}, Choices{
				1="1 : x",
				2="2 : y",
				3="3 : z",
				0="No Anisotropy"},
			Name Sprintf("Input/3Material Properties/3C-axis Sample%g Number", i), Visible 1}];
		EndFor
	Else
		C_Axis_Base_1 = 3;
		C_Axis_Base_2 = 2;
		C_Axis_Base_3 = 3;
		C_Axis_Base_4 = 0;
		C_Axis_Base_5 = 2;
		C_Axis_Base_6 = 2;
		For i In {1:Num_Super}
			DefineConstant[ C_Axis~{i} = {C_Axis_Base~{i}, Choices{
				1="1 : x",
				2="2 : y",
				3="3 : z"},
			Name Sprintf("Input/3Material Properties/3C-axis Sample%g Number", i), Visible 1}];
		EndFor
	EndIf
	// Rhosup qui fonctionne : 0.00000001
	DefineConstant [RhoSupCaxis = {0.0000000, Name "Input/3Material Properties/9999Artificial supplementary resistivity along c-axis"}];
	DefineConstant[ Anisotropy_Factor = {1,
			Name Sprintf("Input/3Material Properties/4Anisostropy Factor"), Visible 1}];

	For i In {1:Num_Super}
		If(C_Axis~{i}==1)
			SQRTAN[Cuboid_Superconductor~{i}] = TensorDiag[Sqrt[Anisotropy_Factor^n[]], 1, 1]; 		// For h-formulation
			AddRho[Cuboid_Superconductor~{i}] =  MatRot[MyTheta]*TensorDiag[RhoSupCaxis, 0, 0]; 					   	// For h-formulation
			Anys_Matrix[Cuboid_Superconductor~{i}] = TensorDiag[1/Anisotropy_Factor, 1, 1];	   		// For a-formulation
		ElseIf(C_Axis~{i}==2)
			SQRTAN[Cuboid_Superconductor~{i}] = TensorDiag[1, Sqrt[Anisotropy_Factor^n[]], 1]; 		// For h-formulation
			AddRho[Cuboid_Superconductor~{i}] =  MatRot[MyTheta]*TensorDiag[0, RhoSupCaxis, 0]; 					   	// For h-formulation
			Anys_Matrix[Cuboid_Superconductor~{i}] = TensorDiag[1,1/Anisotropy_Factor, 1];	   		// For a-formulation
		ElseIf(C_Axis~{i}==3)
			SQRTAN[Cuboid_Superconductor~{i}] = TensorDiag[1, 1, Sqrt[Anisotropy_Factor^n[]]]; 		// For h-formulation
			AddRho[Cuboid_Superconductor~{i}] = MatRot[MyTheta]*TensorDiag[0, 0, RhoSupCaxis]; 					   	// For h-formulation
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

    // Excitation - Source field or imposed current intensty
    // 0: sine, 1: triangle, 2: up-down-pause TFE , 3: step, 4: up-pause-down
	If(Active_approach==0)
		DefineConstant [Flag_Source = {2, Highlight "yellow", Choices{
			1="Field Cooled (with current in Super)",
			2="Magnetisation TFE",
			3="No source => For modelling motion"}, Name "Input/4Source/0Source field type" }];
	Else
		DefineConstant [Flag_Source = {3, Visible 0, Highlight "yellow", Choices{
			1="Field Cooled (with current in Super)",
			2="Magnetisation TFE",
			3="No source => For modelling motion"}, Name "Input/4Source/0Source field type" }];
	EndIf
    DefineConstant [f = {0.1, Visible (Flag_Source ==0), Name "Input/4Source/1Frequency (Hz)"}]; // Frequency of imposed current intensity [Hz]
    DefineConstant [bmax = {1, Visible (Active_approach==0 || Active_approach==2) , Name "Input/4Source/2Field amplitude (T)"}]; // Maximum applied magnetic induction [T]
    DefineConstant [partLength = {5, Visible (Flag_Source != 0 && (Active_approach==0 || Active_approach==2)), Name "Input/4Source/1Ramp duration (s)"}];
    DefineConstant [timeStart = 0]; // Initial time [s]
    DefineConstant [timeFinal = (Flag_Source == 1) ? 6000 : (Flag_Source == 2) ? 7500 : (Flag_Source == 3) ? 2700 : (Active_approach == 2) ? 2700 : 3*partLength]; // Final time for source definition [s]
    DefineConstant [timeFinalSimu = timeFinal]; // Final time of simulation [s]
    DefineConstant [stepTime = 0.01]; // Initiation of the step [s]
    DefineConstant [stepSharpness = 0.001]; // Duration of the step [s]

    // ------- NUMERICAL PARAMETERS -------
	If(Active_approach == 0)
		DefineConstant [dt = { (preset==1 || preset == 3) ? timeFinal/15 : timeFinal/15, Highlight "LightBlue",
			ReadOnly !expMode, Name "Input/5Method/Time step (s)"}]; // Time step (initial if adaptive)[s]
	Else
		DefineConstant [dt = {Time_step_amplitude, Highlight "LightBlue",
			ReadOnly !expMode, Name "Input/5Method/Time step (s)"}]; // Time step (initial if adaptive)[s]
	EndIf
    DefineConstant [adaptive = 1]; // Allow adaptive time step increase (case 0 not implemented yet)
    DefineConstant [dt_max = dt]; // Maximum allowed time step [s]
    DefineConstant [iter_max = {(Flag_NR_Super==1) ? 30 : 600, Highlight "LightBlue",
        ReadOnly !expMode, Name "Input/5Method/Max number of iteration (-)"}]; // Maximum number of nonlinear iterations
    DefineConstant [extrapolationOrder = (preset==1) ? 1 : 2]; // Extrapolation order
    // Use relaxation factors?
    tryrelaxationfactors = 0;
    // Convergence criterion
    // 0: energy estimate
    // 1: absolute/relative residual (do not use)
    // 2: relative increment (do not use either)
    DefineConstant [convergenceCriterion = 0];
    DefineConstant [tol_energy = {(preset == 1) ? 1e-6 : 1e-4, Highlight "LightBlue",
        ReadOnly !expMode, Name "Input/5Method/Relative tolerance (-)"}]; // Relative tolerance on the energy estimates
    DefineConstant [tol_abs = 1e-12]; //Absolute tolerance on nonlinear residual
    DefineConstant [tol_rel = 1e-6]; // Relative tolerance on nonlinear residual
    DefineConstant [tol_incr = 5e-3]; // Relative tolerance on the solution increment
    multFix = 1e0;
    // Output information
    DefineConstant [economPos = 0]; // 0: Saves all fields. 1: Does not save fields (.pos)
    DefineConstant [economInfo = 0]; // 0: Saves all iteration/residual info. 1: Does not save them
    // Parameters
    DefineConstant [saveAll = 0];  // Save all the iterations? (pay attention to memory! heavy files)
    DefineConstant [writeInterval = dt]; // Time interval between two successive output file saves [s]
    DefineConstant [saveAllSteps = 0];
    DefineConstant [saveAllStepsSeparately = 0];
    DefineConstant [savedPoints = 2000]; // Resolution of the line saving postprocessing

    // Control points
    controlPoint1 = {1e-5,0, 0}; // CP1
    controlPoint2 = {ax~{Sample_1}/2-1e-5, 0, 0}; // CP2
    controlPoint3 = {0, ay~{Sample_1}/2+2e-3, 0}; // CP3
    controlPoint4 = {ax~{Sample_1}/2, ay~{Sample_1}/2+2e-3, 0}; // CP4

	// Hall sensor position
	Hall_sensor3 = {1e-5, 0 ,az~{Sample_1}/2 + 0.0005};
	Hall_sensor5 = {0.01, 0 ,az~{Sample_1}/2 + 0.0005};

    // Direction of applied field
    directionApplied[] = Vector[0., 0., 1.]; // y --> central ech, z --> peripheral ech
	// directionApplied[] = Vector[0., 1/Sqrt[2], 1/Sqrt[2]];// Test
    DefineFunction [I, js, hsVal];
    mu0 = 4*Pi*1e-7; // [H/m]
    nu0 = 1.0/mu0; // [m/H]
    hmax = bmax / mu0;
    If(Flag_Source == 1)
        // Modelling a Field cooled (but with current inside the superconductor)
        controlTimeInstants = {3600, 6000};
        bmax_m = 3.6;
    		rate = bmax_m/3600;
    		qttMax = bmax_m / mu0;
            hsVal[] =  (($Time * rate  <= bmax_m) ? ($Time * rate)/mu0 :
                        ($Time * rate  > bmax_m) ?
                        qttMax - (($Time - 3600) * rate)/mu0);
            hsVal_prev[] = ((($Time-$DTime) * rate  <= bmax_m) ? (($Time-$DTime) * rate)/mu0 :
                        (($Time-$DTime) * rate  > bmax_m?
                        qttMax - ((($Time-$DTime) - 3600) * rate)/mu0 );
	ElseIf(Flag_Source == 2)
		// Source Big Blue Magnet with 45 min of Mag. Relax.
		controlTimeInstants = {2400, 4800, timeFinal};
		bmax_m = 2.4;
		rate = bmax_m/2400;
		qttMax = bmax_m / mu0;
        hsVal[] =  (($Time * rate  <= bmax_m) ? ($Time * rate)/mu0 :
                    ($Time * rate  > bmax_m && $Time * rate  <= 2*bmax_m) ?
                    qttMax - (($Time - 2400) * rate)/mu0 : 0);
        hsVal_prev[] = ((($Time-$DTime) * rate  <= bmax_m) ? (($Time-$DTime) * rate)/mu0 :
                    (($Time-$DTime) * rate  > bmax_m && ($Time-$DTime) * rate  <= 2*bmax_m) ?
                    qttMax - ((($Time-$DTime) - 2400) * rate)/mu0  : 0);
	ElseIf(Flag_Source == 3)
        // No source --> For movement
        controlTimeInstants = {timeFinalSimu, timeFinal};
        rate = 0;
		    qttMax = 0;
        hsVal[] = 0;
        hsVal_prev[] = 0;
    EndIf

	Str_Directory_Code = "C:\Users\miche\OneDrive - Universite de Liege\Unif\Phd\WP2\Getdp\RotatingSuperconductor";
  Str_LcCube = "7";
  Velocity[] = Vector[0,0,0];

  For i In {1:Num_Super}
    CentreSuperconductor~{i}[] = Vector[CentreXSuperconductor~{i},CentreYSuperconductor~{i},CentreZSuperconductor~{i}];
  EndFor
	// Projection parameters
	If(Time_step==1) // First step
		// For projection
			//************ Initial condition File Depending on the considered modelled samples ****************//
      /* DefineConstant [initialConditionFile_a1 = StrCat[Str_Directory_Code,"\IniCond_coupled_formulation\afield_CentralEch_LcCube_0_000",Str_LcCube,".pos"]];	// Central
      DefineConstant [initialConditionFile_h1 = StrCat[Str_Directory_Code,"\IniCond_coupled_formulation\hfield_CentralEch_LcCube_0_000",Str_LcCube,".pos"]];	// Central */
      /* DefineConstant [initialConditionFile_a1 = StrCat[Str_Directory_Code,"\IniCond_coupled_formulation\ST\afield_CentralEch_LcCube_0_00035.pos"]];	// Central
      DefineConstant [initialConditionFile_h1 = StrCat[Str_Directory_Code,"\IniCond_coupled_formulation\ST\hfield_CentralEch_LcCube_0_00035.pos"]];	// Central */
      DefineConstant [initialConditionFile_a1 = StrCat[Str_Directory_Code,"\IniCond_coupled_formulation\ST\a_NbelemCube6.pos"]];	// Central
      DefineConstant [initialConditionFile_h1 = StrCat[Str_Directory_Code,"\IniCond_coupled_formulation\ST\h_NbelemCube6.pos"]];	// Central

				// Read a from File
				GmshRead[ initialConditionFile_a1,1];

				// Read h from file
				GmshRead[ initialConditionFile_h1,4];

        // Rotate back to go to the right coordinate in the file at previous step, but the field rotate forward
        a_fromFile[Surface_Cuboid_Superconductor_1] = MatRot[dTheta]*VectorField[MatRot[-dTheta]*(XYZ[]-CentreSuperconductor_1[])]{1};
				h_fromFile[Cuboid_Superconductor_1] = MatRot[dTheta]*VectorField[MatRot[-dTheta]*(XYZ[]-CentreSuperconductor_1[])]{4};
	Else	// All other steps
        //************ Initial condition File Depending on the considered modelled samples ****************//
        DefineConstant [initialConditionFile_a1 = StrCat[Str_Directory_Code,"\Last_computed_a.pos"]];	// Central
        DefineConstant [initialConditionFile_h1 = StrCat[Str_Directory_Code,"\Last_computed_h.pos"]];	// Central

        // Read a from File
				GmshRead[ initialConditionFile_a1,1];

				// Read h from file
				GmshRead[ initialConditionFile_h1,4];

        // Rotate back to go to the right coordinate in the file at previous step, but the field rotate forward
        a_fromFile[Surface_Cuboid_Superconductor_1] = MatRot[dTheta]*VectorField[MatRot[-dTheta]*(XYZ[]-CentreSuperconductor_1[])+CentreSuperconductor_1[]]{1};
				h_fromFile[Cuboid_Superconductor_1] = MatRot[dTheta]*VectorField[MatRot[-dTheta]*(XYZ[]-CentreSuperconductor_1[])+CentreSuperconductor_1[]]{4};
	EndIf
}

// Only external field is implemented
Constraint {
    { Name a ;
        Case {
			If(Active_approach == 1)
				{Region SurfOut ; Value 0; }
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
          If(Active_approach==1)
            Print[ a, OnElementsOf Omega_a, File StrCat["res/For_Matlab/Save_afield_",Str_step,".pos"],Format Gmsh, OverrideTimeStepValue 0, LastTimeStepOnly, SendToServer "No"] ;
  					Print[ h, OnElementsOf Omega_h, File StrCat["res/For_Matlab/Save_hfield_",Str_step,".pos"],Format Gmsh, OverrideTimeStepValue 0, LastTimeStepOnly, SendToServer "No"] ;
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

DefineConstant[
  R_ = {"MagDyn", Name "GetDP/1ResolutionChoices", Visible 0},
  C_ = {"-solve -pos -bin -v 3 -v2", Name "GetDP/9ComputeCommand", Visible 0},
  P_ = { "MagDyn", Name "GetDP/2PostOperationChoices", Visible 0}
];
