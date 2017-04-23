clear();

// Initial data
T_1 = 1;
T_2 = 2;
K = 210;
t_p = 0.1;
sigma = 27;
g_max = 5;
g_0max = 0.8;
e_max = 0.015;

K_d = g_max/e_max;
w_p = 2.7*%pi/t_p;
w_c = 0.7*w_p;
L = 12.5;

w_2 = w_c/10^((L)/20);
w_3 = w_c/10^(-(L)/20);
w_1 = sqrt(w_c/K_d)*w_2;
//dw_1 = w_c*w_2/K_d;

path = "/home/senserlex/homeworks/TAY/csi-students/kurs/";
modleName = "models/model.zcos";

// Load model
loadXcosLibs(); loadScicos();
importXcosDiagram(path + modleName);
typeof(scs_m);

scicos_simulate(scs_m);

differ = [];
// Calc params
for x = [2:1:size(data.values, 1)]
    if (abs(1 - data.values(x)) <= 0.05 & abs(1 - data.values(x - 1)) > 0.05) then 
        i = x 
    end
    differ(x) = (data.values(x) - data.values(x - 1))/data.time(x);
end

differ(1) = differ(2);
sigma_real = (max(data.values) - 1)*100;

disp(data.time(i), sigma_real);

plot(data.time, data.values);
