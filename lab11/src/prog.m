% Inital data from Table 11.1
% Variant 3
Cp = 0.8 * 10^8;
m = 0.5;
K0 = 9.3;
Kd = 0.8 * 10^3;
Tu = 0.08;
Fb = 75;

% Compute other data
Ku = 300/10;   % U_pm/U_m, U_pm = 300 V; U_m = 10 V.
Kf = 1;
Kv = 1;
Kx = 1;

%% First experiment
U = 10;
Fb = 0;

% Simulation params
ParameterStruct.AbsTol         = '1e-1';
ParameterStruct.TimeOut        = 1;
ParameterTime



%ModelName = '/home/senserlex/homeworks/TAY/csi-students/lab11/models/model.slx';
%simOut = sim(ModelName, ParameterStruct);