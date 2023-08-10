SetFactory("OpenCASCADE");
// Debug the orientation of the suface
Geometry.Normals = 0;
// Include cross data
Include "Cuboid_Superconductors_data.pro";
Include "Sample_Characteristics.pro";

// Definition of the air volume
airVol = 1234;
Block(airVol) = {-Air_Lx/2, -Air_Ly/2, -Air_Lz/2, Air_Lx, Air_Ly, Air_Lz};

// Creation of the Bulk(s).
Include "RotatingSuper.geo";

volAir = BooleanDifference{ Volume{airVol}; Delete; }{ Volume{MaterialVol_Tot()};};
Physical Volume("Air", AIR) = {volAir};

// Maintain fine mesh close to superconductor
p = newp;
Point(p) = {1.5*ax~{Sample~{1}}, 1.5*ay~{Sample~{1}} , 1.5*az~{Sample~{1}},ax~{Sample~{1}}/NbElemCube};
Point(p+1) = {1.5*ax~{Sample~{1}}, -1.5*ay~{Sample~{1}} , 1.5*az~{Sample~{1}},ax~{Sample~{1}}/NbElemCube};
Point(p+2) = {1.5*ax~{Sample~{1}}, -1.5*ay~{Sample~{1}} , -1.5*az~{Sample~{1}},ax~{Sample~{1}}/NbElemCube};
Point(p+3) = {1.5*ax~{Sample~{1}}, 1.5*ay~{Sample~{1}} , -1.5*az~{Sample~{1}},ax~{Sample~{1}}/NbElemCube};

Point(p+4) = {-1.5*ax~{Sample~{1}}, 1.5*ay~{Sample~{1}} , 1.5*az~{Sample~{1}},ax~{Sample~{1}}/NbElemCube};
Point(p+5) = {-1.5*ax~{Sample~{1}}, -1.5*ay~{Sample~{1}} , 1.5*az~{Sample~{1}},ax~{Sample~{1}}/NbElemCube};
Point(p+6) = {-1.5*ax~{Sample~{1}}, -1.5*ay~{Sample~{1}} , -1.5*az~{Sample~{1}},ax~{Sample~{1}}/NbElemCube};
Point(p+7) = {-1.5*ax~{Sample~{1}}, 1.5*ay~{Sample~{1}} , -1.5*az~{Sample~{1}},ax~{Sample~{1}}/NbElemCube};

Point{p} In Volume {volAir};
Point{p+1} In Volume {volAir};
Point{p+2} In Volume {volAir};
Point{p+3} In Volume {volAir};
Point{p+4} In Volume {volAir};
Point{p+5} In Volume {volAir};
Point{p+6} In Volume {volAir};
Point{p+7} In Volume {volAir};

//****************** Volume and Physical definition ******************//

Physical Surface("Boundary material", BND_MATERIAL) = {f_c_Tot()};
f_s() = Boundary{Volume{volAir};};
l_s() = Boundary{Surface{f_s(0),f_s(1),f_s(2),f_s(3),f_s(4),f_s(5)};};
p_s() = PointsOf{Line{l_s()};};
Characteristic Length{p_s()} = LcAir;

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

Physical Surface("Boundary air", SURF_OUT) = {f_s(0),f_s(1),f_s(2),f_s(3),f_s(4),f_s(5)};
For i In {1:Num_Super}
	// Samples faces not oriented correctly since New Gmsh
	f_c~{i}(0) = -f_c~{i}(0);
	f_c~{i}(2) = -f_c~{i}(2);
	f_c~{i}(4) = -f_c~{i}(4);
	// Debug the orientation of the suface
	/* Printf("Boundary Bulk: %g", f_c~{i}(0));
	Printf("Boundary Bulk: %g", f_c~{i}(1));
	Printf("Boundary Bulk: %g", f_c~{i}(2));
	Printf("Boundary Bulk: %g", f_c~{i}(3));
	Printf("Boundary Bulk: %g", f_c~{i}(4));
	Printf("Boundary Bulk: %g", f_c~{i}(5)); */
	Physical Volume(Sprintf("Bulk %g", i), BULK~{i}) = {materialVol~{i}()};
	Physical Surface(Sprintf("Boundary Bulk %g", i), Boundary_BULK~{i}) = {f_c~{i}()};
EndFor



Px = 0;
Py = 0.006;
Pz = 0;

Color SkyBlue {Surface{f_s(0),f_s(1),f_s(2),f_s(3),f_s(4),f_s(5)};}
Color Yellow {Surface{f_c_Tot()};}
