SetFactory("OpenCASCADE");
// Include cross data
Include "Cuboid_Superconductors_data.pro";
Include "Sample_Characteristics.pro";

// Definition of the air volume
airVol = 1234;
Block(airVol) = {-Air_Lx/2, -Air_Ly/2, -Air_Lz/2, Air_Lx, Air_Ly, Air_Lz};

// Starting point of the first cuboid (x and y dir --> same whatever if we consider one or two superconductors)

// Creation of the Bulk(s), their initial positions depend both on the chosen displacement type and on the disposition chosen.
Include "RotatingSuper.geo";

volAir = BooleanDifference{ Volume{airVol}; Delete; }{ Volume{MaterialVol_Tot()};};
Physical Volume("Air", AIR) = {volAir};

//****************** Volume and Physical definition ******************//

Physical Surface("Boundary material", BND_MATERIAL) = {f_c_Tot()};
f_s() = Boundary{Volume{volAir};};
l_s() = Boundary{Surface{f_s(0),f_s(1),f_s(2),f_s(3),f_s(4),f_s(5)};};
p_s() = PointsOf{Line{l_s()};};
Characteristic Length{p_s()} = LcAir;
Physical Surface("Boundary air", SURF_OUT) = {f_s(0),f_s(1),f_s(2),f_s(3),f_s(4),f_s(5)};
For i In {1:Num_Super}
	Physical Volume(Sprintf("Bulk %g", i), BULK~{i}) = {materialVol~{i}()};
	Physical Surface(Sprintf("Boundary Bulk %g", i), Boundary_BULK~{i}) = {f_c~{i}()};
EndFor

Px = 0;
Py = 0.006;
Pz = 0;

Color SkyBlue {Surface{f_s(0),f_s(1),f_s(2),f_s(3),f_s(4),f_s(5)};}
Color Black {Surface{f_c_Tot()};}
