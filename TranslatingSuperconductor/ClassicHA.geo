For i In {1:Num_Super}
	  LcCube = ax~{Sample~{i}}/NbElemCube; // Mesh size in superconductors [m]
		materialVol~{i} = i*100;
		If(Approach_Type == 1)
			// Motion along the axis of the array
			If((True_Numbering~{i} == 2)||(True_Numbering~{i} == 4))
				// Peripheral samples
				If((Bulk_Disposition == 1)||(Bulk_Disposition == 2))
					Block(materialVol~{i}) = {x_Bottom_Super, y_Bottom_Super, z_Bottom_Super, ax~{Sample~{i}}, ay~{Sample~{i}}, az~{Sample~{i}}};     // No offset in position along y
				ElseIf(Bulk_Disposition == 3)
					Block(materialVol~{i}) = {x_Bottom_Super, 0, z_Bottom_Super, ax~{Sample~{i}}, ay~{Sample~{i}}, az~{Sample~{i}}};			      // y = 0 is the edge of sample 1 and 3
				EndIf
			ElseIf(True_Numbering~{i} == 3)
				// Central sample
				If(Bulk_Disposition == 1)
					Block(materialVol~{i}) = {x_Bottom_Super, y_Bottom_Super, z_Bottom_Super, ax~{Sample~{i}}, ay~{Sample~{i}}, az~{Sample~{i}}};     // No offset in position along y
				ElseIf((Bulk_Disposition == 2)||(Bulk_Disposition == 3))
					Block(materialVol~{i}) = {x_Bottom_Super, 2*y_Bottom_Super, z_Bottom_Super, ax~{Sample~{i}}, ay~{Sample~{i}}, az~{Sample~{i}}};   // y = 0 is the edge of sample 2
				EndIf
			Else
				// Most external samples
				Block(materialVol~{i}) = {x_Bottom_Super, y_Bottom_Super, z_Bottom_Super, ax~{Sample~{i}}, ay~{Sample~{i}}, az~{Sample~{i}}};     // No offset in position along y
			EndIf
		ElseIf(Approach_Type == 2)
			// Motion perpendicularly of the axis of the array
			If((True_Numbering~{i} == 1)||(True_Numbering~{i} == 3)||(True_Numbering~{i} == 5))
				// Central and most external samples
				Block(materialVol~{i}) = {x_Bottom_Super, y_Bottom_Super-(Distance_between_super/2), z_Bottom_Super, ax~{Sample~{i}}, ay~{Sample~{i}}, az~{Sample~{i}}};
			Else
				// Peripheral samples
				Block(materialVol~{i}) = {x_Bottom_Super, y_Bottom_Super+(Distance_between_super/2), z_Bottom_Super, ax~{Sample~{i}}, ay~{Sample~{i}}, az~{Sample~{i}}};
			EndIf
		EndIf
		f_c~{i}() = Boundary{Volume{materialVol~{i}};};
		l_c~{i}() = Boundary{Surface{f_c~{i}()};};
		p_c~{i}() = PointsOf{Line{l_c~{i}()};};
		Characteristic Length{p_c~{i}()} = LcCube;
		// Debug the orientation of the suface
		f_c~{i}(0) = -f_c~{i}(0);
	  f_c~{i}(2) = -f_c~{i}(2);
	  f_c~{i}(4) = -f_c~{i}(4);
		/* Printf("Central ech: %g", f_c~{i}(0));
		Printf("Central ech: %g", f_c~{i}(1));
		Printf("Central ech: %g", f_c~{i}(2));
		Printf("Central ech: %g", f_c~{i}(3));
		Printf("Central ech: %g", f_c~{i}(4));
		Printf("Central ech: %g", f_c~{i}(5)); */


		MaterialVol_Tot() += {materialVol~{i}};
		f_c_Tot() += {f_c~{i}()};
		l_c_Tot() += {l_c~{i}()};
		p_c_Tot() += {p_c~{i}()};

		// Samples faces not oriented correctly since New Gmsh
		f_c~{i}(0) = -f_c~{i}(0);
		f_c~{i}(2) = -f_c~{i}(2);
		f_c~{i}(4) = -f_c~{i}(4);

		// Debug the orientation of the suface
		/* Printf("Periph ech: %g", f_c~{i}(0));
		Printf("Periph ech: %g", f_c~{i}(1));
		Printf("Periph ech: %g", f_c~{i}(2));
		Printf("Periph ech: %g", f_c~{i}(3));
		Printf("Periph ech: %g", f_c~{i}(4)); */



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
		// */
		If(Approach_Type == 1)
			z_Bottom_Super = z_Bottom_Super + az~{Sample~{i}} + Distance_between_super;
		ElseIf(Approach_Type == 2)
			z_Bottom_Super = z_Bottom_Super + az~{Sample~{i}} + ContactDist_TransverseApproach;
		EndIf
	EndFor
