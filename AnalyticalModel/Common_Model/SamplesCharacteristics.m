% This script contains all the sample characteristics

% Model dependant parameters (--> Jc and Jc variation)
%% 1216 Homogene
Sample1216.HOMOGENEOUSGoodJc = 1.6615e+08;
Sample1216.HOMOGENEOUSBadJc = 1.6615e+08;
Sample1216.HOMOGENEOUSEpaisseur_loss = 0;
%% 1216 Not Full Height Continuous variation
Sample1216.LINVARGoodJc = 2.1868e+08;
Sample1216.LINVARBadJc = 0;
Sample1216.LINVAREpaisseur_loss = 0.0014;
%% 1216 test full nothing
Sample1216.FULLNOTHINGGoodJc = 1.8017e+08;
Sample1216.FULLNOTHINGBadJc = 1.8017e+08;
Sample1216.FULLNOTHINGEpaisseur_loss = 0.0054; 
%% 1220 Homogene
Sample1220.HOMOGENEOUSGoodJc = 1.6293e+08;
Sample1220.HOMOGENEOUSBadJc = 1.6293e+08;
Sample1220.HOMOGENEOUSEpaisseur_loss = 0;
%% 1220 Full Supercond
Sample1220.LINVARGoodJc = 2.0290e+08;
Sample1220.LINVARBadJc = 1.1160e+07;
Sample1220.LINVAREpaisseur_loss = 0;
%% 1220 Half ech
d_halfech = 0.012;
Sample1220.HALFECHGoodJc = 2.0290e+08 - (2.0290e+08 - 1.1160e+07)*((0.0159 - d_halfech)/0.0159);
Sample1220.HALFECHBadJc = 1.1160e+07;
Sample1220.HALFECHEpaisseur_loss = 0;
%% 1220 Test full nothing
Sample1220.FULLNOTHINGGoodJc = 1.7246e+08;
Sample1220.FULLNOTHINGBadJc = 1.7246e+08;
Sample1220.FULLNOTHINGEpaisseur_loss = 0.0038;  

%% 1220 Not Full Height
% Not possible
%% 1218 Homogene
Sample1218.HOMOGENEOUSGoodJc = 1.6293e+08;
Sample1218.HOMOGENEOUSBadJc = 1.6293e+08;
Sample1218.HOMOGENEOUSEpaisseur_loss = 0;
%% 1218 Not Full Height Continuous variation
Sample1218.LINVARGoodJc = 2.0598e+08;
Sample1218.LINVARBadJc = 0;
Sample1218.LINVAREpaisseur_loss = 0.0005;
%% 1218 Test full nothing
Sample1218.FULLNOTHINGGoodJc = 1.7044e+08;
Sample1218.FULLNOTHINGBadJc = 1.7044e+08;
Sample1218.FULLNOTHINGEpaisseur_loss = 0.0045;
%% 1222 Homogene
Sample1222.HOMOGENEOUSGoodJc = 1.8361e+08;
Sample1222.HOMOGENEOUSBadJc = 1.8361e+08;
Sample1222.HOMOGENEOUSEpaisseur_loss = 0;
%% 1222 Full Supercond
Sample1222.LINVARGoodJc = 2.2985e+08;
Sample1222.LINVARBadJc = 0;
Sample1222.LINVAREpaisseur_loss = 0;
%% ST2 Full Supercond and homogeneous
SampleST2.HOMOGENEOUSGoodJc = 9.7134e+07; % Enchatier ici!
SampleST2.HOMOGENEOUSBadJc = 9.7134e+07;
% SampleST2.HOMOGENEOUSGoodJc = 1.1818e+08; % Enchatier ici!
% SampleST2.HOMOGENEOUSBadJc = 1.1818e+08;
SampleST2.HOMOGENEOUSEpaisseur_loss = 0;
%% Permanent magnets
PM.Kc77K = 8.9880e+05;
PM.Kc300K = 1.0269e+06;
%% Qualitative Bulk
QualitativeBulk.Jc = 1.6882e8;
%% Qualitative PM
QualitativePM.Kc = 0.9448e6;


% Model Independant parameters (--> Dimensions and distance from surface)
Sample1216.Dimension = [0.0143 0.0145 0.0145]; %1216
Sample1216.DistFromSurfUp = 0.001;
Sample1220.Dimension = [0.0144 0.0144 0.0159]; %1220
Sample1220.DistFromSurfUp = 0.001;
Sample1220.HALFECHDimension = [0.0144 0.0144 d_halfech]; %1220 Halfech
Sample1220.HALFECHDistFromSurfUp = 0.001;
Sample1218.Dimension = [0.0141 0.0141 0.0152]; %1218
Sample1218.DistFromSurfUp = 0.001;
Sample1222.Dimension = [0.0143 0.0143 0.0159]; %1222
Sample1222.DistFromSurfUp = 0.001;
SampleST2.Dimension = [0.012 0.012 0.0125]; % ST2
% SampleST2.DistFromSurfUp = 0.0015;
SampleST2.DistFromSurfUp = 0.001; %test for magnetic moment Enchantier ici!
PM.Dimension = [0.012 0.012 0.012];
PM.Distfromsurf = 0.0012;
QualitativeBulk.Dimension = [0.014 0.014 0.014];    % Qualitative Bulk
QualitativeBulk.DistFromSurfUp = 0.001;
QualitativePM.Dimension = [0.014 0.014 0.014];      % Qualitative PM
QualitativePM.DistFromSurfUp = 0.001;
