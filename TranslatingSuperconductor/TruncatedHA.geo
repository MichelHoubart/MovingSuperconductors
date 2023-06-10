SetFactory("OpenCASCADE");
//**** Temporary definition of variable ****//
/* Num_Super = 3;
NbElemCube = 12;
DefineConstant[ Distance_between_super = {0.01, Highlight "LightYellow", Name "3Bulks Motion/Input/1Distance between super", Visible 1}];
For i In {1:Num_Super}
			ax~{Sample~{i}} = 0.013;
			ay~{Sample~{i}} = 0.013;
			az~{Sample~{i}} = 0.013;
EndFor
x_Bottom_Super = -(ax~{1}/2);
y_Bottom_Super = -(ay~{1}/2);
z_Bottom_Super = -3*(az~{1}/2)-Distance_between_super;

Air_Lx =  0.15;
Air_Ly =  0.15;
Air_Lz =  0.15;
AIR = 2000;
airVol = 1234; */

//**** Creation of Truncated Halbach array ****//
If(Num_Super==1)
	If(Sample_1==41)
		i=1;
		Include "HalfCube.geo";
	ElseIf(Sample_1==42)
		Block(materialVol~{i}) = {x_Bottom_Super, y_Bottom_Super, z_Bottom_Super, ax~{Sample~{i}}, ay~{Sample~{i}}, az~{Sample~{i}}};
	ElseIf(Sample_1==43)
		i=3;
		Include "HalfCube.geo";
	EndIf
ElseIf(Num_Super==3)
	For i In {1:Num_Super}
		  LcCube = ax~{Sample~{i}}/NbElemCube; // Mesh size in superconductors [m]
			materialVol~{i} = i*100;
			If((i == 1)||(i == 3))
					// Peripheral sample
					Include "HalfCube.geo";
			ElseIf(i == 2)
					// Central sample
					Block(materialVol~{i}) = {x_Bottom_Super, y_Bottom_Super, z_Bottom_Super, ax~{Sample~{i}}, ay~{Sample~{i}}, az~{Sample~{i}}};     // No offset in position along y
			EndIf

			//**** Handle different tags and the mesh ****//
			If((i == 1)||(i == 3))
					// Peripheral samples
					f_c~{i}() = Boundary{Volume{materialVol~{i}[1]};};
					l_c~{i}() = Boundary{Surface{f_c~{i}()};};
					p_c~{i}() = PointsOf{Line{l_c~{i}()};};
					Characteristic Length{p_c~{i}()} = LcCube;
					MaterialVol_Tot() += {materialVol~{i}[1]};
					f_c_Tot() += {f_c~{i}()};
					l_c_Tot() += {l_c~{i}()};
					p_c_Tot() += {p_c~{i}()};
			ElseIf(i == 2)
					// Central Sample
					f_c~{i}() = Boundary{Volume{materialVol~{i}};};
					l_c~{i}() = Boundary{Surface{f_c~{i}()};};
					p_c~{i}() = PointsOf{Line{l_c~{i}()};};
					Characteristic Length{p_c~{i}()} = LcCube;
					MaterialVol_Tot() += {materialVol~{i}};
					f_c_Tot() += {f_c~{i}()};
					l_c_Tot() += {l_c~{i}()};
					p_c_Tot() += {p_c~{i}()};
					/* Printf("Central ech: %g", -f_c~{i}(0)); */

					// Structured mesh in cube
					Transfinite Surface(-f_c~{i}(0));
					Transfinite Surface(-f_c~{i}(0)+1);
					Transfinite Surface(-f_c~{i}(0)+2);
					Transfinite Surface(-f_c~{i}(0)+3);
					Transfinite Surface(-f_c~{i}(0)+4);
					Transfinite Surface(-f_c~{i}(0)+5);
					Transfinite Volume(materialVol~{i});
					Recombine Surface(-f_c~{i}(0));
					Recombine Surface(-f_c~{i}(0)+1);
					Recombine Surface(-f_c~{i}(0)+2);
					Recombine Surface(-f_c~{i}(0)+3);
					Recombine Surface(-f_c~{i}(0)+4);
					Recombine Surface(-f_c~{i}(0)+5);
			EndIf
			z_Bottom_Super = z_Bottom_Super + az~{Sample~{i}} + Distance_between_super;
	EndFor
EndIf


//**** Creation of the air volume ****//
/* Block(airVol) = {-Air_Lx/2, -Air_Ly/2, -Air_Lz/2, Air_Lx, Air_Ly, Air_Lz};
volAir = BooleanDifference{ Volume{airVol}; Delete; }{ Volume{MaterialVol_Tot()};};
Physical Volume("Air", AIR) = {volAir}; */
