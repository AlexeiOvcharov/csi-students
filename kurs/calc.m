clear
%% Initial data
K = 210;
T1 = 1;
T2 = 2;
tp = 0.1;
sigma = 27;
gMax = 5;
g0Max = 0.8;
eMax = 0.015;

%% From table
L1 = 19; L2 = -19;
wc = 4*pi/tp*0.9;

%% Calculate desired params
w0 = gMax/g0Max;
accMax = g0Max*w0^2;
Kacc = accMax/eMax;

w1 = Kacc/Kv;
w2 = sqrt(Kv*w1/10^(L1/20));
w3 = wc/10^(L2/20);

%% Second calc
Kv = gMax/eMax;
w2 = wc/10^(L1/20);
w3 = wc/10^(L2/20);
w1 = sqrt(wc/Kv)*w2;