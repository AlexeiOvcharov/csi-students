%% Initial data
K = 210;
T1 = 0.04;
T2 = 0.2;
tp = 0.1;
sigma = 27;
gMax = 5;
g0Max = 0.8;
eMax = 0.015;

%% From table
L1 = 18; L2 = -18;
wc = 4*pi/tp*0.9;

%% Calculate desired params
Kv = gMax/eMax;
w0 = gMax/g0Max;
Kd = Kv*w0*T2;

w1 = 1/T2;
w2 = sqrt(Kd*w1^2/wc);
w3 = wc/10^(L2/20);

%% Calc
test = [
    1, 20*log10(Kd);
    w1, 20*log10(Kd/w1);
    w2, 20*log10(Kd*w1^2/w2^3);
    w2, 20*log10(wc/w2);
    w3, 20*log10(wc/w3);
];

%% Write data to file
csvwrite('data/Sin.csv', [simout.Time, simout.Data]);
