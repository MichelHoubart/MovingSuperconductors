// Include cross data
Include "Cuboid_Superconductors_data.pro";
Include "Sample_Characteristics.pro";
Macro InitialFileSelection
  If(Modelled_Samples == 1 || Modelled_Samples == 3)
    If(Num_Super == 3)
      If(formulation == a_formulation)
      // Qualitative Bulks	CARE Lc_cube --> meshMult*0.00035 (Possible to change to 0.0005 though)
        DefineConstant [initialConditionFile_a1 = StrCat[Str_Directory_Code,"\Initial_Conditions\Ini_cond_a_Maxdist", Str_Maxdist ,"_66613_Lccube_0_000",Str_LcCube,".pos"]];	// Peripheral
        // DefineConstant [initialConditionFile_a1 = StrCat[Str_Directory_Code,"\Initial_Conditions\Ini_cond_a_Maxdist", Str_Maxdist ,"_66613_Lccube_0_000",Str_LcCube,"_n40.pos"]];	// Peripheral
        // DefineConstant [initialConditionFile_a1 = StrCat[Str_Directory_Code,"\Initial_Conditions\Ini_cond_a_Maxdist", Str_Maxdist ,"_66613_Lccube_0_000",Str_LcCube,"_Jc4.pos"]];	// Peripheral

        // DefineConstant [initialConditionFile_a2 = StrCat[Str_Directory_Code,"\Initial_Conditions\Ini_cond_a_Maxdist", Str_Maxdist ,"_6662_Lccube_0_000",Str_LcCube,"_Jc1.pos"]];	// Central
        DefineConstant [initialConditionFile_a2 = StrCat[Str_Directory_Code,"\Initial_Conditions\Ini_cond_a_Maxdist", Str_Maxdist ,"_6662_Lccube_0_000",Str_LcCube,".pos"]];	// Central

        DefineConstant [initialConditionFile_a3 = StrCat[Str_Directory_Code,"\Initial_Conditions\Ini_cond_a_Maxdist", Str_Maxdist ,"_66613_Lccube_0_000",Str_LcCube,".pos"]];	// Peripheral
        // DefineConstant [initialConditionFile_a3 = StrCat[Str_Directory_Code,"\Initial_Conditions\Ini_cond_a_Maxdist", Str_Maxdist ,"_66613_Lccube_0_000",Str_LcCube,"_n40.pos"]];	// Peripheral
        // DefineConstant [initialConditionFile_a3 = StrCat[Str_Directory_Code,"\Initial_Conditions\Ini_cond_a_Maxdist", Str_Maxdist ,"_66613_Lccube_0_000",Str_LcCube,"_Jc4.pos"]];	// Peripheral
      ElseIf(formulation == coupled_formulation)
        If(RhoSupCaxis == 0)  // Qualitative Bulks (Isotropic behaviour)
          DefineConstant [initialConditionFile_a1 = StrCat[Str_Directory_Code,"\IniCond_coupled_formulation\afield_PeripheralEch_LcCube_0_000",Str_LcCube,".pos"]];	// Peripheral
          DefineConstant [initialConditionFile_a2 = StrCat[Str_Directory_Code,"\IniCond_coupled_formulation\afield_CentralEch_LcCube_0_000",Str_LcCube,".pos"]];	// Central
          DefineConstant [initialConditionFile_a3 = StrCat[Str_Directory_Code,"\IniCond_coupled_formulation\afield_PeripheralEch_LcCube_0_000",Str_LcCube,".pos"]];	// Peripheral

          DefineConstant [initialConditionFile_h1 = StrCat[Str_Directory_Code,"\IniCond_coupled_formulation\hfield_PeripheralEch_LcCube_0_000",Str_LcCube,".pos"]];	// Peripheral
          DefineConstant [initialConditionFile_h2 = StrCat[Str_Directory_Code,"\IniCond_coupled_formulation\hfield_CentralEch_LcCube_0_000",Str_LcCube,".pos"]];	// Central
          DefineConstant [initialConditionFile_h3 = StrCat[Str_Directory_Code,"\IniCond_coupled_formulation\hfield_PeripheralEch_LcCube_0_000",Str_LcCube,".pos"]];	// Peripheral
        ElseIf(Modelled_Samples == 1) // Qualitative Stacked Tapes (14x14x14 mm3)
          DefineConstant [initialConditionFile_a1 = StrCat[Str_Directory_Code,"\IniCond_coupled_formulation\afield_PeripheralEch_LcCube_0_000",Str_LcCube,"_Ani.pos"]];	// Peripheral
          DefineConstant [initialConditionFile_a2 = StrCat[Str_Directory_Code,"\IniCond_coupled_formulation\afield_CentralEch_LcCube_0_000",Str_LcCube,"_Ani.pos"]];	// Central
          DefineConstant [initialConditionFile_a3 = StrCat[Str_Directory_Code,"\IniCond_coupled_formulation\afield_PeripheralEch_LcCube_0_000",Str_LcCube,"_Ani.pos"]];	// Peripheral

          DefineConstant [initialConditionFile_h1 = StrCat[Str_Directory_Code,"\IniCond_coupled_formulation\hfield_PeripheralEch_LcCube_0_000",Str_LcCube,"_Ani.pos"]];	// Peripheral
          DefineConstant [initialConditionFile_h2 = StrCat[Str_Directory_Code,"\IniCond_coupled_formulation\hfield_CentralEch_LcCube_0_000",Str_LcCube,"_Ani.pos"]];	// Central
          DefineConstant [initialConditionFile_h3 = StrCat[Str_Directory_Code,"\IniCond_coupled_formulation\hfield_PeripheralEch_LcCube_0_000",Str_LcCube,"_Ani.pos"]];	// Peripheral
        ElseIf(Modelled_Samples == 3)
          DefineConstant [initialConditionFile_a1 = StrCat[Str_Directory_Code,"\IniCond_coupled_formulation\StackedTapes\afield_PeripheralEch_LcCube_0_000",Str_LcCube,".pos"]];	// Peripheral
          DefineConstant [initialConditionFile_a2 = StrCat[Str_Directory_Code,"\IniCond_coupled_formulation\StackedTapes\afield_CentralEch_LcCube_0_000",Str_LcCube,".pos"]];	// Central
          DefineConstant [initialConditionFile_a3 = StrCat[Str_Directory_Code,"\IniCond_coupled_formulation\StackedTapes\afield_PeripheralEch_LcCube_0_000",Str_LcCube,".pos"]];	// Peripheral

          DefineConstant [initialConditionFile_h1 = StrCat[Str_Directory_Code,"\IniCond_coupled_formulation\StackedTapes\hfield_PeripheralEch_LcCube_0_000",Str_LcCube,".pos"]];	// Peripheral
          DefineConstant [initialConditionFile_h2 = StrCat[Str_Directory_Code,"\IniCond_coupled_formulation\StackedTapes\hfield_CentralEch_LcCube_0_000",Str_LcCube,".pos"]];	// Central
          DefineConstant [initialConditionFile_h3 = StrCat[Str_Directory_Code,"\IniCond_coupled_formulation\StackedTapes\hfield_PeripheralEch_LcCube_0_000",Str_LcCube,".pos"]];	// Peripheral
        EndIf
      EndIf
    ElseIf(Num_Super == 4)
      If(formulation == coupled_formulation)
        If(Approach_Type == 1)
          DefineConstant [initialConditionFile_a1 = StrCat[Str_Directory_Code,"\IniCond_coupled_formulation\StackedTapes\afield_PeripheralEch_LcCube_0_000",Str_LcCube,".pos"]];	// Peripheral
          DefineConstant [initialConditionFile_a2 = StrCat[Str_Directory_Code,"\IniCond_coupled_formulation\StackedTapes\afield_CentralEch_LcCube_0_000",Str_LcCube,"_4ech.pos"]]; // Central sample
          DefineConstant [initialConditionFile_a3 = StrCat[Str_Directory_Code,"\IniCond_coupled_formulation\StackedTapes\afield_PeripheralEch_LcCube_0_000",Str_LcCube,".pos"]];	// Peripheral
          DefineConstant [initialConditionFile_a4 = StrCat[Str_Directory_Code,"\IniCond_coupled_formulation\StackedTapes\afield_CentralEch_LcCube_0_000",Str_LcCube,"_4ech.pos"]];	// Supplementary sample

          DefineConstant [initialConditionFile_h1 = StrCat[Str_Directory_Code,"\IniCond_coupled_formulation\StackedTapes\hfield_PeripheralEch_LcCube_0_000",Str_LcCube,".pos"]];	// Peripheral
          DefineConstant [initialConditionFile_h2 = StrCat[Str_Directory_Code,"\IniCond_coupled_formulation\StackedTapes\hfield_CentralEch_LcCube_0_000",Str_LcCube,"_4ech.pos"]]; // Central sample
          DefineConstant [initialConditionFile_h3 = StrCat[Str_Directory_Code,"\IniCond_coupled_formulation\StackedTapes\hfield_PeripheralEch_LcCube_0_000",Str_LcCube,".pos"]];	// Peripheral
          DefineConstant [initialConditionFile_h4 = StrCat[Str_Directory_Code,"\IniCond_coupled_formulation\StackedTapes\hfield_CentralEch_LcCube_0_000",Str_LcCube,"_4ech.pos"]];	// Supplementary sample
        ElseIf(Approach_Type == 2)
          DefineConstant [initialConditionFile_a1 = StrCat[Str_Directory_Code,"\IniCond_coupled_formulation\StackedTapes\afield_3ST1Bulk_FCZFCEndStep1_LcCube_0_000",Str_LcCube,".pos"]];	// Peripheral
          DefineConstant [initialConditionFile_a2 = StrCat[Str_Directory_Code,"\IniCond_coupled_formulation\StackedTapes\afield_3ST1Bulk_FCZFCEndStep1_LcCube_0_000",Str_LcCube,".pos"]]; // Central sample
          DefineConstant [initialConditionFile_a3 = StrCat[Str_Directory_Code,"\IniCond_coupled_formulation\StackedTapes\afield_3ST1Bulk_FCZFCEndStep1_LcCube_0_000",Str_LcCube,".pos"]];	// Peripheral
          DefineConstant [initialConditionFile_a4 = StrCat[Str_Directory_Code,"\IniCond_coupled_formulation\StackedTapes\afield_3ST1Bulk_FCZFCEndStep1_LcCube_0_000",Str_LcCube,".pos"]];	// Supplementary sample

          DefineConstant [initialConditionFile_h1 = StrCat[Str_Directory_Code,"\IniCond_coupled_formulation\StackedTapes\hfield_3ST1Bulk_FCZFCEndStep1_LcCube_0_000",Str_LcCube,".pos"]];	// Peripheral
          DefineConstant [initialConditionFile_h2 = StrCat[Str_Directory_Code,"\IniCond_coupled_formulation\StackedTapes\hfield_3ST1Bulk_FCZFCEndStep1_LcCube_0_000",Str_LcCube,".pos"]]; // Central sample
          DefineConstant [initialConditionFile_h3 = StrCat[Str_Directory_Code,"\IniCond_coupled_formulation\StackedTapes\hfield_3ST1Bulk_FCZFCEndStep1_LcCube_0_000",Str_LcCube,".pos"]];	// Peripheral
          DefineConstant [initialConditionFile_h4 = StrCat[Str_Directory_Code,"\IniCond_coupled_formulation\StackedTapes\hfield_3ST1Bulk_FCZFCEndStep1_LcCube_0_000",Str_LcCube,".pos"]];	// Supplementary sample

        EndIf
      Else
        If(Approach_Type == 1)
          DefineConstant [initialConditionFile_a1 = StrCat[Str_Directory_Code,"\Initial_Conditions\Ini_cond_a_Maxdist", Str_Maxdist ,"_66613_Lccube_0_000",Str_LcCube,".pos"]];	// Peripheral
          DefineConstant [initialConditionFile_a2 = StrCat[Str_Directory_Code,"\Initial_Conditions\Ini_cond_a_Maxdist", Str_Maxdist ,"_66626_size",Str_ay_6664,"mm_Lccube_0_000",Str_LcCube,".pos"]]; // Central sample
          DefineConstant [initialConditionFile_a3 = StrCat[Str_Directory_Code,"\Initial_Conditions\Ini_cond_a_Maxdist", Str_Maxdist ,"_66613_Lccube_0_000",Str_LcCube,".pos"]];	// Peripheral
          DefineConstant [initialConditionFile_a4 = StrCat[Str_Directory_Code,"\Initial_Conditions\Ini_cond_a_Maxdist", Str_Maxdist ,"_66626_size",Str_ay_6664,"mm_Lccube_0_000",Str_LcCube,".pos"]];	// Supplementary sample
        ElseIf(Approach_Type == 2)
          DefineConstant [initialConditionFile_a1 = StrCat[Str_Directory_Code,"\Initial_Conditions\A_Field_EndStep1_FCZFC_",Str_ay_6664,"mm.pos"]];	// Peripheral
          DefineConstant [initialConditionFile_a2 = StrCat[Str_Directory_Code,"\Initial_Conditions\A_Field_EndStep1_FCZFC_",Str_ay_6664,"mm.pos"]];	// Central aligned
          DefineConstant [initialConditionFile_a3 = StrCat[Str_Directory_Code,"\Initial_Conditions\A_Field_EndStep1_FCZFC_",Str_ay_6664,"mm.pos"]];	// Peripheral
          DefineConstant [initialConditionFile_a4 = StrCat[Str_Directory_Code,"\Initial_Conditions\A_Field_EndStep1_FCZFC_",Str_ay_6664,"mm.pos"]];	// Central misaligned
        EndIf
      EndIf
    EndIf
  ElseIf(Modelled_Samples == 2)
    // Real bulks			CARE Lc_cube --> meshMult*0.0005
    DefineConstant [initialConditionFile_a1 = StrCat[Str_Directory_Code,"\Initial_Conditions\Ini_cond_a_Maxdist", Str_Maxdist ,"_1219.pos"]];
    DefineConstant [initialConditionFile_a2 = StrCat[Str_Directory_Code,"\Initial_Conditions\Ini_cond_a_Maxdist", Str_Maxdist ,"_1218.pos"]];
    DefineConstant [initialConditionFile_a3 = StrCat[Str_Directory_Code,"\Initial_Conditions\Ini_cond_a_Maxdist", Str_Maxdist ,"_1220.pos"]];
  ElseIf(Modelled_Samples == 3)
    // Stacked tapes		CARE Lc_cube --> meshMult*0.0005
    // DefineConstant [initialConditionFile_a1 = StrCat[Str_Directory_Code,"\Initial_Conditions\Ini_cond_a_Maxdist", Str_Maxdist ,"_12345678913.pos"]]; 		// Peripheral
    // DefineConstant [initialConditionFile_a2 = StrCat[Str_Directory_Code,"\Initial_Conditions\Ini_cond_a_Maxdist", Str_Maxdist ,"_1234567892.pos"]];			// Central
    // DefineConstant [initialConditionFile_a3 = StrCat[Str_Directory_Code,"\Initial_Conditions\Ini_cond_a_Maxdist", Str_Maxdist ,"_12345678913.pos"]]; 		// Peripheral
  EndIf
Return
Macro FirstBulkPositionning
  If(Approach_Type == 1)
    If(Bulk_Disposition == 1)
      // Pojection without offset along y
      If(Num_Super == 3)
        dXYZ[Region[{Cuboid_Superconductor_1}]] = Vector[-ax~{Stationnary_Sample}/2 + ax~{Sample_1}/2,-ay~{Stationnary_Sample}/2 + ay~{Sample_1}/2 , -az~{Stationnary_Sample}/2 -az~{Sample_1}/2 -Distance_between_super];
        dXYZ[Region[{Cuboid_Superconductor_2}]] = Vector[0., 0 , 0];
        dXYZ[Region[{Cuboid_Superconductor_3}]] = Vector[-ax~{Stationnary_Sample}/2 + ax~{Sample_3}/2, -ay~{Stationnary_Sample}/2 + ay~{Sample_3}/2,  +az~{Stationnary_Sample}/2 +az~{Sample_3}/2 + Distance_between_super];

        dXYZ[Region[{Surface_Cuboid_Superconductor_1}]] = Vector[-ax~{Stationnary_Sample}/2 + ax~{Sample_1}/2,-ay~{Stationnary_Sample}/2 + ay~{Sample_1}/2 , -az~{Stationnary_Sample}/2 -az~{Sample_1}/2 -Distance_between_super];
        dXYZ[Region[{Surface_Cuboid_Superconductor_2}]] = Vector[0., 0 , 0];
        dXYZ[Region[{Surface_Cuboid_Superconductor_3}]] = Vector[-ax~{Stationnary_Sample}/2 + ax~{Sample_3}/2, -ay~{Stationnary_Sample}/2 + ay~{Sample_3}/2,  +az~{Stationnary_Sample}/2 +az~{Sample_3}/2 + Distance_between_super];
      ElseIf(Num_Super == 4)
        dXYZ[Region[{Cuboid_Superconductor_1}]] = Vector[-ax~{Stationnary_Sample}/2 + ax~{Sample_1}/2,-ay~{Stationnary_Sample}/2 + ay~{Sample_1}/2 -ay~{Stationnary_Sample}/2, -az~{Stationnary_Sample}/2 -az~{Sample_1}/2 -Distance_between_super];
        dXYZ[Region[{Cuboid_Superconductor_2}]] = Vector[0., 0 , 0];
        dXYZ[Region[{Cuboid_Superconductor_3}]] = Vector[-ax~{Stationnary_Sample}/2 + ax~{Sample_3}/2, -ay~{Stationnary_Sample}/2 + ay~{Sample_3}/2 -ay~{Stationnary_Sample}/2,  +az~{Stationnary_Sample}/2 +az~{Sample_3}/2 + Distance_between_super];
        dXYZ[Region[{Cuboid_Superconductor_4}]] = Vector[0., 0 , 0];

        dXYZ[Region[{Surface_Cuboid_Superconductor_1}]] = Vector[-ax~{Stationnary_Sample}/2 + ax~{Sample_1}/2,-ay~{Stationnary_Sample}/2 + ay~{Sample_1}/2 -ay~{Stationnary_Sample}/2, -az~{Stationnary_Sample}/2 -az~{Sample_1}/2 -Distance_between_super];
        dXYZ[Region[{Surface_Cuboid_Superconductor_2}]] = Vector[0., 0 , 0];
        dXYZ[Region[{Surface_Cuboid_Superconductor_3}]] = Vector[-ax~{Stationnary_Sample}/2 + ax~{Sample_3}/2, -ay~{Stationnary_Sample}/2 + ay~{Sample_3}/2 -ay~{Stationnary_Sample}/2,  +az~{Stationnary_Sample}/2 +az~{Sample_3}/2 + Distance_between_super];
        dXYZ[Region[{Surface_Cuboid_Superconductor_4}]] = Vector[0., 0 , 0];
      EndIf
    ElseIf(Bulk_Disposition == 2)
      // Pojection with Half offset along y
      dXYZ[Region[{Cuboid_Superconductor_1}]] = Vector[-ax~{Stationnary_Sample}/2 + ax~{Sample_1}/2,-ay~{Stationnary_Sample}/2 + ay~{Sample_1}/2 , -az~{Stationnary_Sample}/2 -az~{Sample_1}/2 -Distance_between_super];
      dXYZ[Region[{Cuboid_Superconductor_2}]] = Vector[0., -ay~{Stationnary_Sample}/2 , 0];
      dXYZ[Region[{Cuboid_Superconductor_3}]] = Vector[-ax~{Stationnary_Sample}/2 + ax~{Sample_3}/2, -ay~{Stationnary_Sample}/2 + ay~{Sample_3}/2,  +az~{Stationnary_Sample}/2 +az~{Sample_3}/2 + Distance_between_super];

      dXYZ[Region[{Surface_Cuboid_Superconductor_1}]] = Vector[-ax~{Stationnary_Sample}/2 + ax~{Sample_1}/2,-ay~{Stationnary_Sample}/2 + ay~{Sample_1}/2 , -az~{Stationnary_Sample}/2 -az~{Sample_1}/2 -Distance_between_super];
      dXYZ[Region[{Surface_Cuboid_Superconductor_2}]] = Vector[0., -ay~{Stationnary_Sample}/2 , 0];
      dXYZ[Region[{Surface_Cuboid_Superconductor_3}]] = Vector[-ax~{Stationnary_Sample}/2 + ax~{Sample_3}/2, -ay~{Stationnary_Sample}/2 + ay~{Sample_3}/2,  +az~{Stationnary_Sample}/2 +az~{Sample_3}/2 + Distance_between_super];
    ElseIf(Bulk_Disposition == 3)
      // Pojection with Full offset along y
      dXYZ[Region[{Cuboid_Superconductor_1}]] = Vector[-ax~{Stationnary_Sample}/2 + ax~{Sample_1}/2, ay~{Sample_1}/2 , -az~{Stationnary_Sample}/2 -az~{Sample_1}/2 -Distance_between_super];
      dXYZ[Region[{Cuboid_Superconductor_2}]] = Vector[0., -ay~{Stationnary_Sample}/2 , 0];
      dXYZ[Region[{Cuboid_Superconductor_3}]] = Vector[-ax~{Stationnary_Sample}/2 + ax~{Sample_3}/2, ay~{Sample_3}/2,  +az~{Stationnary_Sample}/2 +az~{Sample_3}/2 + Distance_between_super];

      dXYZ[Region[{Surface_Cuboid_Superconductor_1}]] = Vector[-ax~{Stationnary_Sample}/2 + ax~{Sample_1}/2, ay~{Sample_1}/2 , -az~{Stationnary_Sample}/2 -az~{Sample_1}/2 -Distance_between_super];
      dXYZ[Region[{Surface_Cuboid_Superconductor_2}]] = Vector[0., -ay~{Stationnary_Sample}/2 , 0];
      dXYZ[Region[{Surface_Cuboid_Superconductor_3}]] = Vector[-ax~{Stationnary_Sample}/2 + ax~{Sample_3}/2, ay~{Sample_3}/2,  +az~{Stationnary_Sample}/2 +az~{Sample_3}/2 + Distance_between_super];
    ElseIf(Bulk_Disposition == 4)
    // Not done yet
    EndIf
  ElseIf(Approach_Type == 2)
    If(Num_Super == 4)
      dXYZ[Region[{Cuboid_Superconductor_1}]] = Vector[0,0,0];
      dXYZ[Region[{Cuboid_Superconductor_2}]] = Vector[0., 0 , 0];
      dXYZ[Region[{Cuboid_Superconductor_3}]] = Vector[0, 0, 0];
      dXYZ[Region[{Cuboid_Superconductor_4}]] = Vector[0., (Approach_speed*Time_step_amplitude) , 0];

      dXYZ[Region[{Surface_Cuboid_Superconductor_1}]] = Vector[0,0,0];
      dXYZ[Region[{Surface_Cuboid_Superconductor_2}]] = Vector[0., 0 , 0];
      dXYZ[Region[{Surface_Cuboid_Superconductor_3}]] = Vector[0, 0, 0];
      dXYZ[Region[{Surface_Cuboid_Superconductor_4}]] = Vector[0., (Approach_speed*Time_step_amplitude) , 0];
    Else
      dXYZ[Region[{Cuboid_Superconductor_1}]] = Vector[-ax~{Stationnary_Sample}/2 + ax~{Sample_1}/2,-ay~{Stationnary_Sample}/2 + ay~{Sample_1}/2 +(Distance_between_super/2), -az~{Stationnary_Sample}/2 -az~{Sample_1}/2 -ContactDist_TransverseApproach];
      dXYZ[Region[{Cuboid_Superconductor_2}]] = Vector[0., -(Distance_between_super/2) , 0];
      dXYZ[Region[{Cuboid_Superconductor_3}]] = Vector[-ax~{Stationnary_Sample}/2 + ax~{Sample_3}/2, -ay~{Stationnary_Sample}/2 + ay~{Sample_3}/2 +(Distance_between_super/2),  +az~{Stationnary_Sample}/2 +az~{Sample_3}/2 + ContactDist_TransverseApproach];

      dXYZ[Region[{Surface_Cuboid_Superconductor_1}]] = Vector[-ax~{Stationnary_Sample}/2 + ax~{Sample_1}/2,-ay~{Stationnary_Sample}/2 + ay~{Sample_1}/2 +(Distance_between_super/2), -az~{Stationnary_Sample}/2 -az~{Sample_1}/2 -ContactDist_TransverseApproach];
      dXYZ[Region[{Surface_Cuboid_Superconductor_2}]] = Vector[0., -(Distance_between_super/2) , 0];
      dXYZ[Region[{Surface_Cuboid_Superconductor_3}]] = Vector[-ax~{Stationnary_Sample}/2 + ax~{Sample_3}/2, -ay~{Stationnary_Sample}/2 + ay~{Sample_3}/2 +(Distance_between_super/2),  +az~{Stationnary_Sample}/2 +az~{Sample_3}/2 + ContactDist_TransverseApproach];
    EndIf
  EndIf
Return
Macro AllOtherBulkPositionning
  If(Time_step<=(Time_step_per_cycle/2))
    //************ Definition of change in position ****************//
    If(Approach_Type == 1)
      dXYZ[Region[{Cuboid_Superconductor_1}]] = Vector[0.,0 , ((Approach_speed*Time_step_amplitude))];
      dXYZ[Region[{Cuboid_Superconductor_2}]] = Vector[0., 0 , 0];
      dXYZ[Region[{Cuboid_Superconductor_3}]] = Vector[0., 0 , -((Approach_speed*Time_step_amplitude))];

      dXYZ[Region[{Surface_Cuboid_Superconductor_1}]] = Vector[0.,0 , ((Approach_speed*Time_step_amplitude))];
      dXYZ[Region[{Surface_Cuboid_Superconductor_2}]] = Vector[0., 0 , 0];
      dXYZ[Region[{Surface_Cuboid_Superconductor_3}]] = Vector[0., 0 , -((Approach_speed*Time_step_amplitude))];

      If(Num_Super == 4)
        dXYZ[Region[{Cuboid_Superconductor_4}]] = Vector[0., 0 , 0];
        dXYZ[Region[{Surface_Cuboid_Superconductor_4}]] = Vector[0., 0 , 0];
      EndIf
    ElseIf(Approach_Type == 2)
      If(Num_Super == 4)
        dXYZ[Region[{Cuboid_Superconductor_1}]] = Vector[0,0,0];
        dXYZ[Region[{Cuboid_Superconductor_2}]] = Vector[0., 0 , 0];
        dXYZ[Region[{Cuboid_Superconductor_3}]] = Vector[0, 0, 0];
        dXYZ[Region[{Cuboid_Superconductor_4}]] = Vector[0., (Approach_speed*Time_step_amplitude) , 0];

        dXYZ[Region[{Surface_Cuboid_Superconductor_1}]] = Vector[0,0,0];
        dXYZ[Region[{Surface_Cuboid_Superconductor_2}]] = Vector[0., 0 , 0];
        dXYZ[Region[{Surface_Cuboid_Superconductor_3}]] = Vector[0, 0, 0];
        dXYZ[Region[{Surface_Cuboid_Superconductor_4}]] = Vector[0., (Approach_speed*Time_step_amplitude) , 0];
      Else
        dXYZ[Region[{Cuboid_Superconductor_1}]] = Vector[0.,-(Approach_speed*Time_step_amplitude)/2 , 0];
        dXYZ[Region[{Cuboid_Superconductor_2}]] = Vector[0., (Approach_speed*Time_step_amplitude)/2 , 0];
        dXYZ[Region[{Cuboid_Superconductor_3}]] = Vector[0., -(Approach_speed*Time_step_amplitude)/2 , 0];

        dXYZ[Region[{Surface_Cuboid_Superconductor_1}]] = Vector[0.,-(Approach_speed*Time_step_amplitude)/2 , 0];
        dXYZ[Region[{Surface_Cuboid_Superconductor_2}]] = Vector[0., (Approach_speed*Time_step_amplitude)/2 , 0];
        dXYZ[Region[{Surface_Cuboid_Superconductor_3}]] = Vector[0., -(Approach_speed*Time_step_amplitude)/2 , 0];
      EndIf
    ElseIf(Approach_Type == 3)
      // Not done yet
    EndIf
  Else
    If(Active_approach == 1)
      If(Approach_Type == 1)
        dXYZ[Region[{Cuboid_Superconductor_1}]] = Vector[0.,0 , -(Approach_speed*Time_step_amplitude)];
        dXYZ[Region[{Cuboid_Superconductor_2}]] = Vector[0., 0 , 0];
        dXYZ[Region[{Cuboid_Superconductor_3}]] = Vector[0., 0 , (Approach_speed*Time_step_amplitude)];

        dXYZ[Region[{Surface_Cuboid_Superconductor_1}]] = Vector[0.,0 , -(Approach_speed*Time_step_amplitude)];
        dXYZ[Region[{Surface_Cuboid_Superconductor_2}]] = Vector[0., 0 , 0];
        dXYZ[Region[{Surface_Cuboid_Superconductor_3}]] = Vector[0., 0 , (Approach_speed*Time_step_amplitude)];
        If(Num_Super == 4)
          dXYZ[Region[{Cuboid_Superconductor_4}]] = Vector[0., 0 , 0];

          dXYZ[Region[{Surface_Cuboid_Superconductor_4}]] = Vector[0., 0 , 0];
        EndIf
      ElseIf(Approach_Type == 2)
        If(Num_Super == 4)
          dXYZ[Region[{Cuboid_Superconductor_1}]] = Vector[0,0,0];
          dXYZ[Region[{Cuboid_Superconductor_2}]] = Vector[0., 0 , 0];
          dXYZ[Region[{Cuboid_Superconductor_3}]] = Vector[0, 0, 0];
          dXYZ[Region[{Cuboid_Superconductor_4}]] = Vector[0., (Approach_speed*Time_step_amplitude) , 0];

          dXYZ[Region[{Surface_Cuboid_Superconductor_1}]] = Vector[0,0,0];
          dXYZ[Region[{Surface_Cuboid_Superconductor_2}]] = Vector[0., 0 , 0];
          dXYZ[Region[{Surface_Cuboid_Superconductor_3}]] = Vector[0, 0, 0];
          dXYZ[Region[{Surface_Cuboid_Superconductor_4}]] = Vector[0., (Approach_speed*Time_step_amplitude) , 0];
        Else
          dXYZ[Region[{Cuboid_Superconductor_1}]] = Vector[0.,(Approach_speed*Time_step_amplitude)/2 , 0];
          dXYZ[Region[{Cuboid_Superconductor_2}]] = Vector[0., -(Approach_speed*Time_step_amplitude)/2 , 0];
          dXYZ[Region[{Cuboid_Superconductor_3}]] = Vector[0., (Approach_speed*Time_step_amplitude)/2 , 0];

          dXYZ[Region[{Surface_Cuboid_Superconductor_1}]] = Vector[0.,(Approach_speed*Time_step_amplitude)/2 , 0];
          dXYZ[Region[{Surface_Cuboid_Superconductor_2}]] = Vector[0., -(Approach_speed*Time_step_amplitude)/2 , 0];
          dXYZ[Region[{Surface_Cuboid_Superconductor_3}]] = Vector[0., (Approach_speed*Time_step_amplitude)/2 , 0];
        EndIf
      ElseIf(Approach_Type == 3)
        // Not done yet
      EndIf
    ElseIf(Active_approach == 2)
      dXYZ[Region[{Cuboid_Superconductor_1}]] = Vector[0., 0 , 0];
      dXYZ[Region[{Cuboid_Superconductor_2}]] = Vector[0., 0 , 0];
      dXYZ[Region[{Cuboid_Superconductor_3}]] = Vector[0., 0 , 0];

      dXYZ[Region[{Surface_Cuboid_Superconductor_1}]] = Vector[0., 0 , 0];
      dXYZ[Region[{Surface_Cuboid_Superconductor_2}]] = Vector[0., 0 , 0];
      dXYZ[Region[{Surface_Cuboid_Superconductor_3}]] = Vector[0., 0 , 0];
    EndIf
  EndIf
Return
Macro ReadFirstInitialCondition
  If(formulation == a_formulation)  // Use preferably the coupled formulation.
    GmshRead[ initialConditionFile_a1,1];
    GmshRead[ initialConditionFile_a2,2];
    GmshRead[ initialConditionFile_a3,3];
    a_fromFile[Cuboid_Superconductor_1] = VectorField[XYZ[]-dXYZ[]]{1};
    a_fromFile[Cuboid_Superconductor_2] = VectorField[XYZ[]-dXYZ[]]{2};	// Real initial condition

    If((Modelled_Samples == 1)||(Modelled_Samples == 3))
      If((Num_Super == 4)&&(Approach_Type == 2))
        a_fromFile[Cuboid_Superconductor_3] = VectorField[XYZ[]-dXYZ[]]{3};
      Else
        a_fromFile[Cuboid_Superconductor_3] = -VectorField[XYZ[]-dXYZ[]]{3};// Minus sign for ST or Qualitative Bulk, at first step !!!!!!!!!
      EndIf
    ElseIf(Modelled_Samples == 2)
      a_fromFile[Cuboid_Superconductor_3] = VectorField[XYZ[]-dXYZ[]]{3};
    EndIf
    If((Num_Super == 4))
      GmshRead[ initialConditionFile_a4,4];
      a_fromFile[Cuboid_Superconductor_4] = VectorField[XYZ[]-dXYZ[]]{4}; // Real initial condition
      // a_fromFile[Cuboid_Superconductor_4] = Vector[0, 0, 0];	// TEST
    EndIf
  ElseIf(formulation == coupled_formulation)
    // Read a from File
    GmshRead[ initialConditionFile_a1,1];
    GmshRead[ initialConditionFile_a2,2];
    GmshRead[ initialConditionFile_a3,3];
    // Read h from file
    GmshRead[ initialConditionFile_h1,4];
    GmshRead[ initialConditionFile_h2,5];
    GmshRead[ initialConditionFile_h3,6];

    a_fromFile[Surface_Cuboid_Superconductor_1] = VectorField[XYZ[]-dXYZ[]]{1};
    h_fromFile[Cuboid_Superconductor_1] = VectorField[XYZ[]-dXYZ[]]{4};
    a_fromFile[Surface_Cuboid_Superconductor_2] = VectorField[XYZ[]-dXYZ[]]{2};	// Real initial condition
    h_fromFile[Cuboid_Superconductor_2] = VectorField[XYZ[]-dXYZ[]]{5};	// Real initial condition

    // a_fromFile[Surface_Cuboid_Superconductor_2] = Vector[0, 0, 0];					// To see only the impact of the assembly process in the central bulk
    // h_fromFile[Cuboid_Superconductor_2] = Vector[0, 0, 0];					// To see only the impact of the assembly process in the central bulk
    If((Modelled_Samples == 1)||(Modelled_Samples == 3))
      If((Num_Super == 4)&&(Approach_Type == 2))
        a_fromFile[Surface_Cuboid_Superconductor_3] = VectorField[XYZ[]-dXYZ[]]{3};
        h_fromFile[Cuboid_Superconductor_3] = VectorField[XYZ[]-dXYZ[]]{6};
      Else
        a_fromFile[Surface_Cuboid_Superconductor_3] = -VectorField[XYZ[]-dXYZ[]]{3};// Minus sign for ST or Qualitative Bulk, at first step !!!!!!!!!
        h_fromFile[Cuboid_Superconductor_3] = -VectorField[XYZ[]-dXYZ[]]{6};// Minus sign for ST or Qualitative Bulk, at first step !!!!!!!!!
      EndIf
    ElseIf(Modelled_Samples == 2)
      a_fromFile[Surface_Cuboid_Superconductor_3] = VectorField[XYZ[]-dXYZ[]]{3};
      h_fromFile[Cuboid_Superconductor_3] = VectorField[XYZ[]-dXYZ[]]{6};
    EndIf
    If((Num_Super == 4))
      a_fromFile[Surface_Cuboid_Superconductor_4] = VectorField[XYZ[]-dXYZ[]]{2}; // Real initial condition
      h_fromFile[Cuboid_Superconductor_4] = VectorField[XYZ[]-dXYZ[]]{5}; // Real initial condition
    EndIf
  EndIf
Return
Macro ReadAllOtherInitialCondition
  If(formulation == a_formulation)
    GmshRead[initialConditionFile_a];
    a_fromFile[Cuboid_Superconductor_1] =   VectorField[XYZ[]-dXYZ[]];
    a_fromFile[Cuboid_Superconductor_2] =   VectorField[XYZ[]-dXYZ[]];
    a_fromFile[Cuboid_Superconductor_3] =   VectorField[XYZ[]-dXYZ[]];
    If(Num_Super == 4)
      a_fromFile[Cuboid_Superconductor_4] =   VectorField[XYZ[]-dXYZ[]];
    EndIf
  ElseIf(formulation == h_formulation)
    h_fromFile[] = VectorField[XYZ[]]{42}; // We do not convect the field but we add the v/\B term in the formulation. Not recommended, because require a projection between different mesh.
  ElseIf(formulation == coupled_formulation) // Best formulation to do what we want.
    GmshRead[initialConditionFile_a,1];
    GmshRead[initialConditionFile_h,2];
    a_fromFile[Surface_Cuboid_Superconductor_1] =   VectorField[XYZ[]-dXYZ[]]{1};
    a_fromFile[Surface_Cuboid_Superconductor_2] =   VectorField[XYZ[]-dXYZ[]]{1};
    a_fromFile[Surface_Cuboid_Superconductor_3] =   VectorField[XYZ[]-dXYZ[]]{1};

    h_fromFile[Cuboid_Superconductor_1] =   VectorField[XYZ[]-dXYZ[]]{2};
    h_fromFile[Cuboid_Superconductor_2] =   VectorField[XYZ[]-dXYZ[]]{2};
    h_fromFile[Cuboid_Superconductor_3] =   VectorField[XYZ[]-dXYZ[]]{2};
    If(Num_Super == 4)
      a_fromFile[Surface_Cuboid_Superconductor_4] =   VectorField[XYZ[]-dXYZ[]]{1};
      h_fromFile[Cuboid_Superconductor_4] =   VectorField[XYZ[]-dXYZ[]]{2};
    EndIf
  EndIf
Return

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
    // ------- PARAMETERS -------
    // Superconductor parameters
    DefineConstant [ec = 1e-4]; // Critical electric field [V/m]
	  For i In {1:Num_Super} // Full Bulk: 2.2977 Stacked Tapes : 1.5312*1e8 (Adjusted after Bobine Zoubir) (2.2977*0.3962*1.9083*0.8814) ||| Cutted Sample: 3.1786*1e8
    		If(Modelled_Samples==1) // Qualitative Bulk
      			jc_Base_1 = 2.6133*1e8;
      			jc_Base_2 = 2.6133*1e8;
      			jc_Base_3 = 2.6133*1e8;
      			jc_Base_4 = 2.6133*1e8;
      			jc_Base_5 = 2.6133*1e8;
      			jc_Base_6 = 3.1786*1e8;
    		ElseIf(Modelled_Samples == 3)// Stacked tapes
      			jc_Base_1 = 1.7417*1e8;
      			jc_Base_2 = 1.7417*1e8;
      			jc_Base_3 = 1.7417*1e8;
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
    		DefineConstant[ jc~{i} = {jc_Base~{i}, Highlight "LightGreen", Name Sprintf("1Input/3Material Properties/2jc Sample%g (Am⁻²)",i), Visible 1}]; // Critical current density [A/m2] QUALITATIVE BULKS : 2.2977*1e8, STACK TAPES : 1.3037*1e8
    		DefineConstant [n~{i} = {n_Base~{i}, Highlight "LightGreen", Name Sprintf("1Input/3Material Properties/1n Sample%g(-)",i)}];	// Superconductor exponent (n) value [-]
    		jc[Cuboid_Superconductor~{i}] = jc~{i};
    		n[Cuboid_Superconductor~{i}] = n~{i};

    		// Kim's model for anisotropy : Jc(B) = Jc0/(1+(||B||/B0)); n(B) = n1 + (n0-n1)/(1+(||B||/B0))
    		DefineConstant[ jc0~{i} = {4.5061*1e8, Highlight "LightGreen", Name Sprintf("1Input/3Material Properties/5jc Sample%g (Am⁻²) (Kim's model)",i), Visible Flag_JcB}]; // Critical current density [A/m2] QUALITATIVE BULKS : 2.2977*1e8, STACK TAPES : 1.3037*1e8
    		DefineConstant [n0~{i} = {20, Highlight "LightGreen", Name Sprintf("1Input/3Material Properties/6n0 Sample%g(-) (Kim's model)",i), Visible Flag_JcB}];
    		DefineConstant [n1~{i} = {20, Highlight "LightGreen", Name Sprintf("1Input/3Material Properties/7n1 Sample%g(-) (Kim's model)",i), Visible Flag_JcB}];
    		DefineConstant [B0~{i} = {0.5, Highlight "LightGreen", Name Sprintf("1Input/3Material Properties/8B0 Sample%g(-) (Kim's model)",i), Visible Flag_JcB}];
    		jc0[Cuboid_Superconductor~{i}] = jc0~{i};
    		n0[Cuboid_Superconductor~{i}] = n0~{i};
    		n1[Cuboid_Superconductor~{i}] = n1~{i};
    		B0[Cuboid_Superconductor~{i}] = B0~{i};
	  EndFor
	// Parameters for anisotropy
	If(Num_Super == 1)
    	DefineConstant[ C_Axis_1 = {3, Highlight "LightGreen", Choices{
    		1="1 : x",
    		2="2 : y",  // Central sample
    		3="3 : z"}, // Peripheral sample
    	Name Sprintf("1Input/3Material Properties/3C-axis Sample1 Number"), Visible 1}];
	ElseIf(Num_Super == 2)
  		C_Axis_Base_1 = 2;
  		C_Axis_Base_2 = 0;
  		For i In {1:Num_Super}
    			DefineConstant[ C_Axis~{i} = {C_Axis_Base~{i}, Highlight "LightGreen" , Choices{
    				1="1 : x",
    				2="2 : y",
    				3="3 : z",
    				0="No Anisotropy"},
    			Name Sprintf("1Input/3Material Properties/3C-axis Sample%g Number", i), Visible 1}];
  		EndFor
  Else
  		C_Axis_Base_1 = 3;
  		C_Axis_Base_2 = 2;
  		C_Axis_Base_3 = 3;
  		C_Axis_Base_4 = 0;
  		C_Axis_Base_5 = 2;
  		C_Axis_Base_6 = 2;
  		For i In {1:Num_Super}
    			DefineConstant[ C_Axis~{i} = {C_Axis_Base~{i}, Highlight "LightGreen", Choices{
    				1="1 : x",
    				2="2 : y",
    				3="3 : z"},
    			Name Sprintf("1Input/3Material Properties/3C-axis Sample%g Number", i), Visible 1}];
  		EndFor
	EndIf

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
  If(Active_approach==0)
  		DefineConstant [Flag_Source = {2, Highlight "yellow", Choices{
  			1="Ramp up and down",
  			2="Ramp up, down and flux creep",
  			3="No source => For modelling motion",
        4="Constant background field",
        5="Ramp Down",
        6="Rotating field"}, Name "1Input/4Source/0Source field type" }];
  Else
  		DefineConstant [Flag_Source = {3, Visible 0, Highlight "yellow", Choices{
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
  DefineConstant [partLength = {5, Visible (Flag_Source != 0 && (Active_approach==0 || Active_approach==2)), Name "1Input/4Source/1Ramp duration (s)"}];
  DefineConstant [timeFinal = (Flag_Source == 0) ? 5/(4*f) : (Flag_Source == 1) ? 5*partLength : (Flag_Source == 2) ? 7500 : (Flag_Source == 3) ? 2700 : (Active_approach == 2) ? 2700 : 3*partLength]; // Final time for source definition [s]
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

	// Hall sensor position
	Hall_sensor3 = {1e-5, 0 ,az~{Sample_1}/2 + 0.0005};
	Hall_sensor5 = {0.01, 0 ,az~{Sample_1}/2 + 0.0005};

  DefineFunction [I, js, hsVal];
  mu0 = 4*Pi*1e-7; // [H/m]
  nu0 = 1.0/mu0; // [m/H]

	If(Active_approach == 1)
		  Velocity[Cuboid_Superconductor_1] = Vector[0, 0, Approach_speed]; // Useful only if we do not convect fields and add the term v/\B (/!\ define it for all samples in the geometry!)
	Else
		  Velocity[] = Vector[0, 0, 0];
	EndIf

	Str_Directory_Code = "C:\Users\Administrator\Desktop\Michel\WP1\Test_Moving_Super\Cuboid_Superconductors";
	// Projection parameters
	If(Time_step==1 && Cycle==1) // First step
  		// For projection
  		If(Num_Super == 3 || Num_Super == 4)
    			//************ Definition of the position of each bulk w.r.t. their position in the Z.F.C. individual magnetization ****************//
    			Call FirstBulkPositionning; // definition of dXYZ[] for each

    			//************ Selection of the initial condition File Depending on the considered modelled samples ****************//
    			Call InitialFileSelection; // Change this and define your own initial condition file if needed

          //************ Read the initial condition and store it correctly in a variable used in the formulation. ****************//
          Call ReadFirstInitialCondition;
		  Else
      		// MAGNETISATION ONLY, Whatever From File, except for test
      			initialConditionFile_Cylinder1_h = StrCat[Str_Directory_Code,"\IniCond_coupled_formulation\hfield_CentralEch_LcCube_0_000",Str_LcCube,".pos"];
      			// initialConditionFile_Cylinder1_h = StrCat[Str_Directory_Code,"\IniCond_coupled_formulation\Last_computed_h.pos"];
      			GmshRead[initialConditionFile_Cylinder1_h,43];
      			h_fromFile[Super] = VectorField[XYZ[]]{43};

      			initialConditionFile_Cylinder1_a = StrCat[Str_Directory_Code,"\IniCond_coupled_formulation\afield_CentralEch_LcCube_0_000",Str_LcCube,".pos"];
      			// initialConditionFile_Cylinder1_a = StrCat[Str_Directory_Code,"\IniCond_coupled_formulation\Last_computed_a.pos"];
      			GmshRead[initialConditionFile_Cylinder1_a,44];
      			a_fromFile[Surface_Superconductors] = VectorField[XYZ[]]{44};
		  EndIf
	Else	// All other steps
  		If(Num_Super == 3 || Num_Super == 4)
          //************ Definition of the position of each bulk w.r.t. their position in the Z.F.C. individual magnetization ****************//
            Call AllOtherBulkPositionning;

          //************ Selection of the initial condition File ****************//
      			// For projection of a
      			initialConditionFile_a = StrCat[Str_Directory_Code,"\Last_computed_a.pos"];
      			initialConditionFile_j = StrCat[Str_Directory_Code,"\Last_computed_j.pos"];
      			initialConditionFile_h = StrCat[Str_Directory_Code,"\Last_computed_h.pos"];
      			// MVT h formulation, !!!!!!!!!! give correct File !!!!!!!!!! (Not recommended, because require a projection between different mesh).
      			initialConditionFile_WholeDomain = StrCat[Str_Directory_Code,"\Last_computed_h.pos"];
      			GmshRead[initialConditionFile_WholeDomain,42];

            //************ Read the initial condition and store it correctly in a variable used in the formulation. ****************//
      			Call ReadAllOtherInitialCondition;
  		Else
      			dXYZ[] = Vector[0., 0 , 0];
      			// For projection of a
      			initialConditionFile_a = StrCat[Str_Directory_Code,"\Last_computed_a.pos"];
      			initialConditionFile_h = StrCat[Str_Directory_Code,"\Last_computed_h.pos"];
      			GmshRead[initialConditionFile_a,51];
      			GmshRead[initialConditionFile_h,52];
      			a_fromFile[Surface_Cuboid_Superconductor_1] =   VectorField[XYZ[]]{51};
      			h_fromFile[Cuboid_Superconductor_1] =   VectorField[XYZ[]]{52};
  		EndIf
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
				// { Region Omega ; Type InitFromResolution ; NameOfResolution ProjectionInit ; }
			EndIf
        }
    }
    { Name h ;
        Case {
			If((Active_approach==1|| Active_approach == 2) || Flag_Test_projection == 1)
					// { Region Omega ; Type InitFromResolution ; NameOfResolution ProjectionInit ; }
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
                EndIf
        				If(Active_approach==0)
          					Print[ j, OnElementsOf OmegaC , File "res/j.pos", Name "j [A/m2]" ];
          					Print[ e, OnElementsOf OmegaC , File "res/e.pos", Name "e [V/m]" ];
          					Print[ b, OnElementsOf Omega , File "res/b.pos", Name "b [T]" ];
            				If(formulation == coupled_formulation)
            						Print[ a, OnElementsOf Omega_a , File "res/a.pos", Name "a" ];
            				EndIf
        		    EndIf
            EndIf
      			If(Save_later == 1) // Exports for MATLAB plot
        				Print[ b, OnElementsOf Omega , File StrCat["res/For_Matlab/b_",Str_step,".pos"], Format Gmsh, OverrideTimeStepValue Time_step, LastTimeStepOnly];
        				Print[ j, OnElementsOf Omega, File StrCat["res/For_Matlab/j_wholedomain",Str_step,".pos"], Format Gmsh, OverrideTimeStepValue Time_step, LastTimeStepOnly];
        				If(Num_Super == 3 || Num_Super == 4)
          					// Save the field a, h and j at current step
          					If(formulation == a_formulation)
          						Print[ a, OnElementsOf Omega_a, File StrCat["res/For_Matlab/Save_afield_",Str_step,".pos"],Format Gmsh, OverrideTimeStepValue 0, LastTimeStepOnly, SendToServer "No"] ;
          					ElseIf(formulation == h_formulation)
          						Print[ h, OnElementsOf Omega_h, File StrCat["res/For_Matlab/Save_hfield_",Str_step,".pos"],Format Gmsh, OverrideTimeStepValue 0, LastTimeStepOnly, SendToServer "No"] ;
          					ElseIf(formulation == coupled_formulation)
          						Print[ a, OnElementsOf Omega_a, File StrCat["res/For_Matlab/Save_afield_",Str_step,".pos"],Format Gmsh, OverrideTimeStepValue 0, LastTimeStepOnly, SendToServer "No"] ;
          						Print[ h, OnElementsOf Omega_h, File StrCat["res/For_Matlab/Save_hfield_",Str_step,".pos"],Format Gmsh, OverrideTimeStepValue 0, LastTimeStepOnly, SendToServer "No"] ;
                      // Magnetic moment and force of each sample
                    For i In {1:Num_Super}
                        Str_Sample = Sprintf("%g", i);
                        Print[ mSample~{i}, OnRegion Cuboid_Superconductor~{i}, Format Table , File StrCat["res/For_Matlab/m_Step",Str_step,"_Sample",Str_Sample,".txt"]];
                        Print[ f~{i}[Air], OnGlobal, Format Table, File StrCat["res/For_Matlab/F_Step",Str_step,"_Sample",Str_Sample,".txt"]  ];
                    EndFor
                    EndIf
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
