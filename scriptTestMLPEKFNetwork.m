%% Script to test the MLP EKF Network
% NOTE Not sure how useful this will be
clear all;
close all;
clc;

%% Load in variables from a grid search script
gridSearchFile = 'mlpekf_gridSearch20110722_122832.mat';
fileVariables = {...
    'bestHN','bestEta','bestEpsilon',...
    'testSamples','epochs',...
    'q','annealingFlag'};
load(gridSearchFile,fileVariables{:});

numHiddenNodes = bestHN;
eta = bestEta;
epsilon = bestEpsilon;
trainingSamples = testSamples;
trainingEpochs = epochs;
q2 = q;
annealingFlag2 = annealingFlag;

% Clear the load variables
clear(fileVariables{:});

%% We need to retrain the neural network and get the weight vector
perfPlotFlag = true;

[perf,weights] = runEKFMLP2(...
    trainingEpochs,trainingSamples,...
    numHiddenNodes,eta,epsilon,q2,...
    annealingFlag2,perfPlotFlag);

% disp(['Performance: ' num2str(perf*100)]);

%% Test the network
perf2 = getPerfMLP( weights, 1, true );