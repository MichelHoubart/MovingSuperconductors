// Include cross data
Include "Cuboid_Superconductors_data.pro";

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
    Air = Region[ AIR];
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
    		For i In {1:1}
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
        For i In {1:1}
          DefineGroup [Cuboid_Superconductor~{i}];
          /* Super += Region[ BULK~{i} ]; */
          Cond += Region[{ BULK~{i} }];
          Copper += Region[ BULK~{i} ];
          Cuboid_Superconductor~{i} = Region[ BULK~{i} ];
          Surface_Cuboid_Superconductor~{i} = Region[ Boundary_BULK~{i} ];
          Surface_Superconductors += Region[ Boundary_BULK~{i} ];
          BndOmegaC += Region[ Boundary_BULK~{i} ];
          Layer~{i} =  Region[Air, OnOneSideOf Boundary_BULK~{i}];
          Vol_Layer += Region[Layer~{i}];
        EndFor
        Vol_Force = Region [ Vol_Layer ];
        IsThereSuper = 0;
        Flag_LinearProblem = 1;
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
    // ------- PARAMETERS -------
    i=1;
    // Superconductor parameters
    DefineConstant [ec = 1e-4]; // Critical electric field [V/m]
    jc_Base_1 = 1.7417*1e8;
    n_Base_1 = 50;

		DefineConstant[ jc~{i} = {jc_Base~{i}, Highlight "LightGreen", Name Sprintf("1Input/3Material Properties/2jc Sample%g (Am⁻²)",i), Visible 1}]; // Critical current density [A/m2] QUALITATIVE BULKS : 2.2977*1e8, STACK TAPES : 1.3037*1e8
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

	   // Parameters for anisotropy
    DefineConstant[ C_Axis_1 = {3, Highlight "LightGreen", Choices{
        1="1 : x",
    		2="2 : y",  // Central sample
    		3="3 : z"}, // Peripheral sample
    	  Name Sprintf("1Input/3Material Properties/3C-axis Sample1 Number"), Visible 1}];

	// Rhosup qui fonctionne : 0.00000001
	DefineConstant [RhoSupCaxis = {0.0000000, Highlight "LightGreen", Name "1Input/3Material Properties/9999Artificial supplementary resistivity along c-axis"}];

  DefineConstant[ Anisotropy_Factor = {1, Highlight "LightGreen",
			Name Sprintf("1Input/3Material Properties/4Anisostropy Factor"), Visible 1}];

	For i In {1:Num_Super}
  		If(C_Axis~{i}==1)
    			SQRTAN[Cuboid_Superconductor~{i}] = TensorDiag[Sqrt[Anisotropy_Factor^n[]], 1, 1]; 		// For h-formulation
    			AddRho[Cuboid_Superconductor~{i}] = TensorDiag[RhoSupCaxis, 0, 0]; 					   	      // For h-formulation
    			Anys_Matrix[Cuboid_Superconductor~{i}] = TensorDiag[1/Anisotropy_Factor, 1, 1];	   		// For a-formulation
  		ElseIf(C_Axis~{i}==2)
    			SQRTAN[Cuboid_Superconductor~{i}] = TensorDiag[1, Sqrt[Anisotropy_Factor^n[]], 1]; 		// For h-formulation
    			AddRho[Cuboid_Superconductor~{i}] = TensorDiag[0, RhoSupCaxis, 0]; 					   	      // For h-formulation
    			Anys_Matrix[Cuboid_Superconductor~{i}] = TensorDiag[1,1/Anisotropy_Factor, 1];	   		// For a-formulation
  		ElseIf(C_Axis~{i}==3)
    			SQRTAN[Cuboid_Superconductor~{i}] = TensorDiag[1, 1, Sqrt[Anisotropy_Factor^n[]]]; 		// For h-formulation
    			AddRho[Cuboid_Superconductor~{i}] = TensorDiag[0, 0, RhoSupCaxis]; 					   	      // For h-formulation
    			Anys_Matrix[Cuboid_Superconductor~{i}] = TensorDiag[1, 1, 1/Anisotropy_Factor];	   		// For a-formulation
  		Else
    			SQRTAN[Cuboid_Superconductor~{i}] = TensorDiag[1, 1, 1]; 								              // For h-formulation
    			AddRho[Cuboid_Superconductor~{i}] = TensorDiag[0, 0, 0]; 					   			            // For h-formulation
    			Anys_Matrix[Cuboid_Superconductor~{i}] = TensorDiag[1, 1, 1];	  						          // For a-formulation
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

  DefineConstant [Flag_Source = {8, Highlight "yellow", Choices{
  	1="Ramp up and down",
  	2="Ramp up, down and flux creep",
  	3="No source => For modelling motion",
    4="Constant background field",
    5="Ramp Down",
    6="Rotating field",
    8="mH Curve"}, Name "1Input/4Source/0Source field type" }];
  }
Include "../lib/SourceDefinition.pro";
Function{
  DefineConstant [f = {0.1, Visible (Flag_Source ==0), Name "1Input/4Source/1Frequency (Hz)"}]; // Frequency of imposed current intensity [Hz]
  DefineConstant [partLength = {5, Name "1Input/4Source/1Ramp duration (s)"}];
  DefineConstant [timeFinal = EndUpFromDown]; // Final time for source definition [s]
  DefineConstant [timeFinalSimu = timeFinal]; // Final time of simulation [s]
  DefineConstant [stepTime = 0.01]; // Initiation of the step [s]
  DefineConstant [stepSharpness = 0.001]; // Duration of the step [s]

    // ------- NUMERICAL PARAMETERS -------
		  DefineConstant [dt = { (preset==1 || preset == 3) ? 25 : 25, Highlight "LightBlue",
			   ReadOnly !expMode, Name "Input/5Method/Time step (s)"}]; // Time step (initial if adaptive)[s]
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

  DefineFunction [I, js, hsVal];
  mu0 = 4*Pi*1e-7; // [H/m]
  nu0 = 1.0/mu0; // [m/H]
	Velocity[] = Vector[0, 0, 0];


	Str_Directory_Code = "C:\Users\Administrator\Desktop\Michel\WP1\Test_Moving_Super\Computing_mH_Curves";
  Str_LcCube = Sprintf("%g", NbElemCube); // Not well defined for old simulation

  // Projection parameters (Have to define this because the .lib is shared)

	   // MAGNETISATION ONLY, Whatever From File, except for test
    dXYZ[] = Vector[0., 0 , 0];
    initialConditionFile_Cylinder1_h = StrCat[Str_Directory_Code,"\Last_computed_h",".pos"];
    GmshRead[initialConditionFile_Cylinder1_h,43];
    If(MaterialType==1)
       h_fromFile[Super] = VectorField[XYZ[]]{43};
    ElseIf(MaterialType==2)
       h_fromFile[Copper] = VectorField[XYZ[]]{43};
    EndIf
		initialConditionFile_Cylinder1_a = StrCat[Str_Directory_Code,"\Last_computed_a",".pos"];
		GmshRead[initialConditionFile_Cylinder1_a,44];
		a_fromFile[Surface_Superconductors] = VectorField[XYZ[]]{44};
}

// Only external field is implemented
Constraint {
    { Name a ;
        Case {
			If(((formulation == a_formulation)))
				{ Region Omega ; Type InitFromResolution ; NameOfResolution ProjectionInit ; }
			EndIf
        }
    }
    { Name phi ;
        Case {
            {Region SurfOut ; Value XYZ[]*directionApplied[] ; TimeFunction hsVal[] ;}
        }
    }
    { Name h ;
        Case {
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

// ---- Save directory ----
i=1;
/* Str_SaveDir = StrCat["res\For_Matlab\ResultsBatch\Jc",Sprintf("%g", jc~{i}),"Jc0",Sprintf("%g", jc0~{i}),"n",Sprintf("%g", n~{i}),"B0",Sprintf("%g", B0~{i}),"Bapp",Sprintf("%g", bmax_m),"\"];
CreateDirectory[Str_SaveDir]; */

Include "../lib/formulations.pro";
Include "../lib/resolution.pro";
ExtGmsh     = ".pos" ;

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
               If(formulation == h_formulation)
                    Print[ phi, OnElementsOf OmegaCC , File "res/phi.pos", Name "phi [A]", SendToServer "No" ];
          					Print[ j, OnElementsOf Omega, File StrCat["Last_computed_j", ExtGmsh], Format Gmsh,
          					OverrideTimeStepValue 0, LastTimeStepOnly, SendToServer "No"] ;
          					Print[ h, OnElementsOf Omega_h, File StrCat["Last_computed_h", ExtGmsh], Format Gmsh,
          					OverrideTimeStepValue 0, LastTimeStepOnly, SendToServer "No"] ;
                ElseIf(formulation == a_formulation)
                    Print[ a, OnElementsOf Omega_a , File "res/a.pos", Format Gmsh, OverrideTimeStepValue Time_step, LastTimeStepOnly ];
                    // Print[ ur, OnElementsOf OmegaC , File "res/ur.pos", Name "ur [V/m]", SendToServer "No" ];
          					Print[ a, OnElementsOf Omega_a, File StrCat["Last_computed_a", ExtGmsh],Format Gmsh,
          					OverrideTimeStepValue 0, LastTimeStepOnly, SendToServer "No"] ;
          					Print[ b, OnElementsOf Omega , File "res/b.pos", Name "b [T]" ];
				        ElseIf(formulation == coupled_formulation)
          					Print[ h, OnElementsOf Omega_h, File StrCat["Last_computed_h", ExtGmsh], Format Gmsh,
          					OverrideTimeStepValue 0, LastTimeStepOnly, SendToServer "No"] ;
          					Print[ a, OnElementsOf Omega_a, File StrCat["Last_computed_a", ExtGmsh],Format Gmsh,
					          OverrideTimeStepValue 0, LastTimeStepOnly, SendToServer "No"] ;
                    Print[ h, OnElementsOf Omega_h, File StrCat[Str_SaveDir,"Last_computed_h", ExtGmsh], Format Gmsh,
                    OverrideTimeStepValue 0, LastTimeStepOnly, SendToServer "No"] ;
                    Print[ a, OnElementsOf Omega_a, File StrCat[Str_SaveDir,"Last_computed_a", ExtGmsh],Format Gmsh,
                    OverrideTimeStepValue 0, LastTimeStepOnly, SendToServer "No"] ;
                EndIf
          					Print[ j, OnElementsOf OmegaC , File "res/j.pos", Name "j [A/m2]" ];
          					Print[ e, OnElementsOf OmegaC , File "res/e.pos", Name "e [V/m]" ];
          					/* Print[ b, OnElementsOf Omega , File "res/b.pos", Name "b [T]" ]; */
            				 If(formulation == coupled_formulation)
            						Print[ a, OnElementsOf Omega_a , File "res/a.pos", Name "a" ];
            				EndIf
            EndIf
      			If(Save_later == 1) // Exports for MATLAB plot
        				Print[ j, OnElementsOf Omega, File StrCat[Str_SaveDir,"j_wholedomain",Str_step,".pos"], Format Gmsh, OverrideTimeStepValue Time_step, LastTimeStepOnly];
          					// Save the field a, h and j at current step
          					If(formulation == a_formulation)
          						Print[ a, OnElementsOf Omega_a, File StrCat[Str_SaveDir,"Save_afield_",Str_step,".pos"],Format Gmsh, OverrideTimeStepValue 0, LastTimeStepOnly, SendToServer "No"] ;
          					ElseIf(formulation == h_formulation)
          						Print[ h, OnElementsOf Omega_h, File StrCat[Str_SaveDir,"Save_hfield_",Str_step,".pos"],Format Gmsh, OverrideTimeStepValue 0, LastTimeStepOnly, SendToServer "No"] ;
          					ElseIf(formulation == coupled_formulation)
          						Print[ a, OnElementsOf Omega_a, File StrCat[Str_SaveDir,"Save_afield_",Str_step,".pos"],Format Gmsh, OverrideTimeStepValue 0, LastTimeStepOnly, SendToServer "No"] ;
          						Print[ h, OnElementsOf Omega_h, File StrCat[Str_SaveDir,"Save_hfield_",Str_step,".pos"],Format Gmsh, OverrideTimeStepValue 0, LastTimeStepOnly, SendToServer "No"] ;
                      p1 = {0,0,0};
                      Print[ bsVal,  OnLine{{List[p1]}{List[p1]}} {2}, Format Table , File StrCat[Str_SaveDir,"Bapp",Str_step,".txt"]];
                      /* Print[{$bsVal}, Format "%g", File StrCat[Str_SaveDir,"Bapp",Str_step,".txt"]]]; */
                      // Magnetic moment and force of each sample
                      For i In {1:Num_Super}
                          Str_Sample = Sprintf("%g", i);
                          Print[ mSample~{i}, OnRegion Cuboid_Superconductor~{i}, Format Table , File StrCat[Str_SaveDir,"m_Step",Str_step,"_Sample",Str_Sample,".txt"]];
                          Print[ f~{i}[Air], OnGlobal, Format Table, File StrCat[Str_SaveDir,"F_Step",Str_step,"_OnSample",Str_Sample,".txt"]  ];
                          Print[ t~{i}[Air], OnGlobal, Format Table, File StrCat[Str_SaveDir,"T_Step",Str_step,"_OnSample",Str_Sample,".txt"]  ];
                      EndFor
                    EndIf
      			EndIf
        }
    }
}

DefineConstant[
  R_ = {"MagDyn", Name "GetDP/1ResolutionChoices", Visible 0},
  C_ = {"-solve -pos -bin -v 3 -v2", Name "GetDP/9ComputeCommand", Visible 1},
  P_ = { "MagDyn", Name "GetDP/2PostOperationChoices", Visible 0}
];
