clear();

function writeToFile(filePath, var, data)
    fd = mopen(filePath, 'wt');
    for i = [1:size(var, 2)]
        mfprintf(fd,"%s\t",var(i));
    end
    mfprintf(fd, "\n");

    for i = [1:size(data, 1)]
        for j = [1:size(data, 2)]
            mfprintf(fd, "%f\t", data(i, j));
        end
        mfprintf(fd, "\n");
    end;
    mclose(fd);
endfunction

// Initial data
Fb = 75;
m = 0.5;

// TIme
Tu = 0.08*10^(-3);

// Koeff
K0 = 9.3;
Kd = 0.8 * 10^3;
Cp = 0.8 * 10^8;
Ku = 300/10;
Kf = 10/180;
Kv = 10/0.04;
Kx = 10/0.000007;

outputData = [];
// Modelling #1
experiment = 1;
stateVar = ["f", "0.008", "0.00001"; "v", "0.01", "0.00001"; "u", "0.01", "0.00001"; "x", "0.01", "0.00001"];

// Load model
path = "/home/senserlex/homeworks/TAY/csi-students/lab11/";
modelName = "models/model.zcos";

loadXcosLibs(); loadScicos();
importXcosDiagram(path + modelName);
typeof(scs_m);

// Simalation
Fb = 0;
U = 10;
for x = [1:4]
    dataFileName = "data/ex" + string(experiment) + "/TransPlot-" + stateVar(x, 1) + ".dat";
    simTime = strtod(stateVar(x, 2));
    timeStep = strtod(stateVar(x, 3));
    
    scicos_simulate(scs_m);
    
    outputData = [data.time, data.values(:, x)];
    writeToFile(path + dataFileName, ['t', stateVar(x)], outputData);
end

plot2d(data.time, outputData);
