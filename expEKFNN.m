clear all;
R = 40;
Q = 0.01;
HN = 200;
avgPerf = runEKFMLP(50, 200, HN, Q, R);