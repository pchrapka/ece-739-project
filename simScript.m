clc;
clear all;
close all;

%% Initialize variables
samples = 10;
epochs = 2000;%10;%500;
testSamples = 200;
eta = 1/500;%0.556; %R
epsilon = 1/100;%0.005 %P
q = 0.01;
HN = 20;%100;
annealingFlag = false;
perfPlotFlag = true;
preProcessData = false; % Needs to match what is set in runEKFMLP2

%% Run the EKF MLP alg

[perf,weights] = runEKFMLP2(...
                epochs,testSamples,...
                HN, eta, epsilon, q, ...
                annealingFlag, perfPlotFlag);
            
%% Test the network and output a plot
numOutputs = 1;
perf2 = getPerfMLP( weights, numOutputs, true, preProcessData);