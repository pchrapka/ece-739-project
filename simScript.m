clc;
clear all;
close all;

%% Initialize variables
samples = 10;
epochs = 500;
testSamples = 200;
eta = 0.556;
epsilon = 0.005;
q = 0.001;
HN = 100;
annealingFlag = true;
perfPlotFlag = true;

%% Run the EKF MLP alg

[perf,weights] = runEKFMLP2(...
                epochs,testSamples,...
                HN, eta, epsilon, q, ...
                annealingFlag, perfPlotFlag);
            
%% Test the network and output a plot
numOutputs = 1;
perf2 = getPerfMLP( weights, numOutputs, true );