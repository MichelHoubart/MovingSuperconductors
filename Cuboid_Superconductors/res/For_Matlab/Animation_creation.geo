// set the dimension of the animation

General.GraphicsWidth = 640 ;
General.GraphicsHeight = 480 ;

// Set max jpeg quality

Print.JpegQuality = 1000;

// Hide all views

For i In {1:PostProcessing.NbViews}
View[i-1].Visible = 0;
EndFor

// Loop on all views

index = 0;

For i In {1:PostProcessing.NbViews}

// Display view i-1

View[i-1].Visible = 1;

// Loop on all solutions in view i-1

For j In {1:View[i-1].NbTimeStep}

index++;
Draw;

// generate a jpeg image

Print Sprintf("anim-%03g.jpg", index);

View[i-1].TimeStep++;

EndFor

View[i-1].Visible = 0;

EndFor

// create the parameter file for mpeg_encode

System 'echo "PATTERN I" > anim.par' ;
System 'echo "BASE_FILE_FORMAT JPEG" >> anim.par' ;
System 'echo "GOP_SIZE 30" >> anim.par' ;
System 'echo "SLICES_PER_FRAME 1" >> anim.par' ;
System 'echo "PIXEL HALF" >> anim.par' ;
System 'echo "RANGE 10" >> anim.par' ;
System 'echo "PSEARCH_ALG TWOLEVEL" >> anim.par' ;
System 'echo "BSEARCH_ALG CROSS2" >> anim.par' ;
System 'echo "IQSCALE 8" >> anim.par' ;
System 'echo "PQSCALE 10" >> anim.par' ;
System 'echo "BQSCALE 25" >> anim.par' ;
System 'echo "REFERENCE_FRAME ORIGINAL" >> anim.par' ;
System 'echo "OUTPUT anim.mpg" >> anim.par' ;
System 'echo "INPUT_CONVERT *" >> anim.par' ;
System 'echo "INPUT_DIR ." >> anim.par' ;
System 'echo "INPUT" >> anim.par' ;
System Sprintf('echo "anim-*.jpg [001-%03g]" >> anim.par', index) ;
System 'echo "END_INPUT" >> anim.par' ;

// Call mpeg_encode

System "mpeg_encode anim.par" ;

// Clean-up all temp files

System "rm -f anim-*.gif" ;
System "rm -f anim-*.jpg" ;
System "rm -f anim.par" ;