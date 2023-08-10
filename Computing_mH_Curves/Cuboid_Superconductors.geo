SetFactory("OpenCASCADE");
// Debug the orientation of the suface
Geometry.Normals = 0;
// Include cross data
Include "Cuboid_Superconductors_data.pro";

//****************** Definition of the air volume ******************//
airVol = 1234;
Block(airVol) = {-Air_Lx/2, -Air_Ly/2, -Air_Lz/2, Air_Lx, Air_Ly, Air_Lz};

//****************** Definition of the bulk superconductors ******************//
materialVol~{1} = 100;
Block(materialVol~{1}) = {-ax/2, -ay/2, -az/2, ax, ay, az};
i = 1;
f_c~{i}() = Boundary{Volume{materialVol~{i}};};
l_c~{i}() = Boundary{Surface{f_c~{i}()};};
p_c~{i}() = PointsOf{Line{l_c~{i}()};};
LcCube = az/NbElemCube;
Characteristic Length{p_c~{i}()} = LcCube;

MaterialVol_Tot() += {materialVol~{i}};
f_c_Tot() += {f_c~{i}()};
l_c_Tot() += {l_c~{i}()};
p_c_Tot() += {p_c~{i}()};

// Samples faces not oriented correctly since New Gmsh
f_c~{i}(0) = -f_c~{i}(0);
f_c~{i}(2) = -f_c~{i}(2);
f_c~{i}(4) = -f_c~{i}(4);

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

//****************** Volume and Physical definition ******************//
volAir = BooleanDifference{ Volume{airVol}; Delete; }{ Volume{MaterialVol_Tot()};};
Physical Volume("Air", AIR) = {volAir[0]};
Physical Surface("Boundary material", BND_MATERIAL) = {f_c_Tot()};
f_s() = Boundary{Volume{volAir};};
l_s() = Boundary{Surface{f_s(0),f_s(1),f_s(2),f_s(3),f_s(4),f_s(5)};};

// Faces not oriented correctly since New Gmsh
f_s(0) = -f_s(0);
f_s(1) = -f_s(1);
f_s(4) = -f_s(4);

// Debug the orientation of the suface
/* Printf("Boundary Air: %g", f_s(0));
Printf("Boundary Air: %g", f_s(1));
Printf("Boundary Air: %g", f_s(2));
Printf("Boundary Air: %g", f_s(3));
Printf("Boundary Air: %g", f_s(4));
Printf("Boundary Air: %g", f_s(5)); */

p_s() = PointsOf{Line{l_s()};};
Characteristic Length{p_s()} = LcAir;
Physical Surface("Boundary air", SURF_OUT) = {f_s(0),f_s(1),f_s(2),f_s(3),f_s(4),f_s(5)};
For i In {1:1}
	Physical Volume(Sprintf("Bulk %g", i), BULK~{i}) = {materialVol~{i}()};
	Physical Surface(Sprintf("Boundary Bulk %g", i), Boundary_BULK~{i}) = {f_c~{i}()};
EndFor
