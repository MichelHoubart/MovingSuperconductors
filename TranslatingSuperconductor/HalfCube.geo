p = newp;
If(i==1)
	Point(p) = {x_Bottom_Super, y_Bottom_Super, z_Bottom_Super, LcCube};
	Point(p+1) = {x_Bottom_Super, y_Bottom_Super+ay~{Sample_1}, z_Bottom_Super, LcCube};
	Point(p+2) = {x_Bottom_Super, y_Bottom_Super+ay~{Sample_1}, z_Bottom_Super+az~{Sample_1}, LcCube};
ElseIf(i==3)
	Point(p) = {x_Bottom_Super, y_Bottom_Super+ay~{Sample_1}, z_Bottom_Super, LcCube};
	Point(p+1) = {x_Bottom_Super, y_Bottom_Super+ay~{Sample_1}, z_Bottom_Super+az~{Sample_1}, LcCube};
	Point(p+2) = {x_Bottom_Super, y_Bottom_Super, z_Bottom_Super+az~{Sample_1}, LcCube};
EndIf

l = newl;
Line(l) = {p,p+1};
Line(l+1) = {p+1,p+2};
Line(l+2) = {p+2, p};

cl = newcl;
Curve Loop(cl) = {l,l+1,l+2};

s = news;
Plane Surface(s) = {cl};

// TODO set right number of nodes
Transfinite Curve{l, l+1, l+2} = 10;
Mesh.TransfiniteTri = 1; // optionel
Transfinite Surface{s};
//Recombine Surface{s}; // optionel

materialVol~{i} = Extrude {0, ay~{1}, 0} { Surface{s}; Layers{10}; Recombine; };

/* Printf("Periph ech = %g", materialVol~{i}[0]); */
