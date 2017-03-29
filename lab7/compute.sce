clear();
gray = color(200, 200, 200);

// Initial data
A = 2;
V = 4;
a = 0.2;
f1 = 0.0;
f2 = 1;

path = "/home/senserlex/homeworks/TAY/csi-students/lab7/src/"
fileName = "model4.zcos";

// Load model
loadXcosLibs(); loadScicos();
importXcosDiagram(path + fileName);
typeof(scs_m);

// Variables
for k = [10]

    // Simaulation
    scicos_simulate(scs_m);

    errExp = 0.06 + 0.2*data.time + 0.80096*cos(0.1*data.time) - 0.024*sin(0.1*data.time);

    // Plot
    plot2d(data.time, data.values(:, 1));
    plot2d(data.time, errExp);
    xlabel("$t\text{, c}$", "fontsize", 3);
    ylabel("$e$", "fontsize", 3);
    axis = gca();
    axis.parent.figure_size = [800, 500];
    axis.children(1).children.thickness = 2;
    axis.grid = [gray, gray];
//    axis.data_bounds = [0,a.data_bounds(1, 2); 5.5, a.data_bounds(2, 2)]
end;

legend("Ошибка", "Ошибка, разложенная в ряд Тейлора");
e = gce();
e.legend_location = "in_upper_left";
e.font_size = 3;
