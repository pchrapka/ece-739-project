clear all;
eta = 0.01;
epsilon = 0.01;
q = 0.1;
HN = 200;
avgPerf = runEKFMLP(50, 200, HN, eta, epsilon, q, true);