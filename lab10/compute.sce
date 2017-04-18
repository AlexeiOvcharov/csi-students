clear();
gray = color(200, 200, 200);

// Initial data
U_n = 36;
n_0 = 4000;4
I_n = 6.5;
M_n = 0.57;
R = 0.85;
T_a = 3*10^(-3)/10;
J_d = 2.2*10^(-4);
T_y = 6*10^(-3)/10;
i = 40;
J_m = 0.15;
U_m = 10;

I_max = 31.353872;
alpha_max = 1.8464867*3;

w_0 = n_0*%pi/30;
K_e = U_n/w_0;
K_y = U_n/U_m;
K_d = 1/R;
K_m = M_n/I_n;
J_summ = J_d + 0.2*J_d + J_m/i^2;
K_u = 10/U_n;
K_I = 10/I_max;
K_w = 10/w_0;
K_alpha = 10/alpha_max;

K = K_y/(K_e*i);
K_f = R/(K_m*K_e*i^2);
T_m = R*J_summ/(K_m*K_e);

// Paths
path = "/home/senserlex/homeworks/TAY/csi-students/lab10/";
modleName = "models/full-model.zcos";
dataFile = "data/FullModel/GearRatioWithMoment.dat";

// Load model
loadXcosLibs(); loadScicos();
importXcosDiagram(path + modleName);
typeof(scs_m);

simulation_time = 2;
dt = 0.001;
U = 5;
Mcm = M_n*i/2;
//Mcm = 0;

differDat = [];
dta = [];
fullData = [];
t_p = 0;

ratio = i;
x = 1;
//for prefix = ["w", "U", "I", "alpha"]
//fullData = [];
//filename = dataFile + "-" + prefix + ".dat";

for i = [ratio - 0.75*ratio:1.5*ratio/4:ratio + 0.75*ratio]
    J_summ = J_d + 0.2*J_d + J_m/i^2;

//     Simulate
    scicos_simulate(scs_m);

    w_stab = data.values(size(data.values, 1), 1);
    I_stab = data.values(size(data.values, 1), 3);
    differDat = abs(data.values(:, 1) - w_stab)/w_stab;

    for n = [2:size(differDat, 1)]
        if differDat(n) <= 0.5 & differDat(n - 1) > 0.5 then
            t_p = data.time(n);
        end
    end
    dta(size(dta, 1) + 1, :) = [i, t_p, w_stab, I_stab];
//    dta(size(dta, 1) + 1, :) = [t_p, w_stab];
    fullData(:, size(fullData, 2) + 1) = data.values(:, x);
//    write(path+dataFile, [data.time, data.values]);
    plot2d(data.time, data.values(:, :));
end
//fullData = [data.time, fullData];
//write(path+filename, fullData);
//x = x +1;
//end
write(path+dataFile, dta);
//write(path+dataFile, [data.time, data.values]);

//lam2 = (-J_summ - sqrt(J_summ^2 - 4*T_a*J_summ*K_m*K_d*K_e))/(2*T_a*J_summ);
//lam1 = (-J_summ + sqrt(J_summ^2 - 4*T_a*J_summ*K_m*K_d*K_e))/(2*T_a*J_summ);
//A = K_d*K_y*U*K_m/(-T_a*J_summ/T_y^2 + J_summ/T_y - K_d*K_m*K_e);
//B = K_d*K_y*U*K_m/(K_d*K_m*K_e);
//C1 = -(lam2*(A*exp(-data.time/T_y) + B) + A/T_y)/(lam2 - lam1);
//C2 =   (lam1*(A*exp(-data.time/T_y) + B) + A/T_y)/(lam2 - lam1);
//w = C1.*exp(lam1*data.time) + C2.*exp(lam2*data.time) + A*exp(-data.time/T_y) + B;

//data1 = read("/home/senserlex/homeworks/TAY/csi-students/lab10/data/EasyModel/TransPlot.dat", -1, 3);
//data2 = read("/home/senserlex/homeworks/TAY/csi-students/lab10/data/FullModel/TransPlotSwitchedTime.dat", -1, 5);
