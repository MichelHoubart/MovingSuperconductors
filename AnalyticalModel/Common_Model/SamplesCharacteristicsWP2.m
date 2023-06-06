% This script contains all the sample characteristics
%% Permanent magnets
PM.Kc77K = 8.9880e+05;
PM.Kc300K = 1.0269e+06;
%% Qualitative Bulk
SampleWP2.HOMOGENEOUSGoodJc = 2.364e8; % Fitted for Sample 2 (without Glue)
SampleWP2.HOMOGENEOUSBadJc = 2.364e8;
SampleWP2.HOMOGENEOUSEpaisseur_loss = 0;

%% Sample1WP2
Sample1WP2.HOMOGENEOUSGoodJc = 2.338e8; % Fitted for Sample 1
Sample1WP2.HOMOGENEOUSBadJc = 2.338e8;
Sample1WP2.HOMOGENEOUSEpaisseur_loss = 0;

%% Sample2WP2
Sample2WP2.HOMOGENEOUSGoodJc = 2.3404e8; % Fitted for Sample 2 RotativeOne (Broken)
Sample2WP2.HOMOGENEOUSBadJc = 2.3404e8;
Sample2WP2.HOMOGENEOUSEpaisseur_loss = 0;

%% To compare to Getdp Results
SampleGetdp.HOMOGENEOUSGoodJc =1.26e8; % Pire cas pour magnétisation
SampleGetdp.HOMOGENEOUSBadJc = 1.26e8;
SampleGetdp.HOMOGENEOUSEpaisseur_loss = 0;

%% Qualitative PM
QualitativePM.Kc = 0.9448e6;


% Model Independant parameters (--> Dimensions and distance from surface)
PM.Dimension = [0.012 0.012 0.012];
PM.Distfromsurf = 0.0012;
SampleWP2.Dimension = [0.006 0.006 0.006];    % Qualitative Bulk
SampleWP2.DistFromSurfUp = 0.0035;
Sample1WP2.Dimension = [0.006 0.006 0.005];    % Sample1 WP2
Sample1WP2.DistFromSurfUp = 0.005;
Sample2WP2.Dimension = [0.006 0.006 0.006];    % Sample2 WP2
Sample2WP2.DistFromSurfUp = 0.0035;
SampleGetdp.Dimension = [0.006 0.006 0.006];    % To compare to Getdp Results
SampleGetdp.DistFromSurfUp = 0.001;
QualitativePM.Dimension = [0.014 0.014 0.014];      % Qualitative PM
QualitativePM.DistFromSurfUp = -0.001;
