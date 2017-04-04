clear();
gray = color(200, 200, 200);

// Initial data
T1 = 1;

path = "/home/senserlex/homeworks/TAY/csi-students/lab8/";
modleName = "src/model.zcos";
dataFileName = "data/dataTreshold.dat";

// Load model
loadXcosLibs(); loadScicos();
importXcosDiagram(path + modleName);
typeof(scs_m);

T2 = -100;
K = 0;
dat = []
//
//for T2 = [0.1:(5 - 0.1)/19:5]
//    K = 1/T1 + 1/T2;
//    dat(size(dat, 1) + 1, :) = [T2, K]
//end

scicos_simulate(scs_m);

plot2d(data.time, data.values);

//write(path + dataFileName, dat);
