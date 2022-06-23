For i In {1:Num_Super}
		materialVol~{i} = i*100;
		Block(materialVol~{i}) = {x_Bottom_Super~{i}, y_Bottom_Super~{i}, z_Bottom_Super~{i}, ax~{Sample~{i}}, ay~{Sample~{i}}, az~{Sample~{i}}};
		If(Active_approach==1||Flag_Test_projection==1)
			Rotate {{1, 0, 0}, {x_Bottom_Super~{i}+ax~{Sample~{i}}/2, y_Bottom_Super~{i}+ay~{Sample~{i}}/2, z_Bottom_Super~{i}+az~{Sample~{i}}/2}, MyTheta} { Volume{materialVol~{i}};}
		EndIf
		f_c~{i}() = Boundary{Volume{materialVol~{i}};};
		l_c~{i}() = Boundary{Surface{f_c~{i}()};};
		p_c~{i}() = PointsOf{Line{l_c~{i}()};};
		Characteristic Length{p_c~{i}()} = ax~{Sample~{i}}/NbElemCube;

		MaterialVol_Tot() += {materialVol~{i}};
		f_c_Tot() += {f_c~{i}()};
		l_c_Tot() += {l_c~{i}()};
		p_c_Tot() += {p_c~{i}()};


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
	EndFor
