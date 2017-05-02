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

// Koeff
K0 = 9.3;
Kd = 0.8 * 10^3;
Cp = 0.8 * 10^8;
U = 10;
Tu = 0.08*10^(-3);
Ku = 300/10;

path = "/home/senserlex/homeworks/TAY/csi-students/lab11/";

w = 10.^([-2:0.01:6])';
A = 20*log10(sqrt(((Ku*Kd*U - Fb)^2 + (Tu*Fb*w).^2)./((1 + Tu^2*w.^2).*((Cp - m*w.^2).^2 + Kd^2*w.^2))));


data = [w, A];

writeToFile(path + "data/FreqResponse/BodePlot.dat", ["w", "A"], data);
