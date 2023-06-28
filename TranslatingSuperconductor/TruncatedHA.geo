 /* SetFactory("OpenCASCADE"); */
If(Num_Super==1)
//****************** Individual magnetization of the sample in the THA ******************//
  i=1;
	LcCube = ax~{Sample~{i}}/NbElemCube;
  // Add the geometry of a single sample
	If(Sample_1==41)
		IdPositionInTHA = 1;
		Include "HalfCube.geo";
	ElseIf(Sample_1==42)
    IdPositionInTHA = 2;
    materialVol~{i} = newv;
		Block(materialVol~{i}) = {x_Bottom_Super, y_Bottom_Super, z_Bottom_Super, ax~{Sample~{i}}, ay~{Sample~{i}}, az~{Sample~{i}}};
	ElseIf(Sample_1==43)
		IdPositionInTHA = 3;
		Include "HalfCube.geo";
	EndIf
	// Handle the different tags
  // Certain faces are misoriented, don't know why, but it is fixed here
	If((IdPositionInTHA == 1)||(IdPositionInTHA == 3))
      f_c~{i}() = Boundary{Volume{materialVol~{i}[1]};};
      l_c~{i}() = Boundary{Surface{f_c~{i}()};};
      p_c~{i}() = PointsOf{Line{l_c~{i}()};};
      Characteristic Length{p_c~{i}()} = LcCube;
      MaterialVol_Tot() += {materialVol~{i}[1]};
      f_c_Tot() += {f_c~{i}()};
      l_c_Tot() += {l_c~{i}()};
      p_c_Tot() += {p_c~{i}()};
			// Peripheral samples faces not oriented correctly
      f_c~{i}(0) = -f_c~{i}(0);
      f_c~{i}(1) = -f_c~{i}(1);
      f_c~{i}(2) = -f_c~{i}(2);

      // Debug the orientation of the suface
      /* Printf("Periph ech: %g", f_c~{i}(0));
      Printf("Periph ech: %g", f_c~{i}(1));
      Printf("Periph ech: %g", f_c~{i}(2));
      Printf("Periph ech: %g", f_c~{i}(3));
      Printf("Periph ech: %g", f_c~{i}(4));  */
	ElseIf(IdPositionInTHA == 2)
      f_c~{i}() = Boundary{Volume{materialVol~{i}};};
      l_c~{i}() = Boundary{Surface{f_c~{i}()};};
      p_c~{i}() = PointsOf{Line{l_c~{i}()};};
      Characteristic Length{p_c~{i}()} = LcCube;
      MaterialVol_Tot() += {materialVol~{i}};
      f_c_Tot() += {f_c~{i}()};
      l_c_Tot() += {l_c~{i}()};
      p_c_Tot() += {p_c~{i}()};
      // Central sample faces not oriented correctly
      f_c~{i}(0) = -f_c~{i}(0);
      f_c~{i}(2) = -f_c~{i}(2);
      f_c~{i}(4) = -f_c~{i}(4);

      // Debug the orientation of the suface
			/* Printf("Central ech: %g", f_c~{i}(0));
      Printf("Central ech: %g", f_c~{i}(1));
      Printf("Central ech: %g", f_c~{i}(2));
      Printf("Central ech: %g", f_c~{i}(3));
      Printf("Central ech: %g", f_c~{i}(4));
      Printf("Central ech: %g", f_c~{i}(5)); */

			// Structured mesh in cube
			Transfinite Surface(f_c~{i}(0));
			Transfinite Surface(f_c~{i}(1));
			Transfinite Surface(f_c~{i}(2));
			Transfinite Surface(f_c~{i}(3));
			Transfinite Surface(f_c~{i}(4));
			Transfinite Surface(f_c~{i}(5));
			Transfinite Volume(materialVol~{i});
			Recombine Surface(f_c~{i}(0));
			Recombine Surface(f_c~{i}(1));
			Recombine Surface(f_c~{i}(2));
			Recombine Surface(f_c~{i}(3));
			Recombine Surface(f_c~{i}(4));
			Recombine Surface(f_c~{i}(5));
	EndIf

ElseIf(Num_Super==3)
//****************** Full THA geometry ******************//
	For i In {1:Num_Super}
		  IdPositionInTHA = i;
		  LcCube = ax~{Sample~{i}}/NbElemCube; // Mesh size in superconductors [m]
      // Add the geometry of a single sample
			If((i == 1)||(i == 3))
					// Peripheral sample
					Include "HalfCube.geo";
			ElseIf(i == 2)
					// Central sample
          materialVol~{i} = newv;
					Block(materialVol~{i}) = {x_Bottom_Super, y_Bottom_Super, z_Bottom_Super, ax~{Sample~{i}}, ay~{Sample~{i}}, az~{Sample~{i}}};     // No offset in position along y
			EndIf
			// Handle the different tags
      // Certain faces are misoriented, don't know why, but it is fixed here
			If((i == 1)||(i == 3))
          f_c~{i}() = Boundary{Volume{materialVol~{i}[1]};};
          l_c~{i}() = Boundary{Surface{f_c~{i}()};};
          p_c~{i}() = PointsOf{Line{l_c~{i}()};};
          Characteristic Length{p_c~{i}()} = LcCube;
          MaterialVol_Tot() += {materialVol~{i}[1]};
          f_c_Tot() += {f_c~{i}()};
          l_c_Tot() += {l_c~{i}()};
          p_c_Tot() += {p_c~{i}()};
					// Peripheral samples faces not oriented correctly
          f_c~{i}(0) = -f_c~{i}(0);
          f_c~{i}(1) = -f_c~{i}(1);
          f_c~{i}(2) = -f_c~{i}(2);

          // Debug the orientation of the suface
          /* Printf("Periph ech: %g", f_c~{i}(0));
          Printf("Periph ech: %g", f_c~{i}(1));
          Printf("Periph ech: %g", f_c~{i}(2));
          Printf("Periph ech: %g", f_c~{i}(3));
          Printf("Periph ech: %g", f_c~{i}(4)); */
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

          // Peripheral samples faces not oriented correctly
          f_c~{i}(0) = -f_c~{i}(0);
          f_c~{i}(2) = -f_c~{i}(2);
          f_c~{i}(4) = -f_c~{i}(4);

          // Debug the orientation of the suface
    			/* Printf("Central ech: %g", f_c~{i}(0));
          Printf("Central ech: %g", f_c~{i}(1));
          Printf("Central ech: %g", f_c~{i}(2));
          Printf("Central ech: %g", f_c~{i}(3));
          Printf("Central ech: %g", f_c~{i}(4));
          Printf("Central ech: %g", f_c~{i}(5)); */

          // Structured mesh in cube
    			Transfinite Surface(f_c~{i}(0));
    			Transfinite Surface(f_c~{i}(1));
    			Transfinite Surface(f_c~{i}(2));
    			Transfinite Surface(f_c~{i}(3));
    			Transfinite Surface(f_c~{i}(4));
    			Transfinite Surface(f_c~{i}(5));
    			Transfinite Volume(materialVol~{i});
    			Recombine Surface(f_c~{i}(0));
    			Recombine Surface(f_c~{i}(1));
    			Recombine Surface(f_c~{i}(2));
    			Recombine Surface(f_c~{i}(3));
    			Recombine Surface(f_c~{i}(4));
    			Recombine Surface(f_c~{i}(5));
			EndIf
      // Fix the position of the neighbouring sample
			z_Bottom_Super = z_Bottom_Super + az~{Sample~{i}} + Distance_between_super;
	EndFor
EndIf
