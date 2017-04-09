clear();

// Initial data
K = 10;
T = 2;
ksi = 0.25;
g_m = 1;

// Paths
path = "/home/senserlex/homeworks/TAY/csi-students/lab9/";
modleName = "src/model7.zcos";
dataFileName = "data/data7.dat";

// Load model
loadXcosLibs(); loadScicos();
importXcosDiagram(path + modleName);
typeof(scs_m);

dta = [];

w_1 = 1.5;

simulation_time = 100 + 2*%pi/(w_1)*50;
dt = 2*%pi/(w_1*500);

// Simulate
scicos_simulate(scs_m);

//for w_1 = [10^(1.5:0.25:2)]
//
simulation_time = 100 + 2*%pi/(w_1)*50;
dt = 2*%pi/(w_1*500);
n = 7;

// Simulate
scicos_simulate(scs_m);

// Calculate
maximum = max(data.values(size(data.values, 1) - floor(n*2*%pi/(w_1*dt)):size(data.values, 1), 1));
minimum = min(data.values(size(data.values, 1) - floor(n*2*%pi/(w_1*dt)):size(data.values, 1), 1));

amplitude = (maximum - minimum)/2;
data.values(:, 1) = data.values(:, 1) - maximum + amplitude;

i = size(data.values, 1) - floor(n*2*%pi/(w_1*dt)) - 1;
oldState = [data.values(i, 1), data.values(i, 2)];
currState = [];
firstZeroCrossing = [];
secondZeroCrossing = [];

for i = [size(data.values, 1) - floor(n*2*%pi/(w_1*dt)):1:size(data.values, 1)]
    currState = [data.values(i, 1), data.values(i, 2)];
    if currState(1) < 0 & oldState(1) > 0 then
        firstZeroCrossing(length(firstZeroCrossing) + 1, :) = i;
    end
    if currState(2) < 0 & oldState(2) > 0 then
        secondZeroCrossing(length(secondZeroCrossing) + 1, :) = i;
    end

    oldState = currState;
end

t1 = data.time(firstZeroCrossing);
t2 = data.time(secondZeroCrossing);
t1 = t1(2:length(t2) - 1);
t2 = t2(2:length(t2) - 1);

phi = sum(t2 - t1)/length(t2);
psi = w_1*phi*180/%pi;
if psi > 0 then
    psi = psi - 360;
end

dta(size(dta, 1) + 1, :) = [w_1, log10(w_1), amplitude, 20*log10(amplitude), psi];

disp(dta);
//
//end
//write(path + dataFileName, dta);
// Plots
plot2d(data.time, data.values);

