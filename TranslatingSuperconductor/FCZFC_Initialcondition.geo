For i In {1:Num_Super}
  LcCube = ax~{Sample~{i}}/NbElemCube; // Mesh size in superconductors [m]
	materialVol~{i} = i*100;
	If((True_Numbering~{i} == 3))
		// Central Bulk
		Block(materialVol~{i}) = {x_Bottom_Super, y_Bottom_Super, z_Bottom_Super, ax~{Sample~{i}}, ay~{Sample~{i}}, az~{Sample~{i}}};     // No offset in position along y
	ElseIf(True_Numbering~{i} == 6)
		// Supplementary Bulk
		Block(materialVol~{i}) = {x_Bottom_Super-((ax~{Sample~{2}}-ax~{Sample~{1}})/2), y_Bottom_Super+ay~{Stationnary_Sample}+Initial_Dist_Sample_Sup, z_Bottom_Super-((az~{Sample~{2}}-az~{Sample~{1}})/2), ax~{Sample~{i}}, ay~{Sample~{i}}, az~{Sample~{i}}};     // No offset in position along y
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
EndFor
