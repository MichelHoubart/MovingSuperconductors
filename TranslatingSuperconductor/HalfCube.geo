//****************** Triangluar surface ******************//
// Geometry
p = newp;
If(IdPositionInTHA==1)
	Point(p) = {x_Bottom_Super, y_Bottom_Super, z_Bottom_Super, LcCube};
	Point(p+1) = {x_Bottom_Super, y_Bottom_Super+ay~{Sample~{i}}, z_Bottom_Super, LcCube};
	Point(p+2) = {x_Bottom_Super, y_Bottom_Super+ay~{Sample~{i}}, z_Bottom_Super+az~{Sample~{IdPositionInTHA}}, LcCube};
ElseIf(IdPositionInTHA==3)
	Point(p+1) = {x_Bottom_Super, y_Bottom_Super+ay~{Sample~{i}}, z_Bottom_Super, LcCube};
	Point(p+2) = {x_Bottom_Super, y_Bottom_Super+ay~{Sample~{i}}, z_Bottom_Super+az~{Sample~{i}}, LcCube};
	Point(p) = {x_Bottom_Super, y_Bottom_Super, z_Bottom_Super+az~{Sample~{i}}, LcCube};
EndIf

l = newl;
Line(l) = {p,p+1};
Line(l+1) = {p+1,p+2};
Line(l+2) = {p+2, p};


cl = newl+9000;
Curve Loop(cl) = {l,l+1,l+2};

s = news;
Plane Surface(s) = {cl};

// Force the number of nodes
Transfinite Curve{l} = NbElemHalfCube+1;
Transfinite Curve{l+1} = NbElemHalfCube+1;
Transfinite Curve{l+2} = NbElemHalfCube+1;
Mesh.TransfiniteTri = 1; // Beaucoup mieux avec! Evite d'avoir des éléments avec des aspect ratio très mauvais
Transfinite Surface{s};
Recombine Surface{s};

//****************** Extrude to obtain truncated cube ******************//
materialVol~{i} = Extrude {ax~{Sample~{i}}, 0, 0} { Surface{s}; Layers{NbElemHalfCube}; Recombine; };
