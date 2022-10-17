x_Bottom_Super_courant = x_Bottom_Super;
y_Bottom_Super_courant = y_Bottom_Super;
z_Bottom_Super_courant = z_Bottom_Super;
// ******************* Bulks Definition ******************* //
For i In {1:Num_Super}
	materialVol~{i} = i*100;
	If((True_Numbering~{i} == 3)) 
		// Central Bulk
		Block(materialVol~{i}) = {x_Bottom_Super_courant, y_Bottom_Super_courant, z_Bottom_Super_courant, ax~{Sample~{i}}, ay~{Sample~{i}}, az~{Sample~{i}}};     // No offset in position along y
	ElseIf(True_Numbering~{i} == 6) 
		// Supplementary Bulk
		If(Approach_Type == 1)
			// Approach along the axis of the array
			Block(materialVol~{i}) = {x_Bottom_Super_courant-((ax~{Sample~{4}}-ax~{Sample~{2}})/2), y_Bottom_Super_courant+ay~{Stationnary_Sample}+Initial_Dist_Sample_Sup, z_Bottom_Super_6-((az~{Sample~{4}}-az~{Sample~{2}})/2), ax~{Sample~{i}}, ay~{Sample~{i}}, az~{Sample~{i}}};     // No offset in position along y
		ElseIf(Approach_Type == 2)
			// Retract perpendicularly to the axis of the array
			Block(materialVol~{i}) = {x_Bottom_Super_courant-((ax~{Sample~{4}}-ax~{Sample~{2}})/2), y_Bottom_Super_courant+ay~{Stationnary_Sample}+Distance_between_super, z_Bottom_Super_6-((az~{Sample~{4}}-az~{Sample~{2}})/2), ax~{Sample~{i}}, ay~{Sample~{i}}, az~{Sample~{i}}};
		EndIf
	ElseIf((True_Numbering~{i} == 2)||(True_Numbering~{i} == 4)) 
		// Peripheral samples
		Block(materialVol~{i}) = {x_Bottom_Super_courant, y_Bottom_Super_courant, z_Bottom_Super_courant, ax~{Sample~{i}}, ay~{Sample~{i}}, az~{Sample~{i}}};     // No offset in position along y
	EndIf
	
	// Surfaces, lines and points of the current sample
	f_c~{i}() = Boundary{Volume{materialVol~{i}};};
	l_c~{i}() = Boundary{Surface{f_c~{i}()};};
	p_c~{i}() = PointsOf{Line{l_c~{i}()};};
	Characteristic Length{p_c~{i}()} = LcCube;

	// Surfaces, lines and points of the superconducting domain
	MaterialVol_Tot() += {materialVol~{i}};
	f_c_Tot() += {f_c~{i}()};
	l_c_Tot() += {l_c~{i}()};
	p_c_Tot() += {p_c~{i}()};

	// Quad Mesh in superconducting domain
	Transfinite Surface((i)*6+1);
	Transfinite Surface((i)*6+2);
	Transfinite Surface((i)*6+3);
	Transfinite Surface((i)*6+4);
	Transfinite Surface((i)*6+5);
	Transfinite Surface((i)*6+6);
	Transfinite Volume(materialVol~{i});
	//*
	Recombine Surface((i)*6+1);
	Recombine Surface((i)*6+2);
	Recombine Surface((i)*6+3);
	Recombine Surface((i)*6+4);
	Recombine Surface((i)*6+5);
	Recombine Surface((i)*6+6);

	If(Approach_Type == 1) 
		// Approach along z
		z_Bottom_Super_courant = z_Bottom_Super_courant + az~{Sample~{i}} + Distance_between_super;
	ElseIf(Approach_Type == 2)
		// Constant position along z
		z_Bottom_Super_courant = z_Bottom_Super_courant + az~{Sample~{i}} + ContactDist_TransverseApproach;
	EndIf
EndFor