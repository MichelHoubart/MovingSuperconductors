% This script contains all the sample characteristics
%% Permanent magnets
SamplePMAlone77K.HOMOGENEOUSGoodJc = 8.9880e+05;
SamplePMAlone77K.HOMOGENEOUSBadJc = 8.9880e+05;
SamplePMAlone300K.HOMOGENEOUSGoodJc = (1.0269e+06);
SamplePMAlone300K.HOMOGENEOUSBadJc = (1.0269e+06);

%% Sample alpha
Samplealpha.HOMOGENEOUSGoodJc = 2.0377e+08; 
Samplealpha.HOMOGENEOUSBadJc = 2.0377e+08;
Samplealpha.HOMOGENEOUSEpaisseur_loss = 0;

%% Sample beta
Samplebeta.HOMOGENEOUSGoodJc = 2.0377e+08; 
Samplebeta.HOMOGENEOUSBadJc = 2.0377e+08;
Samplebeta.HOMOGENEOUSEpaisseur_loss = 0;

%% Sample Left_2T
SampleLeft_2T.HOMOGENEOUSGoodJc = 2.0377e+08; 
SampleLeft_2T.HOMOGENEOUSBadJc = 2.0377e+08;
SampleLeft_2T.HOMOGENEOUSEpaisseur_loss = 0;

%% Sample Right_4T
SampleRight_4T.HOMOGENEOUSGoodJc = 2.0377e+08; 
SampleRight_4T.HOMOGENEOUSBadJc = 2.0377e+08;
SampleRight_4T.HOMOGENEOUSEpaisseur_loss = 0;

%% In the truncated HA --> all properties are the same than alpha
SampleTruncatedHA.HOMOGENEOUSGoodJc = 2.0377e+08; 
SampleTruncatedHA.HOMOGENEOUSBadJc = 2.0377e+08;
SampleTruncatedHA.HOMOGENEOUSEpaisseur_loss = 0;

% Model Independant parameters (--> Dimensions and distance from surface)
Samplealpha.Dimension = [0.013 0.013 0.013];    % Sample2 WP2
Samplealpha.DistFromSurfUp = 0.0035;
Samplebeta.Dimension = [0.013 0.013 0.013];    % Sample2 WP2
Samplebeta.DistFromSurfUp = 0.0035;
SampleLeft_2T.Dimension = [0.013 0.013 0.013];    % Sample2 WP2
SampleLeft_2T.DistFromSurfUp = 0.0035;
SampleRight_4T.Dimension = [0.013 0.013 0.013];    % Sample2 WP2
SampleRight_4T.DistFromSurfUp = 0.0035;
SampleTruncatedHA.Dimension = [0.013 0.013 0.013];    % Sample2 WP2
SampleTruncatedHA.DistFromSurfUp = 0.0035;
SamplePMAlone77K.Dimension = [0.012 0.012 0.012];
SamplePMAlone77K.DistFromSurfUp = 0.0035;
SamplePMAlone300K.Dimension = [0.012 0.012 0.012];
SamplePMAlone300K.DistFromSurfUp  = 0.0035;